<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<jsp:include page="${sns:template(sConfig, sGlobal, 'header.jsp')}"/>
<h2 class="title">
	<c:choose>
	<c:when test="${eventid>0}">
	<img src="image/app/event.gif"><a href="zone.action?do=event&id=${eventid}">${event.title}</a>
	</c:when>
	<c:otherwise>
	<img src="image/app/mtag.gif"><a href="zone.action?do=mtag&id=${mtag.fieldid}">${mtag.title}</a> -
	<a href="zone.action?do=mtag&tagid=${mtag.tagid}">${mtag.tagname}</a>
	</c:otherwise>
	</c:choose>
</h2>

<div class="tabs_header">

	<ul class="tabs">
		<c:choose>
		<c:when test="${eventid>0}">
		<li><a href="zone.action?do=event&id=${eventid}&view=thread"><span>返回讨论区</span></a></li>
		</c:when>
		<c:otherwise>
		<li><a href="zone.action?do=mtag&tagid=${thread.tagid}&view=list"><span>返回讨论区</span></a></li>
		</c:otherwise>
		</c:choose>
		<c:choose>
		<c:when test="${eventid>0}">
			<c:if test="${event.grade>0 && userevent.status>=2}">
		<li class="null"><a href="main.action?ac=thread&tagid=${mtag.tagid}&eventid=${eventid}">发起新话题</a></li>
			</c:if>
		</c:when>
		<c:when test="${sns:snsEmpty(mtag.ismember) && mtag.joinperm<2}">
		<li class="null"><a href="main.action?ac=mtag&op=join&tagid=${mtag.tagid}" id="mtag_join_${mtag.tagid}" onclick="ajaxmenu(event, this.id)">加入该群组</a></li>
		</c:when>
		<c:when test="${!sns:snsEmpty(mtag.allowpost)}">
		<li class="null"><a href="main.action?ac=thread&tagid=${mtag.tagid}">发起新话题</a></li>
		</c:when>
		</c:choose>
	</ul>
	<c:if test="${not empty sGlobal.refer}">
	<div class="r_option">
		<a  href="${sGlobal.refer}">&laquo; 返回上一页</a>
	</div>
	</c:if>
</div>

<div id="div_post">

	<div class="board">
		<c:if test="${not empty thread.content}">
		<div id="post_${thread.content.pid}_li">

			<ul class="line_list">
				<li>
				<table width="100%">
				<tr>
					<td width="70" valign="top">
						<div class="avatar48">
						<a href="zone.action?uid=${thread.uid}">${sns:avatar1(thread.uid,sGlobal,sConfig)}</a>
						</div>
					</td>
					<td>
						<div class="title">
							<a href="main.action?ac=share&type=thread&id=${thread.tid}" id="a_share" onclick="ajaxmenu(event, this.id, 1)" class="a_share">分享</a>
							<div class="r_option">
								<a href="main.action?ac=common&op=report&idtype=tid&id=${thread.tid}" id="a_report" onclick="ajaxmenu(event, this.id, 1)">举报</a><span class="pipe">|</span>
							</div>

							<h1 <c:if test="${!sns:snsEmpty(thread.magiccolor)}"> class="magiccolor${thread.magiccolor}"</c:if>>${thread.magiceggImage} ${thread.subject}</h1>
							<c:if test="${thread.hot>0}"><span class="hot"><em>热</em>${thread.hot}</span></c:if>
							<a href="zone.action?uid=${thread.uid}">${sNames[thread.uid]}</a>
							<span class="gray"><sns:date dateformat="yyyy-MM-dd HH:mm" timestamp="${thread.dateline}" format="1"/></span>


							<c:if test="${not empty topic}">
							<p style="padding:5px 0;">
								<img src="image/app/topic.gif" align="absmiddle">
								<strong>凑个热闹</strong>：<a href="zone.action?do=topic&topicid=${topic.topicid}">${topic.subject}</a></p>
							</c:if>

							<c:if test="${eventid==0 && thread.eventid>0 && not empty event}">
							<p style="padding:5px 0;"><strong>来自活动</strong>：<a href="zone.action?do=event&id=${event.eventid}&view=thread">${event.title}</a></p>
							</c:if>
						</div>

						<div class="detail" id="detail_0">
							<c:if test="${not empty globalAd.rightside}">
							<div style="float: right; padding:5px;">${sns:showAd(globalAd.rightside)}</div>
							</c:if>
							${thread.content.message}
						</div>

					</td>
				</tr>
			</table>
			
			<div id="click_div">
			<jsp:include page="${sns:template(sConfig, sGlobal, 'space_click.jsp')}"/>
			</div>

			<table width="100%">			
				<tr>
					<td align="right">
						<c:if test="${thread.uid==sGlobal.supe_uid}">
							<c:if test="${not empty globalMagic.icon}">
							<img src="image/magic/icon.small.gif" class="magicicon">
							<a href="props.action?mid=icon&idtype=tid&id=${thread.tid}" id="a_magic_icon" onclick="ajaxmenu(event,this.id,1)">${globalMagic.icon}</a>							
							<span class="pipe">|</span>
							</c:if>
							<c:if test="${not empty globalMagic.color}">
							<img src="image/magic/color.small.gif" class="magicicon">
								<c:choose>
								<c:when test="${!sns:snsEmpty(thread.magiccolor)}">
							<a href="main.action?ac=magic&op=cancelcolor&idtype=tid&id=${thread.tid}" id="a_magic_color" onclick="ajaxmenu(event,this.id)">取消${globalMagic.color}</a>
								</c:when>
								<c:otherwise>
							<a href="props.action?mid=color&idtype=tid&id=${thread.tid}" id="a_magic_color" onclick="ajaxmenu(event,this.id,1)">${globalMagic.color}</a>
								</c:otherwise>
								</c:choose>
							<span class="pipe">|</span>
							</c:if>
						</c:if>
						<c:if test="${mtag.grade>=8 || thread.uid==sGlobal.supe_uid || (eventid>0 && userevent.status>=3)}">
						<a href="main.action?ac=thread&op=edit&pid=${thread.content.pid}&tagid=${thread.tagid}<c:if test="${eventid>0}">&eventid=${eventid}</c:if>">编辑</a>
						<a href="main.action?ac=thread&op=delete&pid=${thread.content.pid}&tagid=${thread.tagid}<c:if test="${eventid>0}">&eventid=${eventid}</c:if>" id="p_${thread.content.pid}_delete" onclick="ajaxmenu(event, this.id)">删除</a>
						</c:if>
						<c:if test="${thread.uid==sGlobal.supe_uid || managethread}">
						<a href="main.action?ac=topic&op=join&id=${thread.tid}&idtype=tid" id="a_topicjoin_${thread.tid}" onclick="ajaxmenu(event, this.id)">凑热闹</a><span class="pipe">|</span>
						</c:if>
						<c:if test="${managethread}">
						<a href="main.action?ac=thread&tid=${thread.tid}&op=edithot" id="a_hot_${thread.tid}" onclick="ajaxmenu(event, this.id)">热度</a><span class="pipe">|</span>
						</c:if>
						<c:if test="${(eventid==0 && !sns:snsEmpty(mtag.allowpost)) || (eventid>0 && userevent.status>=2) }"><a href="#postform">回复</a>&nbsp;</c:if>
						<c:if test="${mtag.grade>=8 && eventid==0}">
							<c:choose>
							<c:when test="${!sns:snsEmpty(thread.displayorder)}">
							<a href="main.action?ac=thread&op=top&tagid=${thread.tagid}&tid=${thread.tid}&cancel" id="t_${thread.tid}_top" onclick="ajaxmenu(event, this.id, 0, 2000)">取消置顶</a>&nbsp;
							</c:when>
							<c:otherwise>
							<a href="main.action?ac=thread&op=top&tagid=${thread.tagid}&tid=${thread.tid}" id="t_${thread.tid}_top" onclick="ajaxmenu(event, this.id, 0, 2000)">置顶</a>&nbsp;
							</c:otherwise>
							</c:choose>
							<c:choose>
							<c:when test="${!sns:snsEmpty(thread.digest)}">
							<a href="main.action?ac=thread&op=digest&tagid=${thread.tagid}&tid=${thread.tid}&cancel" id="t_${thread.tid}_digest" onclick="ajaxmenu(event, this.id, 0, 2000)">取消精华</a>
							</c:when>
							<c:otherwise>
							<a href="main.action?ac=thread&op=digest&tagid=${thread.tagid}&tid=${thread.tid}" id="t_${thread.tid}_digest" onclick="ajaxmenu(event, this.id, 0, 2000)">精华</a>
							</c:otherwise>
							</c:choose>
						</c:if>
					</td>
				</tr>
				</table>
				</li>
			</ul>

		</div>

		</c:if>
		<div class="page">${multi}</div>
		<div id="post_ul">

			<c:if test="${pid>0}">
			<div class="notice">
				当前只显示与你操作相关的单个帖子，<a href="zone.action?uid=${thread.uid}&do=thread&id=${thread.tid}<c:if test="${eventid>0}">&eventid=${eventid}</c:if>">点击此处查看全部回帖</a>
			</div>
			</c:if>

			<c:forEach items="${list}" var="value">
			<c:set var="postValue" value="${value}" scope="request"></c:set>
			<jsp:include page="${sns:template(sConfig, sGlobal, 'space_post_li.jsp')}"/>
			</c:forEach>
		</div>

		<div class="page">${multi}</div>
		<c:choose>
		<c:when test="${(eventid==0 && !sns:snsEmpty(mtag.allowpost)) || (eventid>0 && userevent.status>=1) }">
		<div class="quickpost" id="postform">
			<form method="post" action="main.action?ac=thread<c:if test="${eventid>0}">&eventid=${eventid}</c:if>" class="quickpost" id="quickpostform_${thread.tid}" name="quickpostform_${thread.tid}">
				<table>
					<tr>
						<td>
							<a href="###" id="quickpost" onclick="showFace(this.id, 'message');return false;"><img src="image/facelist.gif" align="absmiddle" /></a>
							<c:if test="${not empty globalMagic.doodle}">
							<a id="a_magic_doodle" href="props.action?mid=doodle&showid=comment_doodle&target=message" onclick="ajaxmenu(event, this.id, 1)"><img src="image/magic/doodle.small.gif" class="magicicon" />涂鸦板</a>
							</c:if>
							<br />
							<textarea id="message" name="message" onkeydown="ctrlEnter(event, 'postsubmit_btn');" col="50" rows="6" style="width: 430px; height: 6em;"></textarea>
						</td>
					</tr>
					<tr>
						<td>插入图片</td>
					</tr>
					<tbody id="quickpostimg">
						<tr>
							<td>
								<input type="text" name="pics[]" onfocus="if(this.value == 'http://')this.value='';" onblur="if(this.value=='')this.value='http://'" value="http://" class="t_input" size="55" style="width: 350px" />&nbsp;
								<a href="javascript:;" onclick="insertWebImg(this.previousSibling.previousSibling)">插入</a> &nbsp;
								<a href="javascript:;" onclick="delRow(this, 'quickpostimg')">删除</a>
							</td>
						</tr>
					</tbody>
					<tr>
						<td><a href="javascript:;" onclick="copyRow('quickpostimg')">+增加图片</a> <span class="gray">只支持 .jpg、.gif、.png为结尾的URL地址</span></td>
					</tr>
					<tr>
						<td>
							<input type="hidden" name="tid" value="${thread.tid}" />
							<input type="hidden" name="postsubmit" value="true" />
							<input type="button" id="postsubmit_btn" name="postsubmit_btn" value="回复" class="submit" onclick="ajaxpost('quickpostform_${thread.tid}', 'post_add')" />
							<div id="__quickpostform_${thread.tid}"></div>
						</td>
					</tr>
				</table>
				<input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,false)}" />
			</form>
		</div>
		</c:when>
		<c:otherwise>
		<div class="c_form">
		<c:choose>
		<c:when test="${eventid>0}">
			只有活动成员可以回复活动话题
		</c:when>
		<c:when test="${mtag.grade==-1}">
			您现在被群主禁言，不能参与讨论。
		</c:when>
		<c:otherwise>
			你还不是该群组正式成员，不能参与讨论。
			<c:if test="${mtag.grade==-9}">
			<a href="main.action?ac=mtag&op=join&tagid=${mtag.tagid}" id="_tag_join_${mtag.tagid}" onclick="ajaxmenu(event, this.id)">现在就加入</a>。
			</c:if>
		</c:otherwise>
		</c:choose>
		</div>
		</c:otherwise>
		</c:choose>
	</div>
</div>

<script type="text/javascript">
	resizeImg('div_post','600');
</script>

<jsp:include page="${sns:template(sConfig, sGlobal, 'footer.jsp')}"/>