<%@ page language="java" pageEncoding="UTF-8"%>
<jsp:directive.include file="header.jsp" />
<div class="mainarea">
	<div class="maininner">
		<div class="tabs_header">
			<ul class="tabs">
				<li${actives_view}><a href="backstage.action?ac=task"><span>浏览全部任务</span></a></li>
				<li class="null"><a href="backstage.action?ac=task&op=add">添加新任务</a></li>
			</ul>
		</div>
		<form method="post" action="backstage.action?ac=task&taskid=${taskid}">
			<input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,true)}" />
			<div class="bdrcontent">通过有奖任务，您可以实现引导站内的新人更好的完善自己的头像、资料和发表信息；还可以实现在节日期间给用户发送积分；用户定期领取积分红包等各种任务。有奖任务可以带动用户更容易的融入到站内的气氛中来。</div>
			<br>
			<c:choose>
				<c:when test="${op == 'edit' || op == 'add'}">
					<div class="bdrcontent">
						<table cellspacing="0" cellpadding="0" class="formtable">
							<tr>
								<th style="width: 12em;">有奖任务名</th>
								<td><input size="25" name="name" value="${thevalue.name}" type="text"></td>
							</tr>
							<tr>
								<th>有奖任务图片</th>
								<td><input size="100" name="image" value="${thevalue.image}" type="text"><br>输入有奖任务图片的URL地址，不要太大，建议长60px，宽60px的小图片</td>
							</tr>
							<tr>
								<th>有奖任务说明</th>
								<td><textarea name="note" rows="8" style="width: 90%;">${thevalue.note}</textarea><br>支持html代码，文字换行请使用&lt;br&gt;标签。</td>
							</tr>
							<tr>
								<th>有奖任务奖励积分</th>
								<td><input type="text" name="credit" value="${thevalue.credit}" size="10"><br>设置用户完成该有奖任务后可以获得的积分奖励。为0，则不奖励积分。</td>
							</tr>
							<tr>
								<th>有奖任务完成数限制</th>
								<td>
									<input type="text" name="maxnum" value="${thevalue.maxnum}" size="10"><br>设置该有奖任务最多可完成多少人次。超过该人次后，该有奖任务将自动失效。为0，则不限制。
									<c:if test="${thevalue.num > 0}"><br><b>目前该有奖任务已经完成 ${thevalue.num} 人次</b>。</c:if>
								</td>
							</tr>
							<tr>
								<th>有奖任务处理JSP脚本</th>
								<td>
									./source/task/<input size="25" name="filename" value="${thevalue.filename}" type="text">
									<br>不能包含路径，程序脚本必须存放于 ./source/task/ 目录中
									<br>本功能为高级应用，有奖任务脚本的编写，需要您懂一定JSP知识。
									<br>请参考系统自带的有奖任务脚本 ./source/task/sample.jsp 中的说明来编写。
								</td>
							</tr>
							<tr>
								<th>有效性</th>
								<td>
									<input type="radio" name="available" value="1"${availables_1}>有效
									<input type="radio" name="available" value="0"${availables_0}>无效
								</td>
							</tr>
							<tr>
								<th>开始日期</th>
								<td><input type="text" name="starttime" value="${thevalue.starttime}" size="25"> (格式：2008-08-08 00:00:00)<br>设置该有奖任务开始的日期。为空为立即开始。</td>
							</tr>
							<tr>
								<th>结束日期</th>
								<td><input type="text" name="endtime" value="${thevalue.endtime}" size="25"> (格式：2008-08-08 23:59:59)<br>设置该有奖任务结束的日期。为空为永久有效。</td>
							</tr>
							<tr>
								<th>用户重复执行周期</th>
								<td>
									<select name="nexttype" onchange="show_nexttime(this.value);">
										<option value="">不重复</option>
										<option value="day"${nexttypes_day}>每天</option>
										<option value="hour"${nexttypes_hour}>整点</option>
										<option value="time"${nexttypes_time}>间隔指定时间</option>
									</select>
									<span id="nexttime" style="display: ${nextimestyle};">间隔 <input type="text" name="nexttime" value="${thevalue.nexttime }" size="10"> 秒后可重复执行</span>
									<script>
									function show_nexttime(type) {
										if(type == 'time') {
											$('nexttime').style.display ='';
										} else {
											$('nexttime').style.display ='none';
										}
									}
									</script>
								</td>
							</tr>
							<tr>
								<th>优先顺序</th>
								<td><input type="text" name="displayorder" value="${thevalue.displayorder}" size="10"><br>数字越小，排序越靠前，优先级越高</td>
							</tr>
						</table>
					</div>
					<div class="footactions"><input type="submit" name="tasksubmit" value="提交" class="submit"></div>
				</c:when>
				<c:otherwise>
					<div class="bdrcontent">
						<table cellspacing="0" cellpadding="0" class="formtable">
							<tr>
								<th width="80">图片</th>
								<th>有奖任务名/有奖任务脚本</th>
								<th>积分奖励</th>
								<th>有效期</th>
								<th>操作</th>
							</tr>
							<c:forEach items="${tasks}" var="task">
								<tr>
									<td><img src="${task.image}" width="60" height="60"></td>
									<td>${task.name}<br>${task.filename}</td>
									<td>${task.credit}</td>
									<td><c:choose><c:when test="${task.available > 0}">${task.starttime}<br>${task.endtime}</c:when><c:otherwise>无效</c:otherwise></c:choose></td>
									<td><a href="backstage.action?ac=task&op=edit&taskid=${task.taskid}">编辑</a>&nbsp;|&nbsp;<a href="backstage.action?ac=task&op=delete&taskid=${task.taskid}">删除</a></td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</c:otherwise>
			</c:choose>
		</form>
	</div>
</div>
<div class="side">
	<jsp:directive.include file="side.jsp" />
</div>
<jsp:directive.include file="footer.jsp" />