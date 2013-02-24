<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<jsp:include page="${sns:template(sConfig, sGlobal, 'header.jsp')}"/>
<c:if test="${op == 'use'}">
	<c:if test="${!frombuy}">
	<h1>使用道具</h1>
	<a class="float_del" title="关闭" href="javascript:hideMenu();">关闭</a>
	</c:if>
	<div class="toolly" id="__magicuse_form_${mid}">
		<form method="post" id="magicuse_form_${mid}" action="props.action?mid=${mid}&idtype=${idtype }&id=${id }">
			<div class="magic_img">
				<img src="image/magic/${mid}.gif" alt="${magic.name }" />
			</div>
			<div class="magic_info">
				<h3>${magic.name }</h3>
				<p class="gray">${magic.description }</p>
				<p>拥有个数: ${usermagic.count }</p>
				<div id="superstar" class="magicstar">
					<object codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,45,0" width="200" height="250">
					<param name="movie" value="image/magic/star/1.swf" />
					<param name="quality" value="high" />
					<param NAME="wmode" value="transparent">
					<embed src="image/magic/star/1.swf" quality="high" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash"  wmode="transparent" width="200" height="250"></embed>
					</object>
				</div>
			
				<div class="magicavatar">${sns:avatar2(space.uid,'big',false,sGlobal,sConfig) }</div>
				
				<br />
				
				<div>
					<h4>选择样式</h4>
					<ul>
						<li style="float:left; width:60px; margin:4px; cursor:pointer;" onclick="$('superstar').innerHTML = $('superstar1').innerHTML;$('star1').click();">
							<div style="display:block; margin:0; width:50px; height:50px;"><img src="image/magic/star/1.preview.gif" /></div>
							<input id="star1" type="radio" name="star" value="1" checked />
							选择
						</li>
						<li style="float:left; width:60px; margin:4px; cursor:pointer;" onclick="$('superstar').innerHTML = $('superstar2').innerHTML;$('star2').click();">
							<div style="display:block; margin:0; width:50px; height:50px;"><img src="image/magic/star/2.preview.gif" /></div>
							<input id="star2" type="radio" name="star" value="2" />
							选择
						</li>
						<li style="float:left; width:60px; margin:4px; cursor:pointer;" onclick="$('superstar').innerHTML = $('superstar3').innerHTML;$('star3').click();">
							<div style="display:block; margin:0; width:50px; height:50px;"><img src="image/magic/star/3.preview.gif" /></div>
							<input id="star3" type="radio" name="star" value="3" />
							选择
						</li>
						<li style="float:left; width:60px; margin:4px; cursor:pointer;" onclick="$('superstar').innerHTML = $('superstar4').innerHTML;$('star4').click();" >
							<div style="display:block; margin:0; width:50px; height:50px;"><img src="image/magic/star/4.preview.gif" /></div>
							<input id="star4" type="radio" name="star" value="4" />
							选择
						</li>
					</ul>
					<br style="clear:both;"/>
				</div>
				<p class="btn_line">
					<input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,false)}" />
					<input type="hidden" name="refer" value="${sGlobal.refer }"/>
					<input type="hidden" name="usesubmit" value="1" />
					<input type="submit" name="usesubmit_btn" value="使用" class="submit" />
				</p>
			</div>
		</form>
	</div>
	<div id="superstar1" style="display:none;">
	<object codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,45,0" width="200" height="250">
		<param name="movie" value="image/magic/star/1.swf" />
		<param name="quality" value="high" />
		<param NAME="wmode" value="transparent">
		<embed src="image/magic/star/1.swf" quality="high" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash"  wmode="transparent" width="200" height="250"></embed>
	</object>
	</div>
	<div id="superstar2" style="display:none;">
	<object codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,45,0" width="200" height="250">
		<param name="movie" value="image/magic/star/2.swf" />
		<param name="quality" value="high" />
		<param NAME="wmode" value="transparent">
		<embed src="image/magic/star/2.swf" quality="high" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash"  wmode="transparent" width="200" height="250"></embed>
	</object>
	</div>
	<div id="superstar3" style="display:none;">
	<object codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,45,0" width="200" height="250">
		<param name="movie" value="image/magic/star/3.swf" />
		<param name="quality" value="high" />
		<param NAME="wmode" value="transparent">
		<embed src="image/magic/star/3.swf" quality="high" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash"  wmode="transparent" width="200" height="250"></embed>
	</object>
	</div>
	<div id="superstar4" style="display:none;">
	<object codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,45,0" width="200" height="250">
		<param name="movie" value="image/magic/star/4.swf" />
		<param name="quality" value="high" />
		<param NAME="wmode" value="transparent">
		<embed src="image/magic/star/4.swf" quality="high" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash"  wmode="transparent" width="200" height="250"></embed>
	</object>
	</div>
</c:if>
<jsp:include page="${sns:template(sConfig, sGlobal, 'footer.jsp')}"/>