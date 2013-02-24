<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<c:set var="tpl_noSideBar" value="1" scope="request"/>
<jsp:include page="${sns:template(sConfig, sGlobal, 'header.jsp')}"/>
  <style type="text/css">
   @import url(image/backstage/style.css);
  </style>
  <div id="cp_content">