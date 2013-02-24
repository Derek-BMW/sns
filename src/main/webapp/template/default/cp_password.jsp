<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<jsp:include page="${sns:template(sConfig, sGlobal, 'header.jsp')}" />
<jsp:include page="${sns:template(sConfig, sGlobal, 'cp_header.jsp')}"/>
<div class="c_form">
 <form method="post" action="main.action?ac=password&op=">
  <table cellspacing="0" cellpadding="0" class="formtable">
   <caption>
    <h2>我的登录密码</h2>
    <p>修改密码后，您需要重新登陆一次。</p>
   </caption>
   <tr>
    <th width="100">登录用户名</th>
    <td>${space.username}</td>
   </tr>
   <tr>
    <th width="100">旧密码</th>
    <td><input type="password" id="password" name="password" value="" class="t_input" /></td>
   </tr>
   <tr>
    <th>新密码</th>
    <td><input type="password" id="newpasswd1" name="newpasswd1" value="" class="t_input"></td>
   </tr>
   <tr>
    <th>确认新密码</th>
    <td><input type="password" id="newpasswd2" name="newpasswd2" value="" class="t_input"></td>
   </tr>
   <tr>
    <th>&nbsp;</th>
    <td><input type="submit" name="pwdsubmit" value="修改密码" class="submit" /></td>
   </tr>
  </table>
  <input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,false)}" />
 </form>
</div>
<jsp:include page="${sns:template(sConfig, sGlobal, 'footer.jsp')}" />