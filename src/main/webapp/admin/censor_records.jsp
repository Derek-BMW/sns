<%@ page language="java" pageEncoding="UTF-8"%>
<jsp:directive.include file="header.jsp" />
<script language="javascript" type="text/javascript" src="source/jquery.min.js"></script>

<div class="mainarea">
	<div class="maininner">
		<div><strong>词语屏蔽记录清单(共 <c:out value="${censor_records_count}" /> 条):</strong></div>
		<div>
		<table width="100%">
			<thead>
				<tr>
				<td width="10%">ID</td>
				<td width="5%">类型</td>
				<td width="20%">状态</td>
				<td width="20%">更新时间</td>
				<td width="10%">用户</td>
				<td>操作</td>
				</tr>					
			</thead>
			<tbody>
			<c:forEach items="${censor_records}" var="record">
			<c:set var="url"></c:set>
			<c:set var="audit_url" value="backstage.action?ac=censor&subac=viewRecords&wsid=${record.id}&do=doaudit"></c:set>
				<tr>
					<td><c:out value="${record.id}" /></td>
					<td>
						<c:choose>
							<c:when test="${record.type=='doing'}">
								<c:set var="url" value="zone.action?uid=${record.modify_user_id}&do=${record.type}&doid=${record.item_id}&f=audit"></c:set>
								心情
							</c:when>
							<c:when test="${record.type=='blog'}">
								<c:set var="url" value="zone.action?uid=${record.modify_user_id}&do=${record.type}&id=${record.item_id}&f=audit"></c:set>
								日志
							</c:when>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${record.status=='n'}">发布+审核</c:when>
							<c:when test="${record.status=='b'}">审核</c:when>
						</c:choose>					
					</td>
					<td><c:out value="${record.create_date}" /></td>
					<td><c:out value="${record.username}" /></td>
					<td>
						<a href="#" onclick="window.open('<c:out value='${url}'/>'); return;" class="submit">查看详情</a> 
						<a href="<c:out value='${audit_url}'/>"  class="submit">通过审核</a>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		</div>
		<!-- page controller -->
		<div align="left">
			<%
				Integer count = (Integer)request.getAttribute("censor_records_count");
				Integer page_count = (Integer)request.getAttribute("page_count");
				Integer page_index = (Integer)request.getAttribute("page");
				Integer pages = count/page_count + (count%page_count > 0 ? 1 : 0);
				Integer max_pages = 10;
				boolean maxed = false;
			%>		
			<a href="backstage.action?ac=censor&subac=viewRecords&page=<%= page_index-1 < 0 ? 0 : page_index-1 %>" class="submit">上一页</a>
			<%
				for( int i= page_index-5 < 0 ? 0 : page_index-5; i<pages ; i++ ){
					if( i == page_index+max_pages ){
						%> ... <%
						break;
					}					
					%>
						<a href="backstage.action?ac=censor&subac=viewRecords&page=<%=i%>" class="submit" <% if(i==page_index){%>style="background:#aa0000;"<%}%>><%=i+1 %></a>
					<%
				}
			%>
			<a href="backstage.action?ac=censor&subac=viewRecords&page=<%= page_index+1 < pages ? page_index+1 : pages-1%>" class="submit">下一页</a>
		</div>
	</div>
</div>

<script type="text/javascript" lang="javascript">
	$("document").ready(function(){

	});
</script>

<div class="side">
	<jsp:directive.include file="side.jsp" />
</div>
<jsp:directive.include file="footer.jsp" />