<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<jsp:include page="${sns:template(sConfig, sGlobal, 'header.jsp')}"/>

<div class="tabs_header">
	<ul class="tabs">
		<c:if test="${sCookie.currentsite ne 'space'}">
		<li><a href="zone.action?uid=${space.uid}&do=doing&view=all"><span>大家的心情</span></a></li>
		</c:if>
		<c:if test="${space.self}">
		<li><a href="zone.action?uid=${space.uid}&do=doing&view=me"><span>我的心情</span></a></li>
		<c:if test="${space.friendnum>0}"><li><a href="zone.action?uid=${space.uid}&do=doing&view=we"><span>最新好友心情</span></a></li></c:if>
		<li class="active"><a href="zone.action?uid=${space.uid}&do=mood&view=all"><span>同心情的朋友</span></a></li>
		</c:if>
	</ul>
</div>

<div class="h_status">
	他们现在与你有着同样的心情
</div>

<jsp:include page="${sns:template(sConfig, sGlobal, 'space_list.jsp')}"/>

<jsp:include page="${sns:template(sConfig, sGlobal, 'footer.jsp')}"/>