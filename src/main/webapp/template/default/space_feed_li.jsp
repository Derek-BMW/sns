<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<li class="s_clear ${feed.magic_class }" id="feed_${feed.feedid }_li"
	onmouseover="feed_menu(${feed.feedid },1);"
	onmouseout="feed_menu(${feed.feedid },0);">
	<div style="width: 100%; overflow: hidden;"${feed.style}>
		<c:if test="${feed.uid>0 && sns:snsEmpty(TPL.hidden_more)}">
			<a href="main.action?ac=feed&op=menu&feedid=${feed.feedid }" class="float_more" id="a_feed_menu_${feed.feedid }" onmouseover="feed_menu(${feed.feedid },1);" onmouseout="feed_menu(${feed.feedid },0);" onclick="ajaxmenu(event, this.id)" title="显示更多选项" style="display: none;">菜单</a>
		</c:if>
		<a class="type" href="zone.action?uid=${param.uid }&do=feed&view=${param.view }&appid=${feed.appid }&icon=${feed.icon}" title="只看此类动态"><img src="${feed.icon_image }" /></a> ${feed.title_template }
		<c:if test="${sns:snsEmpty(TPL.hidden_time)}">
			<span class="gray"><sns:date dateformat="MM-dd HH:mm" timestamp="${feed.dateline}" format="1" /></span>
		</c:if>

		<c:if test="${sns:snsEmpty(TPL.hidden_menu)}">
			<c:choose>
				<c:when test="${feed.idtype=='doid'}">(<a href="javascript:;" onclick="docomment_get('docomment_${feed.id }', 1);" id="do_a_op_${feed.id }">回复</a>)</c:when>
				<c:when test="${sns:inArray(fn:split('blogid,picid,sid,pid,eventid', ','),feed.idtype)}">(<a href="javascript:;" onclick="feedcomment_get(${feed.feedid });" id="feedcomment_a_op_${feed.feedid }">评论</a>)</c:when>
			</c:choose>
		</c:if>
		<div class="feed_content">
			<c:if test="${sns:snsEmpty(TPL.hidden_hot) && feed.hot>0}">
				<div class="hotspot">
					<a href="main.action?ac=feed&feedid=${feed.feedid }">${feed.hot }</a>
				</div>
			</c:if>

			<c:if test="${not empty feed.image_1}">
				<a href="${feed.image_1_link}"${feed.target }><img src="${feed.image_1 }" class="summaryimg" /></a>
			</c:if>
			<c:if test="${not empty feed.image_2}">
				<a href="${feed.image_2_link }"${feed.target }><img src="${feed.image_2 }" class="summaryimg" /></a>
			</c:if>
			<c:if test="${not empty feed.image_3}">
				<a href="${feed.image_3_link }"${feed.target }><img src="${feed.image_3 }" class="summaryimg" /></a>
			</c:if>
			<c:if test="${not empty feed.image_4}">
				<a href="${feed.image_4_link }"${feed.target }><img src="${feed.image_4 }" class="summaryimg" /></a>
			</c:if>

			<c:if test="${not empty feed.body_template}">
				<div class="detail"
					<c:if test="${not empty feed.image_3}"> style="clear: both;"</c:if>>
					${feed.body_template }
				</div>
			</c:if>
			<c:choose>
				<c:when test="${feed.thisapp>0 && !sns:snsEmpty(feed.body_data.flashvar)}">
				<div class="media">
					<div class="movie_app">
						<c:if test="${!sns:snsEmpty(feed.body_data.flashimg)}">
							<img class="movie_icon" id="icon_id_${feed.feedid}" src="image/movie_icon.png" alt="点击播放" onclick="javascript:showFlash('${feed.body_data.host}', '${feed.body_data.flashvar}', this, '${feed.feedid}');" style="cursor: pointer;" />
						</c:if>
						<img class="movie_pic" id="media_id_${feed.feedid}" src="${sns:snsEmpty(feed.body_data.flashimg)  ?  'image/vd.gif'  :  feed.body_data.flashimg}" alt="点击播放" onerror="this.onerror=null;this.src='image/vd.gif'" onclick="javascript:showFlash('${feed.body_data.host}', '${feed.body_data.flashvar}', this, '${feed.feedid}');" style="cursor: pointer;" />
					</div>
				</div>
				</c:when>
				<c:when
					test="${feed.thisapp>0 && !sns:snsEmpty(feed.body_data.musicvar)}">
					<div class="media">
						<img src="image/music.gif" alt="点击播放" onclick="javascript:showFlash('music', '${feed.body_data.musicvar }', this, '${feed.feedid }');" style="cursor: pointer;" />
					</div>
				</c:when>
				<c:when
					test="${feed.thisapp>0 && !sns:snsEmpty(feed.body_data.flashaddr)}">
					<div class="media">
						<img src="image/flash.gif" alt="点击查看" onclick="javascript:showFlash('flash', '${feed.body_data.flashaddr }', this, '${feed.feedid }');" style="cursor: pointer;" />
					</div>
				</c:when>
			</c:choose>

			<c:if test="${not empty feed.body_general}">
				<div class="quote">
					<span class="q">${feed.body_general }</span>
				</div>
			</c:if>
		</div>
	</div>

	<c:choose>
		<c:when test="${feed.idtype=='doid'}">
			<div id="docomment_${feed.id }" style="display: none;"></div>
		</c:when>
		<c:when test="${not empty feed.idtype}">
			<div id="feedcomment_${feed.feedid }" style="display: none;"></div>
		</c:when>
	</c:choose>

	<c:if test="${not empty hiddenfeed_num[feed.icon]}">
		<div id="appfeed_open_${feed.feedid }">
			<a href="javascript:;" id="feed_a_more_${feed.feedid }" onclick="feed_more_show('${feed.feedid }');">&raquo;更多动态(${hiddenfeed_num[feed.icon]})</a>
		</div>
		<div id="feed_more_${feed.feedid }" style="display: none;">
			<ol>
				<c:forEach items="${hiddenfeed_list[feed.icon]}" var="appvalue">
					<li>
						${appvalue.title_template }
						<div class="feed_content" style="width: 100%; overflow: hidden;">
							<c:if test="${not empty appvalue.image_1}">
								<a href="${appvalue.image_1_link }"${appvalue.target }><img src="${appvalue.image_1 }" class="summaryimg" /></a>
							</c:if>
							<c:if test="${not empty appvalue.image_2}">
								<a href="${appvalue.image_2_link }"${appvalue.target }><img src="${appvalue.image_2 }" class="summaryimg" /></a>
							</c:if>
							<c:if test="${not empty appvalue.image_3}">
								<a href="${appvalue.image_3_link }"${appvalue.target }><img src="${appvalue.image_3 }" class="summaryimg" /></a>
							</c:if>
							<c:if test="${not empty appvalue.image_4}">
								<a href="${appvalue.image_4_link }"${appvalue.target }><img src="${appvalue.image_4 }" class="summaryimg" /></a>
							</c:if>
							<c:if test="${not empty appvalue.body_template}">
								<div class="detail" ${not empty appvalue.image_3 ? ' style="clear: both;"' : ''}>
									${appvalue.body_template }
								</div>
							</c:if>
							<c:if test="${not empty appvalue.body_general}">
								<div class="quote">
									<span class="q">${appvalue.body_general }</span>
								</div>
							</c:if>
						</div>
					</li>
				</c:forEach>
			</ol>
		</div>
	</c:if>
</li>