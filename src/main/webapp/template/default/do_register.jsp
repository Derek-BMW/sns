<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<c:set var="tpl_noSideBar" value="1" scope="request" />
<jsp:include page="${sns:template(sConfig, sGlobal, 'header.jsp')}" />
<style type="text/css">
	.psdiv0,.psdiv1,.psdiv2,.psdiv3,.psdiv4{position:relative;height:30px;color:#666}/*密码强度容器*/
	.strongdepict{position:absolute; width:300px;left:0px;top:3px}/*密码强度固定文字*/
	.strongbg{position:absolute;left:0px;top:22px;width:235px!important;width:234px;height:10px;background-color:#E0E0E0; font-size:0px;line-height:0px}/*灰色强度背景*/
	.strong{float:left;font-size:0px;line-height:0px;height:10px}/*色块背景*/
					
	.psdiv0 span{display:none}
	.psdiv1 span{display:inline;color:#F00}
	.psdiv2 span{display:inline;color:#C48002}
	.psdiv3 span{display:inline;color:#2CA4DE}
	.psdiv4 span{display:inline;color:#063}
					
	.psdiv0 .strong{ width:0px}
	.psdiv1 .strong{ width:25%;background-color:#F00}
	.psdiv2 .strong{ width:50%;background-color:#F90}
	.psdiv3 .strong{ width:75%;background-color:#2CA4DE}
	.psdiv4 .strong{ width:100%;background-color:#063}
</style>
<div class="warp_page">
<script>
	function register(id, result) {
		if(result) {
			$('registersubmit').disabled = true;
			window.location.href = "${jumpurl}";
		} else {
			updateseccode();
		}
	}
</script>
<form name="registerform" action="operate.action?ac=${sConfig.register_action}${empty url_plus ? '' : '&'}${url_plus}&ref" method="post" class="c_form">
	<table cellpadding="0" cellspacing="0" class="formtable">
		<caption>
			<h2>注册</h2>
		</caption>
		<tr>
		<td>
		<table>
		<c:if test="${not empty invits}">
			<tr>
				<th width="100">好友邀请</th>
				<td>
					<a href="zone.action?${url_plus}" target="_blank">${sns:avatar1(invits.uid,sGlobal,sConfig)}</a>
					<a href="zone.action?${url_plus}" target="_blank">${sNames[invits.uid]}</a>
				</td>
			</tr>
		</c:if>
		<tr>
			<th width="100">用户名</th>
			<td>
				<input type="text" id="username" name="username" value="" class="t_input" onBlur="checkUserName()" tabindex="1" />&nbsp;<span id="checkusername">&nbsp;</span>
			</td>
		</tr>
		<tr>
			<th>注册密码</th>
			<td>
				<input type="password" name="password" id="password" value="" class="t_input" onBlur="checkPassword()" onkeyup="checkPwd(this.value);" tabindex="2" />&nbsp;<span id="checkpassword">&nbsp;</span><br />
				<div class="psdiv0" id="chkpswd">
					<div class="strongdepict">密码安全程度：<span id="chkpswdcnt">太短</span></div>
					<div class="strongbg"><div class="strong"></div></div>
				</div>
			</td>
		</tr>
		<tr>
			<th>再次输入密码</th>
			<td><input type="password" id="password2" name="password2" value="" class="t_input" onBlur="checkPassword2()" tabindex="3" />&nbsp;<span id="checkpassword2">&nbsp;</span></td>
		</tr>
		<tr>
			<th>邮箱</th>
			<td>
				<input type="text" id="email" name="email" class="t_input" tabindex="4" />
				<br>邮箱用于找回密码、接收信息。
			</td>
		</tr>
		<c:if test="${sConfig.seccode_register==1}">
			<c:choose>
				<c:when test="${sConfig.questionmode==1}">
					<tr>
						<th width="100" style="vertical-align: top;">回答问题</th>
						<td>
							<p>${sns:question(pageContext.request,pageContext.response)}</p>
							<input type="text" id="seccode" name="seccode" value="" class="t_input" onBlur="checkSeccode()" tabindex="5" autocomplete="off" />&nbsp;<span id="checkseccode">&nbsp;</span>
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr>
						<th width="100" style="vertical-align: top;">验证码</th>
						<td>
							<input type="text" id="seccode" name="seccode" value="" class="t_input" onBlur="checkSeccode()" tabindex="5" autocomplete="off" />&nbsp;<span id="checkseccode">&nbsp;</span>
							<p>输入下图中的字符，不区分大小写</p>
							<script>seccode();</script>
							<a href="javascript:updateseccode()">看不清，换一张</a>
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</c:if>
		<c:if test="${not empty registerRule}">
			<tr>
				<th>服务条款</th>
				<td>
					<div name="rule" style="border: 1px solid #C3C3C3; width: 220px; height: 200px; overflow: auto; padding: 5px;">${registerRule}</div>
					<input type="checkbox" name="accede" id="accede" value="1">我已阅读，并同意以上服务条款
					<script type="text/javascript">
						function checkClause() {
							if($('accede').checked) {
								return true;
							} else {
								alert("您必须同意服务条款后才能注册");
								return false;
							}
						}
					</script>
				</td>
			</tr>
		</c:if>
		<tr>
			<th>&nbsp;</th>
			<td>
				<input type="hidden" name="refer" value="zone.action?do=home" />
				<input type="submit" id="registersubmit" name="registersubmit" value="注册" class="submit" onclick="<c:if test='${not empty registerRule }'>if(!checkClause()){return false;}</c:if>ajaxpost('registerform', 'register');" tabindex="6" />
			</td>
		</tr>
		<tr>
			<th>&nbsp;</th>
			<td id="__registerform" style="color: red; font-weight: bold;"></td>
		</tr>
		</table>
		</td>
		<td id="registerform"></td>
		</tr>
	</table>
	<input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,false)}" />
</form>

<script type="text/javascript">
<!--
	$('username').focus();
	var lastUserName = lastPassword = lastEmail = lastSecCode = '';
	function checkUserName() {
		var userName = $('username').value;
		if(userName == lastUserName) {
			return;
		} else {
			lastUserName = userName;
		}
		var cu = $('checkusername');
		var unLen = userName.replace(/[^\x00-\xff]/g, "**").length;
		if(unLen < 3 || unLen > 15) {
			warning(cu, unLen < 3 ? '用户名小于3个字符' : '用户名超过 15 个字符');
			return;
		}
		if(!isNumberOrLetter(userName)){
			warning(cu, '用户名只能是英文字母和数字的组合，并且以字母开头');
			return;
		}
		ajaxresponse('checkusername', 'op=checkusername&username=' + (is_ie && document.charset == 'utf-8' ? encodeURIComponent(userName) : userName));
	}
	function checkPassword(confirm) {
		var password = $('password').value;
		if(!confirm && password == lastPassword) {
			return;
		} else {
			lastPassword = password;
		}
		var cp = $('checkpassword');
		if(password == '' || /[\'\"\\]/.test(password)) {
			warning(cp, '密码空或包含非法字符');
			return false;
		} else {
			cp.style.display = '';
			cp.innerHTML = '<img src="image/check_right.gif" width="13" height="13">';
			if(!confirm) {
				checkPassword2(true);
			}
			return true;
		}
	}
	function checkPassword2(confirm) {
		var password = $('password').value;
		var password2 = $('password2').value;
		var cp2 = $('checkpassword2');
		if(password2 != '') {
			checkPassword(true);
		}
		if(password == '' || (confirm && password2 == '')) {
			cp2.style.display = 'none';
			return;
		}
		if(password != password2) {
			warning(cp2, '两次输入的密码不一致');
		} else {
			cp2.style.display = '';
			cp2.innerHTML = '<img src="image/check_right.gif" width="13" height="13">';
		}
	}
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

	function checkPwd(pwd){

		if (pwd == "") {
			$("chkpswd").className = "psdiv0";
			$("chkpswdcnt").innerHTML = "";
		} else if (pwd.length < 3) {
			$("chkpswd").className = "psdiv1";
			$("chkpswdcnt").innerHTML = "太短";
		} else if(!isPassword(pwd) || !/^[^%&]*$/.test(pwd)) {
			$("chkpswd").className = "psdiv0";
			$("chkpswdcnt").innerHTML = "";
		} else {
			var csint = checkStrong(pwd);
			switch(csint) {
				case 1:
					$("chkpswdcnt").innerHTML = "很弱";
					$( "chkpswd" ).className = "psdiv"+(csint + 1);
					break;
				case 2:
					$("chkpswdcnt").innerHTML = "一般";
					$( "chkpswd" ).className = "psdiv"+(csint + 1);
					break;
				case 3:		
					$("chkpswdcnt").innerHTML = "很强";
					$("chkpswd").className = "psdiv"+(csint + 1);
					break;
			}
		}
	}
	function isPassword(str){
		if (str.length < 3) return false;
		var len;
		var i;
		len = 0;
		for (i=0;i<str.length;i++){
			if (str.charCodeAt(i)>255) return false;
		}
		return true;
	}
	function charMode(iN){ 
		if (iN>=48 && iN <=57) //数字 
		return 1; 
		if (iN>=65 && iN <=90) //大写字母 
		return 2; 
		if (iN>=97 && iN <=122) //小写 
		return 4; 
		else 
		return 8; //特殊字符 
	} 
	//计算出当前密码当中一共有多少种模式 
	function bitTotal(num){ 
		modes=0; 
		for (i=0;i<4;i++){ 
			if (num & 1) modes++; 
			num>>>=1; 
		} 
		return modes; 
	} 

	//返回密码的强度级别 
	function checkStrong(pwd){ 
		modes=0; 
		for (i=0;i<pwd.length;i++){ 
			//测试每一个字符的类别并统计一共有多少种模式. 
			modes|=charMode(pwd.charCodeAt(i)); 
		} 
		return bitTotal(modes);
	}
//-->
</script>
</div>
<jsp:include page="${sns:template(sConfig, sGlobal, 'footer.jsp')}" />