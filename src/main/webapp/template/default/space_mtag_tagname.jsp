<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<jsp:include page="${sns:template(sConfig, sGlobal, 'header.jsp')}"/>

<div class="tabs_header">
	<ul class="tabs">
		<li class="active"><a href="#"><span>访问群组</span></a></li>
		<li><a href="zone.action?do=mtag&view=me"><span>返回我的群组</span></a></li>
	</ul>
</div>

<c:choose>
<c:when test="${not empty taglist}">
<table cellspacing="0" cellpadding="0" class="formtable">
	<caption>
		<h2>选择访问群组</h2>
		<p>您要访问的群组当前有多个，请根据自己的喜好，选择一个群组进行访问。</p>
	</caption>
	<c:forEach items="${taglist}" var="value">
	<tr>
		<td><a href="zone.action?do=mtag&tagid=${value.tagid}" style="font-size:14px;" target="_blank">${value.tagname}</a></td>
		<td>${globalProfield[value.fieldid].title}</td>
		<td>${value.membernum} 位成员</td>
		<td>
			<a href="zone.action?do=mtag&tagid=${value.tagid}" target="_blank">立即访问本群组</a>
			<span class="pipe">|</span>
			<c:choose>
			<c:when test="${value.joinperm<2}">
			<a href="main.action?ac=mtag&op=join&tagid=${value.tagid}" id="mtag_like_${value.tagid}" onclick="ajaxmenu(event, this.id)">选择加入该群组</a>
			</c:when>
			<c:otherwise>
			<strong>本群组需要群主邀请才可加入</strong>
			</c:otherwise>
			</c:choose>
		</td>
	</tr>
	</c:forEach>
</table>
</c:when>
<c:otherwise>

<form method="post" action="main.action?ac=mtag" class="c_form">
<input type="hidden" name="formhash" value="${sns:formHash(sGlobal, sConfig,false)}" />
<table cellspacing="0" cellpadding="0" class="formtable">
	<caption>
		<h2>创建群组: ${tagname}</h2>
		<p>您要访问的群组现在还没有创建，您可以来创建这个群组，并邀请好友来访问。</p>
	</caption>
	<tr>
		<th width="120">群组名称</th>
		<td>${tagname}</td>
	</tr>
	<tr>
		<th width="120">群组分类</th>
		<td>
		<select name="fieldid">
		<c:forEach items="${fields}" var="value">
		<option value="${value.fieldid}">${value.title}</option>
		</c:forEach>
		</select>
		</td>
	</tr>
	<tr>
		<td></td><td>
			<input type="hidden" name="tagname" value="${tagname}">
			<input type="submit" name="textsubmit" value="创建群组" class="submit">
		</td>
	</tr>
</table>
</form>
</c:otherwise>
</c:choose>

<jsp:include page="${sns:template(sConfig, sGlobal, 'footer.jsp')}"/>