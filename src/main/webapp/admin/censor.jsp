<%@ page language="java" pageEncoding="UTF-8"%>
<jsp:directive.include file="header.jsp" />
<div class="mainarea">
	<div class="maininner">
		<form method="post" action="backstage.action?ac=censor">
			<input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,true)}" />
			<div class="bdrcontent">
				<table cellspacing="0" cellpadding="0" class="formtable">
					<tr>
						<td>
							<textarea name="censor" style="width: 98%;" rows="12">${censor}</textarea>
						</td>
					</tr>
					<tr>
						<td>
							添加格式：<br />每行一组过滤词语<br />不良词语和替换词语之间使用“=”进行分割
							<br />如需禁止发布包含某个词语的文字，而不是替换过滤，请将其对应的替换内容设置为 {AUDIT}<!-- ${banflag } --> 即可
							<br />如需发布包含某个词语的文字，并是替换过滤 后通知管理员审核，请将其对应的替换内容设置为 xxxx{AUDIT}<!-- ${banflag } --> 即可
							<br />替换前的内容可以使用限定符 {x} 以限定相邻两字符间可忽略的文字，x 是忽略字符的个数
							<br />如 "a{1}s{2}s"(不含引号) 可以过滤 "ass" 也可过滤 "axsxs" 和 "axsxxs" 等等
							<br /><font style="color:#ff0000;">如 "[*]={AUDIT}"(不含引号) 这个标识所有内容都禁止发布，同时通知管理员审核</font>
							<br />例如：<br />toobad=** (作用:将toobad文字替换为**)<br />badword=good (作用:将badword文字替换为good)
							<br />sexword={AUDIT} (作用:禁止发布包含sexword词语的文字，同时通知管理员审核)
							<br />sexword=xxxxx{AUDIT} (作用:发布,并替换sexword词语为xxxxxx的文字, 同时通知管理员审核)
						</td>
					</tr>
				</table>
			</div>
			<div class="footactions">
				<input id="idViewRecords" type="button" name="censorsubmit" value="查看需要审核的记录" class="submit">&nbsp;
				<input type="submit" name="censorsubmit" value="提交" class="submit">
			</div>
		</form>
	</div>
</div>
<script language="javascript" type="text/javascript" src="source/jquery.min.js"></script>
<script type="text/javascript" lang="javascript">
	$("document").ready(function(){
		$('#idViewRecords').bind('click', function(event){
			window.location.href ='backstage.action?ac=censor&subac=viewRecords'
		});
	});
</script>
<div class="side">
	<jsp:directive.include file="side.jsp" />
</div>
<jsp:directive.include file="footer.jsp" />