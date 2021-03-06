package com.tmwsoft.sns.web.filter;import java.io.File;import java.io.IOException;import java.sql.SQLException;import java.util.ArrayList;import java.util.HashMap;import java.util.List;import java.util.Map;import javax.servlet.Filter;import javax.servlet.FilterChain;import javax.servlet.FilterConfig;import javax.servlet.ServletException;import javax.servlet.ServletRequest;import javax.servlet.ServletResponse;import javax.servlet.http.HttpServletRequest;import javax.servlet.http.HttpServletResponse;import com.tmwsoft.sns.service.CacheService;import com.tmwsoft.sns.service.DataBaseService;import com.tmwsoft.sns.service.ZoneService;import com.tmwsoft.sns.util.BeanFactory;import com.tmwsoft.sns.util.Common;import com.tmwsoft.sns.util.CookieHelper;import com.tmwsoft.sns.util.SessionFactory;import com.tmwsoft.sns.util.SysConstants;public class CommonFilter implements Filter {	private static String[] cacheNames = { "app", "userapp", "ad", "magic" };	private static Map<Integer, String> sNames = new HashMap<Integer, String>();	private DataBaseService dataBaseService = (DataBaseService) BeanFactory.getBean("dataBaseService");	private CacheService cacheService = (CacheService) BeanFactory.getBean("cacheService");	private ZoneService zoneService = (ZoneService) BeanFactory.getBean("zoneService");	public void init(FilterConfig fc) throws ServletException {	}	@SuppressWarnings("unchecked")	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {		HttpServletRequest request = (HttpServletRequest) req;		HttpServletResponse response = (HttpServletResponse) res;		// 系统数据初始化		// 初始化数据库连接		if(SessionFactory.getSessionFactory() == null) {			try {				SessionFactory.buildSessionFactory();			} catch (SQLException e) {				SysConstants.snsConfig.clear();				Common.showMySQLMessage(response, "无法连接到数据库", null, e);				return;			}		}		// 初始化系统缓存文件，并将缓存信息装载到request中		String snsRoot = SysConstants.snsRoot;// 在InitFilter中已经初始化		try {			File configFile = new File(snsRoot + "/data/cache/cache_config.jsp");			if (!configFile.exists()) {				// 系统配置缓存				cacheService.updateCache();				// 广告数据缓存				cacheService.ad_data_cache();			}			Common.getCacheDate(request, response, "cache/cache_config.jsp", "");		} catch (Exception e) {			response.getWriter().write(e.getMessage());			return;		}		for (String cacheName : cacheNames) {			Common.getCacheDate(request, response, "/cache/cache_" + cacheName + ".jsp", "");		}		// 初始化snsConfig，将系统后台配置的参数加载到snsConfig中		Map<String, String> snsConfig = SysConstants.snsConfig;// 在InitFilter中已经初始化，加载了config.properties的数据		if (Common.empty(snsConfig.get("sitename"))) {			List<Map<String, Object>> configs = dataBaseService.executeQuery("SELECT * FROM sns_config WHERE var IN ('snsid', 'sitename', 'close', 'adminemail', 'lastupdate')");			for (Map<String, Object> config : configs) {				String variable = (String) config.get("var");				String value = (String) config.get("datavalue");				if (variable != null) {					snsConfig.put(variable, value);				}			}		}		// 初始化所有用户的展示名称		if(sNames.isEmpty()) {			Common.realname_init(sNames);		}				// 用户数据初始化		// 在CacheService.config_cache中将sns_config数据加载到sConfig中，上面的cacheService.updateCache()调用		Map<String, Object> sConfig = (Map<String, Object>) request.getAttribute("sConfig");		Map<String, Object> sGlobal = new HashMap<String, Object>();		Map<String, String> sCookie = CookieHelper.getCookies(request);		Map<String, Object> space = new HashMap<String, Object>();		request.setAttribute("sGlobal", sGlobal);		request.setAttribute("sCookie", sCookie);		request.setAttribute("space", space);		request.setAttribute("sNames", sNames);		request.setAttribute("IN_SNS", SysConstants.IN_SNS);		request.setAttribute("SNS_VERSION", SysConstants.SNS_VERSION);		request.setAttribute("SNS_RELEASE", SysConstants.SNS_RELEASE);		// 初始化用户的登录、注册路径和首页模板		String sitekey = (String) sConfig.get("sitekey");		if (Common.empty((String) sConfig.get("login_action"))) {			sConfig.put("login_action", Common.md5("login" + Common.md5(sitekey)));		}		if (Common.empty((String) sConfig.get("register_action"))) {			sConfig.put("register_action", Common.md5("register" + Common.md5(sitekey)));		}		if (Common.empty((String) sConfig.get("template"))) {			sConfig.put("template", "default");		}		// 初始化用户选择的首页模板		String myTemplate = sCookie.get("mytemplate");		if (!Common.empty(myTemplate)) {			myTemplate = myTemplate.trim().replace(".", "");			File styleFile = new File(SysConstants.snsRoot + "template/" + myTemplate + "/style.css");			if (styleFile.exists()) {				sConfig.put("template", myTemplate);			} else {				CookieHelper.removeCookie(request, response, "mytemplate");			}		}		// 设置用户的全局变量		long currentTime = System.currentTimeMillis();		int timestamp = (int) (currentTime / 1000);		String mobile = request.getParameter("mobile");		String m_timestamp = request.getParameter("m_timestamp");		if (Common.empty(m_timestamp) || !Common.md5(m_timestamp + "\t" + sitekey).equals(mobile)) {			mobile = null;		}		sGlobal.put("timestamp", timestamp);		sGlobal.put("starttime", currentTime);		sGlobal.put("supe_uid", 0);		sGlobal.put("supe_username", "");		sGlobal.put("mobile", mobile);		sGlobal.put("inajax", Common.intval(request.getParameter("inajax")));		sGlobal.put("refer", Common.trim(request.getHeader("Referer")));		sGlobal.put("uhash", Common.md5(sGlobal.get("supe_uid") + "\t" + String.valueOf(timestamp).substring(0, 6)));		// 设置返回路径		String requestURI = (String) request.getAttribute("requestURI");		if (requestURI == null) {			String queryString = request.getQueryString();			if (Common.empty(queryString)) {				requestURI = request.getRequestURI();			} else {				requestURI = request.getRequestURI() + "?" + queryString;			}			request.setAttribute("requestURI", requestURI);		}		// 权限验证		checkAuth(request, response, sGlobal, sConfig, sCookie);//		getUserApp(request, sGlobal, sConfig);		chain.doFilter(req, res);	}	private void checkAuth(HttpServletRequest request, HttpServletResponse response, Map<String, Object> sGlobal, Map<String, Object> sConfig, Map<String, String> sCookie) {		String m_auth = request.getParameter("m_auth");		if (sGlobal.get("mobile") != null && m_auth != null) {			sCookie.put("auth", m_auth);		}		String username = null;		String auth = sCookie.get("auth");		if (auth != null && auth.length() > 0) {			String[] values = Common.authCode(auth, "DECODE", null, 0).split("\t");			if (values.length > 1) {				String password = values[0];				int supe_uid = Common.intval(values[1]);				if (password.length() > 0 && supe_uid > 0) {					List<Map<String, Object>> members = dataBaseService.executeQuery("SELECT * FROM sns_session WHERE uid=" + supe_uid);					if (members.size() > 0) {						Map<String, Object> member = members.get(0);						if (((String) member.get("password")).equals(password)) {							username = (String) member.get("username");							sGlobal.put("supe_username", Common.addSlashes(username));							sGlobal.put("session", member);						} else {							supe_uid = 0;						}					} else {						members = dataBaseService.executeQuery("SELECT * FROM sns_member WHERE uid=" + supe_uid);						if (members.size() > 0) {							Map<String, Object> member = members.get(0);							if (((String) member.get("password")).equals(password)) {								username = (String) member.get("username");								String supe_username = Common.addSlashes(username);								sGlobal.put("supe_username", supe_username);								zoneService.insertSession(request, response, sGlobal, sConfig, supe_uid, supe_username, password);							} else {								supe_uid = 0;							}						} else {							supe_uid = 0;						}					}				} else {					supe_uid = 0;				}				sGlobal.put("supe_uid", supe_uid);			}		}		if (Common.empty(sGlobal.get("supe_uid"))) {			CookieHelper.clearCookie(request, response);		} else {			sGlobal.put("username", username);			request.getSession().setAttribute("User", username);		}	}	private void getUserApp(HttpServletRequest request, Map<String, Object> sGlobal, Map<String, Object> sConfig) {		int supe_uid = (Integer) sGlobal.get("supe_uid");		int my_status = (Integer) sConfig.get("my_status");		Map<Integer, Map<String, Object>> my_userapp = new HashMap<Integer, Map<String, Object>>();		List<Map<String, Object>> my_menu = new ArrayList<Map<String, Object>>();		int my_menu_more = 0;		if (supe_uid > 0 && my_status > 0) {			Map<String, Object> space = Common.getSpace(request, sGlobal, sConfig, supe_uid);			int showCount = 0;			List<Map<String, Object>> userApps = dataBaseService.executeQuery("SELECT * FROM sns_userapp WHERE uid=" + supe_uid + " ORDER BY menuorder DESC");			if (userApps.size() > 0) {				@SuppressWarnings("unchecked")				Map<Integer, Map<String, Object>> userApp = (Map<Integer, Map<String, Object>>) request.getAttribute("globalUserApp");				for (Map<String, Object> value : userApps) {					int appId = (Integer) value.get("appid");					my_userapp.put(appId, value);					if ((Integer) value.get("allowsidenav") > 0 && userApp.get(appId) == null) {						int menuNum = (Integer) space.get("menunum");						if (menuNum < 5) {							menuNum = 10;						}						if (menuNum > 100 || showCount < menuNum) {							my_menu.add(value);							showCount++;						} else {							my_menu_more = 1;						}						space.put("menunum", menuNum);					}				}			}		}		sGlobal.put("my_userapp", my_userapp);		sGlobal.put("my_menu", my_menu);		sGlobal.put("my_menu_more", my_menu_more);	}	public void destroy() {	}}