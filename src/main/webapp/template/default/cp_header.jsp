<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<div class="tabs_header">
	<ul class="tabs">
		<li${actives.profile}><a href="main.action?ac=profile"><span>个人资料</span></a></li>
		<li${actives.avatar}><a href="main.action?ac=avatar"><span>我的头像</span></a></li>
		<c:if test="${sConfig.videophoto==1}"><li${actives.videophoto}><a href="main.action?ac=videophoto"><span>视频认证</span></a></li></c:if>
		<li${actives.credit}><a href="main.action?ac=credit"><span>我的积分</span></a></li>
		<c:if test="${sConfig.allowdomain ==1 && !empty sConfig.domainroot && sns:checkPerm(pageContext.request, pageContext.response,'domainlength')}"><li${actives.domain}><a href="main.action?ac=domain"><span>我的域名</span></a></li></c:if>
		<c:if test="${sConfig.sendmailday>0}"><li${actives.sendmail}><a href="main.action?ac=sendmail"><span>邮件提醒</span></a></li></c:if>
		<li${actives.privacy}><a href="main.action?ac=privacy"><span>隐私筛选</span></a></li>
		<li${actives.theme}><a href="main.action?ac=theme"><span>个性化设置</span></a></li>
		<li${actives.joinAgent}><a href="main.action?ac=joinAgent"><span>成为二级代理商</span></a></li>
		<li><a href="backstage.action"><span>更多设置</span></a></li>
	</ul>
</div>