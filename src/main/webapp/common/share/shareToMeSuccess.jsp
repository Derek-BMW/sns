<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-cn" lang="zh-cn">
    
    <head>
        <title>
            分享网址到旅游社区
        </title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="Content-Language" content="zh-cn" />
        <link rel="shortcut icon" href="http://www.lysns.net/favicon.ico" type="image/x-icon" />
        <link rel="stylesheet" rev="stylesheet" href="common/share/share_transit.css" type="text/css" media="screen" />
		 <!-- solzhang 添加 jquery支持, 2012.5.4 -->
		 <script language="javascript" type="text/javascript" src="source/jquery.min.js"></script>
		 <script>
		 	jQuery.noConflict();
		 </script>        
    </head>
    
    <body class="mod_qzone" id="normalPanel">
        <div class="wrapper">
            <div class="mod_layout header" id="banner">
                <h1 class="layout_s">
                    <a class="logo_qzone" href="http://www.lysns.net" target="_blank">
                        旅游社区
                    </a>
                </h1>
                <div class="layout_m mod_links" id="login_btn_panel">&nbsp;</div>
            </div>

			<div class="main" id="share_web_panel">
                <div class="bd">
                    <h3>
                        <strong id="shareToTitle">
                            分享网址到旅游社区
                        </strong>
                    </h3>
                	<div id="msg">
	                	<strong id="shareToTitle">
	            			<c:out value="${message}" />
	            		</strong>
            		</div>
            		<c:if test="${link != null}">
	            		<div id="link">
	            			<a href='<c:out value="${link}" />'>请点击这里查看你的分享</a>
	            		</div>
            		</c:if>
            	</div>
            </div>
        </div>
    </body>
</html>