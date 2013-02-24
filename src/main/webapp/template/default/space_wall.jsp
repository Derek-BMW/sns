<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<jsp:include page="${sns:template(sConfig, sGlobal, 'header.jsp')}"/>

<div class="h_status">
	给<c:if test="${space.self}">自己</c:if><c:if test="${!space.self}">${sNames[space.uid]}</c:if>留言
</div>
<div class="space_wall_post">
	<form action="main.action?ac=comment" id="commentform_${space.uid}" name="commentform_${space.uid}" method="post">
		<a href="###" id="message_face" onclick="showFace(this.id, 'comment_message');return false;"><img src="image/facelist.gif" align="absmiddle" /></a>
		<c:if test="${not empty globalMagic.doodle}">
		<a id="a_magic_doodle" href="props.action?mid=doodle&showid=comment_doodle&target=comment_message" onclick="ajaxmenu(event, this.id, 1)"><img src="image/magic/doodle.small.gif" class="magicicon" />涂鸦板</a>
		</c:if>
		<br />
		<textarea name="message" id="comment_message" rows="5" cols="60" onkeydown="ctrlEnter(event, 'commentsubmit_btn');"></textarea>
		<input type="hidden" name="refer" value="zone.action?uid=${space.uid}" />
		<input type="hidden" name="id" value="${space.uid}" />
		<input type="hidden" name="idtype" value="uid" />
		<input type="hidden" name="commentsubmit" value="true" />
		<br>
		<input type="button" id="commentsubmit_btn" name="commentsubmit_btn" class="submit" value="留言" onclick="ajaxpost('commentform_${space.uid}', 'wall_add')" />
		<span id="__commentform_${space.uid}"></span>
		<input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,false)}" />
	</form>
</div>
<br>

<div class="comments_list" id="comment">
	<c:if test="${cid>0}">
	<div class="notice">
		当前只显示与你操作相关的单个留言，<a href="zone.action?uid=${space.uid}&do=wall">点击此处查看全部留言</a>
	</div>
	</c:if>

	<ul id="comment_ul">
	<c:forEach items="${list}" var="value">
	<c:set var="comment" value="${value}" scope="request"></c:set>
		<jsp:include page="${sns:template(sConfig, sGlobal, 'space_comment_li.jsp')}"/>
	</c:forEach>
	</ul>
</div>
<div class="page">${multi}</div>

<script type="text/javascript">
//彩虹炫
var elems = selector('div[class~=magicflicker]'); 
for(var i=0; i<elems.length; i++){
	magicColor(elems[i]);
}
</script>


<jsp:include page="${sns:template(sConfig, sGlobal, 'footer.jsp')}"/>