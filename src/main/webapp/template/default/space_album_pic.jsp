<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<jsp:include page="${sns:template(sConfig, sGlobal, 'header.jsp')}" />
<c:choose>
	<c:when test="${space.self}">
		<h2 class="title"><img src="image/app/album.gif">${album.albumname}</h2>
		<div class="tabs_header">
			<ul class="tabs">
				<li class="active"><a href="zone.action?uid=${pic.uid}&do=album&id=${pic.albumid}"><span>查看图片</span></a></li>
				<li><a href="zone.action?uid=${space.uid}&do=album&id=${pic.albumid}"><span>返回列表</span></a></li>
				<li><a href="zone.action?uid=${space.uid}&do=album&view=me"><span>返回我的相册</span></a></li>
				<li class="null"><a href="main.action?ac=upload&albumid=${pic.albumid}">上传新图片</a></li>
			</ul>
		<div class="searchbar floatright">
			<form method="get" action="zone.action">
				<input name="searchkey" value="" size="15" class="t_input" type="text">
				<input name="searchsubmit" value="搜索相册" class="submit" type="submit">
				<input type="hidden" name="do" value="album" />
				<input type="hidden" name="view" value="all" />
				<input type="hidden" name="orderby" value="dateline" />
			</form>
		</div>
		</div>
	</c:when>
	<c:when test="${sCookie.currentsite ne 'space'}">
	<jsp:include page="${sns:template(sConfig, sGlobal, 'space_menu.jsp')}" />
	</c:when>
</c:choose>
<jsp:include page="${sns:template(sConfig, sGlobal, 'space_pic.jsp')}" />
<jsp:include page="${sns:template(sConfig, sGlobal, 'footer.jsp')}" />