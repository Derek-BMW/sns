package com.tmwsoft.sns.web.action.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmwsoft.sns.util.Common;
import com.tmwsoft.sns.web.action.BaseAction;

/**
 * <code>BlogClassesAction.java</code> is the interface of outputting the logs.
 * 
 * @author Sol Zhang
 * @version 1.0, 2012-6-8
 */
public class BlogClassesAction extends BaseAction {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {

		if (!Common.checkPerm(request, response, "manageblogclasses")) {
			return cpMessage(request, mapping, "cp_no_authority_management_operation");
		}
		Map<String, Object> sGlobal = (Map<String, Object>) request.getAttribute("sGlobal");
		Map<String, Object> sConfig = (Map<String, Object>) request.getAttribute("sConfig");
		String op = request.getParameter("op");
		String submit = request.getParameter("submit");

		if ("add".equals(op)) {
			request.setAttribute("blogclass", new HashMap());
		} else if (("delete".equals(op) || "edit".equals(op)) && StringUtils.isEmpty(submit)) {
			String classid = request.getParameter("id");
			String sql = "SELECT * FROM sns_class WHERE classid = " + classid;
			List<Map<String, Object>> query = dataBaseService.executeQuery(sql);

			if (query.size() == 1) {
				request.setAttribute("blogclass", query.get(0));
			}
		} else {
			if (StringUtils.isNotEmpty(submit)) {
				String id = request.getParameter("id");
				if ("delete".equals(op)) {
					if (StringUtils.isNotEmpty(id)) {
						dataBaseService.execute("delete from sns_class where classid=" + id);
					}
					op = "";
				} else {
					if (StringUtils.isNotEmpty(id)) {
						String classname = request.getParameter("classname");
						if (StringUtils.isNotEmpty(classname)) {
							// 更新操作
							Map<String, Object> setArr = new HashMap<String, Object>();
							Map<String, Object> whereArr = new HashMap<String, Object>();

							setArr.put("classname", classname);
							whereArr.put("classid", id);
							dataBaseService.updateTable("sns_class", setArr, whereArr);
						}
					} else {
						// 新建操作
						String classname = request.getParameter("classname");
						if (StringUtils.isNotEmpty(classname)) {
							Map<String, Object> setArr = new HashMap<String, Object>();
							setArr.put("classname", classname);
							setArr.put("uid", "0");
							setArr.put("dateline", sGlobal.get("timestamp"));
							dataBaseService.insertTable("sns_class", setArr, true, false);
						}
					}
				}
			}

			String sql = "SELECT * FROM sns_class WHERE uid = 0 order by classid asc";
			List<Map<String, Object>> query = dataBaseService.executeQuery(sql);
			request.setAttribute("blogclasses", query);
		}

		request.setAttribute("op", op);

		return mapping.findForward("blogclasses");
	}
}
