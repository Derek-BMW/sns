<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="com.tmwsoft.sns.util.SysConstants"%>
<%@page import="com.tmwsoft.sns.service.DataBaseService"%>
<%
Map<String,Object> task = (Map<String,Object>)request.getAttribute("task");

boolean done = false;
DataBaseService dataBaseService = (DataBaseService)request.getAttribute("dataBaseService");
Map<String,Object> space = (Map<String,Object>)request.getAttribute("space");
int space_uid = (Integer)space.get("uid");
String querySql = "SELECT mobilestatus FROM sns_space WHERE uid='"+space_uid+"'";
List<Map<String,Object>> query = dataBaseService.executeQuery(querySql);
int mobilestatus = 0;
if(query.size() == 1) {
	mobilestatus = (Integer)(query.get(0).get("mobilestatus"));
}
if(mobilestatus == 1){
	task.put("done", 1);//任务完成
	task.put("result", "你已完成本任务，你还可以去领取景区电子优惠卷任务！");//用户参与任务看到的文字说明。支持html代码
}else{
	task.put("guide", "<strong>请按照以下的说明来参与本任务：</strong>" +
			"<ul>" +
			"<li><a href=\"main.action?ac=profile&op=contact\" target=\"_blank\">新窗口打开个人资料的联系方式页面</a>；</li>" +
			"<li>1. 在新打开的联系方式页面中，填写自己的手机号，并点“获取验证码”按钮；</li>" +
			"<li>2. 几分钟内，系统会给你发送一条短信息，收到短信息后，在短信验证码栏输入你收到的验证码，并点“保存”或者“继续下一项”按钮。</li>" +
			"<li>3. 注意：手机验证通过后将不能修改手机号。</li>" +
			"</ul>");
}
%>

