<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<c:set var="tpl_noSideBar" value="1" scope="request" />
<jsp:include page="${sns:template(sConfig, sGlobal, 'home_header.jsp')}" />

 <!--[if lt IE 7]>
 <script src="source/DD_belatedPNG_0.0.8a-min.js" type="text/javascript" charset="utf-8"></script>
 <script type="text/javascript">DD_belatedPNG.fix('.headerwarp,.logo a,.headermenu');</script>  
 <![endif]-->
 
<div id="home">
<div class="nbox">
	<div class="nbox_left">
		<div class="nbox_c">
			<h2 class="ntitle"><span class="r_option"><a href="zone.action?do=blog&view=all">更多&raquo;</a></span>推荐日志</h2>
			<ul class="bloglist">
				<c:forEach items="${recommend_blogs}" var="blog" varStatus="index">
					<li>
						<div class="ttop"><div><span>${blog.hot}</span></div></div><h3><a href="zone.action?uid=${blog.uid}&do=blog&id=${blog.blogid}" target="_blank">${blog.subject}</a></h3>
						<p class="message">${blog.message} ...</p>
						<p class="gray"><a href="zone.action?uid=${blog.uid}">${sNames[blog.uid]}</a> 发表于 ${blog.dateline}</p>
					</li>
				</c:forEach>
			</ul>
		</div>
		
		<div class="nbox_c">
			<h2 class="ntitle"><span class="r_option"><a href="zone.action?do=blog&view=all">更多&raquo;</a></span>热门日志</h2>
			<div class="hot_bloglist">
				<table cellpadding="0" cellspacing="1">
					<tbody>
						<c:forEach items="${blogs}" var="blog" varStatus="index">
							<tr${index.index % 2 == 1 ? " class=color_row" : ""}>
                            	<td><div class="ttop"><div><span>${blog.hot}</span></div></div></td>
								<td class="ttopic"><a href="zone.action?uid=${blog.uid}&do=blog&id=${blog.blogid}" target="_blank">${blog.subject}</a></td>
								<td class="tuser" nowrap><a href="zone.action?uid=${blog.uid}" target="_blank">${sns:avatar1(blog.uid,sGlobal,sConfig)}</a> 
									<a href="zone.action?uid=${blog.uid}" target="_blank">${sNames[blog.uid]}</a></td>
								<td class="tgp" nowrap>${blog.dateline}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		
		<div id="showuser" class="nbox_c">
		<div id="user_wall">
			<div id="user_pay" class="s_clear">
				<ul>
					<c:forEach items="${shows}" var="show">
						<li><a href="zone.action?uid=${show.uid}" target="_blank" rel="${sNames[show.uid]}" rev="${show.note}" title="${sNames[show.uid]} : &quot;${show.note}&quot;">${sns:avatar1(show.uid,sGlobal,sConfig)}</a></li>
					</c:forEach>
				</ul>
				<p><a href="operate.action?ac=${sConfig.register_action}">我要注册</a></p>
			</div>
			<div id="user_online" class="s_clear">
				<h2><a href="zone.action?do=top&view=online">在线会员</a></h2>
				<ul>
					<c:forEach items="${onlines}" var="online">
						<li><a href="zone.action?uid=${online.uid}" target="_blank" rel="${sNames[online.uid]}" rev="${online.note}" class="uonline"  title="${sNames[online.uid]} : &quot;${online.note}&quot;">${sns:avatar1(online.uid,sGlobal,sConfig)}</a></li>
					</c:forEach>
				</ul>
			</div>
		</div>
		</div>
		
		<div class="nbox_c">
			<h2 class="ntitle"><span class="r_option"><a href="zone.action?do=event&view=recommend">更多&raquo;</a></span>活动</h2>
			<ul class="elist">
				<c:forEach items="${events}" var="event">
					<li>
						<h3><a href="zone.action?do=event&id=${event.eventid}" target="_blank">${event.title}</a></h3>
						<p class="eimage"><a href="zone.action?do=event&id=${event.eventid}" target="_blank"><img src="${event.poster}"/></a></p>
						<p><span class="gray">时间:</span> ${event.starttime} - ${event.endtime}</p>
						<c:if test="${not empty event.province or not empty event.city or not empty event.location}">
						<p><span class="gray">地点:</span> ${event.province} ${event.city} ${event.location}</p>
						</c:if>
						<p><span class="gray">发起:</span> <a href="zone.action?uid=${event.uid}">${sNames[event.uid]}</a></p>
						<p class="egz">${event.membernum} 人参加<span class="pipe">|</span>${event.follownum} 人关注</p>
					</li>
				</c:forEach>
			</ul>
		</div>

		<div class="nbox_c">
			<h2 class="ntitle"><span class="r_option"><a href="zone.action?do=thread&view=all">更多&raquo;</a></span>话题</h2>
			<div class="tlist">
				<table cellpadding="0" cellspacing="1">
					<tbody>
						<c:forEach items="${threads}" var="thread" varStatus="index">
							<tr${index.index % 2 == 1 ? " class=color_row" : ""}>
								<td class="ttopic"><div class="ttop"><div><span>${thread.hot}</span></div></div><a href="zone.action?uid=${thread.uid}&do=thread&id=${thread.tid}" target="_blank">${thread.subject}</a></td>
								<td class="tuser" nowrap><a href="zone.action?uid=${thread.uid}" target="_blank">${sns:avatar1(thread.uid,sGlobal,sConfig)}</a> <a href="zone.action?uid=${thread.uid}" target="_blank">${sNames[thread.uid]}</a></td>
								<td class="tgp" nowrap><a href="zone.action?do=mtag&tagid=${thread.tagid}">${thread.tagname}</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
		
	<div class="nbox_s">
		<div class="side_rbox side_rbox_w">
        	<div class="nbox_side_bg">
				<h2 class="ntitle"><span class="r_option"><a href="zone.action?do=doing&view=all">更多&raquo;</a></span>呻吟</h2>
				<ul class="doinglist">
					<c:forEach items="${doings}" var="doing">
						<li>
							<p><a href="zone.action?uid=${doing.uid}&do=doing&doid=${doing.doid}" target="_blank" class="gray r_option dot" style="margin: 0; background-position-y: 0;">${doing.dateline}</a> <a href="zone.action?uid=${doing.uid}" title="${sNames[doing.uid]}" class="s_avatar">${sns:avatar1(doing.uid,sGlobal,sConfig)}</a> <a href="zone.action?uid=${doing.uid}">${sNames[doing.uid]}</a></p>
							<p class="message" title="${doing.title}">${doing.message}</p>
						</li>
					</c:forEach>
				</ul>
            </div>
		</div>

		<div class="side_rbox side_rbox_w">
        	<div class="nbox_side_bg">
			<h2 class="ntitle"><span class="r_option"><a href="zone.action?do=share&view=all">更多&raquo;</a> </span>分享</h2>
			<ul class="slist">
				<c:forEach items="${shares}" var="share">
				<li>
					<div class="title">
						<a href="zone.action?uid=${share.uid}">${sNames[share.uid]}</a>
						<a href="zone.action?uid=${share.uid}&do=share&id=${share.sid}" class="gray">${share.title_template}</a>
					</div>
					<div class="feed">
						<div style="width: 100%; overflow: hidden;">
							<c:if test="${!sns:snsEmpty(share.image)}"><a href="${share.image_link}"><img src="${share.image}" class="simage"/></a></c:if>
							<div class="detail">
								${share.body_template}
							</div>
							<c:choose>
								<c:when test="${'video'==share.type}"><a href="zone.action?uid=${share.uid}&do=share&id=${share.sid}" target="_blank"><img src="${sns:snsEmpty(share.body_data.flashimg)  ?  'image/vd.gif'  :  share.body_data.flashimg}" class="simage"></a></c:when>
								<c:when test="${'music'==share.type}"><div class="media"><img src="image/music.gif" alt="点击播放" onclick="javascript:showFlash('music', '${share.body_data.musicvar}', this, '${share.sid}');" style="cursor: pointer;" /></div></c:when>
								<c:when test="${'flash'==share.type}"><a href="zone.action?uid=${share.uid}&do=share&id=${share.sid}" target="_blank"><img src="image/flash.gif" class="simage"/></a></c:when>
							</c:choose>
							<div class="quote"><span id="quote" class="q">${share.body_general}</span></div>
							<span class="gray">分享于${share.dateline}</span>
						</div>
					</div>
				</li>
				</c:forEach>
			</ul>
            </div>
		</div>
	
		<div class="side_rbox side_rbox_w">
        	<div class="nbox_side_bg">
				<h2 class="ntitle"><span class="r_option"><a href="zone.action?do=poll">更多&raquo;</a></span>投票</h2>
				<ul class="npoll">
					<c:forEach items="${polls}" var="poll" varStatus="index">
						<li class="poll_${index.index}"><a href="zone.action?uid=${poll.uid}&do=poll&pid=${poll.pid}" target="_blank">${poll.subject}</a><c:if test="${index.index == 0}"><p><a href="zone.action?uid=${poll.uid}&do=poll&pid=${poll.pid}">已有 ${poll.voternum} 位会员投票</a></p></c:if></li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
		
	<div class="nbox" id="photolist">
		<h2 class="ntitle"><a href="zone.action?do=album&view=all" class="r_option">更多&raquo;</a>图片</h2>
		<div id="spics_wrap">
			<ul id="spics" style="margin-left: 0;">
				<c:forEach items="${pics}" var="pic" varStatus="index">
					<li class="spic_${index.index}">
						<div class="spic_img"><a href="zone.action?uid=${pic.uid}&do=album&picid=${pic.picid}" target="_blank"><strong>${pic.hot}</strong><img src="${pic.filepath}" alt="${pic.albumname}" height="100" width="100"/></a></div>
						<p><a href="zone.action?uid=${pic.uid}">${sNames[pic.uid]}</a></p>
						<p>${pic.dateline}</p>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
</div>
	
</div>
<jsp:include page="${sns:template(sConfig, sGlobal, 'footer.jsp')}" />