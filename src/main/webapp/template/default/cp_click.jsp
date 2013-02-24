<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<jsp:include page="${sns:template(sConfig, sGlobal, 'header.jsp')}"/>
<c:if test="${op == 'show'}">
	<jsp:include page="${sns:template(sConfig, sGlobal, 'space_click.jsp')}"/>
</c:if>
<jsp:include page="${sns:template(sConfig, sGlobal, 'footer.jsp')}"/>