<%@ page language="java"  pageEncoding="UTF-8"%>
<jsp:directive.include file="header.jsp" />
<div class="mainarea">
 <div class="maininner">
<c:choose>
 <c:when test="${menus.menu0.config == 1}">
  <div class="bdrcontent">
   <div class="title"><h3>欢迎光临社区管理平台</h3></div>
   <div id="customerinfor" style="line-height:1.5em;"></div><br />
   <ul class="listcol list2col"></ul>
  </div><br />
  <div class="bdrcontent">
   <div class="title">
    <h3>站点数据统计</h3>
    <p>通过站点统计，您可以整体把握站点的发展状况。</p>
    <p>您还可以查看<a href="operate.action?ac=stat" target="_blank">趋势统计</a>，把握站点每日变化。</p>
   </div>
   <ul class="listcol list2col">
    <li>开通空间数: ${statistics.spacenum} (<a href="operate.action?ac=stat&type=login" target="_blank">趋势</a>)</li>
    <li>全部动态数: ${statistics.feednum}</li>
    <li>全部日志数: ${statistics.blognum} (<a href="operate.action?ac=stat&type=blog" target="_blank">趋势</a>)</li>
    <li>全部相册数: ${statistics.albumnum} (<a href="operate.action?ac=stat&type=pic" target="_blank">趋势</a>)</li>
    <li>全部分享数: ${statistics.sharenum} (<a href="operate.action?ac=stat&type=share" target="_blank">趋势</a>)</li>
    <li>全部话题数: ${statistics.threadnum} (<a href="operate.action?ac=stat&type=thread" target="_blank">趋势</a>)</li>
    <li>全部评论数: ${statistics.commentnum}</li>
    <li>开启应用数: ${statistics.myappnum}</li>
   </ul>
  </div><br />
  <div class="bdrcontent">
   <div class="title"><h3>程序数据库/版本</h3></div>
   <ul>
    <li>操作系统: ${os}</li>
    <li>服务器软件: ${serverInfo}</li>
    <li>数据库版本: ${statistics.mysql}</li>
    <li>上传许可: ${fileupload}</li>
    <li>数据库尺寸: ${dbsize}</li>
    <li>附件尺寸: ${attachsize}</li>
    <li>当前程序版本: ${statistics.version} ( ${statistics.release} )</li>
   </ul>
  </div>
 </c:when>
 <c:otherwise>
  <div class="bdrcontent">
   <div class="title"><h3>批量管理</h3></div>
   <p>对发布的信息进行批量管理</p><br />
   <div class="title"><h3>快捷管理菜单</h3></div>
   <ul class="listcol list2col">
    <c:if test="${menus.menu1.space == 1}"><li><a href="backstage.action?ac=space" style="font-weight:bold;">用户</a><p>编辑用户的积分、用户组、管理空间信息、删除用户</p></li></c:if>
    <li><a href="backstage.action?ac=feed" style="font-weight:bold;">事件</a><p>对&quot;我在做什么&quot;进行批量删除</p></li>
    <li><a href="backstage.action?ac=blog" style="font-weight:bold;">日志</a><p>对日志进行批量删除、编辑</p></li>
    <li><a href="backstage.action?ac=album" style="font-weight:bold;">相册</a><p>对发布的相册进行批量删除</p></li>
    <li><a href="backstage.action?ac=pic" style="font-weight:bold;">图片</a><p>对发布的图片进行批量删除</p></li>
    <li><a href="backstage.action?ac=comment" style="font-weight:bold;">评论</a><p>对发布的评论进行批量删除</p></li>
    <li><a href="backstage.action?ac=thread" style="font-weight:bold;">话题</a><p>对群组上面发布的话题进行批量删除、精华、置顶</p></li>
    <li><a href="backstage.action?ac=post" style="font-weight:bold;">回帖</a><p>对群组上面发布的回帖进行批量删除</p></li>
    <li><a href="backstage.action?ac=poll" style="font-weight:bold;">投票</a><p>对投票进行批量删除</p></li>
    <c:if test="${menus.menu1.tag == 1}"><li><a href="backstage.action?ac=tag" style="font-weight:bold;">标签</a><p>对站点的标签进行删除、关闭、合并</p></li></c:if>
    <c:if test="${menus.menu1.mtag == 1}"><li><a href="backstage.action?ac=mtag" style="font-weight:bold;">群组</a><p>对站点的群组进行删除、关闭、合并</p></li></c:if>
    <c:if test="${menus.menu1.event == 1}"><li><a href="backstage.action?ac=event" style="font-weight:bold;">活动</a><p>对站点的活动进行删除、审核、推荐</p></li></c:if>
    <c:if test="${menus.menu1.css == 1}"><li><a href="backstage.action?ac=css" style="font-weight:bold;">模版样式</a><p>对站点共享的模版样式进行批量审核、删除</p></li></c:if>
   </ul>
  </div><br />
 </c:otherwise>
</c:choose>
 </div><br>
</div>
<div class="side">
 <jsp:directive.include file="side.jsp" />
</div>
<jsp:directive.include file="footer.jsp" />