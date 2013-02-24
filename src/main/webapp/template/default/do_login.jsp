<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<c:set var="tpl_noSideBar" value="1" scope="request" />
<jsp:include page="${sns:template(sConfig, sGlobal, 'header.jsp')}" />
<div class="warp_page">
<form name="loginform" action="operate.action?ac=${sConfig.login_action}${empty url_plus ? '' : '&'}${url_plus}&ref" method="post" class="c_form">
	<table cellpadding="0" cellspacing="0" class="formtable">
		<caption>
			<h2>登录社区</h2>
		</caption>
		<tr>
		<td>
		<table>
		<c:if test="${not empty invits}">
		<tbody>
			<tr>
				<th width="100">好友邀请：</th>
				<td>
					<a href="zone.action?${url_plus}" target="_blank">${sns:avatar1(invits.uid,sGlobal,sConfig)}</a>
					<a href="zone.action?${url_plus}" target="_blank">${sNames[invits.uid]}</a>
				</td>
			</tr>
		</tbody>
		</c:if>
		<tbody style="display:${not empty sGlobal.input_seccode ? 'none' : ''};">
			<tr>
				<th width="100"><label for="username">用户名：</label></th>
				<td><input type="text" name="username" id="username" class="t_input" tabindex="1" value="${memberName}" /></td>
			</tr>
			<tr>
				<th width="100"><label for="password">密　码：</label></th>
				<td><input type="password" name="password" id="password" class="t_input" tabindex="2" value="${password}" /></td>
			</tr>
		</tbody>
		<c:if test="${sConfig.seccode_login==1}">
		<tbody>
			<c:choose>
			<c:when test="${sConfig.questionmode==1}">
			<c:if test="${not empty sGlobal.input_seccode}">
			<tr>
				<th width="100">&nbsp;</th>
				<td>您回答的问题不正确，请重新回答。</td>
			</tr>
			</c:if>
			<tr>
				<th width="100" style="vertical-align: top;">回答问题：</th>
					<td>
						<p>${sns:question(pageContext.request,pageContext.response)}</p>
						<input type="text" id="seccode" name="seccode" value="" tabindex="3" class="t_input"${empty sGlobal.input_seccode ? " onBlur=checkSeccode()" : ""}/>&nbsp;<span id="checkseccode">&nbsp;</span>
					</td>
				</tr>
			</c:when>
			<c:otherwise>
			<c:if test="${not empty sGlobal.input_seccode}">
			<tr>
				<th width="100">&nbsp;</th>
				<td>您输入的验证码不正确，请重新输入。</td>
			</tr>
			</c:if>
			<tr>
				<th width="100" style="vertical-align: top;">验证码：</th>
				<td>
					<input type="text" id="seccode" name="seccode" value="" tabindex="3" class="t_input"${empty sGlobal.input_seccode ? " onBlur=checkSeccode()" : ""}/>&nbsp;<span id="checkseccode">&nbsp;</span>
					<p>输入下图中的字符，不区分大小写</p>
					<script>seccode();</script>
					<a href="javascript:updateseccode()">看不清，换一张</a>
				</td>
			</tr>
			</c:otherwise>
			</c:choose>
		</tbody>
		</c:if>
		<tbody style="display:${not empty sGlobal.input_seccode ? 'none' : ''};">
			<tr>
				<th width="100">&nbsp;</th>
				<td><input type="checkbox" id="cookietime" name="cookietime" value="315360000"${cookieCheck} style="margin-bottom: -2px;"><label for="cookietime">自动登录</label></td>
			</tr>
		</tbody>
		<tbody>
			<tr>
				<th width="100">&nbsp;</th>
				<td>
					<input type="hidden" name="refer" value="${refer}" />
					<input type="submit" id="loginsubmit" name="loginsubmit" value="登录" class="submit" tabindex="4" />
					<a href="operate.action?ac=lostpasswd" class="button">忘记密码</a>
					<a href="operate.action?ac=${sConfig.register_action}" class="button">注册</a>
				</td>
			</tr>
		</tbody>
                <!--邵林----->
                <tbody>
			<tr>
				<th width="100">其他账号登录：</th>
				<td>
					<a href="https://graph.qq.com/oauth2.0/authorize?response_type=code&client_id=100279664&redirect_uri=http://www.lysns.net/operate.action&scope=get_user_info&state=qLogin" title="使用QQ号登陆">
                                        <image src="image/thirdLogin/qq/16-16.png"/>QQ登陆
                                    </a>
<!--    <iframe name="qqLogin" src="qLogin.action" style="width: 16px;height: 16px;" frameborder="0" marginheight="0" marginwidth="0"></iframe>
    QQ账号登录-->
				</td>
			</tr>
		</tbody>
                <!--邵林----->
		</table>
		</td>
		<td id="loginform"></td>
		</tr>
	</table>
	<input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,false)}" />
</form>
<script type="text/javascript">
	var lastSecCode = '';
	function checkSeccode() {
		var seccodeVerify = $('seccode').value;
		if(seccodeVerify == lastSecCode) {
			return;
		} else {
			lastSecCode = seccodeVerify;
		}
		ajaxresponse('checkseccode', 'op=checkseccode&seccode=' + (is_ie && document.charset == 'utf-8' ? encodeURIComponent(seccodeVerify) : seccodeVerify));
	}
	function ajaxresponse(objname, data) {
		var x = new Ajax('XML', objname);
		x.get('operate.action?ac=${sConfig.register_action}&' + data, function(s){
			var obj = $(objname);
			s = trim(s);
			if(s.indexOf('succeed') > -1) {
				obj.style.display = '';
				obj.innerHTML = '<img src="image/check_right.gif" width="13" height="13">';
				obj.className = "warning";
			} else {
				warning(obj, s);
			}
		});
	}
	function warning(obj, msg) {
		if((ton = obj.id.substr(5, obj.id.length)) != 'password2') {
			$(ton).select();
		}
		obj.style.display = '';
		obj.innerHTML = '<img src="image/check_error.gif" width="13" height="13"> &nbsp; ' + msg;
		obj.className = "warning";
	}

</script>

<c:if test="${not empty sGlobal.input_seccode}">
	<script>
	$('seccode').style.background = '#DDD';
	$('seccode').focus();
	</script>
</c:if>
</div>
<jsp:include page="${sns:template(sConfig, sGlobal, 'footer.jsp')}" />