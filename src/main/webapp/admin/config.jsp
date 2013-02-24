<%@ page language="java" pageEncoding="UTF-8"%>
<jsp:directive.include file="header.jsp" />
<div class="mainarea">
 <div class="maininner">
  <div class="tabs_header">
   <script language="javascript">
    function configShow(value) {
     for(var i=0 ; i <= 7 ; i++){
      if(i==value){
       $('title_'+i).className = 'active';
       $('config_'+i).style.display = '';
      }else{
       $('title_'+i).className = '';
       $('config_'+i).style.display = 'none';
      }
     }
    }
   </script>
   <ul class="tabs">
    <li id="title_0" class="active"><a href="backstage.action?ac=config#base"><span onclick="configShow('0')">基本设置</span></a></li>
    <li id="title_1"><a href="backstage.action?ac=config#sns"><span onclick="configShow('1')">系统功能</span></a></li>
    <li id="title_2"><a href="backstage.action?ac=config#register"><span onclick="configShow('2')">注册与显示</span></a></li>
    <li id="title_3"><a href="backstage.action?ac=config#name"><span onclick="configShow('3')">实名认证设置</span></a></li>
    <li id="title_4"><a href="backstage.action?ac=config#video"><span onclick="configShow('4')">视频认证设置</span></a></li>
    <li id="title_5"><a href="backstage.action?ac=config#upload"><span onclick="configShow('5')">上传图片设置</span></a></li>
    <!--
    <li id="title_7"><a href="backstage.action?ac=config#remote"><span onclick="configShow('7')">远程上传设置</span></a></li>
    -->
    <li id="title_6"><a href="backstage.action?ac=config#email"><span onclick="configShow('6')">邮件设置</span></a></li>
   </ul>
  </div>
  <form method="post" action="backstage.action?ac=config">
   <input type="hidden" name="formhash" value="${sns:formHash(sGlobal,sConfig,true)}">
   <div class="bdrcontent" id="config_0">
    <div class="title"><h3>基本设置</h3></div>
    <table class="formtable">
     <tr>
      <th style="width: 15em;">站点名称</th>
      <td><input type="text" name="config[sitename]" value="${configs.sitename}" size="50"></td>
     </tr>
     <tr>
      <th style="width: 15em;">站点关键字</th>
      <td><input type="text" name="config[keywords]" value="${configs.keywords}" size="50"></td>
     </tr>
      <tr>
      <th style="width: 15em;">站点描述</th>
      <td><input type="text" name="config[description]" value="${configs.description}" size="50"></td>
     </tr>
     
     <tr>
      <th>站点访问URL地址</th>
      <td><input type="text" name="config[siteallurl]" value="${configs.siteallurl}" size="50"><br>开启二级域名时需要使用，例如：http://sns.xxx.com/ ，末尾要加“/”</td>
     </tr>
     <tr>
      <th>站点模板</th>
      <td>
       <select name="config[template]"><c:forEach items="${templates}" var="template">
        <option value="${template}"${template == configs.template ? " selected" : ""}>${template}</option></c:forEach>
       </select><br>站点模板目录存放在 ./template 下面。其中 default 目录为默认风格，不能删除。
      </td>
     </tr>
     <tr>
      <th>站点联系邮箱</th>
      <td><input type="text" name="config[adminemail]" value="${configs.adminemail}" size="50"></td>
     </tr>
     <!-- 
     <tr>
      <th>服务器时区设置</th>
      <td>
       <select name="config[timeoffset]"><c:forEach items="${timeZoneIDs}" var="timeZoneID">
        <option value="${timeZoneID.key}" ${configs.timeoffset == timeZoneID.key ? "selected" : ""}>${timeZoneID.value[1]}</option></c:forEach>
       </select><br>根据服务器的时区配置进行选择，一般国内服务器为 GMT +08:00
      </td>
     </tr>
     -->
     <tr>
      <th>显示授权信息链接</th>
      <td>
       <input type="radio" name="config[licensed]" value="1" ${configs.licensed == 1 ? "checked" : ""}>是
       <input type="radio" name="config[licensed]" value="0" ${configs.licensed != 1 ? "checked" : ""}>否
      </td>
     </tr>
     <tr>
      <th>显示程序执行信息</th>
      <td>
       <input type="radio" name="config[debuginfo]" value="1" ${configs.debuginfo == 1 ? "checked" : ""}>是
       <input type="radio" name="config[debuginfo]" value="0" ${configs.debuginfo != 1 ? "checked" : ""}>否
      </td>
     </tr>
     <tr>
      <th>ICP/IP/域名备案</th>
      <td><input type="text" name="config[miibeian]" value="${configs.miibeian}" size="20"> (例如 京ICP备04000001号，显示在所有页面的最下面)</td>
     </tr>
     <tr>
      <th>强制使用默认字符集</th>
      <td>
       <input type="radio" name="config[headercharset]" value="1" ${configs.headercharset == 1 ? "checked" : ""}>是
       <input type="radio" name="config[headercharset]" value="0" ${configs.headercharset != 1 ? "checked" : ""}>否
       <br>可避免部分页面出现乱码，一般无需开启
      </td>
     </tr>
     <tr>
      <th>URL Rewrite</th>
      <td>
       <input type="radio" name="config[allowrewrite]" value="1" ${configs.allowrewrite == 1 ? "checked" : ""}>是
       <input type="radio" name="config[allowrewrite]" value="0" ${configs.allowrewrite != 1 ? "checked" : ""}>否
       <br>URL 静态化可以提高搜索引擎抓取，开启本功能会轻微增加服务器负担。
      </td>
     </tr>
     <tr>
      <th style="width: 15em;">记录在线时间</th>
      <td><input type="text" name="config[onlinehold]" value="${configs.onlinehold}" size="5"> (单位 秒)</td>
     </tr>
     <tr>
      <th>开启站点概况统计</th>
      <td>
       <input type="radio" name="config[updatestat]" value="1" ${configs.updatestat == 1 ? "checked" : ""}>是
       <input type="radio" name="config[updatestat]" value="0" ${configs.updatestat != 1 ? "checked" : ""}>否
       <br>建议开启，记录站点每日的登录人数、发表数、互动数等重点参数，可为站点运营发展提供重要数据依据
      </td>
     </tr>
     <!--
     <tr>
      <th>用户头像体系</th>
      <td>
       <input type="radio" name="config[avatarreal]" value="0" ${configs.avatarreal != 1 ? "checked" : ""}>使用头像体系1
       <input type="radio" name="config[avatarreal]" value="1" ${configs.avatarreal == 1 ? "checked" : ""}>使用头像体系2
       <br>用户头像分为两套体系(默认为体系1)，您可以选择在本系统内使用的头像体系，而在其他应用系统中使用相同或者不同的头像体系。<br>注意：修改本选项后，用户需要上传与体系对应的新头像。
      </td>
     </tr>
     -->
     <!--
     <tr>
      <th>社区的物理路径</th>
      <td>
       <input type="text" name="config[cms_dir]" value="${configs.cms_dir}" size="40">
       <br>默认为空。如果本系统可以读取社区的程序目录，推荐填写该路径值。
       <br>请输入以 “./” “../”开头的相对路径，或者绝对路径，末尾加 "/"，例如填写：../sns/。
      </td>
     </tr>
     -->
     <!-- 屏蔽应用
     <tr>
      <th>论坛的IP</th>
      <td>
       <input type="text" name="config[my_ip]" value="${configs.my_ip}" size="40">
       <br>默认为空。如果您的服务器因DNS解析问题无法使用MYOP服务，请填写MYOP的IP地址。
      </td>
     </tr> -->
     <tr>
      <th>站点关闭访问</th>
      <td>
       <input type="radio" name="config[close]" value="1" ${configs.close == 1 ? "checked" : ""}>是
       <input type="radio" name="config[close]" value="0" ${configs.close != 1 ? "checked" : ""}>否
      </td>
     </tr>
     <tr>
      <th>站点关闭说明</th>
      <td><textarea name="config[closereason]" cols="80" rows="4">${configs.closereason}</textarea></td>
     </tr>
     <tr>
      <th>举报可选理由</th>
      <td><textarea name="dataset[reason]" cols="80" rows="4">${datasets.reason}</textarea><br>预设举报可选理由，每行一个</td>
     </tr>
    </table>
   </div>
   <div class="bdrcontent" id="config_2" style="display: none;">
    <div class="title"><h3>注册与显示</h3></div>
    <table class="formtable">
     <tr>
      <th style="width: 15em;">关闭新用户注册</th>
      <td>
       <input type="radio" name="config[closeregister]" value="1" ${configs.closeregister == 1 ? "checked" : ""}>是
       <input type="radio" name="config[closeregister]" value="0" ${configs.closeregister != 1 ? "checked" : ""}>否
      </td>
     </tr>
     <tr>
      <th>关闭邀请注册功能</th>
      <td>
       <input type="radio" name="config[closeinvite]" value="1" ${configs.closeinvite == 1 ? "checked" : ""}>是
       <input type="radio" name="config[closeinvite]" value="0" ${configs.closeinvite != 1 ? "checked" : ""}>否
      </td>
     </tr>
     <tr>
      <th>一个邮箱只能注册一个账号</th>
      <td>
       <input type="radio" name="config[checkemail]" value="1" ${configs.checkemail == 1 ? "checked" : ""}>是
       <input type="radio" name="config[checkemail]" value="0" ${configs.checkemail != 1 ? "checked" : ""}>否
      </td>
     </tr>
     <tr>
      <th>同一IP注册时间间隔</th>
      <td><input type="text" name="config[regipdate]" value="${configs.regipdate}" size="5"> (单位：小时)<br>限制同一个ip，在多长时间内只能注册一个账号</td>
     </tr>
     <tr>
      <th>注册服务条款</th>
      <td><textarea name="dataset[registerrule]" cols="80" rows="4">${datasets.registerrule}</textarea><br>用户注册的时候会显示并需要接受的服务条款。（支持html语言，换行使用&lt;br&gt;）</td>
     </tr>
     <tr>
      <th>列表最大分页数</th>
      <td><input type="text" name="config[maxpage]" value="${configs.maxpage}" size="5"> (默认为 100)<br>允许用户查看的最大分页数。当用户查看的分页数越大的时候，对服务器的负载压力就越大。</td>
     </tr>
     <tr>
      <th>动态保留天数</th>
      <td><input type="text" name="config[feedday]" value="${configs.feedday}" size="5"> (默认为 7)<br>个人动态的保留天数。超过该天数的个人动态会被清理掉，从而可以保证数据库的效率。建议不要设置太长。</td>
     </tr>
     <tr>
      <th>我的主页动态显示数</th>
      <td><input type="text" name="config[feedmaxnum]" value="${configs.feedmaxnum}" size="5"> (默认为 100)<br>我的主页显示的好友动态将从这些数目的事件中进行合并显示。建议不要设置太多，从而可以保证数据库的效率，但最少不能低于50。</td>
     </tr>
     <tr>
      <th>我的主页动态默认标签设置</th>
      <td>好友数小于 <input type="text" name="config[showallfriendnum]" value="${configs.showallfriendnum}" size="5"> 个的时候显示所有人的动态，超过这个数值显示好友动态。<br>在日志、相册列表页面，该参数同样生效。</td>
     </tr>
     <tr>
      <th>我的主页动态折叠设置</th>
      <td>
       <input type="text" name="config[feedhiddenicon]" value="${configs.feedhiddenicon}" size="60">
       <br>请输入要折叠显示的动态类型（icon），多个类型之间用半角逗号 "," 隔开。 <br>将某些动态折叠后，可以适当减少我的主页的动态噪音。<br>动态类型的获取方法：
       <br>在查看好友动态的时候，点击每条动态前面的小图标（例如 <img src="image/icon/blog.gif" align="absmiddle">），
       <br>浏览器的网址会变为类似如下的链接：<br>http://<%=request.getServerName()%>/zone.action?uid=&do=feed&view=we&appid=3&<b>icon=blog</b>，
       <br>其中，icon=blog，就表示该动态类型为 blog
       <!-- 屏蔽应用<br>MYOP应用的icon为 7位数字。你可以用英文单词 <b>myop</b> 来表示所有MYOP应用的动态类型。 -->
      </td>
     </tr>
     <tr>
      <th>我的主页显示热点的数目</th>
      <td><input type="text" name="config[feedhotnum]" value="${configs.feedhotnum}" size="5"> (默认为 3)<br>为0，则我的主页不显示热点推荐。最大不要超过10个。<br>系统会自动获取10个热点，其中，排名第一的热点会固定显示，其余热点会随机显示。</td>
     </tr>
     <tr>
      <th>我的主页欢迎新成员选项</th>
      <td>
       显示 <input type="text" name="config[newspacenum]" value="${configs.newspacenum}" size="5"> 个新成员(0为不显示)
       <br>显示的新成员条件:
       <br><input type="checkbox" name="config[newspaceavatar]" value="1" ${configs.newspaceavatar == 1 ? "checked" : ""}> 已经上传头像
       <c:if test="${sConfig.realname == 1}"><br><input type="checkbox" name="config[newspacerealname]" value="1" ${configs.newspacerealname == 1 ? "checked" : ""}> 已经实名认证</c:if>
       <c:if test="${sConfig.videophoto == 1}"><br><input type="checkbox" name="config[newspacevideophoto]" value="1" ${configs.newspacevideophoto == 1 ? "checked" : ""}> 已经视频认证</c:if>
      </td>
     </tr>
     <tr>
      <th>热点推荐的天数范围</th>
      <td><input type="text" name="config[feedhotday]" value="${configs.feedhotday}" size="5"> (单位天，默认为 2天)<br>设置我的主页热点推荐选择的天数范围。</td>
     </tr>
     <tr>
      <th>热点推荐的最小热度值</th>
      <td><input type="text" name="config[feedhotmin]" value="${configs.feedhotmin}" size="5"><br>设置当发布的信息热度值超过多少后，才会显示在推荐里面。</td>
     </tr>
     <tr>
      <th>动态链接打开模式</th>
      <td>
       <input type="radio" name="config[feedtargetblank]" value="1" ${configs.feedtargetblank == 1 ? "checked" : ""}>新窗口打开
       <input type="radio" name="config[feedtargetblank]" value="0" ${configs.feedtargetblank != 1 ? "checked" : ""}>同一窗口打开
       <br>如果选择是，用户阅读动态的时候，所有的链接都会在新窗口打开。
      </td>
     </tr>
     <tr>
      <th>记录动态阅读状态</th>
      <td>
       <input type="radio" name="config[feedread]" value="1" ${configs.feedread == 1 ? "checked" : ""}>是
       <input type="radio" name="config[feedread]" value="0" ${configs.feedread != 1 ? "checked" : ""}>否
       <br>如果选择是，该条动态被点击的时候，会变成灰色，以表示已经阅读。(注意，该功能对热点动态无效)
      </td>
     </tr>
     <!-- 屏蔽应用
     <tr>
      <th>关闭MYOP的更新提示</th>
      <td>
       <input type="radio" name="config[my_closecheckupdate]" value="1" ${configs.my_closecheckupdate == 1 ? "checked" : ""}>是
       <input type="radio" name="config[my_closecheckupdate]" value="0" ${configs.my_closecheckupdate != 1 ? "checked" : ""}>否
       <br>您的站点开启了MYOP多应用服务后，当平台有了新的信息的时候MYOP会自动提示给管理员。关闭本功能后，您将不再获取更新提示。
      </td>
     </tr>
     <tr>
      <th>我的主页调用推荐礼物提示</th>
      <td>
       <input type="radio" name="config[my_showgift]" value="1" ${configs.my_showgift == 1 ? "checked" : ""}>是
       <input type="radio" name="config[my_showgift]" value="0" ${configs.my_showgift != 1 ? "checked" : ""}>否
       <br>如果您开启了MYOP平台的礼物应用后，可以在我的主页显示“推荐礼物”。
      </td>
     </tr> -->
     <tr>
      <th>成员排行榜允许分页浏览</th>
      <td>
       <input type="radio" name="config[homepage]" value="1" ${configs.homepage == 1 ? "checked" : ""}>是
       <input type="radio" name="config[homepage]" value="0" ${configs.homepage != 1 ? "checked" : ""}>否
       <br>该设置只对排行榜中的竞价排行、在线成员、全部成员有效。
      </td>
     </tr>
     <tr>
      <th>成员排行榜缓存时间</th>
      <td><input type="text" name="config[topcachetime]" value="${configs.topcachetime}" size="5"> (单位分钟)<br>用户排行榜中，除竞价排行、在线成员、全部成员外，其余排行榜是缓存处理的。<br>请根据服务器的负载情况，设置合理的更新时间间隔。最少不能低于5分钟。</td>
     </tr>
     <tr>
      <th>外部链接显示导航条</th>
      <td>
       <input type="radio" name="config[linkguide]" value="1" ${configs.linkguide == 1 ? "checked" : ""}>是
       <input type="radio" name="config[linkguide]" value="0" ${configs.linkguide != 1 ? "checked" : ""}>否
      </td>
     </tr>
     <tr>
      <th>星星经验阀值</th>
      <td><input type="text" name="config[starcredit]" value="${configs.starcredit}" size="5"> (默认为 100)<br>当用户经验数到此阀值时，增加一个星星。最小为2，否则此功能无效，不显示星星数。</td>
     </tr>
     <tr>
      <th>星星升级阀值</th>
      <td><input type="text" name="config[starlevelnum]" value="${configs.starlevelnum}" size="5"> (默认为 5)<br>星星数在达到此阀值时，会升级为高级别的图标。最小为2，否则此项功能无效，始终以星星显示</td>
     </tr>
    </table>
   </div>
   <div class="bdrcontent" id="config_1" style="display: none;">
    <div class="title"><h3>系统功能</h3></div>
    <table class="formtable">
     <tr>
      <th style="width: 15em;">好友用户组个数</th>
      <td><input type="text" name="config[groupnum]" value="${configs.groupnum}" size="5"> (默认为 8)<br>设置每个用户最多拥有的好友用户组个数。</td>
     </tr>
     <tr>
      <th>投票单次最高悬赏</th>
      <td><input type="text" name="config[maxreward]" value="${configs.maxreward}" size="5"> (默认 10)<br>允许用户创建悬赏投票时平均单次投票悬赏额度</td>
     </tr>
     <tr>
      <th>邮件通知更新天数</th>
      <td>
       <input type="text" name="config[sendmailday]" value="${configs.sendmailday}" size="5"> (默认 0)
       <br>单位：天，当用户多少天没有登陆站点的时候才会给其发送邮件通知；<br>设置为0，则不启用邮件通知功能；<br>启用本功能将会轻微增加服务器负载
      </td>
     </tr>
     <!-- tr>
      <th>日志单次导入最大数</th>
      <td><input type="text" name="config[importnum]" value="${configs.importnum}" size="5"> (默认 100)<br>允许用户单次导入日志的条数</td>
     </tr>
     <tr>
      <th>开启XMLPRC协议接口</th>
      <td>
       <input type="radio" name="config[openxmlrpc]" value="1" ${configs.openxmlrpc == 1 ? "checked" : ""}>是
       <input type="radio" name="config[openxmlrpc]" value="0" ${configs.openxmlrpc != 1 ? "checked" : ""}>否
       <br>用户可以通过本协议接口，使用客户端发布日志。但是，也可能会增加恶意灌水的可能。
      </td>
     </tr -->
     <tr>
      <th>开启即时消息</th>
      <td>
       <input type="radio" name="config[openim]" value="1" ${configs.openim == 1 ? "checked" : ""}>是
       <input type="radio" name="config[openim]" value="0" ${configs.openim != 1 ? "checked" : ""}>否
       <br>实现站内消息的即时提醒，无需刷新页面就能收到有新消息提示信息。
       <br>注意: 本功能会<span style="color:red">严重加重服务器负担</span>。此功能需要web服务器为Tomcat7.x，并需要配置Tomcat的server.xml，修改Connector节点的protocol属性值为"org.apache.coyote.http11.Http11NioProtocol"。
       <br>如：&lt;Connector port="8080" protocol="<span style="color:red">org.apache.coyote.http11.Http11NioProtocol</span>" .../&gt;
       <br>此功能仅在Tomcat服务器下有效，不支持其他服务器软件或者整合其他HTTP服务器。
      </td>
     </tr>
     <!--
     <tr>
      <th>社区应用标签相关信息</th>
      <td>
       <table>
        <tr>
         <td width="150">是否启用</td>
         <td>
          <input type="radio" name="config[cms_tagrelated]" value="1" ${configs.cms_tagrelated == 1 ? "checked" : ""}>是
          <input type="radio" name="config[cms_tagrelated]" value="0" ${configs.cms_tagrelated != 1 ? "checked" : ""}>否
          <br>开启本功能，则系统会通过社区，获取到站内其他应用的标签相关信息<br>否则，只显示本站内的标签相关日志
         </td>
        </tr>
        <tr>
         <td>缓存更新间隔</td>
         <td>
          <input type="text" name="config[cms_tagrelatedtime]" value="${configs.cms_tagrelatedtime}" size="10" maxlength="10"> (单位:秒, 默认为: 86400 即，24小时)
          <br>设置标签关联信息多长时间更新一次，建议设置1小时（3600秒）以上，减轻对服务器的压力。为0则不更新。
         </td>
        </tr>
       </table>
      </td>
     </tr>
     -->
     <tr>
      <th>模块缓存</th>
      <td>
       <table>
        <tr>
         <td width="150">是否启用</td>
         <td>
          <input type="radio" name="config[allowcache]" value="1" ${configs.allowcache == 1 ? "checked" : ""}>是
          <input type="radio" name="config[allowcache]" value="0" ${configs.allowcache != 1 ? "checked" : ""}>否
          <br>推荐开启，这样在使用模块调用数据的时候，可以大幅度降低数据库的负载
         </td>
        </tr>
        <tr>
         <td>缓存模式</td>
         <td>
          <input type="radio" name="config[cachemode]" value="file" ${configs.cachemode == "file" ? "checked" : ""}>存储到文本
          <input type="radio" name="config[cachemode]" value="database" ${configs.cachemode == "database" ? "checked" : ""}>存储到数据库
         </td>
        </tr>
        <tr>
         <td>缓存分表等级</td>
         <td>
          <select name="config[cachegrade]">
           <option value="0" ${configs.cachegrade == 0 ? "selected" : ""}>只用一个表(或目录)</option>
           <option value="1" ${configs.cachegrade == 1 ? "selected" : ""}>分散到15个子表(或目录)</option>
           <option value="2" ${configs.cachegrade == 2 ? "selected" : ""}>分散到225个子表(或目录)</option>
          </select><br>分表(或目录)越多效率越高，但建立的数据表(或目录)越多
         </td>
        </tr>
       </table>
      </td>
     </tr>
     <tr>
      <th>二级域名功能</th>
      <td>
       <table>
        <tr>
         <td width="150">是否启用</td>
         <td>
          <input type="radio" name="config[allowdomain]" value="1" ${configs.allowdomain == 1 ? "checked" : ""}>是
          <input type="radio" name="config[allowdomain]" value="0" ${configs.allowdomain != 1 ? "checked" : ""}>否
          <br>二级域名功能需要服务器配置支持
         </td>
        </tr>
        <tr>
         <td>保留二级域名</td>
         <td>
          <input type="text" name="config[holddomain]" value="${configs.holddomain}" size="50">
          <br>多个之间用 | 隔开，可以使用通配符*
         </td>
        </tr>
        <tr>
         <td>二级域名根域名</td>
         <td><input type="text" name="config[domainroot]" value="${configs.domainroot}" size="50"></td>
        </tr>
       </table>
      </td>
     </tr>
    </table>
   </div>
   <div class="bdrcontent" id="config_3" style="display: none;">
    <div class="title"><h3>实名认证设置</h3></div>
    <table class="formtable">
     <tr>
      <th style="width: 15em;">开启实名</th>
      <td>
       <input type="radio" name="config[realname]" value="1" ${configs.realname == 1 ? "checked" : ""}>是
       <input type="radio" name="config[realname]" value="0" ${configs.realname != 1 ? "checked" : ""}>否
       <br>以下设置只有在开启实名机制后有效；
       <br>注意，开启实名认证会增加服务器负担。
      </td>
     </tr>
     <tr>
      <th>实名需手工认证</th>
      <td>
       <input type="radio" name="config[namecheck]" value="1" ${configs.namecheck == 1 ? "checked" : ""}>是
       <input type="radio" name="config[namecheck]" value="0" ${configs.namecheck != 1 ? "checked" : ""}>否
       <br>设置为“是”，则用户填写的姓名只有在被管理者手工认证后才算有效。否则，则自动为认证有效。
      </td>
     </tr>
     <tr>
      <th>认证实名可再修改</th>
      <td>
       <input type="radio" name="config[namechange]" value="1" ${configs.namechange == 1 ? "checked" : ""}>是
       <input type="radio" name="config[namechange]" value="0" ${configs.namechange != 1 ? "checked" : ""}>否
       <br>填写的姓名经认证有效后，是否允许用户再次修改姓名。
       <br>如果允许修改且手工认证，那么用户修改的新姓名需要再次手工认证后方可有效。
      </td>
     </tr>
     <tr>
      <th>未认证实名权限</th>
      <td>
       <table>
        <tr>
         <td width="150">允许查看实名用户主页</td>
         <td>
          <input type="radio" name="config[name_allowviewspace]" value="1" ${configs.name_allowviewspace == 1 ? "checked" : ""}>是
          <input type="radio" name="config[name_allowviewspace]" value="0" ${configs.name_allowviewspace != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <tr>
         <td width="150">允许加好友</td>
         <td>
          <input type="radio" name="config[name_allowfriend]" value="1" ${configs.name_allowfriend == 1 ? "checked" : ""}>是
          <input type="radio" name="config[name_allowfriend]" value="0" ${configs.name_allowfriend != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <tr>
         <td width="150">允许打招呼</td>
         <td>
          <input type="radio" name="config[name_allowpoke]" value="1" ${configs.name_allowpoke == 1 ? "checked" : ""}>是
          <input type="radio" name="config[name_allowpoke]" value="0" ${configs.name_allowpoke != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <tr>
         <td width="150">允许发心情</td>
         <td>
          <input type="radio" name="config[name_allowdoing]" value="1" ${configs.name_allowdoing == 1 ? "checked" : ""}>是
          <input type="radio" name="config[name_allowdoing]" value="0" ${configs.name_allowdoing != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <tr>
         <td width="150">允许发日志</td>
         <td>
          <input type="radio" name="config[name_allowblog]" value="1" ${configs.name_allowblog == 1 ? "checked" : ""}>是
          <input type="radio" name="config[name_allowblog]" value="0" ${configs.name_allowblog != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <tr>
         <td width="150">允许使用相册</td>
         <td>
          <input type="radio" name="config[name_allowalbum]" value="1" ${configs.name_allowalbum == 1 ? "checked" : ""}>是
          <input type="radio" name="config[name_allowalbum]" value="0" ${configs.name_allowalbum != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <tr>
         <td width="150">允许发话题</td>
         <td>
          <input type="radio" name="config[name_allowthread]" value="1" ${configs.name_allowthread == 1 ? "checked" : ""}>是
          <input type="radio" name="config[name_allowthread]" value="0" ${configs.name_allowthread != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <tr>
         <td width="150">允许发投票</td>
         <td>
          <input type="radio" name="config[name_allowpoll]" value="1" ${configs.name_allowpoll == 1 ? "checked" : ""}>是
          <input type="radio" name="config[name_allowpoll]" value="0" ${configs.name_allowpoll != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <tr>
         <td width="150">允许发活动</td>
         <td>
          <input type="radio" name="config[name_allowevent]" value="1" ${configs.name_allowevent == 1 ? "checked" : ""}>是
          <input type="radio" name="config[name_allowevent]" value="0" ${configs.name_allowevent != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <tr>
         <td width="150">允许分享</td>
         <td>
          <input type="radio" name="config[name_allowshare]" value="1" ${configs.name_allowshare == 1 ? "checked" : ""}>是
          <input type="radio" name="config[name_allowshare]" value="0" ${configs.name_allowshare != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <tr>
         <td width="150">允许发送礼物</td>
         <td>
          <input type="radio" name="config[name_allowgift]" value="1" ${configs.name_allowgift == 1 ? "checked" : ""}>是
          <input type="radio" name="config[name_allowgift]" value="0" ${configs.name_allowgift != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <tr>
         <td width="150">允许留言/评论</td>
         <td>
          <input type="radio" name="config[name_allowcomment]" value="1" ${configs.name_allowcomment == 1 ? "checked" : ""}>是
          <input type="radio" name="config[name_allowcomment]" value="0" ${configs.name_allowcomment != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <tr>
         <td width="150">允许群组回帖</td>
         <td>
          <input type="radio" name="config[name_allowpost]" value="1" ${configs.name_allowpost == 1 ? "checked" : ""}>是
          <input type="radio" name="config[name_allowpost]" value="0" ${configs.name_allowpost != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <!-- 屏蔽应用
        <tr>
         <td width="150">允许使用MYOP应用</td>
         <td>
          <input type="radio" name="config[name_allowuserapp]" value="1" ${configs.name_allowuserapp == 1 ? "checked" : ""}>是
          <input type="radio" name="config[name_allowuserapp]" value="0" ${configs.name_allowuserapp != 1 ? "checked" : ""}>否
         </td>
        </tr> -->
       </table>
      </td>
     </tr>
    </table>
   </div>
   <div class="bdrcontent" id="config_4" style="display: none;">
    <div class="title"><h3>视频认证设置</h3></div>
    <table class="formtable">
     <tr>
      <th style="width: 15em;">开启视频认证</th>
      <td>
       <input type="radio" name="config[videophoto]" value="1" ${configs.videophoto == 1 ? "checked" : ""}>是
       <input type="radio" name="config[videophoto]" value="0" ${configs.videophoto != 1 ? "checked" : ""}>否
       <br>以下设置只有在开启视频认证后有效
      </td>
     </tr>
     <tr>
     <tr>
      <th>视频认证照片需手工认证</th>
      <td>
       <input type="radio" name="config[videophotocheck]" value="1" ${configs.videophotocheck == 1 ? "checked" : ""}>是
       <input type="radio" name="config[videophotocheck]" value="0" ${configs.videophotocheck != 1 ? "checked" : ""}>否
       <br>设置为“是”，则用户上传的认证照片只有在被管理者手工认证后才算有效。否则，则自动为认证有效。
      </td>
     </tr>
     <tr>
      <th>视频认证照片可再修改</th>
      <td>
       <input type="radio" name="config[videophotochange]" value="1" ${configs.videophotochange == 1 ? "checked" : ""}>是
       <input type="radio" name="config[videophotochange]" value="0" ${configs.videophotochange != 1 ? "checked" : ""}>否
       <br>上传的认证照片经认证有效后，是否允许用户再次修改认证照片。
       <br>如果允许修改且手工认证，那么用户上传的新照片需要再次手工认证后方可有效。
      </td>
     </tr>
      <th>未视频认证用户权限</th>
      <td>
       <table>
        <tr>
         <td width="150">允许查看视频用户的照片</td>
         <td>
          <input type="radio" name="config[video_allowviewphoto]" value="1" ${configs.video_allowviewphoto == 1 ? "checked" : ""}>是
          <input type="radio" name="config[video_allowviewphoto]" value="0" ${configs.video_allowviewphoto != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <tr>
         <td width="150">允许加视频用户为好友</td>
         <td>
          <input type="radio" name="config[video_allowfriend]" value="1" ${configs.video_allowfriend == 1 ? "checked" : ""}>是
          <input type="radio" name="config[video_allowfriend]" value="0" ${configs.video_allowfriend != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <tr>
         <td width="150">允许向视频用户打招呼</td>
         <td>
          <input type="radio" name="config[video_allowpoke]" value="1" ${configs.video_allowpoke == 1 ? "checked" : ""}>是
          <input type="radio" name="config[video_allowpoke]" value="0" ${configs.video_allowpoke != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <tr>
         <td width="150">允许向视频用户留言</td>
         <td>
          <input type="radio" name="config[video_allowwall]" value="1" ${configs.video_allowwall == 1 ? "checked" : ""}>是
          <input type="radio" name="config[video_allowwall]" value="0" ${configs.video_allowwall != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <tr>
         <td width="150">允许向视频用户评论</td>
         <td>
          <input type="radio" name="config[video_allowcomment]" value="1" ${configs.video_allowcomment == 1 ? "checked" : ""}>是
          <input type="radio" name="config[video_allowcomment]" value="0" ${configs.video_allowcomment != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <tr>
         <td width="150">允许发心情</td>
         <td>
          <input type="radio" name="config[video_allowdoing]" value="1" ${configs.video_allowdoing == 1 ? "checked" : ""}>是
          <input type="radio" name="config[video_allowdoing]" value="0" ${configs.video_allowdoing != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <tr>
         <td width="150">允许发日志</td>
         <td>
          <input type="radio" name="config[video_allowblog]" value="1" ${configs.video_allowblog == 1 ? "checked" : ""}>是
          <input type="radio" name="config[video_allowblog]" value="0" ${configs.video_allowblog != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <tr>
         <td width="150">允许使用相册</td>
         <td>
          <input type="radio" name="config[video_allowalbum]" value="1" ${configs.video_allowalbum == 1 ? "checked" : ""}>是
          <input type="radio" name="config[video_allowalbum]" value="0" ${configs.video_allowalbum != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <tr>
         <td width="150">允许发话题</td>
         <td>
          <input type="radio" name="config[video_allowthread]" value="1" ${configs.video_allowthread == 1 ? "checked" : ""}>是
          <input type="radio" name="config[video_allowthread]" value="0" ${configs.video_allowthread != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <tr>
         <td width="150">允许发投票</td>
         <td>
          <input type="radio" name="config[video_allowpoll]" value="1" ${configs.video_allowpoll == 1 ? "checked" : ""}>是
          <input type="radio" name="config[video_allowpoll]" value="0" ${configs.video_allowpoll != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <tr>
         <td width="150">允许发活动</td>
         <td>
          <input type="radio" name="config[video_allowevent]" value="1" ${configs.video_allowevent == 1 ? "checked" : ""}>是
          <input type="radio" name="config[video_allowevent]" value="0" ${configs.video_allowevent != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <tr>
         <td width="150">允许分享</td>
         <td>
          <input type="radio" name="config[video_allowshare]" value="1" ${configs.video_allowshare == 1 ? "checked" : ""}>是
          <input type="radio" name="config[video_allowshare]" value="0" ${configs.video_allowshare != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <tr>
         <td width="150">允许发送礼物</td>
         <td>
          <input type="radio" name="config[video_allowgift]" value="1" ${configs.video_allowgift == 1 ? "checked" : ""}>是
          <input type="radio" name="config[video_allowgift]" value="0" ${configs.video_allowgift != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <tr>
         <td width="150">允许群组回帖</td>
         <td>
          <input type="radio" name="config[video_allowpost]" value="1" ${configs.video_allowpost == 1 ? "checked" : ""}>是
          <input type="radio" name="config[video_allowpost]" value="0" ${configs.video_allowpost != 1 ? "checked" : ""}>否
         </td>
        </tr>
        <!-- 
        <tr>
         <td width="150">允许使用MYOP应用</td>
         <td>
          <input type="radio" name="config[video_allowuserapp]" value="1" ${configs.video_allowuserapp == 1 ? "checked" : ""}>是
          <input type="radio" name="config[video_allowuserapp]" value="0" ${configs.video_allowuserapp != 1 ? "checked" : ""}>否
         </td>
        </tr> -->
       </table>
      </td>
     </tr>
    </table>
   </div>
   <div class="bdrcontent" id="config_5" style="display: none;">
    <div class="title"><h3>上传图片设置</h3></div>
    <table class="formtable">
     <tr>
      <th style="width: 15em;">预览缩略图大小</th>
      <td>
        宽<input type="text" name="data[thumbwidth]" value="${datas.thumbwidth}" size="5">px &nbsp; 高<input type="text" name="data[thumbheight]" value="${datas.thumbheight}" size="5">px
       <br>缩略图按原图比例缩小，宽高不会超过本设定。比如设置为 宽：100px，高：100px，但都不能小于60px
      </td>
     </tr>
     <tr>
      <th style="width: 15em;">图片最大尺寸</th>
      <td>
        宽<input type="text" name="data[maxthumbwidth]" value="${datas.maxthumbwidth}" size="5">px &nbsp; 高<input type="text" name="data[maxthumbheight]" value="${datas.maxthumbheight}" size="5">px
       <br>如果用户上传一些尺寸很大的数码图片，则程序会按照本设置进行缩小该图片并显示，比如可以设置为 宽：1024px，高：768px，但都不能小于300px。设置为0，则不做任何处理。
      </td>
     </tr>
     <tr>
      <th>图片水印</th>
      <td>
       <table>
        <tr>
         <td width="150">是否启用</td>
         <td>
          <input type="radio" name="config[allowwatermark]" value="1" ${configs.allowwatermark == 1 ? "checked" : ""}>是
          <input type="radio" name="config[allowwatermark]" value="0" ${configs.allowwatermark != 1 ? "checked" : ""}>否
          <br>注意，开启水印功能后，图片的EXIF信息将无法获取
         </td>
        </tr>
        <tr>
         <td>水印图片地址</td>
         <td><input type="text" name="data[watermarkfile]" value="${datas.watermarkfile}"><br>默认为image/watermark.png，只支持JPG/GIF/PNG格式，推荐用透明的png图片</td>
        </tr>
        <tr>
         <td>水印位置</td>
         <td>
          <input type="radio" name="data[watermarkpos]" value="1" ${datas.watermarkpos == 1 ? "checked" : ""}> 顶端居左
          <input type="radio" name="data[watermarkpos]" value="2" ${datas.watermarkpos == 2 ? "checked" : ""}> 顶端居右
          <input type="radio" name="data[watermarkpos]" value="3" ${datas.watermarkpos == 3 ? "checked" : ""}> 底端居左
          <input type="radio" name="data[watermarkpos]" value="4" ${datas.watermarkpos == 4 ? "checked" : ""}> 底端居右
         </td>
        </tr>
       </table>
      </td>
     </tr>
    </table>
   </div>
   <!--
   <div class="bdrcontent" id="config_7" style="display: none;">
    <div class="title"><h3>远程上传设置</h3></div>
    <table class="formtable">
     <tr>
      <th style="width: 15em;">启用远程附件</th>
      <td>
       <input type="radio" name="config[allowftp]" value="1" ${configs.allowftp == 1 ? "checked" : ""}>是
       <input type="radio" name="config[allowftp]" value="0" ${configs.allowftp != 1 ? "checked" : ""}>否
      </td>
     </tr>
     <tr>
      <th>启用 SSL 连接</th>
      <td>
       <input type="radio" name="data[ftpssl]" value="1" ${configs.ftpssl == 1 ? "checked" : ""}>是
       <input type="radio" name="data[ftpssl]" value="0" ${configs.ftpssl != 1 ? "checked" : ""}>否
      </td>
     </tr>
     <tr>
      <th>FTP连接信息</th>
      <td>
       <table>
        <tr>
         <td width="150">FTP 服务器地址</td>
         <td><input type="text" name="data[ftphost]" value="${datas.ftphost}"> (FTP 服务器的 IP 地址或域名)</td>
        </tr>
        <tr>
         <td>FTP 服务器端口</td>
         <td><input type="text" name="data[ftpport]" value="${datas.ftpport}" size="5"> (默认为 21)</td>
        </tr>
        <tr>
         <td>FTP 帐号</td>
         <td><input type="text" name="data[ftpuser]" value="${datas.ftpuser}"></td>
        </tr>
        <tr>
         <td>FTP 密码</td>
         <td><input type="password" name="data[ftppassword]" value="${datas.ftppassword}"></td>
        </tr>
        <tr>
         <td>被动模式(pasv)连接</td>
         <td>
          <input type="radio" name="data[ftppasv]" value="1" ${datas.ftppasv == 1 ? "checked" : ""}>是
          <input type="radio" name="data[ftppasv]" value="0" ${datas.ftppasv != 1 ? "checked" : ""}>否 (一般情况下非被动模式即可)
         </td>
        </tr>
        <tr>
         <td>远程附件目录</td>
         <td><input type="text" name="data[ftpdir]" value="${datas.ftpdir}"><br>远程附件目录的绝对路径或相对于 FTP 主目录的相对路径<br>“.”表示 FTP 主目录，例如填写：./attachment</td>
        </tr>
        <tr>
         <td>远程访问 URL</td>
         <td><input type="text" name="config[ftpurl]" value="${configs.ftpurl}"><br>支持 HTTP 和 FTP 协议，结尾要加斜杠“/”</td>
        </tr>
        <tr>
         <td>FTP 传输超时时间</td>
         <td><input type="text" name="data[ftptimeout]" value="${datas.ftptimeout}" size="5"> (单位：秒，0 为服务器默认)</td>
        </tr>
       </table>
      </td>
     </tr>
    </table>
   </div>
   -->
   <div class="bdrcontent" id="config_6" style="display: none;">
    <div class="title"><h3>邮件设置</h3></div>
    <table class="formtable">
     <tr>
      <th style="width: 15em;">邮件发送方式</th>
      <td>通过 SOCKET 连接 SMTP 服务器发送(支持 ESMTP 验证)</td>
     </tr>
     <tr>
      <th>邮件头的分隔符</th>
      <td>
       <input class="radio" name="mail[maildelimiter]" value="0"${mails.maildelimiter == 0 ? " checked" : ""} type="radio"> 使用 LF 作为分隔符(通常为 Unix/Linux 主机)
       <br><input class="radio" name="mail[maildelimiter]" value="1"${mails.maildelimiter == 1 ? " checked" : ""} type="radio"> 使用 CRLF 作为分隔符(通常为 Windows 主机)
       <br><input class="radio" name="mail[maildelimiter]" value="2"${mails.maildelimiter == 2 ? " checked" : ""} type="radio"> 使用 CR 作为分隔符(通常为 Mac 主机)
      </td>
     </tr>
     <tr>
      <th>收件人显示用户名</th>
      <td>
       <input class="radio" name="mail[mailusername]" value="1"${mails.mailusername == 1 ? " checked" : ""} type="radio"> 是 &nbsp; &nbsp;
       <input class="radio" name="mail[mailusername]" value="0"${mails.mailusername != 1 ? " checked" : ""} type="radio"> 否
      </td>
     </tr>
     <tr>
      <th>&nbsp;</th>
      <td>
       <table>
        <tbody>
         <tr>
          <td width="150">SMTP 服务器</td>
          <td><input type="text" name="mail[server]" value="${mails.server}"></td>
         </tr>
         <tr>
          <td>SMTP 端口</td>
          <td><input type="text" name="mail[port]" value="${mails.port}" size="5"> 默认为 25</td>
         </tr>
        </tbody>
        <tr>
         <td>要求身份验证</td>
         <td>
          <input class="radio" name="mail[auth]" value="1" type="radio" ${mails.auth == 1 ? "checked" : ""}> 是 &nbsp; &nbsp;
          <input class="radio" name="mail[auth]" value="0" type="radio" ${mails.auth != 1 ? "checked" : ""}> 否
         </td>
        </tr>
        <tr>
         <td>发信人邮件地址</td>
         <td><input type="text" name="mail[from]" value="${mails.from}"><br>格式为“username &lt;user@domain.com&gt;”，也可以只填地址</td>
        </tr>
        <tr>
         <td>SMTP 用户名</td>
         <td><input type="text" name="mail[auth_username]" value="${mails.auth_username}"></td>
        </tr>
        <tr>
         <td>SMTP 密码</td>
         <td><input type="password" name="mail[auth_password]" value="${mails.auth_password}"></td>
        </tr>
       </table>
      </td>
     </tr>
    </table>
   </div>
   <div class="footactions"><input type="submit" name="thevaluesubmit" value="提交" class="submit"></div>
  </form>
 </div>
</div>
<div class="side">
 <jsp:directive.include file="side.jsp" />
</div>
<jsp:directive.include file="footer.jsp" />