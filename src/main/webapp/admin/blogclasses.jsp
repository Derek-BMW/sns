<%@ page language="java" pageEncoding="UTF-8"%>
<jsp:directive.include file="header.jsp" />
<div class="mainarea">
 <div class="maininner">
  <div class="tabs_header">
   <ul class="tabs">
    <li${actives_view}><a href="backstage.action?ac=blogclasses"><span>全局日志分类</span></a></li>
    <li class="null"><a href="backstage.action?ac=blogclasses&op=add">添加新全局日志分类</a></li>
   </ul>
  </div>
  <c:choose>
   <c:when test="${op == 'delete'}">
    <form method="post" action="backstage.action?ac=blogclasses">
     <input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,true)}" />
     <input type="hidden" name="id" value="${blogclass.classid}" />
     <input type="hidden" name="op" value="delete" />
     <div class="bdrcontent">
      <div class="topactions">你确定需要删除这个[<strong>${blogclass.classname}</strong>] 全局日志分类吗? </div>
     </div>
     <div class="footactions"><input type="submit" name="submit" value="确定删除" class="submit"></div>
    </form>
   </c:when>
   <c:otherwise>
    <c:choose>
     <c:when test="${blogclass == null}">
      <form method="post" action="backstage.action?ac=profield">
       <input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,true)}" />
       <div class="bdrcontent">
        <table cellspacing="0" cellpadding="0" class="formtable">
         <tr><th>全局分类ID</th><th>全局分类名称</th><th width="80">操作</th></tr></tr>
         <c:forEach items="${blogclasses}" var="cls">
          <tr>
 			<th>${cls.classid}</th>          
           <th>${cls.classname}</th>
           <td width="80">
            <a href="backstage.action?ac=blogclasses&op=edit&id=${cls.classid}">编辑</a> |
            <a href="backstage.action?ac=blogclasses&op=delete&id=${cls.classid}">删除</a>
           </td>
          </tr>
         </c:forEach>
        </table>
       </div>
      </form>
     </c:when>
     <c:otherwise>
      <form method="post" action="backstage.action?ac=blogclasses">
       <input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,true)}" />
       <div class="bdrcontent">
        <table cellspacing="0" cellpadding="0" class="formtable">
         <tr>
          <th style="width: 15em;">类型名称</th>
          <td>
          	<input type="hidden" name="id" value="${blogclass.classid}" />
          	<input type="text" name="classname" value="${blogclass.classname}"/>
          </td>
         </tr>
        </table>
       </div>
       <div class="footactions"><input type="submit" name="submit" value="提交" class="submit"></div>
      </form>
     </c:otherwise>
    </c:choose>
   </c:otherwise>
  </c:choose>
 </div>
</div>
<div class="side">
 <jsp:directive.include file="side.jsp" />
</div>
<jsp:directive.include file="footer.jsp" />