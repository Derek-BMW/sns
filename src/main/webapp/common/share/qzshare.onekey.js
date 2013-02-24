var SHARE = window.SHARE || {};
SHARE.string = (function() {
    return {
        countDescLen: function(str) {
            var value = str.replace(/(^\s*)|(\s*$)/g, "");
            var reg = new RegExp('((news|telnet|nttp|file|http|ftp|https)://){1}(([-A-Za-z0-9]+(\\.[-A-Za-z0-9]+)*(\\.[-A-Za-z]{2,5}))|([0-9]{1,3}(\\.[0-9]{1,3}){3}))(:[0-9]*)?(/[-A-Za-z0-9_\\$\\.\\+\\!\\*\\(\\),;:@&=\\?/~\\#\\%]*)*', 'gi');
            value = value.replace(reg, '**********************');
            return Math.ceil(value.replace(/[^\x00-\xff]/ig, "**").length / 2);
        }
    };
})();
var MAX_DESC_LEN = 120;
function escHTML(str) {
    return (str + '').replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/\x27/g, '&#039;').replace(/\x22/g, '&quot;');
}
function restHTML(str) {
    return (str + '').replace(/&#92;/g, "\\").replace(/&quot;/g, '\x22').replace(/&#039;/g, '\x27').replace(/&#39;/g, '\x27').replace(/&gt;/g, '>').replace(/&lt;/g, '<').replace(/&amp;/g, '&');
}
function trim(str) {
    return str.replace(/(^\s*)|(\s*$)/g, "");
}
function $(id) {
    return document.getElementById(id);
}
function showMsgBox(msg, type, time) {
    $("msg_panel").style.display = '';
    $('msgType').style.backgroundPositionY = '-54px';
    $('msgType').style.left = '-45px';
    $('msgType').style.width = '45px';
    $("msgContent").innerHTML = msg;
    setTimeout('$("msg_panel").style.display = "none";', time || 2000);
}
function showLoginPanel(okCB, cancelCB) {
    $('login_panel').style.display = "";
    var curHostname = location.hostname;
    window.loginCallback.Callback = okCB;
    $('loginCancel').onclick = function() {
        cancelCB && cancelCB();
        $('login_panel').style.display = 'none';
        return false;
    }
}

function descEditor(descDom, opt) {
    this._dom = descDom;
    var oThis = this,
    bSetContentStartAt = false;
    if (descDom.innerHTML == '' && descDom.tagName.toLowerCase() == 'div') {
        if (/Firefox/.test(navigator.userAgent)) {
            descDom.innerHTML = '<br _moz_dirty="" />';
        } else if (/Chrome.(\d+\.\d+)/i.exec(navigator.userAgent) || window.chrome) {
            descDom.innerHTML = '<br/>';
        }
    }
    this.addEventListener = function(eventType, handler) {
        if (this._friSenEdi) {
            this._friSenEdi.addEventListener(eventType, handler);
            return;
        }
        if (document.addEventListener) {
            this._dom.addEventListener(eventType, handler, false);
        } else if (document.attachEvent) {
            this._dom.attachEvent('on' + eventType, handler, false);
        } else {
            this._dom['on' + eventType] = handler;
        }
    }
    this.removeEventListener = function(eventType, handler) {
        if (this._friSenEdi) {
            this._friSenEdi.removeEventListener(eventType, handler);
            return;
        }
        if (document.removeEventListener) {
            this._dom.removeEventListener(eventType, handler, false);
        } else if (document.detachEvent) {
            this._dom.detachEvent('on' + eventType, handler);
        } else if (this._dom['on' + eventType] == handler) {
            this._dom['on' + eventType] = null;
        }
    }
    qzShare.event.add('desc_content_set',
    function() {
        bSetContentStartAt = true;
    });
    this.addEventListener('propertychange',
    function() {
        countContentLength(oThis.getContent(), $('currentLength'), MAX_DESC_LEN);
    });
    this.addEventListener('keyup',
    function() {
        countContentLength(oThis.getContent(), $('currentLength'), MAX_DESC_LEN);
    });
}
descEditor.prototype = {
    setContent: function(str) {
        if (!str) return;
        this._dom.innerHTML = escHTML(str);
        qzShare.event.fire('desc_content_set');
    },
    getContent: function(type) {
        type = type || 'text';
        if (this._dom.tagName.toLowerCase() == "textarea" || this._dom.tagName.toLowerCase() == "input") {
            return this._dom.value;
        }
        if (this._friSenEdi) {
            return this._friSenEdi.getContent(type);
        }
        return this._dom.textContent || this._dom.innerText || this._dom.nodeValue || '';
    }
};

function countContentLength(content, currentLength, max) {
    var length = max - SHARE.string.countDescLen(content);
    currentLength.innerHTML = (length < 0 ? '已超出': '还能输入') + '<strong>' + Math.abs(length) + '</strong>字';
    currentLength.style.color = length < 0 ? "red": "";
}


// 要定义好查询串中key
// url：要分享的网址
// desc：介绍
// site：来源网站
// type：分享内容类型 url、video、flash、text
var queryString = (function() {
    var ser = window.location.search.substr(1),
    s = ser.split('&'),
    vs = {};
    for (var i = 0; i < s.length; i++) {
        var t = s[i].split('=');
        vs[t[0]] = t[1];
    }
    return vs;
})();

// 获取浏览器cookies
var cookies = {};
jQuery(document.cookie.split(";")).each(function(index, item){
    var name_value = item.split("=");
    if( name_value.length == 2 ){
        cookies[j.trim(name_value[0])] = j.trim(name_value[1]);
    }
});

var qzShare = window.qzShare || {};
qzShare.event = {
    _event: {},
    fire: function(ev, param) {
        var items = qzShare.event._event[ev] || [];
        for (var i = 0,
        j = items.length; i < j; i++) {
            items[i].handler(param);
        }
    },
    add: function(ev, handler) {
        var t = qzShare.event;
        t._event[ev] = t._event[ev] || [];
        t._event[ev].push({
            type: ev,
            handler: handler
        });
    },
    find: function(ev, handler) {
        for (var i = 0,
        j = qzShare.event._event[ev] || 0 && qzShare.event._event[ev].length; i < j; i++) {
            var item = qzShare.event._event[i];
            if (item.type == ev && item.handler === handler) {
                return item;
            }
        }
        return null;
    }
};

qzShare.onekey = new
function() {
    var oThis = this;
    if (queryString.url) {
        queryString.url = queryString.url.replace(/\+/g, ' ');
    }
    if (queryString.desc) {
        queryString.desc = queryString.desc.replace(/\+/g, ' ');
    }
    
    this.init = function() {
        var agent = navigator.userAgent;
        if (agent.indexOf('Android') > -1 || agent.indexOf('iPhone') > -1 || agent.indexOf('iPod') > -1 || agent.indexOf('iPad') > -1) {
            var textArea = document.createElement('textarea');
            textArea.className = 'inputstyle';
            $('descriptiontx').parentNode.replaceChild(textArea, $('descriptiontx'));
            textArea.id = 'descriptiontx';
        }
        mg_descriptionEd = new descEditor($('descriptiontx'), {
            appendSelectedCallback: function() {
                countContentLength(mg_descriptionEd.getContent(), $('currentLength'), MAX_DESC_LEN);
            }
        });
        $('changeAccounts') && ($('changeAccounts').onclick = function() {
            showLoginPanel(function() {
                location.href = location.href;
            });
            return false;
        });
        loadWebPageInfo();
    };
    
    var mg_loadingClock = null;
    var mg_initWebPageInfoCount = 0;
    function loadWebPageInfo() {
        if (mg_loadingClock) {
            try {
                clearTimeout(mg_loadingClock);
                mg_loadingClock = null;
            } catch(e) {}
        } else {
            mg_loadingClock = setTimeout('showMsgBox("加载中...",6,2000);', 1500);
        }
        handleUrlinfo(queryString);
        return;
    }
    function handleUrlinfo(o) {
        o = o || {};
        if (mg_loadingClock) {
            try {
                clearTimeout(mg_loadingClock);
                mg_loadingClock = null;
            } catch(e) {}
        }
        o.url = decodeURIComponent(queryString.url || o.url || '');
        o.description = decodeURIComponent(queryString.desc || '') || o.description || '';
        o.site = decodeURIComponent(queryString.site || o.site || '');
        o.type = decodeURIComponent(queryString.type || o.type || '');
        initUserLogin(cookies);
        initShareInfo(o);
        initShareButton(o);
    }
    var mg_descriptionEd;
    var _disablePostButton = function(timeout) {
        timeout = timeout || 5000;
        $('postButton').disabled = true;
        $('postButton').__onclick = $('postButton').onclick;
        $('postButton').onclick = null;
        setTimeout(function() {
            $('postButton').disabled = false;
            $('postButton').onclick = $('postButton').__onclick;
        },
        timeout);
    };
    
    function initUserLogin(o){
    	if (o.sns_loginuser && o.sns_auth ){
    		jQuery('#login_btn_panel').append(
    				jQuery('<a />').html(o.sns_loginuser)
    		).append(
    				" | "
    		).append(
    				jQuery('<a />').attr({href:"operate.action?ac="+jQuery('#ac_r').val(), target:"_blank" }).html('注册')
    		);
    	}else{
    		jQuery('#login_btn_panel').append(
    				jQuery('<a />').attr({id:"changeAccounts",href:"operate.action?ac="+jQuery('#ac_l').val(), target:"_blank" }).html('登录')
    		).append(
    				" | "
    		).append(
    				jQuery('<a />').attr({href:"operate.action?ac="+jQuery('#ac_r').val(), target:"_blank" }).html('注册')
    		);    		
    	}
    }
    
    function initShareButton(webp) {
        $('postButton').onclick = function(vc) {
            _disablePostButton(5000);
            
            if (SHARE.string.countDescLen(mg_descriptionEd.getContent()) > MAX_DESC_LEN) {
                showMsgBox('分享理由过长', 2, 2000);
                return false;
            }
            
            if ( cookies.sns_loginuser && cookies.sns_auth ){
                ;
            }else{
            	if( jQuery('#login_panel').css('display') == 'none' ){
		            var arg = arguments;
		            showLoginPanel(function() {
		                arg.callee.apply(null, [webp])
		            },
		            function() {});
            	}
            	
            	if( jQuery('#u').val() && jQuery('#p').val() ){
            		;
            	}else{
			        alert("请填写用户信息");
			        return false;
            	}
            }
            
            // prepare for share submit
            jQuery('#s_u').val(jQuery('#u').val());
            jQuery('#s_p').val(jQuery('#p').val());
            jQuery('#s_url').val(jQuery('#url > a').html());
            jQuery('#s_desc').val(jQuery('#descriptiontx').html());
            jQuery('#login_panel').css('display','none');
            jQuery('#form_share').submit();
            
            return false;
        }
    }
    function initShareInfo(webp) {
        var url = webp.url;
        if (!url.match(/^\s*(https?:\/\/)?([\w-]+\.)+[\w-]+(.*)?\s*$/ig)) {
            $('poster').innerHTML = '<div class="mod_result"><span class="icon_err">&nbsp;</span><h3>要分享的网址格式不正确</h3><p><a id="detailLink"></a></p></div>';
            $('buttonPanel').style.display = 'none';
            return;
        }
        if (url) {
            $('url').innerHTML = '<a target="_blank" href="' + escHTML(url) + '">' + escHTML(url) + '</a>';
        }
        var description = webp.description;
        var site = webp.site;
        if (description) {
        	
        	if( site ){
        		description += " - 来自 "+site;
        	}
        	
            $('wartermark').style.display = 'none';
            $('descriptiontx').focus();
            mg_descriptionEd.setContent(description.length > MAX_DESC_LEN ? (description.substr(0, MAX_DESC_LEN - 3)) + '...': description);
            countContentLength(mg_descriptionEd.getContent(), $('currentLength'), MAX_DESC_LEN);
        } else {
            $('wartermark').style.display = '';
            $('wartermark').onclick = function() {
                this.style.display = 'none';
                this.onclick = null;
                $('descriptiontx').focus();
                $('descriptiontx').onfocus = null;
            }
            $('descriptiontx').onkeydown = $('descriptiontx').onclick = $('descriptiontx').onfocus = function() {
                $('wartermark').style.display = 'none';
                this.onkeydown = this.onclick = this.onfocus = null;
            }
        }
    }
};
qzShare.onekey.init();