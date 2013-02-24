<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<c:set var="tpl_noSideBar" value="1" scope="request"/>
<jsp:include page="${sns:template(sConfig, sGlobal, 'header.jsp')}"/>
<c:if test="${not empty narrowlist || not empty widelist}">
<script type="text/javascript" src="source/script_swfobject.js"></script>
</c:if>

<div id="space_page">
	<div id="ubar">
		<div id="space_avatar">
			<c:if test="${!sns:snsEmpty(space.magicstar) && space.magicexpire>sGlobal.timestamp}">
			<div class="magicstar">
			<object codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,45,0" width="200" height="250">
				<param name="movie" value="image/magic/star/${space.magicstar}.swf" />
				<param name="quality" value="high" />
				<param NAME="wmode" value="transparent">
				<embed src="image/magic/star/${space.magicstar}.swf" quality="high" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash"  wmode="transparent" width="200" height="250"></embed>
			</object>
			</div>
			</c:if>
			<div class="magicavatar">
			${sns:avatar2(space.uid, 'big', false, sGlobal, sConfig)}
			</div>
		</div>
		
		<h3 id="spaceindex_name">
		<c:choose>
		<c:when test="${!sns:snsEmpty(sConfig.realname)}">
			<c:choose>
			<c:when test="${!sns:snsEmpty(space.name)}"><a href="zone.action?uid=${space.uid}"${gColor}>${space.name}</a></c:when>
			<c:otherwise>未填写实名</c:otherwise>
			</c:choose>
		</c:when>
		<c:otherwise>
			<a href="zone.action?uid=${space.uid}"${gColor}>${space.username}</a>
		</c:otherwise>
		</c:choose>

		<c:if test="${!sns:snsEmpty(sConfig.realname)}">
			<c:choose>
			<c:when test="${!sns:snsEmpty(space.namestatus)}">
				&nbsp;<img src="image/realname_yes.gif" align="absmiddle" alt="已通过实名认证">
			</c:when>
			<c:otherwise>
				&nbsp;<img src="image/realname_no.gif" align="absmiddle" alt="未通过实名认证">
			</c:otherwise>
			</c:choose>
		</c:if>
			
		<c:if test="${!sns:snsEmpty(sConfig.videophoto)}">
			<c:choose>
			<c:when test="${!sns:snsEmpty(space.videostatus)}">
				&nbsp; <a id="a_space_videophoto" href="zone.action?uid=${space.uid}&do=videophoto" onclick="ajaxmenu(event, this.id, 1)"><img src="image/videophoto_yes.gif" align="absmiddle" alt="已通过视频认证"></a>
			</c:when>
			<c:otherwise>
				&nbsp;  <span class="gray"><a href="main.action?ac=videophoto"><img src="image/videophoto_no.gif" align="absmiddle" alt="未通过视频认证"></a></span>
			</c:otherwise>
			</c:choose>
		</c:if>
		<br>
		<c:choose>
		<c:when test="${!sns:snsEmpty(sConfig.realname)}">
			<em>(用户名: ${space.username})</em>
		</c:when>
		<c:otherwise>
			<c:if test="${!sns:snsEmpty(space.name)}"><br><em>(姓名: ${space.name})</em></c:if>
		</c:otherwise>
		</c:choose>
		
		</h3>
		
		<c:if test="${space.self && not empty globalMagic.superstar}">
		<div class="borderbox">
			<div style="width:100%; overflow:hidden;">
			<img src="image/magic/sstar.png" class="magicicon" />
			<c:choose>
			<c:when test="${!sns:snsEmpty(space.magicstar) && space.magicexpire>sGlobal.timestamp}">
			<a id="a_magic_superstar" href="main.action?ac=magic&op=cancelsuperstar" onclick="ajaxmenu(event, this.id)">取消超级明星</a>
			</c:when>
			<c:otherwise>
			<a id="a_magic_superstar" href="props.action?mid=superstar" onclick="ajaxmenu(event, this.id, 1)">我要变超级明星</a>
			</c:otherwise>
			</c:choose>
			</div>
		</div><br />
		</c:if>

		<div class="borderbox">
			<ul class="spacemenu_list" style="width:100%; overflow:hidden;">
		<c:choose>
		<c:when test="${space.self}">
			<li><a href="main.action?ac=avatar">我的头像</a></li>
			<li><a href="main.action?ac=profile">个人资料</a></li>
			<li><a href="main.action?ac=theme">主页风格</a></li>
			<li><a href="main.action?ac=credit">我的积分</a></li>
			<c:if test="${sConfig.sendmailday>0}">
			<li><a href="main.action?ac=sendmail">邮件提醒</a></li>
			</c:if>
			<li><a href="main.action?ac=privacy">隐私筛选</a></li>
		</c:when>
		<c:otherwise>
			<c:if test="${!space.isfriend}">
			<li><img src="image/icon/friend.gif"><a href="main.action?ac=friend&op=add&uid=${space.uid}" id="a_friend_li" onclick="ajaxmenu(event, this.id, 1)">加为好友</a></li>
			</c:if>
			<li><img src="image/icon/wall.gif"><a href="#comment">给我留言</a></li>
			<li><img src="image/icon/poke.gif"><a href="main.action?ac=poke&op=send&uid=${space.uid}" id="a_poke" onclick="ajaxmenu(event, this.id, 1)">打个招呼</a></li>
			<li><img src="image/icon/pm.gif"><a href="main.action?ac=pm&uid=${space.uid}" id="a_pm" onclick="ajaxmenu(event, this.id, 1)">发送消息</a></li>
			<c:if test="${space.isfriend}">
			<li><img src="image/icon/friend.gif"><a href="main.action?ac=friend&op=ignore&uid=${space.uid}" id="a_ignore" onclick="ajaxmenu(event, this.id)">解除好友</a></li>
			</c:if>
			<li><img src="image/icon/report.gif"><a href="main.action?ac=common&op=report&idtype=uid&id=${space.uid}" id="a_report" onclick="ajaxmenu(event, this.id, 1)">违规举报</a></li>
			<c:if test="${manageName || manageSpaceGroup || manageSpaceInfo || manageSpaceCredit || manageSpaceNote }">
			<li><img src="image/icon/profile.gif"><a href="backstage.action?ac=space&op=manage&uid=${space.uid}" id="a_manage">管理用户</a></li>
			</c:if>
			<c:if test="${space.showgiftlink == '1'}">
			<li><img src="image/icon/gift.gif"><a href="main.action?ac=gift&defreceiver=${space.username}">送他礼物</a></li>
			</c:if>
		</c:otherwise>
		</c:choose>
			</ul>
		</div><br />

		<c:choose>
		<c:when test="${!space.self}">
			<c:if test="${space.magiccredit>0}">
			<div class="magichongbao" id="div_magic_gift">
				<a id="a_magic_gift" href="main.action?&ac=magic&op=receive&uid=${space.uid}" onclick="ajaxmenu(event, this.id)">送你 <span>${space.magiccredit}</span> 积分大红包</a>
			</div>
			</c:if>

			<c:if test="${not empty globalMagic.viewmagiclog || not empty globalMagic.viewmagic || not empty globalMagic.viewvisitor}">
			<div class="indexmagic">
			<c:forEach items="${mids}" var="mid">
				<c:if test="${not empty globalMagic[mid]}">
				<a id="a_magic_${mid}" href="props.action?mid=${mid}&idtype=uid&id=${space.uid}" onclick="ajaxmenu(event,this.id,1)">
				<img src="image/magic/${mid}.small.gif" title="${globalMagic[mid]}" alt="${globalMagic[mid]}">
				</a>
				</c:if>
			</c:forEach>
			</div>
			</c:if>
		</c:when>
		<c:otherwise>
			<c:if test="${not empty globalMagic.gift}">
			<div class="magichongbao" id="div_magic_gift">				
				<c:choose>
				<c:when test="${space.magiccredit>0}">
				<a id="a_magic_retrieve" href="main.action?ac=magic&op=retrieve" onclick="ajaxmenu(event,this.id)">回收埋下的积分</a>
				</c:when>
				<c:otherwise>
				<a id="a_magic_gift" href="props.action?mid=gift" onclick="ajaxmenu(event,this.id,1)">给来访者埋个红包</a>
				</c:otherwise>
				</c:choose>
			</div>
			</c:if>
		</c:otherwise>
		</c:choose>
	</div>

	<div id="content">
		<div id="maincontent">
		<c:if test="${not empty albumlist}">
		<div id="space_photo">
			<table cellspacing="2" cellpadding="4" width="100%">
			<tr>
				<c:forEach items="${albumlist}" var="value" varStatus="key">
				<td width="700" align="center"><a href="zone.action?uid=${space.uid}&do=album&id=${value.albumid}" target="_blank"><img src="${fn:replace(value.pic, '.thumb.jpg', '')}" alt="${value.albumname}" width="350" /></a>
					<a href="zone.action?uid=${space.uid}&do=album&id=${value.albumid}" target="_blank" title="${value.albumname}">${value.albumname}</a>
					<p class="gray">${value.picnum} 张照片 更新于<sns:date dateformat="MM-dd" timestamp="${value.dateline}" format="1"/></p>
				</td>
				<c:if test="${key.index%2==1}"></tr><tr></c:if>
				</c:forEach>
			</tr>
			</table>
		</div>
		</c:if>
		</div>
	</div>
</div>

<c:if test="${!sns:snsEmpty(param.theme)}"><div class="nn">您是否想使用这款个性风格?<br /><a href="main.action?ac=theme&op=use&dir=${param.theme}">[应用]</a><a href="main.action?ac=theme">[取消]</a></div></c:if>
<jsp:include page="${sns:template(sConfig, sGlobal, 'footer.jsp')}"/>

<script>
function getindex(type) {
	var plus = '';
	if(type == 'event') plus = '&type=self';
	ajaxget('zone.action?uid=${space.uid}&do='+type+'&view=me'+plus+'&ajaxdiv=maincontent', 'maincontent');
}

//彩虹炫
var elems = selector('div[class~=magicflicker]'); 
for(var i=0; i<elems.length; i++){
	magicColor(elems[i]);
}
</script>