package com.tmwsoft.sns.web.filter;import java.io.IOException;import java.util.Map;import java.util.Properties;import java.util.Set;import javax.servlet.Filter;import javax.servlet.FilterChain;import javax.servlet.FilterConfig;import javax.servlet.ServletContext;import javax.servlet.ServletException;import javax.servlet.ServletRequest;import javax.servlet.ServletResponse;import javax.servlet.http.HttpServletRequest;import javax.servlet.http.HttpServletResponse;import com.tmwsoft.sns.util.Common;import com.tmwsoft.sns.util.PropertiesHelper;import com.tmwsoft.sns.util.SysConstants;import com.tmwsoft.sns.web.servlet.HttpServletRequestWrapper;public class InitFilter implements Filter {	public void init(FilterConfig fc) throws ServletException {		ServletContext servletContext = fc.getServletContext();		// 全局信息		servletContext.setAttribute("snsInfo", SysConstants.snsInfo);	}	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException,			ServletException {		HttpServletRequestWrapper request = new HttpServletRequestWrapper((HttpServletRequest) req);		HttpServletResponse response = (HttpServletResponse) res;		request.setCharacterEncoding(SysConstants.SNS_CHARSET);		response.setCharacterEncoding(SysConstants.SNS_CHARSET);		// 初始化系统根路径		if (SysConstants.snsRoot == null) {			SysConstants.setJchRoot(request);		}		Map<String, String> snsConfig = SysConstants.snsConfig;		if (snsConfig.isEmpty()) {			try {				initConfig(request, snsConfig);			} catch (IOException e) {				response.getWriter().write("读取配置文件(./config.properties)出错：" + e.getMessage());				return;			}		}		chain.doFilter(request, res);	}	private synchronized void initConfig(HttpServletRequest request, Map<String, String> snsConfig) throws IOException {		PropertiesHelper propHelper = new PropertiesHelper(SysConstants.snsRoot + "WEB-INF/classes/config.properties");		Properties config = propHelper.getProperties();		Set<Object> keys = config.keySet();		for (Object key : keys) {			String k = (String) key;			String v = (String) config.get(key);			snsConfig.put(k, v);		}		String siteUrl = snsConfig.get("siteUrl");		if (Common.empty(siteUrl)) {			snsConfig.put("siteUrl", Common.getSiteUrl(request));		}		ServletContext servletContext = request.getSession().getServletContext();		servletContext.setAttribute("snsConfig", SysConstants.snsConfig);	}	public void destroy() {	}}