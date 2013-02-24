<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<c:if test="${sns:snsEmpty(ajax_edit)}"><div id="post_${postValue.pid}_li"></c:if>
<ul class="line_list">
	<li>
	<table width="100%">
	<tr>
		<td width="70" valign="top">
			<div class="avatar48"><a href="zone.action?uid=${postValue.uid}">${sns:avatar1(postValue.uid,sGlobal,sConfig)}</a></div>
		</td>
		<td>
			<div class="title">
				<div class="r_option">
					<c:if test="${mtag.grade>=8 || postValue.uid==sGlobal.supe_uid || (eventid>0 && userevent.status>=3)}">
					<a href="main.action?ac=thread&op=edit&pid=${postValue.pid}" id="p_${postValue.pid}_edit" onclick="ajaxmenu(event, this.id, 1)">编辑</a>
					<a href="main.action?ac=thread&op=delete&pid=${postValue.pid}&tagid=${thread.tagid}" id="p_${postValue.pid}_delete" onclick="ajaxmenu(event, this.id)">删除</a>
					</c:if>
					<c:if test="${postValue.uid!=sGlobal.supe_uid && ((!sns:snsEmpty(mtag.allowpost) && eventid==0) || (eventid>0 && userevent.status>1))}"><a href="main.action?ac=thread&op=reply&pid=${postValue.pid}" id="p_${postValue.pid}_reply" onclick="ajaxmenu(event, this.id, 1)">回复</a> </c:if>
					<a href="main.action?ac=common&op=report&idtype=post&id=${postValue.pid}" id="a_report_${postValue.pid}" onclick="ajaxmenu(event, this.id, 1)">举报</a>
					<span class="gray">#${postValue.num}</span>
				</div>
				<a href="zone.action?uid=${postValue.uid}">${sNames[postValue.uid]}</a> 
				<span class="gray"><sns:date dateformat="yyyy-MM-dd HH:mm" timestamp="${postValue.dateline}" format="1"/></span>
			</div>
			<div class="detail" id="detail_${postValue.pid}">
				${postValue.message}
				<c:if test="${!sns:snsEmpty(postValue.pic)}"><div><a href="${postValue.pic}" target="_blank"><img src="${postValue.pic}" class="resizeimg" /></a></div></c:if>
			</div>
		</td>
	</tr>
	</table>
	</li>
</ul>
<c:if test="${sns:snsEmpty(ajax_edit)}"></div></c:if>