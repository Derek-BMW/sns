<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<jsp:include page="${sns:template(sConfig, sGlobal, 'header.jsp')}" />
<jsp:include page="${sns:template(sConfig, sGlobal, 'cp_header.jsp')}" />
<form method="post" action="backstage.action" class="c_form">
 <input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,true)}" />
 <table cellspacing="0" cellpadding="0" class="formtable">
  <caption>
   <h2>高级管理</h2>
   <p>通过高级管理，您可以对自己的日志、图片、留言等进行批量删除管理。<br>为了保护您的数据安全，请再次输入您的账户密码以登录高级管理平台。</p>
  </caption>
  <tr><th width="120">用户名</th><td>${sGlobal.username} (<a href="main.action?ac=common&op=logout">退出</a>)</td></tr>
  <tr><th>密码</th><td><input type="password" name="password" class="t_input" /></td></tr>
  <tr>
   <td></td>
   <td>
    <input type="hidden" name="loginsubmit" value="true" />
    <input type="hidden" name="refer" value="${sGlobal.refer}" />
    <input type="submit" name="btnsubmit" value="进入平台" class="submit" />
   </td>
  </tr>
 </table>
</form>
<jsp:include page="${sns:template(sConfig, sGlobal, 'footer.jsp')}" />