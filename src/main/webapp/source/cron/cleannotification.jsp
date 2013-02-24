<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.tmwsoft.sns.util.BeanFactory"%>
<%@page import="com.tmwsoft.sns.service.DataBaseService"%>
<%@page import="com.tmwsoft.sns.util.SysConstants"%>
<%
	Map<String, Object> sGlobal = (Map<String, Object>) request.getAttribute("sGlobal");
DataBaseService dataBaseService = (DataBaseService) BeanFactory.getBean("dataBaseService");

int deltime = (Integer)sGlobal.get("timestamp") - 2*3600*24;
dataBaseService.execute("DELETE FROM sns_notification WHERE dateline < '"+deltime+"' AND new='0'");
dataBaseService.execute("OPTIMIZE TABLE sns_notification");
%>