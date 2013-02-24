<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<jsp:include page="${sns:template(sConfig, sGlobal, 'header.jsp')}"/>


<c:if test="${sGlobal.inajax>0}">
	<div id="space_blog" class="feed">
		<h3 class="feed_header">
			<a href="main.action?ac=blog" class="r_option" target="_blank">发表日志</a>
			日志(共 ${count } 篇)
		</h3>
		<c:if test="${count>0}">
		<ul class="line_list">
		<c:forEach items="${list}" var="value">
			<li>
				<span class="gray r_option"><sns:date dateformat="MM-dd HH:mm" timestamp="${value.dateline}" format="1"/></span>
				<h4><a href="zone.action?uid=${space.uid }&do=blog&id=${value.blogid }" target="_blank" <c:if test="${value.magiccolor>0}"> class="magiccolor${value.magiccolor}"</c:if>>${value.subject }</a></h4>
				<div class="detail">
					${value.message }
				</div>
			</li>
		</c:forEach>
		</ul>
		<c:if test="${pricount>0}">
		<div class="c_form">本页有 ${pricount } 篇日志因作者的隐私设置而隐藏</div>
		</c:if>
		<div class="page">${multi}</div>
		</c:if>
		<c:if test="${count<=0}">
		<div class="c_form">还没有相关的日志。</div>
		</c:if>
	</div>
</c:if>
<c:if test="${sGlobal.inajax<=0}">

<c:if test="${space.self}">
<div class="tabs_header">
	<ul class="tabs">
		<c:if test="${sCookie.currentsite ne 'space'}">
		<li${actives.all }><a href="zone.action?uid=${space.uid}&do=${do}&view=all"><span>大家的日志</span></a></li>
		</c:if>
		<c:if test="${sGlobal.supe_uid>0}">
		<li${actives.me }><a href="zone.action?uid=${space.uid}&do=${do }&view=me"><span>我的日志</span></a></li>
		<li${actives.click }><a href="zone.action?uid=${space.uid}&do=${do}&view=click"><span>我表态过的日志</span></a></li>
		<c:if test="${space.friendnum>0}"><li${actives.we }><a href="zone.action?uid=${space.uid}&do=${do}&view=we"><span>好友最新日志</span></a></li></c:if>
		</c:if>
		<li class="null"><a href="main.action?ac=blog">发表新日志</a></li>
	</ul>
<div class="searchbar floatright">
<form method="get" action="zone.action">
	<input name="searchkey" value="" size="15" class="t_input" type="text">
	<input name="searchsubmit" value="搜索日志" class="submit" type="submit">
	<input type="hidden" name="searchmode" value="1" />
	<input type="hidden" name="do" value="blog" />
	<input type="hidden" name="view" value="all" />
	<input type="hidden" name="orderby" value="dateline" />
</form>
</div>
</div>		
</c:if>
<c:if test="${!space.self and sCookie.currentsite ne 'space'}">
<jsp:include page="${sns:template(sConfig, sGlobal, 'space_menu.jsp')}"/>
<div class="h_status">按照发布时间排序</div>
</c:if>
		
<div id="content" style="width:610px;">
	<c:if test="${!sns:snsEmpty(param.orderby) && param.orderby!='dateline'}">
	<div class="h_status">
		排行时间范围：
		<a href="zone.action?do=blog&view=all&orderby=${param.orderby}"${day_actives['0']}>全部</a><span class="pipe">|</span>
		<a href="zone.action?do=blog&view=all&orderby=${param.orderby}&day=1"${day_actives['1'] }>最近一天</a><span class="pipe">|</span>
		<a href="zone.action?do=blog&view=all&orderby=${param.orderby}&day=2"${day_actives['2'] }>最近两天</a><span class="pipe">|</span>
		<a href="zone.action?do=blog&view=all&orderby=${param.orderby}&day=7"${day_actives['7'] }>最近七天</a><span class="pipe">|</span>
		<a href="zone.action?do=blog&view=all&orderby=${param.orderby}&day=30"${day_actives['30'] }>最近三十天</a><span class="pipe">|</span>
		<a href="zone.action?do=blog&view=all&orderby=${param.orderby}&day=90"${day_actives['90'] }>最近三个月</a><span class="pipe">|</span>
		<a href="zone.action?do=blog&view=all&orderby=${param.orderby}&day=120"${day_actives['120'] }>最近六个月</a>
	</div>
	</c:if>
	
	<c:if test="${not empty searchkey}">
	<div class="h_status">以下是搜索日志 <span style="color:red;font-weight:bold;">${searchkey }</span> 结果列表</div>
	</c:if>
	
	<c:if test="${count>0}">
	<div class="entry_list">
		<ul>
		<c:forEach items="${list}" var="value">
			<li>
				<div class="avatardiv">
					<div class="avatar48"><a href="zone.action?uid=${value.uid }">${sns:avatar1(value.uid,sGlobal, sConfig)}</a></div>
					<c:if test="${value.hot>0}"><div class="digb">${value.hot }</div></c:if>
				</div>
				
				<div class="title">
					<a href="main.action?ac=share&type=blog&id=${value.blogid }" id="a_share_${value.blogid }" onclick="ajaxmenu(event, this.id, 1)" class="a_share">分享</a>
					<h4><a href="zone.action?uid=${value.uid }&do=${do }&id=${value.blogid }" <c:if test="${value.magiccolor>0}"> class="magiccolor${value.magiccolor}"</c:if>>${value.subject}</a></h4>
					<div>
					<c:if test="${!sns:snsEmpty(value.friend)}">
					<span class="r_option locked gray"><a href="${theurl }&friend=${value.friend }" class="gray">${friendsName[value.friend]}</a></span>
					</c:if>
					<a href="zone.action?uid=${value.uid}">${sNames[value.uid]}</a> <span class="gray"><sns:date dateformat="yyyy-MM-dd HH:mm" timestamp="${value.dateline}" format="1"/></span>
					</div>
				</div>
				<div class="detail image_right l_text s_clear" id="blog_article_${value.blogid }">
					<c:if test="${!sns:snsEmpty(value.pic)}"><p class="image"><a href="zone.action?uid=${value.uid}&do=blog&id=${value.blogid}"><img src="${value.pic}" alt="${value.subject}" /></a></p></c:if>
					${value.message }
				</div>
				<div class="gray">
					<c:if test="${!sns:snsEmpty(classmap[value.classid])}">分类: <a href="zone.action?uid=${value.uid }&do=blog&classid=${value.classid }">${classmap[value.classid].classname}</a><span class="pipe">|</span></c:if>
					<c:if test="${value.recommendnum>0}">
						<a href="zone.action?uid=${value.uid }&do=${do}&id=${value.blogid }">${value.recommendnum} 次推荐</a><span class="pipe">|</span>
					</c:if>
					<c:if test="${value.recommendnum==0}">
						<a href="zone.action?uid=${value.uid }&do=${do}&id=${value.blogid }">没有推荐</a><span class="pipe">|</span>
					</c:if>					
					<c:if test="${value.viewnum>0}"><a href="zone.action?uid=${value.uid }&do=${do}&id=${value.blogid }">${value.viewnum} 次阅读</a><span class="pipe">|</span></c:if>
					<c:if test="${value.replynum>0}"><a href="zone.action?uid=${value.uid }&do=${do}&id=${value.blogid}#comment">${value.replynum } 个评论</a></c:if><c:if test="${value.replynum<=0}">没有评论</c:if>
				</div>
			</li>
		</c:forEach>
		<c:if test="${pricount>0}">
			<li>
				<div class="title">本页有 ${pricount }篇日志因作者的隐私设置而隐藏</div>
			</li>
		</c:if>
		</ul>
	</div>
	
	<div class="page">${multi }</div>
	
	</c:if>
	<c:if test="${count<=0}">
	<div class="c_form">还没有相关的日志。</div>
	</c:if>

</div>

<div id="sidebar" style="width:150px;">

<c:if test="${not empty userlist}">
	<div class="cat">
	<h3>按好友查看</h3>
	<ul class="post_list line_list">
		<li>
			选择好友:<br>
			<select name="fuidsel" onchange="fuidgoto(this.value);">
			<option value="">全部好友</option>
			<c:forEach items="${userlist}" var="value">
			<option value="${value.fuid }"${fuid_actives[value.fuid]}>${sNames[value.fuid]}</option>
			</c:forEach>
			</select>
		</li>
	</ul>
	</div>
</c:if>
	
<c:if test="${not empty classmap}">
	<div class="cat">
	<h3>日志分类</h3>
	<ul class="post_list line_list">
		<li<c:if test="${sns:snsEmpty(param.classid)}"> class="current"</c:if>><a href="zone.action?uid=${space.uid }&do=blog&view=me">全部日志</a></li>
		<c:forEach items="${classmap.values()}" var="classItem">
		<li<c:if test="${param.classid==classItem.classid}"> class="current"</c:if>>
			<c:if test="${space.self && (classItem.uid != 0)}">
				<a href="main.action?ac=class&op=edit&classid=${classItem.classid}" id="c_edit_${classItem.classid}" onclick="ajaxmenu(event, this.id)" class="c_edit">编辑</a>
				<a href="main.action?ac=class&op=delete&classid=${classItem.classid}" id="c_delete_${classItem.classid}" onclick="ajaxmenu(event, this.id)" class="c_delete">删除</a>
			</c:if>
			<a href="zone.action?uid=${space.uid}&do=blog&classid=${classItem.classid}&view=me">${classItem.classname}</a>
		</li>
		</c:forEach>
	</ul>
	</div>
</c:if>

<c:if test="${param.view=='click'}">
	<div class="cat">
	<h3>表态动作</h3>
	<ul class="post_list line_list">
		<li${click_actives.all}><a href="zone.action?do=blog&view=click">全部动作</a></li>
		<c:forEach items="${clicks}" var="click">
		<li${click_actives[click.value.clickid]}>
			<a href="zone.action?do=blog&view=click&clickid=${click.value.clickid }">${click.value.name }</a>
		</li>
		</c:forEach>
	</ul>
	</div>
</c:if>
<c:if test="${param.view=='all'}">
	<div class="cat">
	<h3>排行榜</h3>
	<ul class="post_list line_list">
		<li${all_actives.recommend}><a href="zone.action?do=blog&view=all&orderby=recommend">推荐阅读</a></li>
		<li${all_actives.all}><a href="zone.action?do=blog&view=all">热文排行</a></li>
		<li${all_actives.dateline}><a href="zone.action?do=blog&view=all&orderby=dateline">最新发表</a></li>
		<li${all_actives.hot}><a href="zone.action?do=blog&view=all&orderby=hot&day=${param.hotday }">人气排行</a></li>
		<li${all_actives.replynum}><a href="zone.action?do=blog&view=all&orderby=replynum&day=${param.hotday }">评论排行</a></li>
		<li${all_actives.viewnum}><a href="zone.action?do=blog&view=all&orderby=viewnum&day=${param.hotday }">查看排行</a></li>
		<c:forEach items="${clicks}" var="click">
		<c:set var="clickid" value="click_${click.value.clickid}" scope="page"></c:set>
		<li${all_actives[clickid]}><a href="zone.action?do=blog&view=all&orderby=click_${click.value.clickid }&day=${param.hotday}">${click.value.name}排行</a></li>
		</c:forEach>
	</ul>
	
	</div>
</c:if>

</div>

<script>
function fuidgoto(fuid) {
	window.location.href = "zone.action?do=blog&view=we&fuid="+fuid;
}
</script>
</c:if>
	

<jsp:include page="${sns:template(sConfig, sGlobal, 'footer.jsp')}"/>