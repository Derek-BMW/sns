<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<link rel="stylesheet" href="image/colorpicker/colorpicker.css" type="text/css" />
<script type="text/javascript" src="source/jquery.colorpicker.js"></script>
<script language=javascript>
var colorobj = '#bkColor, #bkLineColor, #middleBKColor, #bottomBKColor, #bottomTextColor, #topBKColor, #topHomeNameTextColor, #topSignatureBKColor, ' 
	+ '#topSignatureTextColor, #topHomeAddressTextColor, #topNavigationBKColor, #topNavigationTextColor, #topNavigationSeparatorColor, ' 
	+ '#moduleAnchorTextColor, #moduleTitleBKColor, #moduleTitleTextColor, #moduleTextareaBKColor, #otherTitleTextColor, #moduleRemarkTextColor, ' 
	+ '#moduleButtonBKColor, #moduleButtonTextColor, #moduleNavigationBKColor, #moduleCurrNavigationBKColor, #moduleNavigationTextColor';
jQuery(function() {
	jQuery(colorobj).ColorPicker({
		onSubmit: function(hsb, hex, rgb, el) {
			jQuery('#' + jQuery(el).attr('id') + 'Show').css('background', "#" + hex);
			jQuery(el).val("#" + hex);
			jQuery(el).ColorPickerHide();
		},
		onBeforeShow: function () {
			jQuery(this).ColorPickerSetColor(this.value);
		}
	});
});
</script>
<style type="text/css">
table th, table td { color:#000; }
table th { width:160px }
h2, h3 { padding: 10px 0 10px 0; color:#999; }
h2 { font-size: 2em; }
h3 { font-size: 1.3em; }
.colorbox { border:1px solid #7F9CBA;background-color:#FFF; }
#mainarea { background-color:#FFF; }
</style>
<div class="h_status">
	<a href="main.action?ac=theme">返回主页风格列表</a>
</div>
<div>
	<form method="post" action="main.action?ac=theme" class="c_form">
	<div class="notice">
		状态：<input name="enablecss" type="radio" value="0" ${space.enablecss eq '0' ? 'checked' : ''} />停用 
		<input name="enablecss" type="radio" value="2" ${space.enablecss eq '2' ? 'checked' : ''} />启用<br>
		<c:if test="${!empty param.view}">
		最后保存时间：${empty lastSaveTime ? '从未修改' : lastSaveTime}。<a href="zone.action?view=template" target="_blank">新窗口预览个人主页</a>
		</c:if>
	</div>
	<br>
	<div>
		<h2>页面自定义</h2>
		<div>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<th>页面背景图片：</th>
					<td>
						<input name="usertheme[bkImgUrl]" id="bkImgUrl" value="${usertheme.bkImgUrl}" type="text" size="90" />
					</td>
				</tr>
				<tr>
					<th></th>
					<td><span>(注:图片路径要以http://开头。建议图片宽度大于1024px、高度大于768px，选择纵横平铺)</span></td>
				</tr>
				<tr>
					<th>平铺方式：</th>
					<td>
						<select id="bkRepeat" name="usertheme[bkRepeat]">
							<option value=""></option>
							<option value="repeat-y" ${usertheme.bkRepeat eq 'repeat-y' ? 'selected' : ''}>纵向平铺</option>
							<option value="repeat-x" ${usertheme.bkRepeat eq 'repeat-x' ? 'selected' : ''}>横向平铺</option>
							<option value="repeat" ${usertheme.bkRepeat eq 'repeat' ? 'selected' : ''}>纵横平铺</option>
							<option value="no-repeat" ${usertheme.bkRepeat eq 'no-repeat' ? 'selected' : ''}>不用平铺</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>水平位置：</th>
					<td>
						<select name="usertheme[bkAlignX]" id="bkAlignX">
							<option value=""></option>
							<option value="left" ${usertheme.bkAlignX eq 'left' ? 'selected' : ''}>居左对齐</option>
							<option value="right" ${usertheme.bkAlignX eq 'right' ? 'selected' : ''}>居右对齐</option>
							<option value="center" ${usertheme.bkAlignX eq 'center' ? 'selected' : ''}>居中对齐</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>垂直位置：</th>
					<td>
						<select name="usertheme[bkAlignY]" id="bkAlignY">
							<option value=""></option>
							<option value="top" ${usertheme.bkAlignY eq 'top' ? 'selected' : ''}>居顶对齐</option>
							<option value="bottom" ${usertheme.bkAlignY eq 'bottom' ? 'selected' : ''}>居底对齐</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>页面背景颜色：</th>
					<td>
						<input id="bkColor" name="usertheme[bkColor]" type="text" size="10" value="${usertheme.bkColor}" />
						<span id="bkColorShow" class="colorbox" style="background-color:${usertheme.bkColor};">
							&nbsp;&nbsp;&nbsp;&nbsp;
						</span>
					</td>
				</tr>
				<tr>
					<th>页面线条颜色：</th>
					<td>
						<input id="bkLineColor" name="usertheme[bkLineColor]" type="text" size="10" value="${usertheme.bkLineColor}" />
						<span id="bkLineColorShow" class="colorbox" style="background-color:${usertheme.bkLineColor};">
							&nbsp;&nbsp;&nbsp;&nbsp;
						</span>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<br>
	<div>
		<h2>头部自定义</h2>
		<div>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<th>整个头部背景图片：</th>
					<td>
						<input id="topBKImgUrl" name="usertheme[topBKImgUrl]" type="text" value="${usertheme.topBKImgUrl}" size="90" />
					</td>
				</tr>
				<tr>
					<th></th>
					<td><span>(注:图片路径要以http://开头。建议图片宽度为990px、高度大于200px，选择纵向平铺、居中对齐)</span></td>
				</tr>
				<tr>
					<th>平铺方式：</th>
					<td>
						<select id="topBKRepeat" name="usertheme[topBKRepeat]">
							<option value=""></option>
							<option value="repeat-x" ${usertheme.topBKRepeat eq 'repeat-x' ? 'selected' : ''}>横向平铺</option>
							<option value="repeat-y" ${usertheme.topBKRepeat eq 'repeat-y' ? 'selected' : ''}>纵向平铺</option>
							<option value="repeat" ${usertheme.topBKRepeat eq 'repeat' ? 'selected' : ''}>纵横平铺</option>
							<option value="no-repeat" ${usertheme.topBKRepeat eq 'no-repeat' ? 'selected' : ''}>不用平铺</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>水平位置：</th>
					<td>
						<select name="usertheme[topBKAlignX]" id="topBKAlignX">
							<option value=""></option>
							<option value="left" ${usertheme.topBKAlignX eq 'left' ? 'selected' : ''}>居左对齐</option>
							<option value="right" ${usertheme.topBKAlignX eq 'right' ? 'selected' : ''}>居右对齐</option>
							<option value="center" ${usertheme.topBKAlignX eq 'center' ? 'selected' : ''}>居中对齐</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>垂直位置：</th>
					<td>
						<select name="usertheme[topBKAlignY]" id="topBKAlignY">
							<option value=""></option>
							<option value="top" ${usertheme.topBKAlignY eq 'top' ? 'selected' : ''}>居顶对齐</option>
							<option value="bottom" ${usertheme.topBKAlignY eq 'bottom' ? 'selected' : ''}>居底对齐</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>整个头部背景颜色：</th>
					<td>
						<input id="topBKColor" name="usertheme[topBKColor]" type="text" value="${usertheme.topBKColor}" size="10" />
						<span id="topBKColorShow" class="colorbox" style="background-color:${usertheme.topBKColor}">
							&nbsp;&nbsp;&nbsp;&nbsp;
						</span>
					</td>
				</tr>
				<tr>
					<th>头部高度：</th>
					<td>
						<input id="topHeight" name="usertheme[topHeight]" value="${usertheme.topHeight}" onmouseover="this.select();this.focus();" onClick="javascript:this.value='';" onblur="CheckValue('TopHeight','${usertheme.topHeight}',this.value,0,0)" type="text" size="10" />
						<span>px</span>
					</td>
				</tr>
				<tr style="display:none;">
					<th>模块透明度：</th>
					<td>
						<input id="topBKFilter" name="usertheme[topBKFilter]" value="100" onmouseover="this.select();this.focus();" onClick="javascript:this.value='';" onblur="CheckValue('TopBKFilter','100',this.value,1,100)" type="text" size="5" />
						<span>% (注：请填写1-100的整数，数值越低透明度越高)</span>
					</td>
				</tr>
				<tr>
					<th><h3>内容区</h3></th>
					<td></td>
				</tr>
				<tr>
					<th>主页名称文字颜色：</th>
					<td>
						<input id="topHomeNameTextColor" name="usertheme[topHomeNameTextColor]" value="${usertheme.topHomeNameTextColor}" type="text" size="10" />
						<span id="topHomeNameTextColorShow" class="colorbox" style="background-color:${usertheme.topHomeNameTextColor};">
							&nbsp;&nbsp;&nbsp;&nbsp;
						</span>
					</td>
				</tr>
				<tr>
					<th>用户签名背景颜色：</th>
					<td>
						<input name="usertheme[topSignatureBKColor]" id="topSignatureBKColor" value="${usertheme.topSignatureBKColor}" type="text" size="10" />
						<span id="topSignatureBKColorShow" class="colorbox" style="background-color:${usertheme.topSignatureBKColor};">
							&nbsp;&nbsp;&nbsp;&nbsp;
						</span>
					</td>
				</tr>
				<tr>
					<th>用户签名文字颜色：</th>
					<td>
						<input name="usertheme[topSignatureTextColor]" id="topSignatureTextColor" value="${usertheme.topSignatureTextColor}" type="text" size="10" />
						<span id="topSignatureTextColorShow" class="colorbox" style="background-color:${usertheme.topSignatureTextColor};">
							&nbsp;&nbsp;&nbsp;&nbsp;
						</span>
					</td>
				</tr>
				<tr>
					<th>主页地址文字颜色：</th>
					<td>
						<input name="usertheme[topHomeAddressTextColor]" id="topHomeAddressTextColor" value="${usertheme.topHomeAddressTextColor}" type="text" size="10" />
						<span id="topHomeAddressTextColorShow" class="colorbox" style="background-color:${usertheme.topHomeAddressTextColor};">
							&nbsp;&nbsp;&nbsp;&nbsp;
						</span>
					</td>
				</tr>
				<tr>
					<th><h3>导航条</h3></th>
					<td></td>
				</tr>
				<tr>
					<th>导航条背景图片：</th>
					<td>
						<input name="usertheme[topNavigationBKImgUrl]" id="topNavigationBKImgUrl" value="${usertheme.topNavigationBKImgUrl}" type="text" size="90" />
					</td>
				</tr>
				<tr>
					<th></th>
					<td><span>(注:图片路径要以http://开头。建议图片高度为40px，选择横向平铺)</span></td>
				</tr>
				<tr>
					<th>平铺方式：</th>
					<td>
						<select id="topNavigationBKRepeat" name="usertheme[topNavigationBKRepeat]">
							<option value=""></option>
							<option value="repeat-y" ${usertheme.topNavigationBKRepeat eq 'repeat-y' ? 'selected' : ''}>纵向平铺</option>
							<option value="repeat-x" ${usertheme.topNavigationBKRepeat eq 'repeat-x' ? 'selected' : ''}>横向平铺</option>
							<option value="repeat" ${usertheme.topNavigationBKRepeat eq 'repeat' ? 'selected' : ''}>纵横平铺</option>
							<option value="no-repeat" ${usertheme.topNavigationBKRepeat eq 'no-repeat' ? 'selected' : ''}>不用平铺</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>水平位置：</th>
					<td>
						<select name="usertheme[topNavigationBKAlignX]" id="topNavigationBKAlignX">
							<option value=""></option>
							<option value="left" ${usertheme.topNavigationBKAlignX eq 'left' ? 'selected' : ''}>居左对齐</option>
							<option value="right" ${usertheme.topNavigationBKAlignX eq 'right' ? 'selected' : ''}>居右对齐</option>
							<option value="center" ${usertheme.topNavigationBKAlignX eq 'center' ? 'selected' : ''}>居中对齐</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>垂直位置：</th>
					<td>
						<select name="usertheme[topNavigationBKAlignY]" id="topNavigationBKAlignY">
							<option value=""></option>
							<option value="top" ${usertheme.topNavigationBKAlignY eq 'top' ? 'selected' : ''}>居顶对齐</option>
							<option value="bottom" ${usertheme.topNavigationBKAlignY eq 'bottom' ? 'selected' : ''}>居底对齐</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>导航条背景颜色：</th>
					<td>
						<input name="usertheme[topNavigationBKColor]" id="topNavigationBKColor" type="text" size="10" value="${usertheme.topNavigationBKColor}" />
						<span id="topNavigationBKColorShow" class="colorbox" style="background-color:${usertheme.topNavigationBKColor};">
							&nbsp;&nbsp;&nbsp;&nbsp;
						</span>
					</td>
				</tr>
				<tr>
					<th>导航条文字颜色：</th>
					<td>
						<input id="topNavigationTextColor" name="usertheme[topNavigationTextColor]" value="${usertheme.topNavigationTextColor}" type="text" size="10" />
						<span id="topNavigationTextColorShow" class="colorbox" style="background-color:${usertheme.topNavigationTextColor};">
							&nbsp;&nbsp;&nbsp;&nbsp;
						</span>
					</td>
				</tr>
				<tr>
					<th>导航条分隔符颜色：</th>
					<td>
						<input id="topNavigationSeparatorColor" name="usertheme[topNavigationSeparatorColor]" value="${usertheme.topNavigationSeparatorColor}" type="text" size="10" />
						<span id="topNavigationSeparatorColorShow" class="colorbox" style="background-color:${usertheme.topNavigationSeparatorColor};">
							&nbsp;&nbsp;&nbsp;&nbsp;
						</span>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<br>
	<div>
		<h2>中部自定义</h2>
		<div>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<th>页面中部内容区背景颜色：</th>
					<td>
						<input id="middleBKColor" name="usertheme[middleBKColor]" value="${usertheme.middleBKColor}" type="text" size="10" />
						<span id="middleBKColorShow" class="colorbox" style="background-color:${usertheme.middleBKColor};">
							&nbsp;&nbsp;&nbsp;&nbsp;
						</span>
					</td>
				</tr>
				<tr>
					<th><h3>标题栏</h3></th>
					<td></td>
				</tr>
				<tr>
					<th>标题栏底图：</th>
					<td>
						<input id="moduleTitleBKImgUrl" name="usertheme[moduleTitleBKImgUrl]" type="text" value="${usertheme.moduleTitleBKImgUrl}" size="90" />
					</td>
				</tr>
				<tr>
					<th></th>
					<td><span>(注:图片路径要以http://开头。建议图片高度为30px，选择横向平铺)</span></td>
				</tr>
				<tr>
					<th>平铺方式：</th>
					<td>
						<select name="usertheme[moduleTitleBKRepeat]" id="moduleTitleBKRepeat">
							<option value=""></option>
							<option value="repeat-x" ${usertheme.moduleTitleBKRepeat eq 'repeat-x' ? 'selected' : ''}>横向平铺</option>
							<option value="repeat-y" ${usertheme.moduleTitleBKRepeat eq 'repeat-y' ? 'selected' : ''}>纵向平铺</option>
							<option value="repeat" ${usertheme.moduleTitleBKRepeat eq 'repeat' ? 'selected' : ''}>纵横平铺</option>
							<option value="no-repeat" ${usertheme.moduleTitleBKRepeat eq 'no-repeat' ? 'selected' : ''}>不用平铺</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>水平位置：</th>
					<td>
						<select name="usertheme[moduleTitleBKAlignX]" id="moduleTitleBKAlignX">
							<option value=""></option>
							<option value="left" ${usertheme.moduleTitleBKAlignX eq 'left' ? 'selected' : ''}>居左对齐</option>
							<option value="right" ${usertheme.moduleTitleBKAlignX eq 'right' ? 'selected' : ''}>居右对齐</option>
							<option value="center" ${usertheme.moduleTitleBKAlignX eq 'center' ? 'selected' : ''}>居中对齐</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>垂直位置：</th>
					<td>
						<select name="usertheme[moduleTitleBKAlignY]" id="moduleTitleBKAlignY">
							<option value=""></option>
							<option value="top" ${usertheme.moduleTitleBKAlignY eq 'top' ? 'selected' : ''}>居顶对齐</option>
							<option value="bottom" ${usertheme.moduleTitleBKAlignY eq 'bottom' ? 'selected' : ''}>居底对齐</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>标题栏背景颜色：</th>
					<td>
						<input id="moduleTitleBKColor" name="usertheme[moduleTitleBKColor]" value="${usertheme.moduleTitleBKColor}" type="text" size="10" />
						<span id="moduleTitleBKColorShow" class="colorbox" style="background-color:${usertheme.moduleTitleBKColor}">
							&nbsp;&nbsp;&nbsp;&nbsp;
						</span>
					</td>
				</tr>
				<tr>
					<th>标题栏文字颜色：</th>
					<td>
						<input id="moduleTitleTextColor" name="usertheme[moduleTitleTextColor]" value="${usertheme.moduleTitleTextColor}" type="text" size="10" />
						<span id="moduleTitleTextColorShow" class="colorbox" style="background-color:${usertheme.moduleTitleTextColor};">
							&nbsp;&nbsp;&nbsp;&nbsp;
						</span>
					</td>
				</tr>
				<tr>
					<th><h3>内容区</h3></th>
					<td></td>
				</tr>
				<tr>
					<th>文本框背景颜色：</th>
					<td>
						<input id="moduleTextareaBKColor" name="usertheme[moduleTextareaBKColor]" value="${usertheme.moduleTextareaBKColor}" type="text" size="10" />
						<span id="moduleTextareaBKColorShow" class="colorbox" style="background-color:${usertheme.moduleTextareaBKColor}">
							&nbsp;&nbsp;&nbsp;&nbsp;
						</span>
					</td>
				</tr>
				<tr>
					<th>其它标题文字颜色：</th>
					<td>
						<input id="otherTitleTextColor" name="usertheme[otherTitleTextColor]" value="${usertheme.otherTitleTextColor}" type="text" size="10" />
						<span id="otherTitleTextColorShow" class="colorbox" style="background-color:${usertheme.otherTitleTextColor};">
							&nbsp;&nbsp;&nbsp;&nbsp;
						</span>
					</td>
				</tr>
				<tr>
					<th>网页链接文字颜色：</th>
					<td>
						<input id="moduleAnchorTextColor" name="usertheme[moduleAnchorTextColor]" value="${usertheme.moduleAnchorTextColor}" type="text" size="10" />
						<span id="moduleAnchorTextColorShow" class="colorbox" style="background-color:${usertheme.moduleAnchorTextColor};">
							&nbsp;&nbsp;&nbsp;&nbsp;
						</span>
					</td>
				</tr>
				<tr>
					<th>备注文字颜色：</th>
					<td>
						<input id="moduleRemarkTextColor" name="usertheme[moduleRemarkTextColor]" value="${usertheme.moduleRemarkTextColor}" type="text" size="10" />
						<span id="moduleRemarkTextColorShow" class="colorbox" style="background-color:${usertheme.moduleRemarkTextColor};">
							&nbsp;&nbsp;&nbsp;&nbsp;
						</span>
					</td>
				</tr>
				<tr>
					<th>按钮背景颜色：</th>
					<td>
						<input id="moduleButtonBKColor" name="usertheme[moduleButtonBKColor]" value="${usertheme.moduleButtonBKColor}" type="text" size="10" />
						<span id="moduleButtonBKColorShow" class="colorbox" style="background-color:${usertheme.moduleButtonBKColor}">
							&nbsp;&nbsp;&nbsp;&nbsp;
						</span>
					</td>
				</tr>
				<tr>
					<th>按钮文字颜色：</th>
					<td>
						<input id="moduleButtonTextColor" name="usertheme[moduleButtonTextColor]" value="${usertheme.moduleButtonTextColor}" type="text" size="10" />
						<span id="moduleButtonTextColorShow" class="colorbox" style="background-color:${usertheme.moduleButtonTextColor};">
							&nbsp;&nbsp;&nbsp;&nbsp;
						</span>
					</td>
				</tr>
				<tr>
					<th><h3>导航条</h3></th>
					<td></td>
				</tr>
				<tr>
					<th>当前导航条背景颜色：</th>
					<td>
						<input name="usertheme[moduleCurrNavigationBKColor]" id="moduleCurrNavigationBKColor" type="text" size="10" value="${usertheme.moduleCurrNavigationBKColor}" />
						<span id="moduleCurrNavigationBKColorShow" class="colorbox" style="background-color:${usertheme.moduleCurrNavigationBKColor};">
							&nbsp;&nbsp;&nbsp;&nbsp;
						</span>
					</td>
				</tr>
				<tr>
					<th>非当前导航条背景颜色：</th>
					<td>
						<input name="usertheme[moduleNavigationBKColor]" id="moduleNavigationBKColor" type="text" size="10" value="${usertheme.moduleNavigationBKColor}" />
						<span id="moduleNavigationBKColorShow" class="colorbox" style="background-color:${usertheme.moduleNavigationBKColor};">
							&nbsp;&nbsp;&nbsp;&nbsp;
						</span>
					</td>
				</tr>
				<tr>
					<th>导航条文字颜色：</th>
					<td>
						<input id="moduleNavigationTextColor" name="usertheme[moduleNavigationTextColor]" value="${usertheme.moduleNavigationTextColor}" type="text" size="10" />
						<span id="moduleNavigationTextColorShow" class="colorbox" style="background-color:${usertheme.moduleNavigationTextColor};">
							&nbsp;&nbsp;&nbsp;&nbsp;
						</span>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div>
		<h2>底部自定义</h2>
		<div>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<th>页面底部背景颜色：</th>
					<td>
						<input id="bottomBKColor" name="usertheme[bottomBKColor]" value="${usertheme.bottomBKColor}" type="text" size="10" />
						<span id="bottomBKColorShow" class="colorbox" style="background-color:${usertheme.bottomBKColor};">
							&nbsp;&nbsp;&nbsp;&nbsp;
						</span>
					</td>
				</tr>
				<tr>
					<th>页面底部文字颜色：</th>
					<td>
						<input id="bottomTextColor" name="usertheme[bottomTextColor]" value="${usertheme.bottomTextColor}" type="text" size="10" />
						<span id="bottomTextColorShow" class="colorbox" style="background-color:${usertheme.bottomTextColor};">
							&nbsp;&nbsp;&nbsp;&nbsp;
						</span>
					</td>
				</tr>
				<tr>
					<th>&nbsp;</th>
					<td></td>
				</tr>
				<tr>
					<th>&nbsp;</th>
					<td>
						<input type="submit" name="csstemplatesubmit" id="csstemplatesubmit" value="保存修改" class="submit" />
					</td>
				</tr>
			</table>
		</div>
	</div>
	<input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,false)}" />
	</form>
</div>