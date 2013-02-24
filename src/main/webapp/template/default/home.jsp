<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<c:set var="tpl_noSideBar" value="1" scope="request" />
<jsp:include page="${sns:template(sConfig, sGlobal, 'home_header.jsp')}" />
<div id="home">
<script language="javascript" type="text/javascript" src="source/wl_img.js"></script>

<div class="index_top">
	<div class="banner_img">
		<!--这里需要在后台去添加广告，我这里添加的是用户自定义广告！插入方式为代码,需要插入的广告代码如下：以后用户需要替换的是图片链接地址就好  缩略图尺寸：75*45 大图尺寸：522*233-->
		<!--比如这里我用的是 ${sns:showAdById(8)}  把这段替换下面 id ifocus 这个div的代码就好了-->
		<!-- div id="ifocus">
			<div id="ifocus_pic">
              <div id="ifocus_piclist" style="left:0; top:0;">
                  <ul>
                      <li><a href="#"><img src="http://www.lysns.net/a/201202/2/18_1328156687mX23.jpg" alt="芙蓉江" /></a></li>
                      <li><a href="#"><img src="http://www.lysns.net/a/201202/2/18_1328156691EAg5.jpg" alt="天生三桥" /></a></li>
                      <li><a href="#"><img src="http://www.lysns.net/a/201202/2/18_1328156685G3gM.jpg" alt="芙蓉洞" /></a></li>
                      <li><a href="#"><img src="http://www.lysns.net/a/201202/2/18_1328156688ezcW.jpg" alt="仙女山" /></a></li>
                  </ul>
              </div>
              <div id="ifocus_opdiv"></div>
              <div id="ifocus_tx">
                  <ul>
                      <li class="current">芙蓉江</li>
                      <li class="normal">天生三桥</li>
                      <li class="normal">芙蓉洞</li>
                      <li class="normal">仙女山</li>
                  </ul>
              </div>
			</div>
			<div id="ifocus_btn">
              <ul>
                  <li class="current"><img src="http://www.lysns.net/a/201202/2/18_1328156687mX23.jpg.thumb.jpg" alt="芙蓉江" /></li>
                  <li class="normal"><img src="http://www.lysns.net/a/201202/2/18_1328156691EAg5.jpg.thumb.jpg" alt="天生三桥" /></li>
                  <li class="normal"><img src="http://www.lysns.net/a/201202/2/18_1328156685G3gM.jpg.thumb.jpg" alt="芙蓉洞" /></li>
                  <li class="normal"><img src="http://www.lysns.net/a/201202/2/18_1328156688ezcW.jpg.thumb.jpg" alt="仙女山" /></li>
              </ul>
			</div>
		</div -->
		${sns:showAdById(8)}
	</div>
	
	<div class="user_top">
		<div class="user_top_t">
			<form method="post" action="zone.action">
				<input name="searchkey" value="" size="22" class="t_input" type="text" style="padding:3px 5px;">
				<select name="do">
					<option value="blog">日志</option>
					<option value="album">相册</option>
					<option value="thread">话题</option>
					<option value="poll">投票</option>
					<option value="event">活动</option>
					<option value="friend">好友</option>
				</select>
				<input name="searchsubmit" value="搜索" class="submit" type="submit">
				<input type="hidden" name="view" value="all" />
				<input type="hidden" name="orderby" value="dateline" />
			</form>
        </div>
        <script language="javascript" type="text/javascript" src="source/jquery.min.js"></script>
        <script language="javascript" type="text/javascript" src="source/jcarousellite_1.0.1.min.js"></script>
        <script>
		jQuery(function() {
			jQuery(".user_top_list_m").jCarouselLite({
				btnNext: ".next",
				btnPrev: ".prev",
				circular: false,
				visible: 5
			});
			 jQuery(".photolist li").hover(function(){
				jQuery(this).find(".ttop").show();
			},function(){
				jQuery(this).find(".ttop").hide();	
			})
		});
		</script>
		<div class="user_top_m">
			<div class="user_top_m_bd">
				<div class="user_top_head">
                	<c:if test="${!empty star}">
                	<div class="user_top_show"><span>推荐人物</span><a href="zone.action?uid=${star.uid}" target="_blank">${sns:avatar2(star.uid,'middle',false,sGlobal,sConfig)}</a></div>
                	<div class="user_top_show_info">
                        <p class="user_top_name"><a href="zone.action?uid=${star.uid}">${sNames[star.uid]}</a></p>
                        <p>人气：${star.viewnum}<br />积分：${star.credit}<br />好友：${star.friendnum}<br />更新：${star.updatetime}</p>
                        <a id="link" href="zone.action?do=top">出现在这里</a>
                    </div>
                    </c:if>
                    
					<!--<div id="user_recomm">
						<a id="link" href="zone.action?do=top">出现在这里</a>
						<c:if test="${!empty star}">
                		<div class="s_avatar">
                			<a href="zone.action?uid=${star.uid}" target="_blank">${sns:avatar2(star.uid,'middle',false,sGlobal,sConfig)}</a>
                		</div>
                		<div>
							<h3><a href="zone.action?uid=${star.uid}">${sNames[star.uid]}</a></h3>
							<p>人气: ${star.viewnum}</p>
							<p>积分: ${star.credit}</p>
							<p>好友: ${star.friendnum}</p>
							<p>更新: ${star.updatetime}</p>
                		</div>
            			</c:if>
            		</div>-->
            	</div>
            	<div class="user_top_list">
                  <div class="prev"></div>
                  <div class="next"></div>
                  <div class="user_top_list_m">
                    <ul>
                      <c:forEach items="${shows}" var="show">
                        <li><a href="zone.action?uid=${show.uid}" title="${sNames[show.uid]}" target="_blank">${sns:avatar1(show.uid,sGlobal,sConfig)}</a></li>
                        </c:forEach>
                    </ul>
                  </div>
                </div>
          	</div>
		</div>
	</div>
</div>
  
<div style="float:left;">
	<div class="box1">
    	<h2 class="ntitle box_left_title"><a href="zone.action?do=blog&view=all" class="more">更多&raquo;</a><strong>日志</strong></h2>
    	<ul class="bloglist">
      		<c:forEach items="${blogs}" var="blog" varStatus="index">
        	<li>
        		<div class="d_avatar avatar48"><a href="zone.action?uid=${blog.uid}" title="${sNames[blog.uid]}" target="_blank">${sns:avatar1(blog.uid,sGlobal,sConfig)}</a></div>
        		<h3><a href="zone.action?uid=${blog.uid}&do=blog&id=${blog.blogid}" target="_blank">${blog.subject}</a></h3>
        		<p class="message image_right">
        			<c:if test="${!sns:snsEmpty(blog.pic)}">
					<a href="zone.action?uid=${blog.uid}&do=blog&id=${blog.blogid}" target="_blank"><img src="${blog.pic}" alt="${blog.subject}" /></a>
					</c:if>
        			${blog.message} ...
        		</p>
        		<p class="gray"><a href="zone.action?uid=${blog.uid}">${sNames[blog.uid]}</a> 发表于 ${blog.dateline}</p>
        		<p class="nhot"><a href="zone.action?uid=${blog.uid}&do=blog&id=${blog.blogid}">${blog.viewnum} 次阅读</a><span class="pipe">|</span></p>
        		<p class="nhot"><a href="zone.action?uid=${blog.uid}&do=blog&id=${blog.blogid}#comment">${blog.replynum} 个评论</a><span class="pipe">|</span></p>
        		<p class="nhot"><a href="zone.action?uid=${blog.uid}&do=blog&id=${blog.blogid}">${blog.hot} 人推荐</a>&nbsp;&nbsp;</p>
        	</li>
        	</c:forEach>
      	</ul>
	</div>

	<div class="box1">
    	<h2 class="ntitle box_left_title"><a href="zone.action?do=album&view=all" class="more">更多&raquo;</a><strong>图片</strong></h2>
		<ul class="photolist">
			<c:forEach items="${pics}" var="pic" varStatus="index">
			<li>
				<div class="spic_img">
					<div class="ttop" title="${pic.hot} 人推荐"><span>${pic.hot}人推荐</span></div>
					<a href="zone.action?uid=${pic.uid}&do=album&picid=${pic.picid}" target="_blank"><img src="${pic.filepath}" alt="${pic.albumname}" /></a>
				</div>
			</li>
			</c:forEach>
		</ul>
	</div>
</div>

<div class="nbox">
	<div class="box2">
		<h2 class="ntitle box_right_title"><a href="zone.action?do=thread&view=all" class="more">更多&raquo;</a><strong>话题 </strong></h2>
		<ul class="box_right_list">
			<c:forEach items="${threads}" var="thread">
			<li>
				<p>
	  				<div class="ttop" title="${thread.hot} 人推荐"><span>${thread.hot}</span></div>
	  				<a href="zone.action?uid=${thread.uid}&do=thread&id=${thread.tid}" target="_blank">${thread.subject}</a>
				</p>
				<p class="gray">
	  				<a href="zone.action?uid=${blog.uid}">${sNames[thread.uid]}</a>
					发布于 
					<a href="zone.action?do=mtag&tagid=${thread.tagid}" target="_blank">${thread.tagname}</a>
				</p>
			</li>
			</c:forEach>
		</ul>
	</div>

	<div class="box2">
		<h2 class="ntitle box_right_title"><a href="zone.action?do=doing&view=all" class="more">更多&raquo;</a><strong>心情 </strong></h2>
		<ul class="box_right_list">
			<c:forEach items="${doings}" var="doing">
			<li>
				<p class="gray r_option">${doing.dateline}</p> 
				<p>
					<a href="zone.action?uid=${doing.uid}" title="${sNames[doing.uid]}" class="s_avatar" target="_blank">${sns:avatar1(doing.uid,sGlobal,sConfig)}</a>
					<a href="zone.action?uid=${doing.uid}&do=doing&doid=${doing.doid}" target="_blank">${doing.message}</a>  
				</p>
			</li>
			</c:forEach>
		</ul>
	</div>
	
	<div class="box2">
		<h2 class="ntitle box_right_title"><a href="zone.action?do=event&view=recommend" class="more">更多&raquo;</a><strong>活动</strong></h2>
		<ul class="box_right_list">
			<c:forEach items="${events}" var="event">
			<li>
				<div class="ttop" title="${event.membernum} 人参加 | ${event.follownum} 人关注"><span>${event.membernum}|${event.follownum}</span></div>
				<h3><a href="zone.action?do=event&id=${event.eventid}" target="_blank">${event.title}</a></h3>
				<p class="eimage"><a href="zone.action?do=event&id=${event.eventid}" target="_blank"><img src="${event.poster}"/></a></p>
				<p><span class="gray">开始:</span> ${event.starttime}</p>
				<p><span class="gray">结束:</span> ${event.endtime}</p>
				<c:if test="${not empty event.province or not empty event.city or not empty event.location}">
				<p><span class="gray">地点:</span> ${event.province} ${event.city} ${event.location}</p>
				</c:if>
				<p><span class="gray">发起:</span> <a href="zone.action?uid=${event.uid}">${sNames[event.uid]}</a></p>
			</li>
			</c:forEach>
		</ul>
	</div>
	
	<div class="box2">
		<h2 class="ntitle box_right_title"><a href="zone.action?do=poll" class="more">更多&raquo;</a><strong>投票 </strong></h2>
		<ul class="box_right_list">
			<c:forEach items="${polls}" var="poll" varStatus="index">
			<li>
	  			<div class="ttop" title="${poll.voternum} 人投票"><span>${poll.voternum}</span></div>
				<a href="zone.action?uid=${poll.uid}&do=poll&pid=${poll.pid}" target="_blank">${poll.subject}</a>
			</li>
			</c:forEach>
		</ul>
	</div>

	<div class="box2">
		<h2 class="ntitle box_right_title"><a href="zone.action?do=share&view=all" class="more">更多&raquo;</a><strong>分享 </strong></h2>
		<ul class="box_right_list index_share">
			<c:forEach items="${shares}" var="share">
			<li>
            	<!--<div class="share_avatar"><a href="zone.action?uid=${share.uid}" title="${sNames[share.uid]}" target="_blank">${sns:avatar1(share.uid,sGlobal,sConfig)}</a></div>-->
				<div class="title">
					<a href="zone.action?uid=${share.uid}">${sNames[share.uid]}</a>
					<a href="zone.action?uid=${share.uid}&do=share&id=${share.sid}" class="gray"><span>${share.title_template}</span></a>
				</div>
				<div class="feed">
					<div style="width: 100%; overflow: hidden;">
						<c:if test="${!sns:snsEmpty(share.image)}"><a href="${share.image_link}"><img src="${share.image}" class="simage"/></a></c:if>
						<div class="detail">${share.body_template}</div>
						<c:choose>
							<c:when test="${'video'==share.type}"><a href="zone.action?uid=${share.uid}&do=share&id=${share.sid}" target="_blank"><img src="${sns:snsEmpty(share.body_data.flashimg)  ?  'image/vd.gif'  :  share.body_data.flashimg}" class="simage"></a></c:when>
							<c:when test="${'music'==share.type}"><div class="media"><img src="image/music.gif" alt="点击播放" onclick="javascript:showFlash('music', '${share.body_data.musicvar}', this, '${share.sid}');" style="cursor: pointer;" /></div></c:when>
							<c:when test="${'flash'==share.type}"><a href="zone.action?uid=${share.uid}&do=share&id=${share.sid}" target="_blank"><img src="image/flash.gif" class="simage"/></a></c:when>
						</c:choose>
						<div class="quote"><span id="quote" class="q">${share.body_general}</span></div>
						<div class="gray">分享于 ${share.dateline}</div>
					</div>
				</div>
			</li>
			</c:forEach>
		</ul>
	</div>
	
</div>

</div>
<jsp:include page="${sns:template(sConfig, sGlobal, 'footer.jsp')}" />