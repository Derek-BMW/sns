<%@ page language="java"  pageEncoding="UTF-8"%>

<jsp:directive.include file="header.jsp" />

<div class="mainarea">
<div class="maininner">
	<div class="tabs_header">
		<ul class="tabs">
			<li ${active}><a href="backstage.action?ac=block"><span>浏览全部模块</span></a></li>
			<li class="null"><a href="backstage.action?ac=block&op=add">添加新模块</a></li>
		</ul>
	</div>
<c:choose>
<c:when test="${empty param.op}">
	<div class="bdrcontent">
		<p>模块调用，会将站内的数据，通过你编写的查询SQL语句，进行查询并读取出来，生成一段调用代码。你将调用代码(模板内嵌，或者JS调用都可以)放置到站点页面上便可以将相应的查询结果展示给访客了，从而可以实现站内任意数据的显示调用。</p>
	</div>
	<br />
	<div class="bdrcontent">
		<table cellspacing="0" cellpadding="0" class="formtable">
		<tr>
			<th>名称</th>
			<th width="220">调用代码</th>
			<th width="180">操作</th>
		</tr>
		<c:forEach items="${list}" var="value">
		<tr>
			<td>${value.blockname}</td>
			<td><a href="${turl}&op=tpl&id=${value.bid}">模块内嵌代码</a> | <a href="${turl}&op=js&id=${value.bid}">Javascript调用代码</a></td>
			<td><a href="${turl}&op=blocksql&id=${value.bid}">编辑SQL</a> | 
			<a href="${turl}&op=code&id=${value.bid}">参数设置</a> | 
			<a href="${turl}&op=delete&id=${value.bid}">删除</a></td>
		</tr>
		</c:forEach>
		<tr><td colspan="3"><div class="pages">${multi}</div></td></tr>
		</table>
	</div>
</c:when>

<c:when test="${param.op == 'add' || param.op == 'blocksql'}">
	<form method="post" action="${turl}" id="sqlform">
	<input type="hidden" name="formhash" value="${formhash}" />
	<div class="bdrcontent">
		<div class="tabs_header" id="sqlGuide" style="display:none;">
		<ul class="tabs">
			<li id="li_${sqltables.blog}"><a id="a_select_${sqltables.blog}" href="javascript:void(0);" onclick="javascript:showSQLDiv('${sqltables.blog}');"><span>日志</span></a></li>
			<li id="li_${sqltables.album}"><a id="a_select_${sqltables.album}" href="javascript:void(0);" onclick="javascript:showSQLDiv('${sqltables.album}');"><span>相册</span></a></li>
			<li id="li_${sqltables.thread}"><a id="a_select_${sqltables.thread}" href="javascript:void(0);" onclick="javascript:showSQLDiv('${sqltables.thread}');"><span>话题</span></a></li>
			<li id="li_${sqltables.feed}"><a id="a_select_${sqltables.feed}" href="javascript:void(0);" onclick="javascript:showSQLDiv('${sqltables.feed}');"><span>动态</span></a></li>
			<li id="li_${sqltables.space}"><a id="a_select_${sqltables.space}" href="javascript:void(0);" onclick="javascript:showSQLDiv('${sqltables.space}');"><span>用户</span></a></li>
			<li id="li_${sqltables.pic}"><a id="a_select_${sqltables.pic}" href="javascript:void(0);" onclick="javascript:showSQLDiv('${sqltables.pic}');"><span>照片</span></a></li>
			<li id="li_${sqltables.mtag}"><a id="a_select_${sqltables.mtag}" href="javascript:void(0);" onclick="javascript:showSQLDiv('${sqltables.mtag}');"><span>群组</span></a></li>
			<li id="li_sqlDiy"><a id="a_select_sqlDiy" href="javascript:void(0);" onclick="javascript:showSQLDiv('sqlDiy');"><span>手写SQL</span></a></li>
		</ul>
		</div>
		<table cellspacing="0" cellpadding="0" class="formtable">
		<tr><th style="width:10em;">模块名称</th><td><input type="text" name="blockname" value="${block.blockname}"></td></tr>
		</table>
		<table cellspacing="0" cellpadding="0" class="formtable" id="${sqltables.blog}" style="display:none;">
		<tr><th style="width:10em;">过滤设置</th><td></td></tr>
		<tr><th>指定日志blogid</th><td>
			<input type="radio" name="sqluseid_${sqltables.blog}" value="0" onclick="javascript:setRadioValue('${sqltables.blog}_where', '${sqltables.blog}_ids');" checked />不指定
			<input type="radio" name="sqluseid_${sqltables.blog}" value="1" onclick="javascript:setRadioValue('${sqltables.blog}_ids', '${sqltables.blog}_where');" />指定
			<input type="hidden" id="${sqltables.blog}_id" value="blogid" />
		</td></tr>
		<tbody id="${sqltables.blog}_ids" style="display:none;">
			<tr><th>日志blogid</th><td><input type="text" id="${sqltables.blog}_where_blogid" value="" /> 多个日志的 blogid 请用“,”格开</td></tr>
		</tbody>
		<tbody id="${sqltables.blog}_where">
			<tr><th>指定作者uid</th><td><input type="text" id="${sqltables.blog}_where_uid" value="" /> 多个用户的 uid 请用“,”格开</td></tr>
			<tr><th>查看数范围</th><td><input type="text" id="${sqltables.blog}_where_viewnum_min" value="" /> ~ <input type="text" id="${sqltables.blog}_where_viewnum_max" value="" /></td></tr>
			<tr><th>回复数范围</th><td><input type="text" id="${sqltables.blog}_where_replynum_min" value="" /> ~ <input type="text" id="${sqltables.blog}_where_replynum_max" value="" /></td></tr>
			<tr><th>发布时间</th><td><select id="${sqltables.blog}_where_dateline">
				<option value="0" selected>---不限制---</option>
				<option value="86400">一天以来</option>
				<option value="172800">两天以来</option>
				<option value="604800">一周以来</option>
				<option value="1209600">两周以来</option>
				<option value="2592000">一个月以来</option>
				<option value="7948800">三个月以来</option>
				<option value="15897600">六个月以来</option>
				<option value="31536000">一年以来</option>
				</select></td></tr>
			<tr><th>是否有图片</th><td><select id="${sqltables.blog}_where_picflag">
				<option value="null">全部</option>
				<option value="1">有图片</option>
				</select></td></tr>
			<tr><th>隐私范围</th><td><select id="${sqltables.blog}_where_friend">
				<option value="0">全站用户可见</option>
				<option value="null">全部</option>
				</select></td></tr>
		</tbody>
		<tr><th>排序设置</th><td></td></tr>
		<tr><th>第一排序</th><td><select id="${sqltables.blog}_order_key_1">
			<option value="null">请选择</option>
			<option value="viewnum">查看数</option>
			<option value="replynum">回复数</option>
			<option value="dateline">发布时间</option>
			</select>
			<select id="${sqltables.blog}_order_value_1">
			<option value="null">请选择</option>
			<option value="ASC">递增</option>
			<option value="DESC">递减</option>
			</select></td></tr>
		<tr><th>第二排序</th><td><select id="${sqltables.blog}_order_key_2">
			<option value="null">请选择</option>
			<option value="viewnum">查看数</option>
			<option value="replynum">回复数</option>
			<option value="dateline">发布时间</option>
			</select>
			<select id="${sqltables.blog}_order_value_2">
			<option value="null">请选择</option>
			<option value="ASC">递增</option>
			<option value="DESC">递减</option>
			</select></td></tr>
		<tr><th>第三排序</th><td><select id="${sqltables.blog}_order_key_3">
			<option value="null">请选择</option>
			<option value="viewnum">查看数</option>
			<option value="replynum">回复数</option>
			<option value="dateline">发布时间</option>
			</select>
			<select id="${sqltables.blog}_order_value_3">
			<option value="null">请选择</option>
			<option value="ASC">递增</option>
			<option value="DESC">递减</option>
			</select></td></tr></table>
		<table cellspacing="0" cellpadding="0" class="formtable" id="${sqltables.album}" style="display:none;">
		<tr><th style="width:10em;">过滤设置</th><td></td></tr>
		<tr><th>指定相册albumid</th><td>
			<input type="radio" name="sqluseid_${sqltables.album}" value="0" onclick="javascript:setRadioValue('${sqltables.album}_where', '${sqltables.album}_ids');" checked />不指定
			<input type="radio" name="sqluseid_${sqltables.album}" value="1" onclick="javascript:setRadioValue('${sqltables.album}_ids', '${sqltables.album}_where');" />指定
			<input type="hidden" id="${sqltables.album}_id" value="albumid" />
		</td></tr>
		<tbody id="${sqltables.album}_ids" style="display:none;">
			<tr><th>相册albumid</th><td><input type="text" id="${sqltables.album}_where_albumid" value="" /> 多个相册的 albumid 请用“,”格开</td></tr>
		</tbody>
		<tbody id="${sqltables.album}_where">
			<tr><th>指定作者uid</th><td><input type="text" id="${sqltables.album}_where_uid" value="" /> 多个用户的 uid 请用“,”格开</td></tr>
			<tr><th>照片数量范围</th><td><input type="text" id="${sqltables.album}_where_picnum_min" value="" /> ~ <input type="text" id="${sqltables.album}_where_picnum_max" value="" /></td></tr>
			<tr><th>发布时间</th><td><select id="${sqltables.album}_where_dateline">
				<option value="0" selected>---不限制---</option>
				<option value="86400">一天以来</option>
				<option value="172800">两天以来</option>
				<option value="604800">一周以来</option>
				<option value="1209600">两周以来</option>
				<option value="2592000">一个月以来</option>
				<option value="7948800">三个月以来</option>
				<option value="15897600">六个月以来</option>
				<option value="31536000">一年以来</option>
				</select></td></tr>
			<tr><th>更新时间</th><td><select id="${sqltables.album}_where_updatetime">
				<option value="0" selected>---不限制---</option>
				<option value="86400">一天以来</option>
				<option value="172800">两天以来</option>
				<option value="604800">一周以来</option>
				<option value="1209600">两周以来</option>
				<option value="2592000">一个月以来</option>
				<option value="7948800">三个月以来</option>
				<option value="15897600">六个月以来</option>
				<option value="31536000">一年以来</option>
				</select></td></tr>
			<tr><th>是否有图片</th><td><select id="${sqltables.album}_where_picflag">
				<option value="1">有图片</option>
				<option value="null">全部</option>
				</select></td></tr>
			<tr><th>隐私范围</th><td><select id="${sqltables.album}_where_friend">
				<option value="0">全站用户可见</option>
				<option value="null">所有</option>
				</select></td></tr>
		</tbody>
		<tr><th>排序设置</th><td></td></tr>
		<tr><th>第一排序</th><td><select id="${sqltables.album}_order_key_1">
			<option value="null">请选择</option>
			<option value="picnum">照片数量</option>
			<option value="updatetime">更新时间</option>
			<option value="dateline">创建时间</option>
			</select>
			<select id="${sqltables.album}_order_value_1">
			<option value="null">请选择</option>
			<option value="ASC">递增</option>
			<option value="DESC">递减</option>
			</select></td></tr>
		<tr><th>第二排序</th><td><select id="${sqltables.album}_order_key_2">
			<option value="null">请选择</option>
			<option value="picnum">照片数量</option>
			<option value="updatetime">更新时间</option>
			<option value="dateline">创建时间</option>
			</select>
			<select id="${sqltables.album}_order_value_2">
			<option value="null">请选择</option>
			<option value="ASC">递增</option>
			<option value="DESC">递减</option>
			</select></td></tr>
		<tr><th>第三排序</th><td><select id="${sqltables.album}_order_key_3">
			<option value="null">请选择</option>
			<option value="picnum">照片数量</option>
			<option value="updatetime">更新时间</option>
			<option value="dateline">创建时间</option>
			</select>
			<select id="${sqltables.album}_order_value_3">
			<option value="null">请选择</option>
			<option value="ASC">递增</option>
			<option value="DESC">递减</option>
			</select></td></tr></table>
		<table cellspacing="0" cellpadding="0" class="formtable" id="${sqltables.thread}" style="display:none;">
		<tr><th style="width:10em;">过滤设置</th><td></td></tr>
		<tr><th>话题threadid</th><td>
			<input type="radio" name="sqluseid_${sqltables.thread}" value="0" onclick="javascript:setRadioValue('${sqltables.thread}_where', '${sqltables.thread}_ids');" checked />不指定
			<input type="radio" name="sqluseid_${sqltables.thread}" value="1" onclick="javascript:setRadioValue('${sqltables.thread}_ids', '${sqltables.thread}_where');" />指定
			<input type="hidden" id="${sqltables.thread}_id" value="tid" />
		</td></tr>
		<tbody id="${sqltables.thread}_ids" style="display:none;">
			<tr><th>话题threadid</th><td><input type="text" id="${sqltables.thread}_where_tid" value="" /> 多个话题的 threadid 请用“,”格开</td></tr>
		</tbody>
		<tbody id="${sqltables.thread}_where">
			<tr><th>指定作者uid</th><td><input type="text" id="${sqltables.thread}_where_uid" value="" /> 多个用户的 uid 请用“,”格开</td></tr>
			<tr><th>指定群组tagid</th><td><input type="text" id="${sqltables.thread}_where_tagid" value="" /> 多个群组的 tagid 请用“,”格开</td></tr>
			<tr><th>话题查看数范围</th><td><input type="text" id="${sqltables.thread}_where_viewnum_min" value="" /> ~ <input type="text" id="${sqltables.thread}_where_viewnum_max" value="" /></td></tr>
			<tr><th>话题回复数范围</th><td><input type="text" id="${sqltables.thread}_where_replynum_min" value="" /> ~ <input type="text" id="${sqltables.thread}_where_replynum_max" value="" /></td></tr>
			<tr><th>发布时间</th><td><select id="${sqltables.thread}_where_dateline">
				<option value="0" selected>---不限制---</option>
				<option value="86400">一天以来</option>
				<option value="172800">两天以来</option>
				<option value="604800">一周以来</option>
				<option value="1209600">两周以来</option>
				<option value="2592000">一个月以来</option>
				<option value="7948800">三个月以来</option>
				<option value="15897600">六个月以来</option>
				<option value="31536000">一年以来</option>
				</select></td></tr>
			<tr><th>是否置顶</th><td><select id="${sqltables.thread}_where_displayorder">
				<option value="null">全部</option>
				<option value="1">置顶</option>
				</select></td></tr>
			<tr><th>是否精华话题</th><td><select id="${sqltables.thread}_where_digest">
				<option value="null">全部</option>
				<option value="1">精华</option>
				</select></td></tr>
		</tbody>
		<tr><th>排序设置</th><td></td></tr>
		<tr><th>第一排序</th><td><select id="${sqltables.thread}_order_key_1">
			<option value="null">请选择</option>
			<option value="viewnum">查看数</option>
			<option value="replynum">回复数</option>
			<option value="dateline">发布时间</option>
			</select>
			<select id="${sqltables.thread}_order_value_1">
			<option value="null">请选择</option>
			<option value="ASC">递增</option>
			<option value="DESC">递减</option>
			</select></td></tr>
		<tr><th>第二排序</th><td><select id="${sqltables.thread}_order_key_2">
			<option value="null">请选择</option>
			<option value="viewnum">查看数</option>
			<option value="replynum">回复数</option>
			<option value="dateline">发布时间</option>
			</select>
			<select id="${sqltables.thread}_order_value_2">
			<option value="null">请选择</option>
			<option value="ASC">递增</option>
			<option value="DESC">递减</option>
			</select></td></tr>
		<tr><th>第三排序</th><td><select id="${sqltables.thread}_order_key_3">
			<option value="null">请选择</option>
			<option value="viewnum">查看数</option>
			<option value="replynum">回复数</option>
			<option value="dateline">发布时间</option>
			</select>
			<select id="${sqltables.thread}_order_value_3">
			<option value="null">请选择</option>
			<option value="ASC">递增</option>
			<option value="DESC">递减</option>
			</select></td></tr></table>
		<table cellspacing="0" cellpadding="0" class="formtable" id="${sqltables.feed}" style="display:none;">
		<tr><th style="width:10em;">过滤设置</th><td></td></tr>
		<tbody id="${sqltables.feed}_where">
			<tr><th>动态feedid</th><td><input type="text" id="${sqltables.feed}_where_feedid" value="" /> 多个动态的 feedid 请用“,”格开</td></tr>
			<tr><th>动态类型</th><td><select id="${sqltables.feed}_where_appid">
				<option value="null">全部</option>
				<option value="0">站内</option>
				<option value="1">应用</option>
				</select></td></tr>
			<tr><th>隐私范围</th><td><select id="${sqltables.feed}_where_friend">
				<option value="0">全站用户可见</option>
				<option value="null">全部</option>
				</select></td></tr>
		</tbody>
		<tr><th>排序设置</th><td></td></tr>
		<tr><th>第一排序</th><td><select id="${sqltables.feed}_order_key_1">
			<option value="null">请选择</option>
			<option value="dateline">产生时间</option>
			</select>
			<select id="${sqltables.feed}_order_value_1">
			<option value="null">请选择</option>
			<option value="ASC">递增</option>
			<option value="DESC">递减</option>
			</select></td></tr></table>
		<table cellspacing="0" cellpadding="0" class="formtable" id="${sqltables.space}" style="display:none;">
		<tr><th style="width:10em;">过滤设置</th><td></td></tr>
		<tr><th>指定用户uid</th><td>
			<input type="radio" name="sqluseid_${sqltables.space}" value="0" onclick="javascript:setRadioValue('${sqltables.space}_where', '${sqltables.space}_ids');" checked />不指定
			<input type="radio" name="sqluseid_${sqltables.space}" value="1" onclick="javascript:setRadioValue('${sqltables.space}_ids', '${sqltables.space}_where');" />指定
			<input type="hidden" id="${sqltables.space}_id" value="uid" />
		</td></tr>
		<tbody id="${sqltables.space}_ids" style="display:none;">
			<tr><th>用户uid</th><td><input type="text" id="${sqltables.space}_where_uid" value="" /> 多个用户的 uid 请用“,”格开</td></tr>
		</tbody>
		<tbody id="${sqltables.space}_where">
			<tr><th>积分数范围</th><td><input type="text" id="${sqltables.space}_where_credit_min" value="" /> ~ <input type="text" id="${sqltables.space}_where_credit_max" value="" /></td></tr>
			<tr><th>指定用户组</th><td>
				<table cellpadding="0" cellspacing="0" class="formtable"><tr>
				<c:forEach items="${usergrouparr}" var="g" varStatus="status">
				<c:if test="${status.index != 0 && status.index % 3 == 0}"></tr><tr></c:if>
				<td><input type="checkbox" name="${sqltables.space}_where_groupid_${g.gid}" value="${g.gid}" id="${sqltables.space}_where_groupid_${g.gid}" /> <label for="${sqltables.space}_where_groupid_${g.gid}" style="cursor:pointer;">${g.grouptitle}</label></td>
				</c:forEach>
				</tr></table>
			</td></tr>
			<tr><th>查看数范围</th><td><input type="text" id="${sqltables.space}_where_viewnum_min" value="" /> ~ <input type="text" id="${sqltables.space}_where_viewnum_max" value="" /></td></tr>
			<tr><th>好友数范围</th><td><input type="text" id="${sqltables.space}_where_friendnum_min" value="" /> ~ <input type="text" id="${sqltables.space}_where_friendnum_max" value="" /></td></tr>
			<tr><th>是否实名认证</th><td><select id="${sqltables.space}_where_namestatus">
				<option value="null">全部</option>
				<option value="1">已认证</option>
				</select></td></tr>
			<tr><th>建立时间</th><td><select id="${sqltables.space}_where_dateline">
				<option value="0" selected>---不限制---</option>
				<option value="86400">一天以来</option>
				<option value="172800">两天以来</option>
				<option value="604800">一周以来</option>
				<option value="1209600">两周以来</option>
				<option value="2592000">一个月以来</option>
				<option value="7948800">三个月以来</option>
				<option value="15897600">六个月以来</option>
				<option value="31536000">一年以来</option>
				</select></td></tr>
			<tr><th>更新时间</th><td><select id="${sqltables.space}_where_updatetime">
				<option value="0" selected>---不限制---</option>
				<option value="86400">一天以来</option>
				<option value="172800">两天以来</option>
				<option value="604800">一周以来</option>
				<option value="1209600">两周以来</option>
				<option value="2592000">一个月以来</option>
				<option value="7948800">三个月以来</option>
				<option value="15897600">六个月以来</option>
				<option value="31536000">一年以来</option>
				</select></td></tr>
			<tr><th>是否有头像</th><td><select id="${sqltables.space}_where_avatar">
				<option value="null">全部</option>
				<option value="1">有</option>
				</select></td></tr>
			<tr><th>用户性别</th><td><select id="${sqltables.space}_where_sex">
				<option value="null">全部</option>
				<option value="1">男</option>
				<option value="2">女</option>
				</select></td></tr>
		</tbody>
		<tr><th>排序设置</th><td></td></tr>
		<tr><th>第一排序</th><td><select id="${sqltables.space}_order_key_1">
			<option value="null">请选择</option>
			<option value="viewnum">查看数</option>
			<option value="friendnum">好友数</option>
			<option value="updatetime">最后更新</option>
			<option value="lastlogin">最后登录时间</option>
			<option value="credit">积分数</option>
			<option value="dateline">开通时间</option>
			</select>
			<select id="${sqltables.space}_order_value_1">
			<option value="null">请选择</option>
			<option value="ASC">递增</option>
			<option value="DESC">递减</option>
			</select></td></tr>
		<tr><th>第二排序</th><td><select id="${sqltables.space}_order_key_2">
			<option value="null">请选择</option>
			<option value="viewnum">查看数</option>
			<option value="friendnum">好友数</option>
			<option value="updatetime">最后更新</option>
			<option value="lastlogin">最后登录时间</option>
			<option value="credit">积分数</option>
			<option value="dateline">开通时间</option>
			</select>
			<select id="${sqltables.space}_order_value_2">
			<option value="null">请选择</option>
			<option value="ASC">递增</option>
			<option value="DESC">递减</option>
			</select></td></tr>
		<tr><th>第三排序</th><td><select id="${sqltables.space}_order_key_3">
			<option value="null">请选择</option>
			<option value="viewnum">查看数</option>
			<option value="friendnum">好友数</option>
			<option value="updatetime">最后更新</option>
			<option value="lastlogin">最后登录时间</option>
			<option value="credit">积分数</option>
			<option value="dateline">开通时间</option>
			</select>
			<select id="${sqltables.space}_order_value_3">
			<option value="null">请选择</option>
			<option value="ASC">递增</option>
			<option value="DESC">递减</option>
			</select></td></tr></table>
		<table cellspacing="0" cellpadding="0" class="formtable" id="${sqltables.mtag}" style="display:none;">
		<tr><th style="width:10em;">过滤设置</th><td></td></tr>
		<tr><th>指定群组tagid</th><td>
			<input type="radio" name="sqluseid_${sqltables.mtag}" value="0" onclick="javascript:setRadioValue('${sqltables.mtag}_where', '${sqltables.mtag}_ids');" checked />不指定
			<input type="radio" name="sqluseid_${sqltables.mtag}" value="1" onclick="javascript:setRadioValue('${sqltables.mtag}_ids', '${sqltables.mtag}_where');" />指定
			<input type="hidden" id="${sqltables.mtag}_id" value="tagid" />
		</td></tr>
		<tbody id="${sqltables.mtag}_ids" style="display:none;">
			<tr><th>群组tagid</th><td><input type="text" id="${sqltables.mtag}_where_tagid" value="" /> 多个群组的 tagid 请用“,”格开</td></tr>
		</tbody>
		<tbody id="${sqltables.mtag}_where">
			<tr><th>群组人数</th><td><input type="text" id="${sqltables.mtag}_where_membernum_min" value="" /> ~ <input type="text" id="${sqltables.mtag}_where_membernum_max" value="" /></td></tr>
			<tr><th>群组分类</th><td>
				<table cellpadding="0" cellspacing="0" class="formtable"><tr>
				<c:forEach items="${list}" var="value" varStatus="status">
				<c:if test="${status.index != 0 && status.index % 3 == 0}"></tr><tr></c:if>
				<td><input type="checkbox" name="${sqltables.mtag}_where_fieldid_${value.fieldid}" value="${value.fieldid}" id="${sqltables.mtag}_where_fieldid_${value.fieldid}" /> <label for="${sqltables.mtag}_where_fieldid_${value.fieldid}" style="cursor:pointer;">${value.title}</label></td>
				</c:forEach>
				</tr></table>
			</td></tr>
			<tr><th>群组权限</th><td><select id="${sqltables.mtag}_where_joinperm">
				<option value="null">全部</option>
				<option value="1">允许所有人可加入</option>
				</select></td></tr>
		</tbody>
		<tr><th>排序设置</th><td></td></tr>
		<tr><th>第一排序</th><td><select id="${sqltables.mtag}_order_key_1">
			<option value="null">请选择</option>
			<option value="membernum">群组人数</option>
			</select>
			<select id="${sqltables.mtag}_order_value_1">
			<option value="null">请选择</option>
			<option value="ASC">递增</option>
			<option value="DESC">递减</option>
			</select></td></tr></table>
		<table cellspacing="0" cellpadding="0" class="formtable" id="${sqltables.pic}" style="display:none;">
		<tr><th style="width:10em;">过滤设置</th><td></td></tr>
		<tbody id="${sqltables.pic}_where">
			<tr><th>相册albumid</th><td><input type="text" id="${sqltables.pic}_where_albumid" value="" /> 多个相册的 albumid 请用“,”格开</td></tr>
			<tr><th>用户uid</th><td><input type="text" id="${sqltables.pic}_where_uid" value="" /> 多个用户的 uid 请用“,”格开</td></tr>
		</tbody>
		<tr><th>排序设置</th><td></td></tr>
		<tr><th>第一排序</th><td><select id="${sqltables.pic}_order_key_1">
			<option value="null">请选择</option>
			<option value="dateline">上传时间</option>
			</select>
			<select id="${sqltables.pic}_order_value_1">
			<option value="null">请选择</option>
			<option value="ASC">递增</option>
			<option value="DESC">递减</option>
			</select></td></tr></table>
		<table cellspacing="0" cellpadding="0" class="formtable" id="sqlDiy" style="display:none;">
		<tr><th style="width:10em;">模块调用SQL</th><td><textarea id="blocksql" name="blocksql" style="width:98%;" rows="6">${block.blocksql}</textarea>
			<br />本功能需要你掌握一定的SQL编写知识。
			<br />本模块调用只支持编写 SELECT 开头的查询SQL。
			<br />SQL语句中需要使用完整的表名。如果想调用非本程序数据库中的表，在表名前面增加数据库名即可。例如：
			<br />1. 查询读取最新的日志 (表名前缀为默认的 sns_)
			<br />SELECT * FROM sns_blog ORDER BY dateline DESC
			</td></tr>
		</table>
	</div>
	<div class="footactions">
		<input type="hidden" name="bid" value="${block.bid}">
		<input type="submit" name="valuesubmit" value="提交" class="submit">
	</div>
	<script language="javascript" type="text/javascript">
	var curMod = '';
	var tableFields = ['uid', 'feedid', 'tagid', 'albumid'];
	var sqls = [];
	//////JSTL脚本//////
	<c:forEach items="${sqls}" var="m">
	sqls['${m.key}'] = '${m.value}';
	</c:forEach>
	$('sqlform').onsubmit = function() {
		var frmObj = $('sqlform');
		var eLen = frmObj.elements.length;
		var whereArr = [];
		var orderKeys = [];
		var orderValues = [];
		var orderArr = [];
		var tmpArr = [];
		var groupidArr = [];
		var fieldidArr = [];
		var preReg = new RegExp('sns_', 'ig');
		var tableName = curMod.replace(preReg, '');
		var timeFields = ['dateline', 'updatetime'];
		var str = '';
		var whereOrder = '';
		if('' == curMod || 'undefined' == typeof(sqls[tableName])) {
			return;
		}
		var tReg = new RegExp('_([a-zA-Z0-9]*)', 'ig');
		for(var i = 0; i < eLen; i ++) {
			if('' == frmObj.elements[i].value || 'null' == frmObj.elements[i].value) {
				continue;
			}
			tmpArr.length = 0;
			str = (frmObj.elements[i].id).replace(curMod, '');
			if(frmObj.elements[i].id != str) {
				str.replace(tReg, function($0, $1) {
					tmpArr[tmpArr.length] = $1;
				});
				if('where' == tmpArr[0]) {
					if('min' == tmpArr[2]) {
						minv = parseInt(frmObj.elements[i].value);
						if(isNaN(minv)) {
							continue;
						}
						whereArr.push("`" + tableName + "`.`" + tmpArr[1] + "`>'" + minv + "'");
					} else if('max' == tmpArr[2]) {
						maxv = parseInt(frmObj.elements[i].value);
						if(isNaN(maxv)) {
							continue;
						}
						whereArr.push("`" + tableName + "`.`" + tmpArr[1] + "`<'" + maxv + "'");
					} else {
						if(-1 != in_array(tmpArr[1], tableFields)) {
							whereArr.push("`" + tableName + "`.`" + tmpArr[1] + "` in ('" + ((frmObj.elements[i].value).split(',')).join("','") + "')");
						} else if('groupid' == tmpArr[1]) {
							groupid = parseInt(tmpArr[2]);
							if(isNaN(groupid) || !frmObj.elements[i].checked) {
								continue;
							}
							groupidArr.push(tmpArr[2]);
						} else if('fieldid' == tmpArr[1]) {
							fieldid = parseInt(tmpArr[2]);
							if(isNaN(fieldid) || !frmObj.elements[i].checked) {
								continue;
							}
							fieldidArr.push(tmpArr[2]);
						} else if('appid' == tmpArr[1]) {
							appid = parseInt(frmObj.elements[i].value);
							if(isNaN(appid)) {
								continue;
							}
							if(0 == appid) {
								whereArr.push("`" + tableName + "`.`" + tmpArr[1] + "`='0'");
							} else {
								whereArr.push("`" + tableName + "`.`" + tmpArr[1] + "`>'0'");
							}
						} else if('sex' == tmpArr[1]) {
							whereArr.push("`spacefield`.`sex`='" + parseInt(frmObj.elements[i].value) + "'");
						} else if(-1 != in_array(tmpArr[1], timeFields)) {
							if(0 < frmObj.elements[i].value) {
								whereArr.push("`" + tableName + "`.`" + tmpArr[1] + "`>'[" + frmObj.elements[i].value + "]'");
							}
						} else {
							whereArr.push("`" + tableName + "`.`" + tmpArr[1] + "`='" + frmObj.elements[i].value + "'");
						}
					}
				} else if('order' == tmpArr[0]) {
					if('key' == tmpArr[1]) {
						orderKeys[frmObj.elements[i].value] = tmpArr[2];
					} else if('value' == tmpArr[1]) {
						orderValues[tmpArr[2]] = frmObj.elements[i].value;
					}
				}
			}
		}
		if(0 < groupidArr.length) {
			whereArr.push("`" + tableName + "`.`groupid` in ('" + groupidArr.join("','") + "')");
		}
		if(0 < fieldidArr.length) {
			whereArr.push("`" + tableName + "`.`fieldid` in ('" + fieldidArr.join("','") + "')");
		}
		for(var i in orderKeys) {
			if(null != orderValues[orderKeys[i]]) {
				orderArr.push("`" + tableName + "`.`" + i + "` " + orderValues[orderKeys[i]]);
			}
		}
		// 如果是只使用了ID，则把where清空
		if($(curMod + '_ids') && 'none' != $(curMod + '_ids').style.display) {
			whereArr.length = 0;
			var whereId = $(curMod + '_where_' + $(curMod + '_id').value).value;
			if('' != whereId) {
				whereArr.push("`" + tableName + "`.`" + $(curMod + '_id').value + "` in ('" + (whereId.split(",")).join("','") + "')");
			}
		}
		if(0 < whereArr.length) {
			whereOrder += ' WHERE ' + whereArr.join(' AND ');
		}
		if(0 < orderArr.length) {
			whereOrder += " ORDER BY " + orderArr.join(", ");
		}
		$('blocksql').value = sqls[tableName].replace(/WHEREORDER/g, whereOrder);
	}
	function in_array(ineedle, haystack, caseinsensitive) {
		var needle = new String(ineedle);
		if(needle.Length == 0) return -1;
		if(caseinsensitive) {
			needle = needle.toLowerCase();
			for(var i in haystack)	{
				if(haystack[i].toLowerCase() == needle) {
					return i;
				}
			}
		} else {
			for(var i in haystack)	{
				if(haystack[i] == needle) {
					return i;
				}
			}
		}
		return -1;
	}
	function setRadioValue(showid, hiddenid) {
		if($(showid)) {
			$(showid).style.display = '';
		}
		if($(hiddenid)) {
			$(hiddenid).style.display = 'none';
		}
	}
	function showSQLDiv(sid) {
		var sObj = $(sid);
		if('' != curMod) {
			$(curMod).style.display = 'none';
			$('li_' + curMod).className = '';
		}
		$('li_' + sid).className = 'active';
		sObj.style.display = '';
		curMod = sid;
	}
	//////JSTL脚本//////
	<c:choose>
	<c:when test="${param.op == 'blocksql'}">
	$('sqlDiy').style.display = '';
	</c:when>
	<c:otherwise>
	$('sqlGuide').style.display = '';
	showSQLDiv('${sqltables.blog}');
	</c:otherwise>
	</c:choose>
	</script>
	</form>
	<br />
	<div class="bdrcontent">
		<div class="title">
			<h3>数据字典参考</h3>
			<p>以下是本程序的数据库的数据表名以及字段列表，供你编写查询语句的时候参考。</p>
		</div>
		<c:forEach items="${tables}" var="m">
		<br />
		<ul class="listcol list4col">
			<b>${m.key}</b>
			<c:forEach items="${m.value}" var="subvalue">
			<li>${subvalue.value}</li>
			</c:forEach>
		</ul>
		</c:forEach>
	</div>
</c:when>

<c:when test="${param.op == 'code'}">
	<form method="post" action="${turl}">
	<input type="hidden" name="formhash" value="${formhash}" />
	<div class="bdrcontent">
	<table cellspacing="0" cellpadding="0" class="formtable">
	<tr><th style="width:10em;">查询SQL语句</th><td>
	${block.blocksql}
	<br />[<a href="${turl}&op=blocksql&id=${block.bid}">编辑SQL</a>]
	</td></tr>
	<tr><th>变量名</th><td>sBlock.<input type="text" name="cachename" id="cachename" value="${block.cachename}" style="width: 60px;"></td></tr>
	<tr><th>缓存时间</th><td><input type="text" name="cachetime" value="${block.cachetime}" size="5"> 秒
		<br />设置一个缓存时间间隔，该模块数据将自动在指定的时间间隔内更新数据。
		<br />缓存时间设置越大，对服务器的负载就越小，但数据的及时性就不够。
		<br />设置为0，则不使用缓存，实时更新，这样会严重增加服务器负载。</td></tr>
	<tr><th>获取数目</th><td>
		<input id="ra_start_num" name="num_option" type="radio" onclick="show_num_option()" ${block.perpage == 0 ? "checked=checked" : ""}><label for="ra_start_num">获取满足条件的部分数据</label>
		&nbsp;&nbsp;
		<input id="ra_perpage" name="num_option" type="radio" onclick="show_num_option()" ${block.perpage != 0 ? "checked=checked" : ""}><label for="ra_perpage">获取全部数据，分页显示</label><br />
		<p id="op_start_num" ${block.perpage != 0 ? "style=display:none" : ""}>
			获取满足条件的第<input type="text" name="startnum" value="${block.startnum}" size="5"> 至 <input type="text" name="num" value="${block.num}" size="5"> 条数据
		</p>
		<p id="op_perpage" ${block.perpage == 0 ? "style=display:none" : ""}>
			每页显示 <input type="text" name="perpage" value="${block.perpage}" size="5"> 条
		</p>
		</td></tr>
	<tr><th>数据显示HTML代码</th><td>
		<textarea name="htmlcode" id="htmlcode" style="width:98%;" rows="10">${block.htmlcode}</textarea>
		<br />用JSTL和html语言，编写数据的显示样式。
		<br />获取到的数据存放在数组 sBlock.变量名 中(将“变量名”替换为你在上面设定的变量名)，可以使用 forEach 语法对该数组变量进行循环展示。
	</td></tr>
	<c:if test="${not empty colnames}">
	<tr><th>数据预览</th><td>
		<input type="button" class="submit" id="preview" name="preview" value="预览" />
		<div id="previewBlock" style="border:1px solid #BBB;padding:2px;margin-top:3px;">数据预览</div></td></tr>
	<tr><th>可调用字段实例</th>
	<td>
		<table cellspacing="1" cellpadding="0" bgcolor="#CCCCCC">
		<tr bgcolor="#F3F3F3"><th>&nbsp;字段名 </th><th>&nbsp;数据实例&nbsp;</th></tr>
		<c:forEach items="${colname}" var="m">
		<tr><td bgcolor="#F5F5F5">&nbsp;${m}&nbsp;</td><td bgcolor="#FFFFFF">&nbsp;${colnames[m]}&nbsp;</td></tr>
		</c:forEach>
		</table>
	</td></tr>
	</c:if>
	</table>
	</div>
	<div class="footactions">
		<input type="hidden" name="bid" value="${block.bid}">
		<input type="submit" name="codesubmit" value="提交" class="submit">
	</div>
	</form>
	<script language="javascript" type="text/javascript">
	$('cachename').onkeyup = function() {
		var blockReg = new RegExp('\\$\\_SBLOCK\\[(.*?)\\]', 'ig');
		var cname = $('cachename').value;
		var htmvalue = $('htmlcode').value;
		htmvalue = htmvalue.replace(blockReg, function($0, $1) {
			$1 = cname;
			return '$' + '_SBLOCK[' + $1 + ']';
		});
		$('htmlcode').value = htmvalue;
	}
	<c:if test="${not empty colnames_slash}">
		var colname = {};
		<c:forEach items="${colnames_slash}" var="m">
			colname['${m.key}'] = "${m.value}";
		</c:forEach>
		$('preview').onclick = function() {
			var html = $('htmlcode').value;
			var loopReg2 = /\<c\:forEach\s+items\=\"(\S+)\"\s+var\=\"(\S+)\"\>/ig;
			var varReg = /\\$(\{([a-zA-Z_]+)(\.){1}([a-zA-Z0-9_]+)\}*)/ig;
			var reg = '';
			html = html.replace(loopReg2, function($0, $1, $2) {
				reg = $2;
				return '';
			});
			eval(reg + ' = colname');
			html = html.replace(varReg, function($0, $1, $2, $3,$4) {
				key = $4.match(/(\w+)/ig);
				return eval($2 + '["' + key + '"]');
			});
			$('previewBlock').innerHTML = html;
		}
	</c:if>
	function show_num_option(){
		if($('ra_perpage').checked) {
			var inputs = $('op_start_num').getElementsByTagName('input');
			for(var i = 0, L=inputs.length; i < L; i++) {
				inputs[i].value = '0';
			}
			$('op_perpage').style.display = "";
			$('op_start_num').style.display = "none";
		} else {
			var inputs = $('op_perpage').getElementsByTagName('input');
			for(var i = 0, L=inputs.length; i < L; i++) {
				inputs[i].value = '0';
			}
			$('op_perpage').style.display = "none";
			$('op_start_num').style.display = "";	
		}
	}
	</script>
</c:when>

<c:when test="${param.op == 'tpl'}">
	<div class="bdrcontent">
	<div class="title"><h3>模版调用代码</h3></div>
	<table cellspacing="0" cellpadding="0" width="100%">
	<tr><td>请将以下代码复制，放到站点模板的任意页面的指定位置即可。</td></tr>
	<tr><td><input type="text" name="blockcode" value="${code}" size="80"></td></tr>
	</table>
	</div>
</c:when>

<c:when test="${param.op == 'js'}">
	<div class="bdrcontent">
	<div class="title"><h3>Javascript调用代码</h3></div>
	<table cellspacing="0" cellpadding="0" width="100%">
	<tr><td><textarea name="blockcode" style="width:98%;" rows="5">${code}</textarea></td></tr>
	</table>
	</div>
</c:when>
</c:choose>
</div>
</div>

<div class="side">
	<jsp:directive.include file="side.jsp" />
</div>

<jsp:directive.include file="footer.jsp" />