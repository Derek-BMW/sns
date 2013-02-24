<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<jsp:include page="${sns:template(sConfig, sGlobal, 'header.jsp')}"/>

<div class="searchbar floatright">
<form method="post" action="zone.action">
	<input name="searchkey" value="" size="15" class="t_input" type="text">
	<input name="searchsubmit" value="搜索群组" class="submit" type="submit">
	<input type="hidden" name="searchmode" value="1" />
	<input type="hidden" name="do" value="mtag" />
	<input type="hidden" name="view" value="hot" />
</form>
</div>

<c:if test="${space.self}">
<div class="tabs_header">
	<ul class="tabs">
		<li><a href="zone.action?uid=${space.uid}&do=thread"><span>群组话题</span></a></li>
		<li><a href="zone.action?do=mtag&view=me"><span>我参与的群组</span></a></li>
		<li><a href="zone.action?do=mtag&view=manage"><span>我管理的群组</span></a></li>
		<li class="active"><a href="zone.action?do=mtag&view=hot"><span>热门群组</span></a></li>
		<li><a href="zone.action?do=mtag&view=recommend"><span>推荐群组</span></a></li>
		<li class="null"><a href="main.action?ac=thread">发起新话题</a></li>
		<li class="null"><a href="main.action?ac=mtag">创建群组</a></li>
	</ul>
</div>
</c:if>
<div class="h_status">
群组分类：
<a href="zone.action?do=mtag&view=hot">全部</a>
<c:forEach items="${globalProfield}" var="profield">
<span class="pipe">|</span><a href="zone.action?do=mtag&id=${profield.value.fieldid}"${sub_actives[profield.value.fieldid]}>${profield.value.title}</a>
</c:forEach>
</div>
<div class="box">
	<c:choose>
	<c:when test="${not empty list}">
	<ul class="thread_list">
	<c:forEach items="${list}" var="value">
		<li>
			<div class="threadimg60"><a href="zone.action?do=mtag&tagid=${value.tagid}"><img src="${value.pic}" style="width:60px;"></a></div>
			<a href="zone.action?do=mtag&tagid=${value.tagid}">${value.tagname}</a><br />
			已有 <span class="num">${value.membernum}</span> 人加入
			<div class="gray">
				话题: ${value.threadnum}, 回帖: ${value.postnum}
			</div>
		</li>
	</c:forEach>
	</ul>
	<div class="page">${multi}</div>
	</c:when>
	<c:otherwise>
	<p>还没有群组。</p>
	</c:otherwise>
	</c:choose>
</div>
<jsp:include page="${sns:template(sConfig, sGlobal, 'footer.jsp')}"/>