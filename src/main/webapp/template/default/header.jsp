<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<c:if test="${sGlobal.inajax==0}">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 <title>${navtitle}<c:if test="${not empty sNames[space.uid]}">${sNames[space.uid]} - </c:if>${sConfig.sitename}</title>
 <meta http-equiv="content-type" content="text/html; charset=${snsConfig.charset}">
 <meta http-equiv="x-ua-compatible" content="ie=7">
 <meta name="keywords" content="旅游网">
 <meta name="description" content="旅游网">
 <script language="javascript" type="text/javascript" src="source/script_cookie.js"></script>
 <script language="javascript" type="text/javascript" src="source/script_common.js"></script>
 <script language="javascript" type="text/javascript" src="source/script_menu.js"></script>
 <script language="javascript" type="text/javascript" src="source/script_ajax.js"></script>
 <script language="javascript" type="text/javascript" src="source/script_face.js"></script>
 <script language="javascript" type="text/javascript" src="source/script_manage.js"></script>
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
 <!-- solzhang 添加 jquery支持, 2012.5.4 -->
 <script language="javascript" type="text/javascript" src="source/jquery.min.js"></script>
 <script>
 	jQuery.noConflict();
 </script> 
</head>
<body>
 <div id="header">
  <div class="headerwarp">
   <h1 class="logo"><a href="portal.action"></a></h1>
   <div class="nav_account">
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
    <c:if test="${sGlobal.member.credit>0}"><a href="main.action?ac=credit" style="font-size:11px;padding:0 0 0 5px;"><img src="image/credit.gif">${sGlobal.member.credit}</a></c:if><br>
    <a href="main.action?ac=task">任务</a>
    <a href="main.action?ac=magic">道具</a>
    <a href="main.action">设置</a>
    <a href="main.action?ac=common&op=logout&uhash=${sGlobal.uhash}">退出</a>
   </c:when>
   <c:otherwise>
    <a href="operate.action?ac=${sConfig.register_action}" class="login_thumb">${sns:avatar1(sGlobal.supe_uid,sGlobal,sConfig)}</a> 欢迎您<br>
    <a href="operate.action?ac=${sConfig.login_action}">登录</a> 
    <a href="operate.action?ac=${sConfig.register_action}">注册</a>
    
   </c:otherwise>
  </c:choose>
   </div>
  </div>
  <div class="headermenu">
   <ul class="menu">
  <c:choose>
   <c:when test="${sGlobal.supe_uid>0}">
    <li><a href="portal.action">社区首页</a></li>
    <li><a href="zone.action?do=home">个人中心</a></li>
    <li><a href="zone.action">我的主页</a></li>
    <li><a href="zone.action?do=friend">我的好友</a></li>
   </c:when>
   <c:otherwise>
    <li><a href="portal.action">社区首页</a></li>
    <li><a href="zone.action?do=blog">日志</a></li>
    <li><a href="zone.action?do=album">相册</a></li>
    <li><a href="zone.action?do=doing">心情</a></li>
    <li><a href="zone.action?do=thread&view=all">话题</a></li>
    <li><a href="zone.action?do=poll">投票</a></li>
    <li><a href="zone.action?do=event">活动</a></li>
    <li><a href="zone.action?do=share">分享</a></li>
   </c:otherwise>
  </c:choose>
  <c:if test="${!empty sGlobal.appmenu}">
   <c:choose>
    <c:when test="${!empty sGlobal.appmenus}"><li class="dropmenu" id="jcappmenu" onclick="showMenu(this.id)"><a href="javascript:;">站内导航</a></li></c:when>
    <c:otherwise><li><a target="_blank" href="${sGlobal.appmenu.url}" title="${sGlobal.appmenu.name}">${sGlobal.appmenu.name}</a></li></c:otherwise>
   </c:choose>
  </c:if>
  <c:choose>
   <c:when test="${sGlobal.supe_uid>0}">
    <li><a href="zone.action?do=pm${sGlobal.member.newpm>0 ? '&filter=newpm' : ''}" id="msgtips">消息${sGlobal.member.newpm>0 ? '(新)' : ''}</a></li>
    <c:if test="${sGlobal.member.allnotenum>0}"><li class="notify" id="membernotemenu" onmouseover="showMenu(this.id)"><a href="zone.action?do=notice">${sGlobal.member.allnotenum}个提醒</a></li></c:if>
   </c:when>
  </c:choose>
   </ul>
  </div>
  <c:if test="${!empty globalAd.header}"><div id="ad_header">${sns:showAd(globalAd.header)}</div></c:if>
 </div>
 <div id="append_parent"></div>
 <div id="ajaxwaitid"></div>
 <div id="wrap">
<c:if test="${empty tpl_noSideBar}">
  <div id="main">
   <div id="app_sidebar">
    <ul class="app_list" id="default_userapp">
     <li><img src="image/app/feed.gif"><a href="zone.action?do=feed">动态</a></li>
     <li><img src="image/app/doing.gif"><a href="zone.action?do=doing">心情</a></li>
     <li><img src="image/app/album.gif"><a href="zone.action?do=album">相册</a><em><a href="main.action?ac=upload" class="gray">上传</a></em></li>
     <li><img src="image/app/blog.gif"><a href="zone.action?do=blog">日志</a><em><a href="main.action?ac=blog" class="gray">发表</a></em></li>
     <li><img src="image/app/poll.gif"><a href="zone.action?do=poll">投票</a><em><a href="main.action?ac=poll" class="gray">发起</a></em></li>
     <li><img src="image/app/mtag.gif"><a href="zone.action?do=mtag">群组</a><em><a href="main.action?ac=thread" class="gray">话题</a></em></li>
     <li><img src="image/app/event.gif"><a href="zone.action?do=event">活动</a><em><a href="main.action?ac=event" class="gray">发起</a></em></li>
     <li><img src="image/app/topic.gif"><a href="zone.action?do=topic">热闹</a><em><a href="main.action?ac=topic" class="gray">添加</a></em></li>
     <li><img src="image/app/share.gif"><a href="zone.action?do=share">分享</a><em><a href="zone.action?do=share&view=me" class="gray">添加</a></em></li>
     <li><img src="image/app/gift.gif"><a href="zone.action?do=gift">礼物</a><em><a href="main.action?ac=gift" class="gray">送礼</a></em></li>
     <li><img src="image/app/addrbook.gif"/><a href="zone.action?do=addrbook">通讯录</a></li>
     <li><img src="image/app/wall.gif"/><a href="zone.action?do=wall">留言板</a></li>
    </ul>
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
   <div id="mainarea">
    <c:if test="${not empty globalAd.contenttop}"><div id="ad_contenttop">${sns:showAd(globalAd.contenttop)}</div></c:if>
</c:if>
</c:if>