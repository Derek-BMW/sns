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
 <meta name="keywords" content="武隆旅游|印象武隆|天生三桥|仙女山|芙蓉洞|武隆旅游网|武隆|武隆仙女山|武隆酒店|武隆自驾|武隆自驾游|武隆特产|重庆武隆|重庆旅游|武隆旅游官网" />
 <meta name="description" content="重庆武隆旅游官网喀斯特旅游区为世界自然遗产和国家AAAAA级旅游区,下有天生三桥、芙蓉洞、仙女山、印象武隆、芙蓉江、龙水峡地缝等景区" />
 <script language="javascript" type="text/javascript" src="source/script_plug.js"></script>
 <style type="text/css">
  @import url(template/${sConfig.template}/style.css);
  <c:if test="${!empty tpl_css}">@import url(template/${sConfig.template}/${tpl_css}.css);</c:if>
 </style>
 <link rel="shortcut icon" href="favicon.ico" />
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
    <c:if test="${sGlobal.member.credit>0}"><a href="main.action?ac=credit" style="font-size:11px;padding:0 0 0 5px;"><img src="image/credit.gif" />${sGlobal.member.credit}</a></c:if><br/>
    <a href="main.action?ac=task">任务</a>
    <a href="main.action?ac=magic">道具</a>
    <a href="main.action">设置</a>
    <a href="main.action?ac=common&op=logout&uhash=${sGlobal.uhash}">退出</a>
   </c:when>
   <c:otherwise>
    <a href="operate.action?ac=${sConfig.register_action}" class="login_thumb">${sns:avatar1(sGlobal.supe_uid,sGlobal,sConfig)}</a> 欢迎您<br/>
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