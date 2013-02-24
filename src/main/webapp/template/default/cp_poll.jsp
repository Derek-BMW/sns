<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<jsp:include page="${sns:template(sConfig, sGlobal, 'header.jsp')}"/>

<c:choose>
<c:when test="${op=='addopt'}">

<h1>添加投票项</h1>
<a href="javascript:hideMenu();" class="float_del" title="关闭">关闭</a>
<div class="popupmenu_inner" id="${pid}">
	<form id="add_option_${pid}" name="add_option_${pid}" method="post" action="main.action?ac=poll&op=addopt&pid=${pid}">
		<div id="__add_option_${pid}">
			<table>
				<tr>
					<td>
			
						<label for="newoption">请输入新增的投票候选项：</label><br />
						<input type="text" class="t_input" id="newoption" name="newoption" value="" size="50"/>
					</td>
				</tr>
				<tr>
					<td>
					<input type="hidden" name="refer" value="${sGlobal.refer}" />
					<input type="hidden" name="addopt" value="true" />
					<input type="submit" name="addopt_btn" id="addopt_btn" value="提交" class="submit" />
					<input type="button" ctype="add_opt_img_btn" name="add_opt_img_btn" id="add_opt_img_btn" value="插入图片" class="submit" onclick="on_insert_option_image();"/>					
					</td>
				</tr>
			</table>
			<input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,false)}" />
		</div>
	</form>
</div>
</c:when>
<c:when test="${op=='delete'}">

<h1>删除投票</h1>
<a href="javascript:hideMenu();" class="float_del" title="关闭">关闭</a>
<div class="popupmenu_inner">
	<form method="post" action="main.action?ac=poll&op=delete&pid=${pid}">
		<p>确定删除指定的投票吗？</p>
		<p class="btn_line">
			<input type="hidden" name="refer" value="${sGlobal.refer}" />
			<input type="hidden" name="deletesubmit" value="true" />
			<input type="submit" name="btnsubmit" value="确定" class="submit" />
		</p>
	<input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,false)}" />
	</form>
</div>
</c:when>
<c:when test="${op=='endreward'}">

<h1>终止悬赏</h1>
<a href="javascript:hideMenu();" class="float_del" title="关闭">关闭</a>
<div class="popupmenu_inner">
	<form method="post" action="main.action?ac=poll&op=endreward&pid=${pid}">
		<p>终止悬赏后，剩余的积分打回您的帐户<br>确定继续吗？</p>
		<p class="btn_line">
			<input type="hidden" name="refer" value="${sGlobal.refer}" />
			<input type="hidden" name="endrewardsubmit" value="true" />
			<input type="submit" name="btnsubmit" value="确定" class="submit" />
		</p>
	<input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,false)}" />
	</form>
</div>
</c:when>
<c:when test="${op=='edithot'}">

<h1>调整热度</h1>
<a href="javascript:hideMenu();" class="float_del" title="关闭">关闭</a>
<div class="popupmenu_inner">
<form method="post" action="main.action?ac=poll&op=edithot&pid=${pid}">
	<p class="btn_line">
		新的热度：<input type="text" name="hot" value="${poll.hot}" size="5"> 
		<input type="hidden" name="refer" value="${sGlobal.refer}" />
		<input type="hidden" name="hotsubmit" value="true" />
		<input type="submit" name="btnsubmit" value="确定" class="submit" />
	</p>
<input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,false)}" />
</form>
</div>
</c:when>
<c:when test="${op=='addreward'}">

<h1>追加投票悬赏</h1>
<a href="javascript:hideMenu();" class="float_del" title="关闭">关闭</a>
<div class="popupmenu_inner" id="${pid}">
	<form id="add_addreward_${pid}" name="add_addreward_${pid}" method="post" action="main.action?ac=poll&op=addreward&pid=${pid}">
		<div id="__add_addreward_${pid}">
			<table>
				<tr>
					<td>
			
						<label for="addcredit">追加悬赏总额：</label>
						<input type="text" class="t_input" id="addcredit" name="addcredit" value="" size="10"/> 范围：0~${space.credit}
					</td>
				</tr>
				<c:if test="${maxreward>0}">
				<tr>
					<td>
						<label for="addpercredit">追加每人悬赏：</label>
						<input type="text" class="t_input" id="addpercredit" name="addpercredit" value="" size="10"/> 范围：0~${maxreward}
					</td>
				</tr>
				</c:if>
				<tr>
					<td>
					<input type="hidden" name="refer" value="${sGlobal.refer}" />
					<input type="hidden" name="addrewardsubmit" value="true" />
					<input type="submit" name="addopt_btn" id="addopt_btn" value="提交" class="submit" />
					</td>
				</tr>
			</table>
			<input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,false)}" />
		</div>
	</form>
</div>
</c:when>
<c:when test="${op=='modify'}">


<h1>修改投票结束时间</h1>
<a href="javascript:hideMenu();" class="float_del" title="关闭">关闭</a>
<div class="popupmenu_inner" id="expiration_${pid}">
<form id="modify_expiration_${pid}" name="modify_expiration_${pid}" method="post" action="main.action?ac=poll&op=modify&pid=${pid}">
<table>
	<tr>
		<td>
			<label for="expiration">请输入新的结束时间：</label><br />
			<input type="text" class="t_input" id="expiration" name="expiration" readonly value="${sns:sgmdate(pageContext.request,'yyyy-MM-dd',!sns:snsEmpty(poll.expiration) ? poll.expiration : sGlobal.timestamp+2592000,false) }" size="30" onclick="showcalendar(event, this, 0, '${sns:sgmdate(pageContext.request,'yyyy-MM-dd',sGlobal.timestamp,false)}')"/>
		</td>
	</tr>
	<tr>
		<td>
		<input type="hidden" name="refer" value="${sGlobal.refer}" />
		<input type="hidden" name="modifysubmit" value="true" />
		<input type="submit" name="modifysubmit_btn" id="modifysubmit_btn" value="提交" class="submit" />
		</td>
	</tr>
</table>
<input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,false)}" />
</form>
</div>
</c:when>
<c:when test="${op=='summary'}">


<h1>投票总结</h1>
<a href="javascript:hideMenu();" class="float_del" title="关闭">关闭</a>
<div class="popupmenu_inner" id="summary_${pid}">
<form id="edit_summary_${pid}" name="edit_summary_${pid}" method="post" action="main.action?ac=poll&op=summary&pid=${pid}">
<table>
	<tr>
		<td>

			<label for="message">请输入对此次投票的总结：</label>
			<a href="###" id="editface_${pid}" onclick="showFace(this.id, 'summary');return false;"><img src="image/facelist.gif" align="absmiddle" /></a>
			<img src="image/zoomin.gif" onmouseover="this.style.cursor='pointer'" onclick="zoomTextarea('summary', 1)">

			<img src="image/zoomout.gif" onmouseover="this.style.cursor='pointer'" onclick="zoomTextarea('summary', 0)">

			<br />
			<textarea id="summary" name="summary" cols="70" onkeydown="ctrlEnter(event, 'summarysubmit_btn');" rows="8">${poll.summary}</textarea></td>
	</tr>
	<tr>
		<td>
		<input type="hidden" name="refer" value="${sGlobal.refer}" />
		<input type="hidden" name="summarysubmit" value="true" />
		<input type="submit" name="summarysubmit_btn" id="summarysubmit_btn" value="提交" class="submit" />
		</td>
	</tr>
</table>
<input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,false)}" />
</form>
</div>
</c:when>
<c:when test="${op=='get'}">
	<ul id="vote_list" class="voter_list">
	<c:choose>
	<c:when test="${not empty voteresult}">
	<c:forEach items="${voteresult}" var="value">
		<li>
			<c:if test="${value.uid==sGlobal.supe_uid}">
			<img class="meicon" alt="我自己的" src="image/arrow.gif"/>
			</c:if>
			<c:choose>
			<c:when test="${sns:snsEmpty(value.username)}">
			匿名
			</c:when>
			<c:otherwise>
			<a href="zone.action?uid=${value.uid}">${sNames[value.uid]}</a>
			</c:otherwise>
			</c:choose>
			${sns:sgmdate(pageContext.request,'yyyy-MM-dd HH:mm:ss',value.dateline,true)} 投票给 ${value.option}
		</li>
	</c:forEach>
	</c:when>
	<c:otherwise>
		<li>暂时没有相关<c:if test="${param.filtrate=='we'}">好友</c:if>投票记录</li>
	</c:otherwise>
	</c:choose>
	</ul>
	<c:if test="${sns:snsEmpty(multi)}"><div class="page">${multi}</div><br/></c:if>
</c:when>
<c:when test="${op=='invite'}">

<form id="inviteform" name="inviteform" method="post" action="main.action?ac=poll&op=invite&pid=${poll.pid}&uid=${param.uid}&grade=${param.grade}&group=${param.group}&page=${param.page}&start=${param.start}">

<div class="tabs_header">
	<ul class="tabs">
		<li><a href="main.action?ac=poll"><span>发起新投票</span></a></li>
		<li class="active"><a href="main.action?ac=poll&op=invite&pid=${poll.pid}"><span>邀请好友</span></a></li>
		<li><a href="zone.action?uid=${poll.uid}&do=poll&pid=${poll.pid}"><span>返回投票</span></a></li>
	</ul>
</div>
<div id="content" style="width: 610px;">
	<div class="h_status">
		您可以邀请下列好友来参与<a href="zone.action?uid=${poll.uid}&do=poll&pid=${poll.pid}">《${poll.subject}》</a>投票
	</div>
	
	<div class="h_status">
		<c:choose>
		<c:when test="${not empty list}">
		<ul class="avatar_list">
		<!--{loop $ $value}-->
		<c:forEach items="${list}" var="value">
			<li><div class="avatar48"><a href="zone.action?uid=${value.fuid}" title="${sNames[value.fuid]}">${sns:avatar1(value.fuid,sGlobal,sConfig)}</a></div>
				<p>
				<a href="zone.action?uid=${value.fuid}" title="${sNames[value.fuid]}">${sNames[value.fuid]}</a>
				</p>
				<p><c:choose><c:when test="${sns:snsEmpty(invitearr[value.fuid])}"><input type="checkbox" name="ids" value="${value.fuid}">选定</c:when><c:otherwise>已邀请</c:otherwise></c:choose></p>
			</li>
		</c:forEach>
		</ul>
		<div class="page">${multi}</div>
		</c:when>
		<c:otherwise>
		<div class="c_form">还没有好友。</div>
		</c:otherwise>
		</c:choose>
	</div>
	<p>
		<input type="checkbox" id="chkall" name="chkall" onclick="checkAll(this.form, 'ids')">全选 &nbsp;
		<input type="submit" name="invitesubmit" value="邀请" class="submit" />
	</p>
</div>

<div id="sidebar" style="width: 150px;">
	<div class="cat">
		<h3>好友分类</h3>
		<ul class="post_list line_list">
			<li<c:if test="${param.group==-1}"> class="current"</c:if>><a href="main.action?ac=poll&pid=${poll.pid}&op=invite&group=-1">全部好友</a></li>
			<c:forEach items="${groups}" var="group">
			<li<c:if test="${param.group==group.key}"> class="current"</c:if>><a href="main.action?ac=poll&pid=${poll.pid}&op=invite&group=${group.key }">${group.value}</a></li>
			</c:forEach>
		</ul>
	</div>
</div>
<input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,false)}" />
</form>
</c:when>
<c:otherwise>


<c:choose>
<c:when test="${not empty topic}">
	<jsp:include page="${sns:template(sConfig, sGlobal, 'cp_topic_menu.jsp')}"/>
</c:when>
<c:otherwise>
	<div class="tabs_header">
		<ul class="tabs">
			<li class="active"><a href="main.action?ac=poll"><span>发起新投票</span></a></li>
			<li><a href="zone.action?do=poll&view=me"><span>返回我的投票</span></a></li>
		</ul>
	</div>
</c:otherwise>
</c:choose>

<div class="c_form">
	
	<form id="addnewpoll" name="addnewpoll" method="post" action="main.action?ac=poll">
		<table cellspacing="4" cellpadding="4" width="100%" class="infotable">
			<tr>
				<th width="80">投票主题</th>
				<td>
					<input type="text" class="t_input" style="width:450px;" id="subject" name="subject" value=""> <br/>
					<a id="addtip" href="javascript:;" onclick="initIntro();" onfocus="this.blur();">添加投票详细说明</a>
				</td>
			</tr>
			<tr id="intropoll" style="display:none">
				<th>详细说明</th>
				<td><textarea id="message" style="padding: 3px 2px;width:450px;height:50px;" name="message"></textarea> </td>
			</tr>
			<tr>
				<td colspan="2" height="1px"><div style="width: 550px; height:1px; border-bottom:1px solid #DDDDDD;"></div></td>
			</tr>
			<c:forEach items="${option}" var="val">
			<c:if test="${val==11}">
			<tbody id="moreoption" style="display: none;">
			</c:if>
			<tr>
				<th>候选项${val}</th>
				<td>
					<input id="opt_input_${val}" type="text" class="t_input"  style="width:450px;" name="option" value="" maxlength="120"> &nbsp; 
					<a ctype="opt_img_btn" index="${val}" href="#" class="button">插入图片</a>
					<c:if test="${val==10}">
					<div><a id="moretip" href="javascript:;" onclick="showMoreOption();" onfocus="this.blur();">增加更多选项</a></div>
					</c:if>
				</td>
			</tr>
			</c:forEach>
			</tbody>
			<tr>
				<th>可投选项</th>
				<td>
					<select name="maxchoice">
						<c:forEach items="${option}" var="val">
							<option value="${val}">
								<c:choose>
								<c:when test="${val==1}">
								单选
								</c:when>
								<c:otherwise>
								可多选，最多${val}项
								</c:otherwise>
								</c:choose>
							</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>截止时间</th>
				<td>
					<script type="text/javascript" src="source/script_calendar.js" charset="${snsConfig.charset}"></script>
					<input type="text" class="t_input" size="16" id="expiration" readonly name="expiration" value="" onclick="showcalendar(event, this, 0, '${sns:sgmdate(pageContext.request,'yyyy-MM-dd',sGlobal.timestamp,false)}')" />
				</td>
			</tr>
			<tr>
				<th>投票限制</th>
				<td>
					<input type="radio" name="sex" value="0" checked />不限制 
					<input type="radio" name="sex" value="1" />男
					<input type="radio" name="sex" value="2" />女 
				</td>
			</tr>
			<tr>
				<th>评论限制</th>
				<td>
					<input type="radio" name="noreply" value="0" checked />不限制 
					<input type="radio" name="noreply" value="1" />仅限好友
				</td>
			</tr>
			<tr>
				<th>悬赏投票</th>
				<td>
					<input type="radio" name="reward" value="0" checked onclick="initReward(this.value);" />否
					<input type="radio" name="reward" value="1" onclick="initReward(this.value);" />是
				</td>
			</tr>
			<tbody id="rewardlist" style="display: none;">
				<tr>
					<th>悬赏总额</th>
					<td>
						<input type="text" class="t_input" size="16" id="credit" name="credit" value="" maxlength="60"> 范围：1~${space.credit}
					</td>
				</tr>
				<tr>
					<th>每人悬赏</th>
					<td>
						<input type="text" class="t_input" size="16" id="percredit" name="percredit" value="" maxlength="60"> 范围：1~${sConfig.maxreward}
					</td>
				</tr>
			</tbody>
			<c:if test="${sns:checkPerm(pageContext.request,pageContext.response,'seccode')}">
				<c:choose>
				<c:when test="${!sns:snsEmpty(sConfig.questionmode)}">
				<tr>
					<th style="vertical-align: top;" width="90">请回答验证问题</th>
					<td>
						<p>${sns:question(pageContext.request,pageContext.response)}</p>
						<input type="text" id="seccode" name="seccode" value="" size="15" class="t_input" />
					</td>
				</tr>
				</c:when>
				<c:otherwise>
				<tr>
					<th style="vertical-align: top;" width="90">请填写验证码</th>
					<td>
						<script>seccode();</script>
						<p>请输入上面的4位字母或数字，看不清可<a href="javascript:updateseccode()">更换一张</a></p>
						<input type="text" id="seccode" name="seccode" value="" size="15" class="t_input" />
					</td>
				</tr>
				</c:otherwise>
				</c:choose>
			</c:if>
			
			<tr>
				<th>动态选项</th>
				<td>
					<input type="checkbox" name="makefeed" id="makefeed" value="1"${ckPrivacyBypoll  ?  ' checked' : ''}> 产生动态 (<a href="main.action?ac=privacy#feed" target="_blank">更改默认设置</a>)
				</td>
			</tr>
			
			<tr>
				<th></th>
				<td>
					<input type="hidden" name="pollsubmit" id="pollsubmit" value="true" />
					<input type="hidden" name="topicid" value="${param.topicid}" />
					<input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,false)}" />
					<input type="submit" name="addpollsubmit" id="addpollsubmit" value="发起投票" class="submit" onclick="validate(this);return false;" />
					<div id="__addnewpoll"></div>
				</td>
			</tr>
		</table>
	</form>
	<script type="text/javascript" charset="${snsConfig.charset}">
		function initIntro() {
			var introObj = $('intropoll');
			var tipObj = $('addtip');
			if(introObj.style.display == 'none') {
				introObj.style.display = '';
				
				tipObj.innerHTML = "隐藏投票详细说明";
			} else {
				if (($('message').value.length == 0) || (confirm("详细说明将被清空，你确定要隐藏吗？"))) {
					introObj.style.display = 'none';
					$('message').value = '';
					tipObj.innerHTML = "添加投票详细说明";
				}
			}
		}
		function initReward(status) {
			var rewardObj = $('rewardlist');
			if(status == 1) {
				rewardObj.style.display = '';
			} else {
				rewardObj.style.display = 'none';
				$("credit").value = '';
				$("percredit").value = '';
			}
		}
		function showMoreOption() {
			$("moreoption").style.display = '';
			$("moretip").style.display = 'none';
		}
		function validate(obj) {
		    var subject = $('subject');
		    if (subject) {
		    	var slen = strlen(subject.value);
		        if (slen < 1 || slen > 80) {
		            alert("标题长度(1~80字符)不符合要求");
		            subject.focus();
		            return false;
		        }
		    }
		    
		    var makefeed = $('makefeed');
		    if(makefeed) {
		    	if(makefeed.checked == false) {
		    		if(!confirm("友情提醒：您确定此次发布不产生动态吗？\n有了动态，好友才能及时看到你的更新。")) {
		    			return false;
		    		}
		    	}
		    }
		    
			var optionCount = 0;
			var optionObj = document.getElementsByName("option");
			for(var i=0;i<optionObj.length;i++) {
				if(optionObj[i].value.Trim()!="") {
					optionCount++;
				}
			}
			if(optionCount<2) {
				alert('请至少添加两个候选项！');
				return false;
			}
			var maxCredit = ${space.credit};
			var maxPercredit = ${sConfig.maxreward};
			//验证悬赏投票设置
			var credit = parseInt($('credit').value.Trim());
			var percredit = parseInt($('percredit').value.Trim());
			if(credit || percredit) {
				if(!credit) {
					alert("请正确填写悬赏总额");
					return false;
				} else if(!percredit) {
					alert("请正确填写每人悬赏积分");
					return false;
				} else if(credit > maxCredit) {
					alert("悬赏总额应在:1~"+maxCredit+"之间取值");
					return false;
				} else if(maxPercredit && percredit > maxPercredit) {
					alert("每人悬赏应在:1~"+maxPercredit+"之间取值");
					return false;
				} else if(credit < percredit) {
					alert("每人悬赏不能高于悬赏总额");
					return false;
				}
			}
			var nowDate = parsedate("${sns:sgmdate(pageContext.request,'yyyy-MM-dd',sGlobal.timestamp,false)}");
			
			
			if($('expiration').value.Trim() != "") {
				var expiration = parsedate($('expiration').value.Trim());
				if(expiration < nowDate) {
					alert("过期时间不能小于当前时间");
					return false;
				}
			}
		    if($('seccode')) {
				var code = $('seccode').value;
				var x = new Ajax();
				x.get('main.action?ac=common&op=seccode&code=' + code, function(s){
					s = trim(s);
					if(s.indexOf('succeed') == -1) {
						alert(s);
						$('seccode').focus();
		           		return false;
					}
				});
		    }
		    ajaxpost('addnewpoll', 'poll_post_result');
		}
		String.prototype.Trim = function() { 
			return this.replace(/(^\s*)|(\s*$)/g, ""); 
		}
		
		/*
		* add by sol zhang, 2012.5.4  支持插入图片
		*/
		function getCursortPosition (ctrl) {//获取光标位置函数
			var CaretPos = 0;	// IE Support
			if (document.selection) {
			ctrl.focus ();
				var Sel = document.selection.createRange ();
				Sel.moveStart ('character', -ctrl.value.length);
				CaretPos = Sel.text.length;
			}
			// Firefox support
			else if (ctrl.selectionStart || ctrl.selectionStart == '0')
				CaretPos = ctrl.selectionStart;
			return (CaretPos);
		}
		
		jQuery(document).ready(function(){
			jQuery("a[ctype='opt_img_btn']").each(function(index, item){
				jQuery(item).bind('click', function(){
					index = jQuery(this).attr("index");
					var url = window.prompt("请输入图片URL:                 ");
					if( url != null && url != '' ){
						url = '[img]'+url+'[/img]';
						var select_index = getCursortPosition(jQuery('#opt_input_'+index)[0]);
						var option_content = jQuery('#opt_input_'+index).val();
						option_content = option_content.substring(0, select_index)+url+option_content.substring(select_index);
						jQuery('#opt_input_'+index).val(option_content);
					}
				});
			});
		});
		
	</script>
	
</div>
</c:otherwise>
</c:choose>

<jsp:include page="${sns:template(sConfig, sGlobal, 'footer.jsp')}"/>