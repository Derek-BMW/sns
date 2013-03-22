<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 <title>${navtitle}<c:if test="${not empty sNames[space.uid]}">${sNames[space.uid]} - </c:if>${sConfig.sitename}</title>
 <meta http-equiv="content-type" content="text/html; charset=${snsConfig.charset}" />
 <meta http-equiv="x-ua-compatible" content="ie=7" />
 <meta property="qc:admins" content="24512666676413636654" />
 <meta name="keywords" content="${sConfig.keywords}" />
 <meta name="description" content="${sConfig.description}" />
 <script language="javascript" type="text/javascript" src="source/script_common.js"></script>
 <script language="javascript" type="text/javascript" src="source/script_menu.js"></script>
 <script language="javascript" type="text/javascript" src="source/script_plug.js"></script>
 <style type="text/css">
  @import url(template/${sConfig.template}/style.css);
  <c:if test="${!empty tpl_css}">@import url(template/${sConfig.template}/${tpl_css}.css);</c:if>
 </style>
 <link rel="shortcut icon" href="favicon.ico" />
 
 <!--[if lt IE 7]>
 <script src="source/DD_belatedPNG_0.0.8a-min.js" type="text/javascript" charset="utf-8"></script>
 <script type="text/javascript">DD_belatedPNG.fix('.logo a, .logo_small a');</script>  
 <![endif]-->
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-34114026-1']);
  _gaq.push(['_setDomainName', 'lysns.net']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
</head>
<body>
<div class="nav_topfixed">
	<div id="wrap">
		<span style="float:left;">
   			<a href="/store">网上商店</a>
   			<c:if test="${sGlobal.supe_uid>0}">
    		<a href="zone.action?do=home">个人中心</a>
    		<a href="zone.action">我的主页</a>
    		<a href="zone.action?do=friend">我的好友</a>
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
<div id="header">
  <div class="headerwarp">
  <div id="wrap">
    <h1 class="logo"><a href="portal.action">旅游社区</a></h1>
    <div id="ad_header">
    <c:if test="${!empty globalAd.header}">${sns:showAd(globalAd.header)}</c:if>
    </div>
    <div class="head_navigation">${sns:showAdById(12)}</div>
  </div>
  </div>
  <div id="wrap" class="headermenu">
    <ul class="menu">
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
  	<c:if test="${!empty sGlobal.appmenu}">
   	<c:choose>
    <c:when test="${!empty sGlobal.appmenus}"><li class="dropmenu" id="jcappmenu" onclick="showMenu(this.id)"><a href="javascript:;">站内导航</a></li></c:when>
    <c:otherwise><li><a target="_blank" href="${sGlobal.appmenu.url}" title="${sGlobal.appmenu.name}">${sGlobal.appmenu.name}</a></li></c:otherwise>
   	</c:choose>
  	</c:if>
    </ul>
  </div>
</div>

 <div id="append_parent"></div>
 <div id="ajaxwaitid"></div>
 <div id="wrap" class="content">