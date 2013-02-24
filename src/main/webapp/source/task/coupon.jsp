<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
Map<String,Object> task = (Map<String,Object>)request.getAttribute("task");

boolean done = false;

if(done){
	task.put("done", 1);//任务完成
	task.put("result", "......");//用户参与任务看到的文字说明。支持html代码
}else{
	task.put("guide", "<strong>请按照以下的说明来参与本任务：</strong>" +
			"<ul>" +
			"<li><a href=\"main.action?ac=profile&op=contact\" target=\"_blank\">新窗口打开优惠卷领取页面</a>；</li>" +
			"<li>1. 在新打开的优惠卷领取页面中，填写自己的手机号，并点“获取验证码”按钮；</li>" +
			"<li>2. 几分钟后，系统会给你发送一条短信息，收到短信息后，在验证码输入栏输入你收到的验证码，并点“确认”按钮。</li>" +
			"<li>3. 系统验证通过后，你就可以凭手机号到景区取票处领取优惠卷。</li>" +
			"</ul>");
}
%>

