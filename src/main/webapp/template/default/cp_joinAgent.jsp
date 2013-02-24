<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<jsp:include page="${sns:template(sConfig, sGlobal, 'header.jsp')}" />
<jsp:include page="${sns:template(sConfig, sGlobal, 'cp_header.jsp')}" />

<div class="d_content" id="note">
		<div class="notice">
			<h2>成为武隆景区票的代理商</h2>
			<p>你可以通过很简单的方式让你的网站成为武隆旅游网电子商务网站的代理商，在成为二级代理商之前请先阅读协议。</p>
		</div>
		<table cellspacing="6" cellpadding="0" width="100%">
			<tr>
				<td>
					如果你要成为武隆旅游网电子商务网站的二级代理商，请仔细阅读下面的协议：
					<textarea name="css" style="width: 98%;" rows="20" readonly="readonly">
						协议起草中
					</textarea>
				</td>
			</tr>
			<tr>
				<td>
					<button class="submit" onclick="document.getElementById('note').style.display='none';document.getElementById('code').style.display='block';">
					同意该协议，申请成为二级代理商
					</button>
				</td>
			</tr>
		</table>
</div>

<div class="d_content" id="code" style="display:none;">
		<div class="notice">
			<h2>如何武隆景区票的代理商</h2>
		</div>
		<table cellspacing="6" cellpadding="0" width="100%" border="10">
			<tr>
				<td width="50%">
					<p>你可以将以下代码复制到你所有的网站的任何页面的合适位置中即可，建议该位置大小为440*360px。</p>
					<textarea id="joincode" name="css" style="width: 98%;" rows="16">&lt;iframe frameborder=0 width=440 height=360 marginheight=0 marginwidth=0 scrolling=no src="http://store.wlkst.com/account/ExternalAccount.action?uid=${space.uid}"&gt;&lt;/iframe&gt;</textarea>
					<br>
					<button class="submit" onclick="var copyText = document.getElementById('joincode').value;window.clipboardData.setData('Text',copyText);alert('代码已复制到粘贴板');">
					复制代码到粘贴板
					</button>
				</td>
				<td>
					页面实际样式：
					<iframe frameborder=0 width=440 height=360 marginheight=0 marginwidth=0 scrolling=no src="http://store.wlkst.com/account/ExternalAccount.action?uid=${space.uid}"></iframe>
				</td>
			</tr>
		</table>
</div>
<script>

</script>
<jsp:include page="${sns:template(sConfig, sGlobal, 'footer.jsp')}" />