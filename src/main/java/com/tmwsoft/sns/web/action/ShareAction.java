package com.tmwsoft.sns.web.action;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmwsoft.sns.util.Common;
import com.tmwsoft.sns.util.Common.WithWordshieldStatus;
import com.tmwsoft.sns.util.Serializer;

public class ShareAction extends BaseAction {

	private static final Logger LOG = Logger.getLogger(ShareAction.class);

	/**
	 * @param mapping
	 * @param form
	 * @param request
	 *            查询串中的key url：要分享的网址，分享的网址要求转码。不能为空 desc：介绍。不能为空 site：来源网站
	 *            type：分享内容类型 url、video、flash、text
	 *            http://www.lysns.net/share.action?desc=xxx&site=www.xxx.com&type=url&url=http://www.xxx.com 或者 
	 *            http://www.lysns.net/shareToSns.action?action=input&desc=xxx&site=www.xxx.com&type=url&url=http://www.xxx.com
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward input(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> sGlobal = (Map<String, Object>) request.getAttribute("sGlobal");
		Map<String, Object> sConfig = (Map<String, Object>) request.getAttribute("sConfig");
		return mapping.findForward("share_home");
	}

	public ActionForward submitShare(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> sGlobal = (Map<String, Object>) request.getAttribute("sGlobal");
		Map<String, Object> sConfig = (Map<String, Object>) request.getAttribute("sConfig");
		Map<String, Object> space = (Map<String, Object>) request.getAttribute("space");
		/*
		 * <input type="hidden" id="s_u" name="u" value="" /> 
		 * <input type="hidden" id="s_p" name="p" value="" /> 
		 * <input type="hidden" id="s_url" name="url" value="" /> 
		 * <input type="hidden" id="s_desc" name="desc" value="" />
		 */

		// 判断用户是否登录
		boolean isLogin = false;
		Map session = (Map) sGlobal.get("session");
		if (session != null && StringUtils.isNotEmpty((String) session.get("username")) && StringUtils.isNotEmpty((String) session.get("password"))) {
			isLogin = true;
		}
		// 获取参数
		String login_user = request.getParameter("u");
		String login_password = request.getParameter("p");
		String share_url = request.getParameter("url");
		String share_desc = request.getParameter("desc");
		String message = "";

		if (!isLogin) {
			// 如果用户没有登录,就使用login_user, login_password验证
			if (StringUtils.isNotEmpty(login_user) && StringUtils.isNotEmpty(login_password)) {

				// 验证社区用户
				if (check_sns_user(login_user, login_password)) {
					// 验证成功提交分享
					message = submit_share(request, response, sGlobal, sConfig, space, login_user, share_url, share_desc);
				} else {
					// 社区账号不正确,不能提交分享
					message = "社区账号不正确,不能提交分享";
				}
			} else {
				// 社区账号不正确,不能提交分享
				message = "社区账号不正确,不能提交分享";
			}
		} else {
			// 使用当前登录的社区用户提交分享
			message = submit_share(request, response, sGlobal, sConfig, space, (String) session.get("username"), share_url, share_desc);
		}

		LOG.info("社区分享 : " + message);
		request.setAttribute("message", message);
		return mapping.findForward("share_success");
	}

	/**
	 * 社区用户信息检查
	 * 
	 * @param login_user
	 * @param login_password
	 * @return
	 */
	private boolean check_sns_user(String login_user, String login_password) {
		List<Map<String, Object>> members = dataBaseService.executeQuery("SELECT * FROM sns_member WHERE username = '" + login_user + "'");
		if (members.isEmpty()) {
			return false;
		}
		Map<String, Object> member = members.get(0);
		login_password = Common.md5(Common.md5(login_password) + member.get("salt"));

		if (!login_password.equals(member.get("password"))) {
			return false;
		}
		return true;
	}

	/**
	 * 提交分享
	 * 
	 * @param request
	 * @param login_user
	 * @param share_url
	 * @param share_desc
	 */
	private String submit_share(HttpServletRequest request, HttpServletResponse response, Map<String, Object> sGlobal, Map<String, Object> sConfig,
			Map<String, Object> space, String login_user, String link, String share_desc) {
		try {
			link = link != null ? link : "";
			link = (String) Common.sHtmlSpecialChars(link.trim());
			if (!Common.empty(link)) {
				if (!link.matches("(?i)^(http|ftp|https|mms)://.{4,300}$")) {
					link = "";
				}
			}
			if (Common.empty(link)) {
				return "链接格式不对";
			}

			Map<String, Object> arr = new HashMap<String, Object>();

			arr.put("title_template", Common.getMessage(request, "cp_share_link"));
			arr.put("body_template", "{link}");
			String link_text;
			try {
				link_text = Common.sub_url(link, 50);
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
				LOG.info(e);
				return "发布分享信息失败";
			}
			Map<String, String> body_data = new HashMap<String, String>();
			body_data.put("link", "<a href=\"" + link + "\" target=\"_blank\">" + link_text + "</a>");
			body_data.put("data", link);
			arr.put("body_data", body_data);

			/*
			 * 需要执行词语屏蔽功能
			 */
			// arr.put("body_general", Common.getStr(share_desc, 150, true, true, true, 1, 0, request, response));
			Map<String, Object> results = Common.getStrWithWordshield(share_desc, 150, true, true, 1, request, response);
			WithWordshieldStatus audit_status = (WithWordshieldStatus) results.get("STATUS");
			if (audit_status != WithWordshieldStatus.AUDIT_PASS) {
				LOG.info("分享内容中存在非法文字");
				return "分享内容中存在非法文字";
			}
			arr.put("body_general", (String) results.get("STR"));

			String type = "link";
			int supe_uid = (Integer) sGlobal.get("supe_uid");
			int topicid = 0;
			arr.put("type", type);
			arr.put("uid", supe_uid);
			arr.put("username", sGlobal.get("supe_username"));
			arr.put("dateline", sGlobal.get("timestamp"));
			arr.put("topicid", topicid);
			arr.put("body_data", Serializer.serialize(arr.get("body_data")));
			Map<String, Object> setarr = (Map<String, Object>) Common.sAddSlashes(arr);
			if (setarr.get("hotuser") == null) {
				setarr.put("hotuser", "");
			}
			if (setarr.get("title_template") == null) {
				setarr.put("title_template", "");
			}
			int sid = dataBaseService.insertTable("sns_share", setarr, true, false);
			mainService.updateStat(request, "share", false);

			String sharenumsql;
			sharenumsql = "sharenum=sharenum+1";

			String needle = "";
			Map<String, Integer> reward = Common.getReward("createshare", false, 0, needle, true, request, response);
			int timestamp = (Integer) sGlobal.get("timestamp");
			Integer credit = reward.get("credit");
			if (credit == null) {
				credit = 0;
				reward.put("credit", credit);
			}
			Integer experience = reward.get("experience");
			if (experience == null) {
				experience = 0;
				reward.put("experience", experience);
			}
			dataBaseService.executeUpdate("UPDATE sns_space SET " + sharenumsql + ", lastpost='" + timestamp + "', updatetime='" + timestamp
					+ "', credit=credit+" + credit + ", experience=experience+" + experience + " WHERE uid='" + supe_uid + "'");
			if (Common.ckPrivacy(sGlobal, sConfig, space, "share", 1)) {
				feedService.feedPublish(request, response, sid, "sid", true);
			}

			request.setAttribute("link", "zone.action?uid=" + supe_uid + "&do=share&id=" + sid);

			LOG.info("社区分享 : do share");
			return "分享成功";

		} catch (Exception e) {
			e.printStackTrace();
			LOG.info(e);
			return "发布分享信息失败";
		}
	}

}