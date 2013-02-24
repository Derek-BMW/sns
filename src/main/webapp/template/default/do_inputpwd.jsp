<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<jsp:include page="${sns:template(sConfig, sGlobal, 'header.jsp')}" />
<form method="post" action="operate.action?ac=inputpwd" class="c_form">
	<table cellpadding="0" cellspacing="0" class="formtable">
		<caption>
			<h2>密码验证</h2>
			<p>您需要正确输入密码后才能继续查看</p>
		</caption>
		<tr>
			<th width="100">输入密码</th>
			<td><input type="password" name="viewpwd" value="" class="t_input" /></td>
		</tr>
		<tr>
			<th>&nbsp;</th>
			<td>
				<input type="hidden" name="refer" value="${requestURI}" />
				<input type="hidden" name="blogid" value="${invalue.blogid}" />
				<input type="hidden" name="albumid" value="${invalue.albumid}" />
				<input type="hidden" name="pwdsubmit" value="true" />
				<input type="submit" name="submit" value="提交" class="submit" />
			</td>
		</tr>
	</table>
	<input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,false)}" />
</form>
<jsp:include page="${sns:template(sConfig, sGlobal, 'footer.jsp')}" />