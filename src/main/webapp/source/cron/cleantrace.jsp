<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.tmwsoft.sns.util.BeanFactory"%>
<%@page import="com.tmwsoft.sns.util.SysConstants"%>
<%@page import="com.tmwsoft.sns.service.DataBaseService"%>
<%
	Map<String, Object> sGlobal = (Map<String, Object>) request.getAttribute("sGlobal");
DataBaseService dataBaseService = (DataBaseService) BeanFactory.getBean("dataBaseService");

int maxday = 90;
int deltime = (Integer)sGlobal.get("timestamp") - maxday*3600*24;;
dataBaseService.execute("DELETE FROM sns_clickuser WHERE dateline < '"+deltime+"'");
dataBaseService.execute("DELETE FROM sns_visitor WHERE dateline < '"+deltime+"'");
%>