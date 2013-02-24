package com.tmwsoft.sns.web.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmwsoft.sns.util.Common;
import com.tmwsoft.sns.util.CookieHelper;

/**
 * 将社区用户做为sso的服务基础，所有子系统都要调用该类的方法进行用户的登陆、注销
 * 获取登陆用户账户：http://www.lysns.net/ssoAccount.action?action=signinUser
 * 用户登陆接口：	 http://www.lysns.net/ssoAccount.action?action=signin&username=tangtang2&password=85394444
 * 用户退出接口：	 http://www.lysns.net/ssoAccount.action?action=signout
 *
 */
public class SsoAccountAction extends BaseAction {

	/**
	 * 得到当前登陆的用户
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward signinUser(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, String> cookies = CookieHelper.getCookies(request);
		String userName = cookies.get("loginuser");
		if(userName == null) {
			userName = "anonym";
		}
		String result = "var i=document.createElement('input');i.id='ssoUserName';i.name='ssoUserName';i.type='hidden';i.value='" 
				+ userName + "';document.body.appendChild(i);";
		response.getWriter().print(result);
		return null;
	}

	/**
	 * 用户登陆
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ActionForward signin(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> sGlobal = (Map<String, Object>) request.getAttribute("sGlobal");
		Map<String, Object> sConfig = (Map<String, Object>) request.getAttribute("sConfig");
		String userName = request.getParameter("username");
		String password = request.getParameter("password");
		if (Common.empty(userName) || Common.empty(password)) {
			response.getWriter().print("//用户名或密码为空");
			return null;
		}
		// 设置cookie失效时间
		int cookieTime = Common.intval(request.getParameter("cookietime"));
		if(cookieTime == 0) {
			cookieTime = 30 * 60 * 1000;
		}
		List<Map<String, Object>> members = dataBaseService.executeQuery("SELECT * FROM sns_member WHERE username = '" + userName + "'");
		if (members.isEmpty()) {
			response.getWriter().print("//该用户不存在");
			return null;
		}
		Map<String, Object> member = members.get(0);
		password = Common.md5(Common.md5(password) + member.get("salt"));
		if (!password.equals(member.get("password"))) {
			response.getWriter().print("//密码错误");
			return null;
		}
		List<Map<String, Object>> spaces = dataBaseService.executeQuery("SELECT * FROM sns_space WHERE uid=" + member.get("uid"));
		Map<String, Object> space = null;
		if (spaces.isEmpty()) {
			space = zoneService.openSpace(request, response, sGlobal, sConfig, (Integer) member.get("uid"), (String) member.get("username"), 0, "");
		} else {
			space = spaces.get(0);
		}
		sGlobal.put("member", space);
		zoneService.insertSession(request, response, sGlobal, sConfig, (Integer) member.get("uid"), (String) member.get("username"), (String) member.get("password"));
		CookieHelper.setCookie(request, response, "auth", Common.authCode(member.get("password") + "\t" + member.get("uid"), "ENCODE", null, 0), cookieTime == 0 ? -1 : cookieTime);
		CookieHelper.setCookie(request, response, "loginuser", (String) member.get("username"), cookieTime);
		CookieHelper.removeCookie(request, response, "_refer");
		sGlobal.put("supe_uid", space.get("uid"));
		Map<String, Object> setData = new HashMap<String, Object>();
		boolean avatarExists = mainService.ckavatar(sGlobal, sConfig, (Integer) space.get("uid"));
		int avatar = (Integer) space.get("avatar");
		if (avatarExists) {
			if (avatar == 0) {
				Map<String, Integer> reward = Common.getReward("setavatar", false, 0, "", true, request, response);
				int credit = reward.get("credit");
				int experience = reward.get("experience");
				if (credit > 0) {
					setData.put("credit", "credit=credit+" + credit);
				}
				if (experience > 0) {
					setData.put("experience", "experience=experience+" + experience);
				}
				setData.put("avatar", "avatar=1");
				setData.put("updatetime", "updatetime=" + sGlobal.get("timestamp"));
			}
		} else if (avatar > 0) {
			setData.put("avatar", "avatar=0");
		}
		if (setData.size() > 0) {
			dataBaseService.executeUpdate("UPDATE sns_space SET " + Common.implode(setData, ",") + " WHERE uid='" + space.get("uid") + "'");
		}
		request.getSession().setAttribute("User", userName);
		response.getWriter().print("//success");
		return null;
	}

	/**
	 * 用户退出
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ActionForward signout(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> sGlobal = (Map<String, Object>) request.getAttribute("sGlobal");
		int supe_uid = (Integer) sGlobal.get("supe_uid");
		if (supe_uid > 0) {
			dataBaseService.executeUpdate("DELETE FROM sns_session WHERE uid=" + supe_uid);
			dataBaseService.executeUpdate("DELETE FROM sns_adminsession WHERE uid=" + supe_uid);
		}
		CookieHelper.clearCookie(request, response);
		CookieHelper.removeCookie(request, response, "_refer");
		// 清空第三方session信息
		HttpSession session = request.getSession();
		if (session.getAttribute("third") != null) {
			session.invalidate();
		}
		response.getWriter().print("//success");
		return null;
	}

}