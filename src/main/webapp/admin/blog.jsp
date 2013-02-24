<%@ page language="java" pageEncoding="UTF-8"%>
<jsp:directive.include file="header.jsp" />
<div class="mainarea">
   <form method="post" id="batchform" action="backstage.action?ac=blog">
 <div class="maininner">
     <div id="inlog_menu">
      <table cellspacing="3" cellpadding="3" class="block style4">
     <c:if test="${allowmanage}">
      <tr>
       <th>作者UID</th>
       <td><input type="text" name="uid" value="${param.uid}"></td>
       <th>作者名</th>
       <td><input type="text" name="username" value="${param.username}"></td>
      </tr>
     </c:if>
     <tr>
      <th>标题*</th>
      <td><input type="text" name="subject" value="${param.subject}"></td>
      <th>内容*</th>
      <td><input type="text" name="message" value="${param.message }"> *表示支持模糊查询</td>
     </tr>
     <tr>
      <th>公开性质</th>
      <td>
       <select name="friend">
        <option value="">不限</option>
        <option value="0"${param.friend == '0' ? " selected" : ""}>全站用户可见</option>
        <option value="1"${param.friend == '1' ? " selected" : ""}>全好友可见</option>
        <option value="2"${param.friend == '2' ? " selected" : ""}>仅指定的好友可见</option>
        <option value="3"${param.friend == '3' ? " selected" : ""}>仅自己可见</option>
        <option value="4"${param.friend == '4' ? " selected" : ""}>凭密码查看</option>
       </select>
      </td>
      <th>发布IP</th>
      <td colspan="3"><input type="text" name="postip" value="${param.postip}"></td>
     </tr>
     <tr>
      <th>指定日志ID</th>
      <td><input type="text" name="blogid" value="${param.blogid}"/></td>
      <th>日志分类ID</th>
      <td colspan="3"><input type="text" name="classid" value="${param.classid}"/></td>
     </tr>
     <tr>
      <th>推荐状态</th>
      <td colspan="3">
       <select name="recommend">
       	<option value="">不限</option>
       	<option value="Y" ${param.recommend == 'Y' ? " selected" : ""}>已推荐</option>
       	<option value="N" ${param.recommend == 'N' ? " selected" : ""}>取消推荐</option>
       </select>
      </td>
     </tr>
     <tr>
      <th>审核状态</th>
      <td colspan="3">
      	<select name="verify">
      		<option value="">不限</option>
      		<option value="Y" ${param.verify == 'Y' ? " selected" : ""}>待审核</option>
      		<option value="N" ${param.verify == 'N' ? " selected" : ""}>无需审核</option>
      	</select>
      </td>
     </tr>     
     <tr>
      <th>推荐数</th>
      <td colspan="3">
       <input type="text" name="recommendnum1" value="${param.recommendnum1}" size="10"> ~
       <input type="text" name="recommendnum2" value="${param.recommendnum2}" size="10">
      </td>
     </tr>
     <tr>
      <th>查看数</th>
      <td colspan="3">
       <input type="text" name="viewnum1" value="${param.viewnum1}" size="10"> ~
       <input type="text" name="viewnum2" value="${param.viewnum2}" size="10">
      </td>
     </tr>
     <tr>
      <th>回复数</th>
      <td colspan="3">
       <input type="text" name="replynum1" value="${param.replynum1}" size="10"> ~
       <input type="text" name="replynum2" value="${param.replynum2}" size="10">
      </td>
     </tr>
     <tr>
      <th>热度</th>
      <td colspan="3">
       <input type="text" name="hot1" value="${param.hot1}" size="10"> ~
       <input type="text" name="hot2" value="${param.hot2}" size="10">
      </td>
     </tr>
     <tr>
      <th>发布时间</th>
      <td colspan="3">
       <input type="text" name="dateline1" value="${param.dateline1 }" size="10"> ~
       <input type="text" name="dateline2" value="${param.dateline2 }" size="10"> (YYYY-MM-DD)
      </td>
     </tr>
     <tr>
      <th>结果排序</th>
      <td colspan="3">
       <select name="orderby">
        <option value="">默认排序</option>
        <option value="dateline"${orderby_dateline}>发布时间</option>
        <option value="recommendnum"${orderby_recommendnum}>推荐数</option>
        <option value="viewnum"${orderby_viewnum}>查看数</option>
        <option value="replynum"${orderby_replynum}>回复数</option>
        <option value="hot"${orderby_hot}>热度</option>
       </select>
       <select name="ordersc">
        <option value="desc"${ordersc_desc}>递减</option>
        <option value="asc"${ordersc_asc}>递增</option>
       </select>
       <select name="perpage">
        <option value="20"${perpage_20}>每页显示20个</option>
        <option value="50"${perpage_50}>每页显示50个</option>
        <option value="100"${perpage_100}>每页显示100个</option>
        <option value="1000"${perpage_1000}>一次处理1000个</option>
       </select>
       <input type="submit" name="searchsubmit" value="确定" class="submit">
      </td>
     </tr>
    </table>
   </div>
  <c:choose><c:when test="${not empty list}">
    <input type="hidden" name="page" value="${page}" />
    <input type="hidden" name="formhash" value="${FORMHASH}" />
    <input id="batchsubmit" type="hidden" name="batchsubmit" value="" />
    <div class="bdrcontent">
     <c:choose><c:when test="${perpage>100}">
      <p>总共有满足条件的数据 <strong>${count}</strong> 个</p>
      <c:forEach items="${list}" var="value">
       <input type="hidden" name="ids" value="${value.blogid}">
      </c:forEach>
     </c:when><c:otherwise>
      <table cellspacing="0" cellpadding="0" class="formtable">
       <tr><td width="25">&nbsp;</td><th>标题</th><th width="80">操作</th></tr>
       <c:forEach items="${list}" var="value">
        <tr>
         <td><input type="${allowbatch ? 'checkbox' : 'radio'}" name="ids" value="${value.blogid}"></td>
         <td>
          <a href="zone.action?uid=${value.uid }&do=blog&id=${value.blogid }" target="_blank">
          	${value.subject }
          </a>
          <c:if test="${value.friend>0}">[<a href="backstage.action?ac=blog&friend=${value.friend}">${value.friendTitle}</a>]</c:if>
          <p class="gray">
           <a href="backstage.action?ac=blog&uid=${value.uid }">${value.username}</a><c:if test="${not empty value.postip}">(<a href="backstage.action?ac=blog&postip=${value.postip}">${value.postip}</a>)</c:if>
           &nbsp;${value.dateline}
           <br>推荐(${value.recommendnum}) / 热度(${value.hot}) / 回复(${value.replynum}) / 查看(${value.viewnum})
          </p>
         </td>
         <td>
          <div>
	          <a href="main.action?ac=blog&op=edit&blogid=${value.blogid}" target="_blank">编辑</a>&nbsp;
	          <a href="backstage.action?ac=comment&id=${value.blogid }&idtype=blogid">评论</a>
          </div>
          <div>
          	<span class="gray">
          	<c:if test="${value.verify=='Y'}">
          		待审核 
          	</c:if>
          	<c:if test="${value.recommend=='Y'}">
          		已推荐
          	</c:if>
          	</span>
          </div>
         </td>
        </tr>
       </c:forEach>
      </table>
     </c:otherwise></c:choose>
    </div>
    <div class="footactions">
     <c:if test="${allowbatch && perpage<=100}"><input type="checkbox" id="chkall" name="chkall" onclick="checkAll(this.form, 'ids')">全选</c:if>
     <input type="hidden" name="mpurl" value="${mpurl}">
     <input type="button"  value="批量删除" onclick="if( confirm('本操作不可恢复，确认删除？') ) {jQuery('#batchsubmit').val('批量删除'); jQuery('#batchform').submit() } return ;" class="submit">
     <input type="button"  value="批量审核通过" onclick="if( confirm('确认通过审核？') ) {jQuery('#batchsubmit').val('批量审核通过'); jQuery('#batchform').submit() } return ;" class="submit">
     <input type="button"  value="批量进行审核" onclick="if( confirm('确认进行审核？') ) {jQuery('#batchsubmit').val('批量进行审核'); jQuery('#batchform').submit() } return ;" class="submit">
     <input type="button"  value="批量推荐" onclick="if( confirm('确认推荐？') ) {jQuery('#batchsubmit').val('批量推荐'); jQuery('#batchform').submit() } return ;" class="submit">
     <input type="button"  value="批量取消推荐" onclick="if( confirm('确认取消推荐？') ) {jQuery('#batchsubmit').val('批量取消推荐'); jQuery('#batchform').submit() } return ;" class="submit">
     <div class="pages">${multi}</div>
    </div>
  </c:when><c:otherwise>
   <div class="bdrcontent"><p>指定条件下还没有数据</p></div>
  </c:otherwise></c:choose>
 </div>
   </form>
</div>
<div class="side">
 <jsp:directive.include file="side.jsp" />
</div>
<jsp:directive.include file="footer.jsp" />