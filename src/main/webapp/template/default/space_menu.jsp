<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<div class="c_header a_header">
	<div class="avatar48"><a href="zone.action?uid=${space.uid }">${sns:avatar1(space.uid,sGlobal, sConfig)}</a></div>
	<c:if test="${!sns:snsEmpty(sGlobal.refer)}">
		<a href="${sGlobal.refer }" class="r_option">&laquo; 返回上一页</a>
	</c:if>
	<p style="font-size:14px">${sNames[space.uid] }的${TPL.spacetitle}</p>
	<a href="zone.action?uid=${space.uid}" class="spacelink">${sNames[space.uid] }的主页</a>
	<c:if test="${not empty TPL.spacemenus}">
		<c:forEach items="${TPL.spacemenus}" var="value"> <span class="pipe">&raquo;</span> ${value}</c:forEach>
	</c:if>
</div>
