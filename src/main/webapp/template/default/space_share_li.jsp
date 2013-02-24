<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<c:if test="${sns:snsEmpty(ajax_edit)}"><li id="share_${share.sid}_li"></c:if>
	<div class="title">
		<div class="r_option">
		<c:if test="${share.sid>0 && (sGlobal.supe_uid==share.uid || sns:checkPerm(pageContext.request, pageContext.response,'manageshare'))}">
		<a href="main.action?ac=topic&op=join&id=${share.sid}&idtype=sid" id="a_topicjoin_${share.sid}" onclick="ajaxmenu(event, this.id)">凑热闹</a><span class="pipe">|</span>
		</c:if>
		<c:if test="${share.sid>0}"><a href="zone.action?uid=${share.uid}&do=share&id=${share.sid}">评论</a>&nbsp;</c:if>
		<c:if test="${share.uid==sGlobal.supe_uid}"><c:if test="${share.type=='link' || share.type=='video' || share.type=='music'}"><span class="pipe">|</span></c:if><a href="main.action?ac=share&op=delete&sid=${share.sid}" id="s_${share.sid}_delete" onclick="ajaxmenu(event, this.id)">删除</a></c:if>
		</div>
		<a href="zone.action?uid=${share.uid}">${sNames[share.uid]}</a> <a href="zone.action?uid=${share.uid}&do=share&id=${share.sid}">${share.title_template}</a>
		&nbsp;<span class="gray"><sns:date dateformat="yyyy-MM-dd HH:mm" timestamp="${share.dateline}" format="1"/></span>
	</div>
	<div class="feed">
	<div style="width:100%;overflow:hidden;">
	<c:if test="${!sns:snsEmpty(share.image)}">
	<a href="${share.image_link}"><img src="${share.image}" class="summaryimg image" alt="" width="70" /></a>
	</c:if>
	<div class="detail">
	${share.body_template}
	</div>
	<c:choose>
	<c:when test="${'video'==share.type}">
	<div class="media">
	<div class="movie_app">
	<c:if test="${!sns:snsEmpty(share.body_data.flashimg)}">
			<img class="movie_icon" id="icon_id_${share.sid}" src="image/movie_icon.png" alt="点击播放" onclick="javascript:showFlash('${share.body_data.host}', '${share.body_data.flashvar}', this, '${share.sid}');" style="cursor:pointer;" />		
	</c:if>
	<img class="movie_pic" id="media_id_${share.sid}" src="${sns:snsEmpty(share.body_data.flashimg)  ?  'image/vd.gif'  :  share.body_data.flashimg}" alt="点击播放" onerror="this.onerror=null;this.src='image/vd.gif'" onclick="javascript:showFlash('${share.body_data.host}', '${share.body_data.flashvar}', this, '${share.sid}');" style="cursor:pointer;" />
	</div>
	</div>
	</c:when>
	<c:when test="${'music'==share.type}">
	<div class="media">
	<img src="image/music.gif" alt="点击播放" onclick="javascript:showFlash('music', '${share.body_data.musicvar}', this, '${share.sid}');" style="cursor:pointer;" />
	</div>
	</c:when>
	<c:when test="${'flash'==share.type}">
	<div class="media">
	<img src="image/flash.gif" alt="点击查看" onclick="javascript:showFlash('flash', '${share.body_data.flashaddr}', this, '${share.sid}');" style="cursor:pointer;" />
	</div>
	</c:when>
	</c:choose>
	<div class="quote"><span id="quote" class="q">${share.body_general}</span></div>
	</div>
	</div>
	<br>
<c:if test="${sns:snsEmpty(ajax_edit)}"></li></c:if>