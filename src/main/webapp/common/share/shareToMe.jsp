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
                <div class="layout_m mod_links" id="login_btn_panel" />
            </div>
            <form id="form_share" action="shareToSns.action" method="post" target="_self">
            <input type="hidden" name="action" value="submitShare" />
            <input type="hidden" id="ac_l" value="${sConfig.login_action}" />
            <input type="hidden" id="ac_r" value="${sConfig.register_action}" />
            <input type="hidden" id="s_u" name="u" value="" />
            <input type="hidden" id="s_p" name="p" value="" />
            <input type="hidden" id="s_url" name="url" value="" />
            <input type="hidden" id="s_desc" name="desc" value="" />
            
            <div class="pop_wrap arr_up" id="login_panel" style="display:none;right:35px;">
                <div class="mod_verify">
                    <ul id="g_list">
                        <li id="g_u">
                            <span>社区帐号：</span>
                            <input type="text" class="inputstyle" id="u" name="u" value="" style="color: rgb(204, 204, 204); "
                            tabindex="1" onfocus="try{ptui_onUserFocus('u', '#000000')}catch(e){}"
                            onblur="try{ptui_onUserBlue('u', '#CCCCCC');}catch(e){}" />
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <span>密码：</span>
                            <input type="password" class="inputstyle" id="p" name="p" value="" maxlength="16" tabindex="2" />
                        </li>
                    </ul>
                    <span class="close" id="loginCancel" title="关闭">
                        ×
                    </span>
                </div>
                <span class="arrow">
                </span>
            </div>
            <div class="main" id="poster" style="display:none;"><div class="bd act_game" id="share_game_result"></div></div>
            <div class="main" id="share_web_panel">
                <div class="bd">
                    <h3>
                        <strong id="shareToTitle">
                            分享网址到旅游社区
                        </strong>
                    </h3>
                    <div id="shareMainPanel" class="mod_conts share_qzone">
                        <div class="mod_section">
                            <p class="sub_head" id="url">
                            	<input name="shareUrl" type="hidden" value="" />
                            </p>
                        </div>
                        <div contenteditable="true" name="Name" class="inputstyle" id="descriptiontx">
                        </div>
                        <p id="wartermark" class="watermark">说点什么吧</p>
                        <div class="count_txt" id="currentLength">
                            还能输入
                            <strong>
                                120
                            </strong>
                            字
                        </div>
                    </div>
                </div>
                <div class="mod_layout ft">
                    <div class="layout_m" id="buttonPanel">
                        <a href="javascript:void(0);" title="确定" id="postButton" class="mod_bt_subs">
                            <span id="postButtonText">
                                分享
                            </span>
                        </a>
                    </div>
                </div>
            </div>
            </form>
            <div class="footer" id="otherLinks">
                <div>
                    Copyright © 2012 www.lysns.net All Rights Reserved
                    <a href="http://www.lysns.net/common/share/getShareButton.html" target="_blank" class="links">
                        获取分享按钮
                    </a>
                </div>
            </div>
        </div>
        <div id="msg_panel" style="display:none;width:100%;position:absolute;top:260px;left:0;text-align:center;z-index:105;">
        	<span style="display:inline-block;height:54px;padding:0 18px 0 9px;margin:0 auto;position:relative;color:#606060;background-position:0 -161px;background-repeat:repeat-x;background-image:url(http://qzonestyle.gtimg.cn/qzonestyle/qzone_client_v5/img/gb_tip_layer.png);_background-image:url(http://qzonestyle.gtimg.cn/qzonestyle/qzone_client_v5/img/gb_tip_layer_ie6.png);font:bold 14px/54px \'Helvetica Neue\', \'Helvetica Neue\', Helvetica, \'Hiragino Sans GB\', \'Microsoft Yahei\', Arial, sans-serif;">
    			<span id="msgType" style="position:absolute;width:45px;height:54px;top:0;left:-45px;background-position:-6px -54px;background-repeat:no-repeat;background-image:url(http://qzonestyle.gtimg.cn/qzonestyle/qzone_client_v5/img/gb_tip_layer.png);_background-image:url(http://qzonestyle.gtimg.cn/qzonestyle/qzone_client_v5/img/gb_tip_layer_ie6.png);">
    			</span>
    			<span id="msgContent">
    			</span>
    			<span style="position:absolute;right:-6px;top:0;width:6px;height:54px;background:url(http://qzonestyle.gtimg.cn/qzonestyle/qzone_client_v5/img/gb_tip_layer.png) no-repeat;_background:url(http://qzonestyle.gtimg.cn/qzonestyle/qzone_client_v5/img/gb_tip_layer_ie6.png);">
    			</span>
			</span>
        </div>
        <script type="text/javascript" src="common/share/qzshare.onekey.js" charset="utf-8"></script>
        <script type="text/javascript">
            window.loginCallback = function() {
                document.getElementById('login_panel').style.display = "none";
            };
        </script>
    </body>

</html>