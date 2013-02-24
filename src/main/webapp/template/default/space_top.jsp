<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<jsp:include page="${sns:template(sConfig, sGlobal, 'header.jsp')}" />
<div class="tabs_header">
	<ul class="tabs">
		<li${actives.show}><a href="zone.action?do=top"><span>竞价排行</span></a></li>
		<li${actives.mm}><a href="zone.action?do=top&view=mm"><span>美女排行</span></a></li>
		<li${actives.gg}><a href="zone.action?do=top&view=gg"><span>帅哥排行</span></a></li>
		<li${actives.experience}><a href="zone.action?do=top&view=experience"><span>经验排行</span></a></li>
		<li${actives.credit}><a href="zone.action?do=top&view=credit"><span>积分排行</span></a></li>
		<li${actives.friendnum}><a href="zone.action?do=top&view=friendnum"><span>好友数排行</span></a></li>
		<li${actives.viewnum}><a href="zone.action?do=top&view=viewnum"><span>访问量排行</span></a></li>
		<li${actives.online}><a href="zone.action?do=top&view=online"><span>在线成员</span></a></li>
		<c:if test="${sns:checkPerm(pageContext.request,pageContext.response,'admin')}">
		<li${actives.updatetime}><a href="zone.action?do=top&view=updatetime"><span>全部成员</span></a></li>
		</c:if>
	</ul>
<div class="searchbar floatright">
	<form method="get" action="main.action">
		<input name="searchkey" value="" size="14" class="t_input" type="text">
		<input name="searchsubmit" value="找人" class="submit" type="submit">
		<input type="hidden" name="searchmode" value="1" />
		<input type="hidden" name="ac" value="friend" />
		<input type="hidden" name="op" value="search" />
	</form>
</div>
</div>
<script type="text/javascript">
	function checkCredit(id) {
		var maxCredit = parseInt(${space.credit});
		var idval = parseInt($(id).value);
		if(idval > maxCredit) {
			alert("您的当前积分为:"+maxCredit+",请填写一个小于该值的数字");
			return false;
		} else if(idval < 1) {
			alert("您所填写的积分值不能小于1");
			return false;
		}
		return true;
	}
</script>
<div class="c_form">
	<c:if test="${now_pos>=0}">
		<div style="padding-bottom: 20px;">
			<h3 class="l_status">排行榜公告：</h3>
			<c:choose>
				<c:when test="${param.view=='show'}">
					<c:choose>
						<c:when test="${space.showcredit>0}">自己当前的竞价积分为：${space.showcredit}，当前排名 <span style="font-size: 20px; color: red;">${now_pos}</span> ，再接再厉！</c:when>
						<c:otherwise>您现在还没有上榜。让自己上榜吧，这会大大提升您的主页曝光率。</c:otherwise>
					</c:choose>
					<br>竞价积分越多，竞价排名越靠前，您的主页曝光率也会越高；<br>上榜用户的主页被别人有效浏览一次，其竞价积分将减少1个(恶意刷新访问不扣减)。
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${param.view=='credit'}"><a href="main.action?ac=credit">自己当前的积分：${space.credit}</a></c:when>
						<c:when test="${param.view=='friendnum'}"><a href="zone.action?do=friend">自己当前的好友数：${space.friendnum}</a></c:when>
						<c:when test="${param.view=='experience'}">自己当前的经验数：${space.experience}</c:when>
						<c:otherwise><a href="zone.action">自己当前的访问量：${space.viewnum}</a></c:otherwise>
					</c:choose>
					，当前排名 <span style="font-size: 20px; color: red;">${now_pos}</span> ，再接再厉！
				</c:otherwise>
			</c:choose>
			<c:if test="${cache_mode}"><p>下面列出的为前100名排行，数据每 ${sConfig.topcachetime} 分钟更新一次。</p></c:if>
		</div>
	</c:if>
	<c:if test="${param.view=='show'}">
		<div style="padding: 0 0 20px 0;">
			<table width="100%">
				<tr>
					<td width="50%" valign="top">
						<div class="l_status"><strong>帮助好友来上榜</strong></div>
						<div class="content">
							<form method="post" action="main.action?ac=top" onsubmit="return checkCredit('stakecredit');">
								<p>
									要帮助的好友用户名<br /><input type="text" name="fusername" value="" size="20" class="t_input" /><br />
									赠送竞价积分(<span class="gray">不要超过自己的积分:${space.credit}</span>)<br />
									<input type="text" id="stakecredit" name="stakecredit" value="100" size="5" class="t_input" onblur="checkCredit('stakecredit');" />
									<input type="submit" name="friend_submit" value="赠送" class="submit" />
								</p>
								<input type="hidden" name="friendsubmit" value="true" />
								<input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,false)}"/>
							</form>
						</div>
					</td>
					<td width="50%" valign="top">
						<div class="l_status"><strong>我也要上榜</strong></div>
						<div class="content">
							<form method="post" action="main.action?ac=top" onsubmit="return checkCredit('showcredit');">
								<p>
									我的上榜宣言(<span class="gray">最多50个汉字，会显示在榜单中</span>)<br />
									<input type="text" name="note" value="" size="35" class="t_input" /><br />
									增加竞价积分(<span class="gray">不要超过自己的积分:${space.credit}</span>)<br />
									<input type="text" id="showcredit" name="showcredit" value="100" size="5" class="t_input" onblur="checkCredit('showcredit');" />
									<input type="submit" name="show_submit" value="增加" class="submit" />
								</p>
								<input type="hidden" name="showsubmit" value="true" />
								<input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,false)}" />
							</form>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</c:if>
	<jsp:include page="${sns:template(sConfig, sGlobal, 'space_list.jsp')}" />
</div>
<jsp:include page="${sns:template(sConfig, sGlobal, 'footer.jsp')}" />