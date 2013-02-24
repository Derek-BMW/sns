<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<jsp:include page="${sns:template(sConfig, sGlobal, 'header.jsp')}" />
<div class="tabs_header">
	<ul class="tabs">
		<c:if test="${sCookie.currentsite ne 'space'}">
		<li${actives.new}><a href="zone.action?do=topic&view=new"><span>最新参与</span></a></li>
		<li${actives.hot}><a href="zone.action?do=topic&view=hot"><span>最热参与</span></a></li>
		</c:if>
		<c:if test="${sGlobal.supe_uid>0}">
		<li${actives.me}><a href="zone.action?do=topic&view=me"><span>我参与的热闹</span></a></li>
		</c:if>
		<li class="null"><a href="main.action?ac=topic">添加新热闹</a></li>
	</ul>
</div>
<c:choose>
	<c:when test="${not empty list}">
		<div class="event_list">
			<ol>
				<c:forEach items="${list}" var="value">
					<li>
						<div class="event_icon"><a href="zone.action?do=topic&topicid=${value.topicid}"><img src="${value.pic}"></a></div>
						<div class="hotspot"><a href="zone.action?do=topic&topicid=${value.topicid}">${value.joinnum}</a></div>
						<div class="event_content">
							<h4 class="event_title"><a href="zone.action?do=topic&topicid=${value.topicid}">${value.subject}</a></h4>
							<ul>
								<li>${value.message} ...</li>
								<li class="gray">发起作者: <a href="zone.action?uid=${value.uid}">${sNames[value.uid]}</a></li>
								<li class="gray">发起时间: ${value.dateline}</li>
								<c:if test="${not empty value.endtime}"><li class="gray">参与截止: ${value.endtime}</li></c:if>
								<li class="gray">最后参与: ${value.lastpost}</li>
							</ul>
						</div>
					</li>
				</c:forEach>
			</ol>
		</div>
	</c:when>
	<c:otherwise><div class="c_form">目前还没有相关列表。</div></c:otherwise>
</c:choose>
<jsp:include page="${sns:template(sConfig, sGlobal, 'footer.jsp')}" />