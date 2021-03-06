﻿<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<c:if test="${sGlobal.inajax==0}">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 <title>${navtitle}<c:if test="${not empty sNames[space.uid]}">${sNames[space.uid]} - </c:if>${sConfig.sitename}</title>
 <meta http-equiv="content-type" content="text/html; charset=${snsConfig.charset}" />
 <meta http-equiv="x-ua-compatible" content="ie=7" />
 <meta property="qc:admins" content="24512666676413636654" />
 <meta name="keywords" content="${sConfig.keywords}" />
 <meta name="description" content="${sConfig.description}" />
 <script language="javascript" type="text/javascript" src="source/script_cookie.js"></script>
 <script language="javascript" type="text/javascript" src="source/script_common.js"></script>
 <script language="javascript" type="text/javascript" src="source/script_menu.js"></script>
 <script language="javascript" type="text/javascript" src="source/script_ajax.js"></script>
 <script language="javascript" type="text/javascript" src="source/script_face.js"></script>
 <script language="javascript" type="text/javascript" src="source/script_manage.js"></script>
 <script language="javascript" type="text/javascript" src="source/script_plug.js"></script>
 <style type="text/css">
  @import url(template/${sConfig.template}/style.css);
  @import url(template/${sConfig.template}/gift.css);
  <c:if test="${!empty tpl_css}">@import url(template/${sConfig.template}/${tpl_css}.css);</c:if>
  <c:choose>
   <c:when test="${not empty sGlobal.space_theme}">@import url(theme/${sGlobal.space_theme}/style.css);</c:when>
  </c:choose>
  <c:if test="${!empty sGlobal.space_css}">${sGlobal.space_css}</c:if>
 </style>
 <link rel="shortcut icon" href="favicon.ico">
 
 <!--[if lt IE 7]>
 <script src="source/DD_belatedPNG_0.0.8a-min.js" type="text/javascript" charset="utf-8"></script>
 <script type="text/javascript">DD_belatedPNG.fix('.logo a, .logo_small a');</script>  
 <![endif]-->
 
 <script language="javascript" type="text/javascript" src="source/jquery.min.js"></script>
 <script>
 	jQuery.noConflict();
 </script>
</head>
<body>
<div class="nav_topfixed">
	<div id="wrap">
		<span style="float:left;">
    		<c:choose>
   			<c:when test="${sCookie.currentsite eq 'space'}">
   			<span class="logo_small"><a href="/sns">旅游社区</a></span>
   			</c:when>
   			<c:otherwise>
   			<a href="/store">在线商店</a>
   			</c:otherwise>
  			</c:choose>
   			<c:if test="${sGlobal.supe_uid>0}">
    		<a href="zone.action?do=home">个人中心</a>
    		<a href="zone.action">我的主页</a>
    		<a href="zone.action?do=pm${sGlobal.member.newpm>0 ? '&filter=newpm' : ''}" id="msgtips">消息${sGlobal.member.newpm>0 ? '(新)' : ''}</a>
    		<c:if test="${sGlobal.member.allnotenum>0}"><a class="notify" id="membernotemenu" onmouseover="showMenu(this.id)" href="zone.action?do=notice">${sGlobal.member.allnotenum}个提醒</a></c:if>
   			</c:if>
    	</span>
		<div style="float:right;">
  	<c:choose>
   	<c:when test="${sGlobal.supe_uid>0}">
    <c:choose>
      <c:when test="${empty sessionScope.nickName}">
      <a href="zone.action?uid=${sGlobal.supe_uid}" class="login_thumb">${sns:avatar1(sGlobal.supe_uid,sGlobal,sConfig)}</a>
      <a href="zone.action?uid=${sGlobal.supe_uid}" class="loginName">${sNames[sGlobal.supe_uid]}</a>
      </c:when>
      <c:otherwise>
      <a href="zone.action?uid=${sGlobal.supe_uid}" class="login_thumb"><img src="${herderIcon}" /></a>
      <a href="zone.action?uid=${sGlobal.supe_uid}" class="loginName"><img src="image/thirdLogin/${sessionScope.third}/16-16.png" width="11px" height="11px" />${nickName}</a>
      </c:otherwise>
    </c:choose>
    <c:if test="${sGlobal.member.credit>0}">
    <a href="main.action?ac=credit" title="我的积分"><img src="image/credit.gif" style="padding:9px 0 0 0;" />${sGlobal.member.credit}</a>
    </c:if>
    <a href="main.action?ac=task">任务</a>|
    <a href="main.action?ac=magic">道具</a>|
    <a href="main.action">设置</a>|
    <a href="main.action?ac=common&op=logout&uhash=${sGlobal.uhash}">退出</a>
   	</c:when>
   	<c:otherwise>
    <a href="operate.action?ac=${sConfig.register_action}" class="login_thumb">${sns:avatar1(sGlobal.supe_uid,sGlobal,sConfig)}</a> 欢迎您！&nbsp;
    <a href="operate.action?ac=${sConfig.login_action}">登录社区</a>|
    <a href="operate.action?ac=${sConfig.register_action}">注册会员</a>
   	</c:otherwise>
  	</c:choose>
		</div>
	</div>
</div>
<div id="header" class="wrap">
  <div class="headerwarp">
  <div>
  	<c:choose>
  	<c:when test="${sCookie.currentsite ne 'space' or space.uid eq 0}">
  	<h1 class="logo"><a href="portal.action">旅游社区</a></h1>
  	</c:when>
  	<c:otherwise>
    <div class="space_head_title">
    <h1>
      <c:choose>
	  <c:when test="${!sns:snsEmpty(space.nickname)}">${space.nickname}</c:when>
	  <c:otherwise>${space.username}</c:otherwise>
	  </c:choose>
	  ${space.star}<br/>
	</h1>
	<p>${space.spacenote}</p>
	<a href="${space.domainurl}" onclick="javascript:setCopy('${space.domainurl}');return false;" class="spacelink domainurl">${space.domainurl}</a>
    </div>
  	</c:otherwise>
  	</c:choose>
  	<c:if test="${sCookie.currentsite ne 'space'}">
    <div id="ad_header">
    <c:if test="${!empty globalAd.header}">${sns:showAd(globalAd.header)}</c:if>
    </div>
    <div class="head_navigation">${sns:showAdById(12)}</div>
    </c:if>
  </div>
  </div>
  <div class="headermenu wrap">
    <ul class="menu">
    <c:choose>
    <c:when test="${sCookie.currentsite ne 'space' or space.uid eq 0}">
    <li><a href="portal.action">社区首页</a></li>
    <li><a href="zone.action?do=feed">动态</a></li>
    <li><a href="zone.action?do=blog">日志</a></li>
    <li><a href="zone.action?do=album">相册</a></li>
    <li><a href="zone.action?do=doing">心情</a></li>
    <li><a href="zone.action?do=mtag">群组</a></li>
    <li><a href="zone.action?do=event">活动</a></li>
    <li><a href="zone.action?do=poll">投票</a></li>
    <li><a href="zone.action?do=topic">热闹</a></li>
    <li><a href="zone.action?do=share">分享</a></li>
    </c:when>
    <c:otherwise>
    <li><a href="zone.action?uid=${param.uid}">主页</a></li>
    <li><a href="zone.action?uid=${param.uid}&view=me&do=blog">日志</a></li>
    <li><a href="zone.action?uid=${param.uid}&view=me&do=album">相册</a></li>
    <li><a href="zone.action?uid=${param.uid}&view=me&do=doing">心情</a></li>
    <li><a href="zone.action?uid=${param.uid}&do=wall">留言板</a></li>
    <c:if test="${sGlobal.supe_uid>0 and space.self}">
    <li><a href="zone.action?uid=${param.uid}&view=me&do=mtag">群组</a></li>
    <li><a href="zone.action?uid=${param.uid}&view=me&do=event">活动</a></li>
    <li><a href="zone.action?uid=${param.uid}&view=me&do=poll">投票</a></li>
    <li><a href="zone.action?uid=${param.uid}&view=me&do=topic">热闹</a></li>
    <li><a href="zone.action?uid=${param.uid}&view=me&do=share">分享</a></li>
    </c:if>
    </c:otherwise>
   	</c:choose>
  	<c:if test="${!empty sGlobal.appmenu}">
   	<c:choose>
    <c:when test="${!empty sGlobal.appmenus}">
    <li class="dropmenu" id="jcappmenu" onclick="showMenu(this.id)"><a href="javascript:;">站内导航</a></li>
    </c:when>
    <c:otherwise>
    <li><a target="_blank" href="${sGlobal.appmenu.url}" title="${sGlobal.appmenu.name}">${sGlobal.appmenu.name}</a></li>
    </c:otherwise>
   	</c:choose>
  	</c:if>
    </ul>
  </div>
</div>

 <div id="append_parent"></div>
 <div id="ajaxwaitid"></div>
 <div id="wrap" class="content">
<c:if test="${empty tpl_noSideBar}">
  <div id="main">
   <c:if test="${sCookie.currentsite ne 'space' or spaceLocation eq 'home'}">
   <div id="app_sidebar">
    <ul class="app_list" id="default_userapp">
     <c:if test="${sCookie.currentsite ne 'space'}">
     <li><img src="image/app/feed.gif"><a href="zone.action?do=feed">动态</a></li>
     <li><img src="image/app/blog.gif"><a href="zone.action?do=blog">日志</a><em><a href="main.action?ac=blog" class="gray">发表</a></em></li>
     <li><img src="image/app/album.gif"><a href="zone.action?do=album">相册</a><em><a href="main.action?ac=upload" class="gray">上传</a></em></li>
     <li><img src="image/app/doing.gif"><a href="zone.action?do=doing">心情</a></li>
     <li><img src="image/app/mtag.gif"><a href="zone.action?do=mtag">群组</a><em><a href="main.action?ac=thread" class="gray">话题</a></em></li>
     <li><img src="image/app/event.gif"><a href="zone.action?do=event">活动</a><em><a href="main.action?ac=event" class="gray">发起</a></em></li>
     <li><img src="image/app/poll.gif"><a href="zone.action?do=poll">投票</a><em><a href="main.action?ac=poll" class="gray">发起</a></em></li>
     <li><img src="image/app/topic.gif"><a href="zone.action?do=topic">热闹</a><em><a href="main.action?ac=topic" class="gray">添加</a></em></li>
     <li><img src="image/app/share.gif"><a href="zone.action?do=share">分享</a></li>
     </c:if>
     <c:if test="${sCookie.currentsite eq 'space' and space.self}">
     <li><img src="image/app/feed.gif"><a href="zone.action?do=feed&view=we">好友动态</a></li>
     <li><img src="image/app/feed.gif"><a href="zone.action?do=feed&view=hot">热门推荐</a></li>
     <li><img src="image/app/feed.gif"><a href="zone.action?do=feed&view=me">与我相关</a></li>
     </c:if>
    </ul>
    <c:if test="${sCookie.currentsite eq 'space' and space.self}">
    <ul class="app_list topline">
     <li><img src="image/icon/friend.gif"><a href="zone.action?do=friend">好友</a></li>
     <li><img src="image/icon/show.gif"><a href="zone.action?do=top">排行榜</a></li>
     <li><img src="image/app/gift.gif"><a href="zone.action?do=gift">礼物</a></li>
     <li><img src="image/app/addrbook.gif"/><a href="zone.action?do=addrbook">通讯录</a></li>
    </ul>
    </c:if>
   	<c:if test="${sGlobal.supe_uid>0}">
    <ul class="app_list topline" id="my_defaultapp">
   	<c:if test="${sConfig.my_status>0}">
    <c:forEach items="${globalUserAPP}" var="userAPP">
     <li><img src="icons/${userAPP.value.appid}"><a href="userapp.action?id=${userAPP.value.appid}">${userAPP.value.appname}</a></li>
    </c:forEach>
   	</c:if>
    </ul>
   	<c:if test="${sConfig.my_status>0}">
    <ul class="app_list topline" id="my_userapp">
    <c:forEach items="${sGlobal.my_menu}" var="menu">
     <li id="userapp_li_${menu.value.appid}"><img src="icons/${menu.value.appid}"><a href="userapp.action?id=${menu.value.appid}" title="${menu.value.appname}">${menu.value.appname}</a></li>
    </c:forEach>
    </ul>
   	</c:if>
    <c:if test="${sConfig.my_menu_more>0}"><p class="app_more"><a href="javascript:;" id="a_app_more" onclick="userapp_open();" class="off">展开</a></p></c:if>
   	<c:if test="${sConfig.my_status>0}">
    <div class="app_m">
     <ul>
      <li><img src="image/app_add.gif"><a href="main.action?ac=userapp&my_suffix=%2Fapp%2Flist" class="addApp">添加应用</a></li>
      <li><img src="image/app_set.gif"><a href="main.action?ac=userapp&op=menu" class="myApp">管理应用</a></li>
     </ul>
    </div>
   	</c:if>
   	</c:if>
   </div>
   </c:if>
   
   <c:if test="${sCookie.currentsite eq 'space' and spaceLocation eq 'home'}">
	<style type="text/css">
	#mainarea { width: 820px; }
	</style>
   </c:if>
   
   <div id="mainarea">
    <c:if test="${not empty globalAd.contenttop}"><div id="ad_contenttop">${sns:showAd(globalAd.contenttop)}</div></c:if>
</c:if>
</c:if>