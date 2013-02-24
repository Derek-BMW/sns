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
	<div style="width:95%;padding: 20px 20px 0 20px">
    	<h2>${sessionScope.nickName} 您好，恭喜您使用 ${sessionScope.third} 登陆成功，第一次使用社区时，需要你绑定社区账号</h2>
		<br>
		<div class="tabs_header">
   			<script language="javascript">
    			function configShow(value) {
     				for(var i=0 ; i < 2 ; i++){
      					if(i==value){
       						$('title_'+i).className = 'active';
       						$('config_'+i).style.display = '';
      					}else{
       						$('title_'+i).className = '';
       						$('config_'+i).style.display = 'none';
      					}
     				}
    			}
   			</script>
   			<ul class="tabs">
    			<li id="title_0" class="active"><a href="#"><span onclick="configShow('0')">有社区帐号</span></a></li>
    			<li id="title_1" class=""><a href="#"><span onclick="configShow('1')">没有社区账号</span></a></li>
   			</ul>
  		</div>
	</div>
	
<div id="config_0" style="display:${empty isMember or isMember ? 'blank' : 'none'};">
<form name="isMember" action="operate.action?ac=bindThird" method="post" class="c_form">
	<table cellpadding="0" cellspacing="0" class="formtable">
		<c:if test="${not empty errorMsg and (empty isMember or isMember)}">
		<tr>
		<td>
		<div><b>${errorMsg}</b></div>
		</td>
		</tr>
		</c:if>
		<tr>
		<td>
		<table>
		<tr>
			<th width="100">用户名</th>
			<td><input type="text" id="loginUserName" name="loginUserName" value="" class="t_input" tabindex="1" /></td>
		</tr>
		<tr>
			<th>密 码</th>
			<td><input type="password" id="loginPassword" name="loginPassword" value="" class="t_input" tabindex="2" /></td>
		</tr>
		<tr>
			<th>&nbsp;</th>
			<td>
				<input type="hidden" name="isMember" value="true"/>
				<input type="submit" value="登陆并绑定" class="submit" onclick="return loginCheck();" tabindex="3" />
			</td>
		</tr>
		</table>
		</td>
		</tr>
	</table>
</form>
</div>

<div id="config_1" style="display:${empty isMember or isMember ? 'none' : 'blank'};">
<form name="registerform" action="operate.action?ac=bindThird" method="post" class="c_form">
	<table cellpadding="0" cellspacing="0" class="formtable">
		<c:if test="${not empty errorMsg and !isMember}">
		<tr>
		<td>
		<div><b>${errorMsg}</b></div>
		</td>
		</tr>
		</c:if>
		<tr>
		<td>
		<table>
		<tr>
			<th width="100">昵称</th>
			<td>
				<input type="text" id="nickname" name="nickname" value="${sessionScope.nickName}" class="t_input" onBlur="checkNickName()" tabindex="1" />&nbsp;<span id="checknickname">&nbsp;</span>
			</td>
		</tr>
		<tr>
			<th width="100">用户名</th>
			<td>
				<input type="text" id="username" name="username" value="" class="t_input" onBlur="checkUserName()" tabindex="2" />&nbsp;<span id="checkusername">&nbsp;</span>
				<br>只能是英文字母和数字，并且以字母开头。
			</td>
		</tr>
		<tr>
			<th>密 码</th>
			<td>
				<input type="password" id="password" name="password" value="" class="t_input" onBlur="checkPassword()" onkeyup="checkPwd(this.value);" tabindex="3" />&nbsp;<span id="checkpassword">&nbsp;</span><br />
				<div class="psdiv0" id="chkpswd">
					<div class="strongdepict">密码安全程度：<span id="chkpswdcnt">太短</span></div>
					<div class="strongbg"><div class="strong"></div></div>
				</div>
			</td>
		</tr>
		<tr>
			<th>再次输入密码</th>
			<td><input type="password" id="password2" name="password2" value="" class="t_input" onBlur="checkPassword2()" tabindex="4" />&nbsp;<span id="checkpassword2">&nbsp;</span></td>
		</tr>
		<tr>
			<th>邮箱</th>
			<td>
				<input type="text" id="email" name="email" class="t_input" onBlur="checkEmail()" tabindex="5" />&nbsp;<span id="checkemail">&nbsp;</span>
				<br>邮箱用于找回密码、接收信息。
			</td>
		</tr>
		<tr>
			<th>&nbsp;</th>
			<td>
				<input type="hidden" name="isMember" value="false"/>
				<input type="submit" value="注册并绑定" class="submit" onclick="return registerCheck();" tabindex="6" />
			</td>
		</tr>
		</table>
		</td>
		</tr>
	</table>
</form>
</div>

<script type="text/javascript">
<!--
$('loginUserName').focus();
var lastNickName = '';
var lastUserName = '';
var lastPassword = '';
var lastEmail = '';
var tag = true;

function loginCheck(){
    var ln = $("loginUserName").value;
    var lp = $("loginPassword").value;
    if(!ln || !lp){
        alert("用户名或密码不能为空");
        return false;
    }
    return true;
}
function registerCheck(){
	tag = true;
	checkNickNameRun();
	checkUserNameRun();
	checkPasswordRun();
	checkPassword2();
	checkEmailRun();
    return tag;
}

function checkNickName() {
	var nickName = $('nickname').value;
	nickName = trim(nickName);
	if(nickName != lastNickName) {
		checkNickNameRun();
	}
}
function checkNickNameRun() {
	var nickName = $('nickname').value;
	var ck = $('checknickname');
	nickName = trim(nickName);
	var unLen = nickName.replace(/[^\x00-\xff]/g, "**").length;
	if(unLen > 10) {
		warning(ck, '昵称超过 10 个字符');
		tag = false;
	} else  if(/[\'\"\\]/.test(nickName)) {
		warning(ck, '昵称包含非法字符');
		tag = false;
	} else {
		ck.style.display = '';
		ck.innerHTML = '<img src="image/check_right.gif" width="13" height="13">';
		lastNickName = nickName;
	}
}

	function checkUserName() {
		var userName = $('username').value;
		userName = trim(userName);
		if(userName != lastUserName) {
			checkUserNameRun();
		}
	}
	function checkUserNameRun() {
		var userName = $('username').value;
		var cu = $('checkusername');
		userName = trim(userName);
		if(userName == ''){
			warning(cu, '请输入用户名');
			tag= false;
			return;
		}
		var unLen = userName.replace(/[^\x00-\xff]/g, "**").length;
		if(unLen < 3 || unLen > 15) {
			warning(cu, unLen < 3 ? '用户名小于3个字符' : '用户名超过 15 个字符');
			tag = false;
		} else if(!isNumberOrLetter(userName)){
			warning(cu, '用户名只能是英文字母和数字的组合，并且以字母开头');
			tag = false;
		} else {
			ajaxresponse('checkusername', 'op=checkusername&username=' + (is_ie && document.charset == 'utf-8' ? encodeURIComponent(userName) : userName));
			lastUserName = userName;
		}
	}
	
	function checkPassword(confirm) {
		var password = $('password').value;
		if(confirm || password != lastPassword) {
			checkPasswordRun(confirm)
		}
	}
	function checkPasswordRun(confirm) {
		var password = $('password').value;
		var cp = $('checkpassword');
		if(password == ''){
			warning(cp, '请输入密码');
			tag = false;
		} else if(/[\'\"\\]/.test(password)) {
			warning(cp, '密码包含非法字符');
			tag = false;
		} else {
			cp.style.display = '';
			cp.innerHTML = '<img src="image/check_right.gif" width="13" height="13">';
			if(!confirm) {
				checkPassword2(true);
			}
			lastPassword = password;
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
		} else if(password != password2) {
			warning(cp2, '两次输入的密码不一致');
			tag = false;
		} else {
			cp2.style.display = '';
			cp2.innerHTML = '<img src="image/check_right.gif" width="13" height="13">';
		}
	}
	
	function checkEmail() {
		var email = $('email').value;
		if(email != lastEmail) {
			checkEmailRun();
		}
	}
	function checkEmailRun() {
		var email = $('email').value;
		var ce = $('checkemail');
		var myReg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
		if(email == ''){
			warning(ce, '请输入电子邮箱地址');
			tag = false;
		} else  if(/[\'\"\\]/.test(email)) {
			warning(ce, '电子邮箱包含非法字符');
			tag = false;
		} else if(!myReg.test(email)) {
			warning(ce, '电子邮箱格式无效');
			tag = false;
	    } else {
	    	ce.style.display = '';
			ce.innerHTML = '<img src="image/check_right.gif" width="13" height="13">';
			lastEmail = email;
	    }
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
				tag = false;
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