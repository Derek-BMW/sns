<%@ page language="java" pageEncoding="UTF-8"%>
<jsp:directive.include file="header.jsp" />
<div class="mainarea">
	<div class="maininner">
		<form method="post" action="backstage.action?ac=home">
			<input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,true)}" />
			<div class="title">
				<h1>社区首页配置</h1>
			</div>
			<div class="bdrcontent">
				<div class="title">
					<h3>日志聚合设置</h3>
					<p>设置日志显示在社区首页的条件</p>
				</div>
				<table cellspacing="0" cellpadding="0" class="formtable">
					<tr>
						<td style="width: 10em;">指定日志(blogid)</td>
						<td><input name="home[blog][blogid]" type="text" size="50" value="${globalHome.blog.blogid}" /> 多个blogid用","分隔</td>
					</tr>
					<tr>
						<td>指定作者(uid)</td>
						<td><input name="home[blog][uid]" type="text" size="50" value="${globalHome.blog.uid}" /> 多个uid用","分隔</td>
					</tr>
					<tr>
						<td>热度范围</td>
						<td>
							<input name="home[blog][hot1]" type="text" size="10" value="${globalHome.blog.hot1}" /> ~
							<input name="home[blog][hot2]" type="text" size="10" value="${globalHome.blog.hot2}" />
						</td>
					</tr>
					<tr>
						<td>查看数范围</td>
						<td>
							<input name="home[blog][viewnum1]" type="text" size="10" value="${globalHome.blog.viewnum1}" /> ~
							<input name="home[blog][viewnum2]" type="text" size="10" value="${globalHome.blog.viewnum2}" />
						</td>
					</tr>
					<tr>
						<td>回复数范围</td>
						<td>
							<input name="home[blog][replynum1]" type="text" size="10" value="${globalHome.blog.replynum1}" /> ~
							<input name="home[blog][replynum2]" type="text" size="10" value="${globalHome.blog.replynum2}" />
						</td>
					</tr>
					<tr>
						<td>发布时间范围</td>
						<td><input type="text" name="home[blog][dateline]" value="${globalHome.blog.dateline}" size="10"> 内天发布的才显示</td>
					</tr>
					<tr>
						<td>列表排序</td>
						<td>
							<select name="home[blog][order]">
								<option value="dateline">发布时间</option>
								<option value="viewnum"${orders.order_blog_viewnum}>查看数</option>
								<option value="replynum"${orders.order_blog_replynum}>回复数</option>
								<option value="hot"${orders.order_blog_hot}>热度</option>
							</select>
							<select name="home[blog][sc]">
								<option value="desc">递减</option>
								<option value="asc"${orders.sc_blog_asc}>递增</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>缓存有效时间</td>
						<td><input type="text" name="home[blog][cache]" value="${globalHome.blog.cache}" size="10"> 单位:秒 (设为0将不使用缓存机制，这会增加服务器负担)</td>
					</tr>
				</table>
				<br>
				<div class="title">
					<h3>图片聚合设置</h3>
					<p>设置图片显示在社区首页的条件</p>
				</div>
				<table cellspacing="0" cellpadding="0" class="formtable">
					<tr>
						<td style="width: 10em;">指定图片(picid)</td>
						<td><input name="home[pic][picid]" type="text" size="50" value="${globalHome.pic.picid}" /> 多个picid用","分隔</td>
					</tr>
					<tr>
						<td>指定作者(uid)</td>
						<td><input name="home[pic][uid]" type="text" size="50" value="${globalHome.pic.uid}" /> 多个uid用","分隔</td>
					</tr>
					<tr>
						<td>热度范围</td>
						<td>
							<input name="home[pic][hot1]" type="text" size="10" value="${globalHome.pic.hot1}" /> ~
							<input name="home[pic][hot2]" type="text" size="10" value="${globalHome.pic.hot2}" />
						</td>
					</tr>
					<tr>
						<td>发布时间范围</td>
						<td><input type="text" name="home[pic][dateline]" value="${globalHome.pic.dateline}" size="10"> 内天发布的才显示</td>
					</tr>
					<tr>
						<td>列表排序</td>
						<td>
							<select name="home[pic][order]">
								<option value="dateline">发布时间</option>
								<option value="hot"${orders.order_pic_hot }>热度</option>
							</select>
							<select name="home[pic][sc]">
								<option value="desc">递减</option>
								<option value="asc"${orders.sc_pic_asc }>递增</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>缓存有效时间</td>
						<td><input type="text" name="home[pic][cache]" value="${globalHome.pic.cache}" size="10"> 单位:秒 (设为0将不使用缓存机制，这会增加服务器负担)</td>
					</tr>
				</table>
				<br>
				<div class="title">
					<h3>话题聚合设置</h3>
					<p>设置话题显示在社区首页的条件</p>
				</div>
				<table cellspacing="0" cellpadding="0" class="formtable">
					<tr>
						<td style="width: 10em;">指定话题(tid)</td>
						<td><input name="home[thread][tid]" type="text" size="50" value="${globalHome.thread.tid}" /> 多个tid用","分隔</td>
					</tr>
					<tr>
						<td>指定作者(uid)</td>
						<td><input name="home[thread][uid]" type="text" size="50" value="${globalHome.thread.uid}" /> 多个uid用","分隔</td>
					</tr>
					<tr>
						<td>热度范围</td>
						<td>
							<input name="home[thread][hot1]" type="text" size="10" value="${globalHome.thread.hot1}" /> ~
							<input name="home[thread][hot2]" type="text" size="10" value="${globalHome.thread.hot2}" />
						</td>
					</tr>
					<tr>
						<td>查看数范围</td>
						<td>
							<input name="home[thread][viewnum1]" type="text" size="10" value="${globalHome.thread.viewnum1}" /> ~
							<input name="home[thread][viewnum2]" type="text" size="10" value="${globalHome.thread.viewnum2}" />
						</td>
					</tr>
					<tr>
						<td>回复数范围</td>
						<td>
							<input name="home[thread][replynum1]" type="text" size="10" value="${globalHome.thread.replynum1}" /> ~
							<input name="home[thread][replynum2]" type="text" size="10" value="${globalHome.thread.replynum2}" />
						</td>
					</tr>
					<tr>
						<td>发布时间范围</td>
						<td><input type="text" name="home[thread][dateline]" value="${globalHome.thread.dateline}" size="10"> 内天发布的才显示</td>
					</tr>
					<tr>
						<td>回复时间范围</td>
						<td><input type="text" name="home[thread][lastpost]" value="${globalHome.thread.lastpost}" size="10"> 内天回复的才显示</td>
					</tr>
					<tr>
						<td>列表排序</td>
						<td>
							<select name="home[thread][order]">
								<option value="dateline">发布时间</option>
								<option value="viewnum"${orders.order_thread_viewnum }>查看数</option>
								<option value="replynum"${orders.order_thread_replynum }>回复数</option>
								<option value="hot"${orders.order_thread_hot }>热度</option>
							</select>
							<select name="home[thread][sc]">
								<option value="desc">递减</option>
								<option value="asc"${orders.sc_thread_asc }>递增</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>缓存有效时间</td>
						<td><input type="text" name="home[thread][cache]" value="${globalHome.thread.cache}" size="10"> 单位:秒 (设为0将不使用缓存机制，这会增加服务器负担)</td>
					</tr>
				</table>
				<br>
				<div class="title">
					<h3>活动聚合设置</h3>
					<p>设置活动显示在社区首页的条件</p>
				</div>
				<table cellspacing="0" cellpadding="0" class="formtable">
					<tr>
						<td style="width: 10em;">指定活动(eventid)</td>
						<td><input name="home[event][eventid]" type="text" size="50" value="${globalHome.event.eventid}" /> 多个eventid用","分隔</td>
					</tr>
					<tr>
						<td>指定作者(uid)</td>
						<td><input name="home[event][uid]" type="text" size="50" value="${globalHome.event.uid}" /> 多个uid用","分隔</td>
					</tr>
					<tr>
						<td>热度范围</td>
						<td>
							<input name="home[event][hot1]" type="text" size="10" value="${globalHome.event.hot1}" /> ~
							<input name="home[event][hot2]" type="text" size="10" value="${globalHome.event.hot2}" />
						</td>
					</tr>
					<tr>
						<td>参与人数范围</td>
						<td>
							<input name="home[event][membernum1]" type="text" size="10" value="${globalHome.event.membernum1}" /> ~
							<input name="home[event][membernum2]" type="text" size="10" value="${globalHome.event.membernum2}" />
						</td>
					</tr>
					<tr>
						<td>关注人数范围</td>
						<td>
							<input name="home[event][follownum1]" type="text" size="10" value="${globalHome.event.follownum1}" /> ~
							<input name="home[event][follownum2]" type="text" size="10" value="${globalHome.event.follownum2}" />
						</td>
					</tr>
					<tr>
						<td>发布时间范围</td>
						<td><input type="text" name="home[event][dateline]" value="${globalHome.event.dateline}" size="10"> 内天发布的才显示</td>
					</tr>
					<tr>
						<td>列表排序</td>
						<td>
							<select name="home[event][order]">
								<option value="dateline">发布时间</option>
								<option value="membernum"${orders.order_event_membernum }>参与人数</option>
								<option value="follownum"${orders.order_event_follownum }>关注人数</option>
								<option value="hot"${orders.order_event_hot }>热度</option>
							</select>
							<select name="home[event][sc]">
								<option value="desc">递减</option>
								<option value="asc"${orders.sc_event_asc }>递增</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>缓存有效时间</td>
						<td><input type="text" name="home[event][cache]" value="${globalHome.event.cache}" size="10"> 单位:秒 (设为0将不使用缓存机制，这会增加服务器负担)</td>
					</tr>
				</table>
				<br>
				<div class="title">
					<h3>投票聚合设置</h3>
					<p>设置投票显示在社区首页的条件</p>
				</div>
				<table cellspacing="0" cellpadding="0" class="formtable">
					<tr>
						<td style="width: 10em;">指定投票(pid)</td>
						<td><input name="home[poll][pid]" type="text" size="50" value="${globalHome.poll.pid}" /> 多个pid用","分隔</td>
					</tr>
					<tr>
						<td>指定作者(uid)</td>
						<td><input name="home[poll][uid]" type="text" size="50" value="${globalHome.poll.uid}" /> 多个uid用","分隔</td>
					</tr>
					<tr>
						<td>热度范围</td>
						<td>
							<input name="home[poll][hot1]" type="text" size="10" value="${globalHome.poll.hot1}" /> ~
							<input name="home[poll][hot2]" type="text" size="10" value="${globalHome.poll.hot2}" />
						</td>
					</tr>
					<tr>
						<td>投票人数范围</td>
						<td>
							<input name="home[poll][voternum1]" type="text" size="10" value="${globalHome.poll.voternum1}" /> ~
							<input name="home[poll][voternum2]" type="text" size="10" value="${globalHome.poll.voternum2}" />
						</td>
					</tr>
					<tr>
						<td>回复人数范围</td>
						<td>
							<input name="home[poll][replynum1]" type="text" size="10" value="${globalHome.poll.replynum1}" /> ~
							<input name="home[poll][replynum2]" type="text" size="10" value="${globalHome.poll.replynum2}" />
						</td>
					</tr>
					<tr>
						<td>发布时间范围</td>
						<td><input type="text" name="home[poll][dateline]" value="${globalHome.poll.dateline}" size="10"> 内天发布的才显示</td>
					</tr>
					<tr>
						<td>列表排序</td>
						<td>
							<select name="home[poll][order]">
								<option value="dateline">发布时间</option>
								<option value="voternum"${orders.order_poll_voternum }>参与人数</option>
								<option value="replynum"${orders.order_poll_replynum }>关注人数</option>
								<option value="hot"${orders.order_poll_hot }>热度</option>
							</select>
							<select name="home[poll][sc]">
								<option value="desc">递减</option>
								<option value="asc"${orders.sc_poll_asc }>递增</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>缓存有效时间</td>
						<td><input type="text" name="home[poll][cache]" value="${globalHome.poll.cache}" size="10"> 单位:秒 (设为0将不使用缓存机制，这会增加服务器负担)</td>
					</tr>
				</table>
				<br>
				<div class="title">
					<h3>分享聚合设置</h3>
					<p>设置分享显示在社区首页的条件</p>
				</div>
				<table cellspacing="0" cellpadding="0" class="formtable">
					<tr>
						<td style="width: 10em;">指定分享(sid)</td>
						<td><input name="home[share][sid]" type="text" size="50" value="${globalHome.share.sid}" /> 多个sid用","分隔</td>
					</tr>
					<tr>
						<td>指定作者(uid)</td>
						<td><input name="home[share][uid]" type="text" size="50" value="${globalHome.share.uid}" /> 多个uid用","分隔</td>
					</tr>
					<tr>
						<td>热度范围</td>
						<td>
							<input name="home[share][hot1]" type="text" size="10" value="${globalHome.share.hot1}" /> ~
							<input name="home[share][hot2]" type="text" size="10" value="${globalHome.share.hot2}" />
						</td>
					</tr>
					<tr>
						<td>发布时间范围</td>
						<td><input type="text" name="home[share][dateline]" value="${globalHome.share.dateline}" size="10"> 内天分享的才显示</td>
					</tr>
					<tr>
						<td>列表排序</td>
						<td>
							<select name="home[share][order]">
								<option value="dateline">发布时间</option>
								<option value="hot"${orders.order_share_hot }>热度</option>
							</select>
							<select name="home[share][sc]">
								<option value="desc">递减</option>
								<option value="asc"${orders.sc_share_asc }>递增</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>缓存有效时间</td>
						<td><input type="text" name="home[share][cache]" value="${globalHome.share.cache}" size="10"> 单位:秒 (设为0将不使用缓存机制，这会增加服务器负担)</td>
					</tr>
				</table>
			</div>
			<div class="footactions"><input type="submit" name="homesubmit" value="提交" class="submit"></div>
		</form>
	</div>
</div>
<div class="side">
	<jsp:directive.include file="side.jsp" />
</div>
<jsp:directive.include file="footer.jsp" />