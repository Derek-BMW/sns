<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<h2 class="title">
	<img src="image/app/topic.gif" /><a href="zone.action?do=topic&topicid=${topicid}">${topic.subject}</a>
</h2>
<div class="tabs_header">
	<ul class="tabs">
		<li class="active"><a href="javascript:;"><span>凑个热闹</span></a></li>
		<li><a href="zone.action?do=topic&topicid=${topicid}"><span>查看热闹</span></a></li>
	</ul>
	<c:if test="${sns:checkPerm(pageContext.request, pageContext.response,'managetopic') || topic.uid == sGlobal.supe_uid}">
	<div class="r_option">
		<a href="main.action?ac=topic&op=edit&topicid=${topic.topicid}">编辑</a> | 
		<a href="main.action?ac=topic&op=delete&topicid=${topic.topicid}" id="a_delete_${topic.topicid}" onclick="ajaxmenu(event,this.id);">删除</a>
		</p>
	</div>
	</c:if>
</div>
<jsp:include page="${sns:template(sConfig, sGlobal, 'space_topic_inc.jsp')}"/>