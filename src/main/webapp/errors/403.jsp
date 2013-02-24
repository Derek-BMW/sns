<%@ page language="java" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="${snsConfig.siteUrl}"/>
		<title>禁止访问</title>
		<meta http-equiv="content-type" content="text/html; charset=${snsConfig.charset}" />
		<meta http-equiv="refresh" content="3;url=${snsConfig.siteUrl}index.action" />
		<link rel="shortcut icon" href="favicon.ico" />
        <style>
        	body{ background:url(../template/default/image/background.jpg) center top #EFF0F2; font-size:12px; margin:0; padding:0;}
			.nav{ width:930px; margin:0 auto; height:40px; line-height:40px; padding:0 20px; margin-top:98px;}
			.nav a{ color:#fff; }
			h1,h2{ font-family:"微软雅黑";}
			.msg{ width:300px; padding:20px 50px; position:absolute; top:250px; left:50%; margin-left:-200px; background:#000; background:rgba(0,0,0,0.5); color:#fff; border-radius:10px;}
        </style>
	</head>
	<body bgcolor="#DFEBFA">
    	<div class="nav"><a href="${snsConfig.siteUrl}index.action">返回首页</a></div>
    	<div class="msg">
       	  <h1>404</h1>
          <h2>对不起，该资源禁止访问</h2>
          <p>即将自动返回首页……</p>
   		</div>
		<!--<center>
			<table>
				<tr><td><img src="image/403.gif"/></td></tr>
			</table>
		</center>-->
	</body>
</html>
