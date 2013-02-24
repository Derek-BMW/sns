<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sns.tmwsoft.com/sns" prefix="sns"%>
<c:set var="tpl_noSideBar" value="1" scope="request" />
<jsp:include page="${sns:template(sConfig, sGlobal, 'home_header.jsp')}" />
 <!--[if lte IE 7]><link rel="stylesheet" href="template/${sConfig.template}/lte-ie7.css" /><![endif]-->
 
 <script language="javascript" type="text/javascript" src="source/jquery.min.js"></script>
 <script>jQuery.noConflict();</script>
 
 <script language="javascript" type="text/javascript" src="source/jquery.KinSlideshow-1.2.1.min.js"></script>
 <script type="text/javascript">
  jQuery(function(){
   jQuery("#index_side_news").KinSlideshow({
	titleBar:{titleBar_height:28,titleBar_bgColor:"#000",titleBar_alpha:0.5},
	titleFont:{TitleFont_size:14,TitleFont_color:"#FFFFFF",TitleFont_weight:"normal"},
	btn:{btn_bgColor:"#3e3d3b",btn_bgHoverColor:"#1072aa",btn_fontColor:"#fff",btn_fontHoverColor:"#FFFFFF",btn_borderColor:"#3e3d3b",btn_borderHoverColor:"#0f655f",btn_borderWidth:1}
   });
  })
 </script>
 
  <div class="home_top clearfix mb15">
    <div class="home_show l" id="index_side_news"> 
    	${sns:showAdById(10)}
    </div>
    
    <div class="box2 r" id="focus_news">
      <div class="box2_title">
        <h3><span aria-hidden="true" class="icon-globe"></span><a href="zone.action?do=thread&view=hot" target="_blank">旅游聚焦</a></h3>
      </div>
      <div class="box2_main">
        <ul class="focus_news_top">
          <c:forEach items="${recommend_threads}" var="thread" varStatus="index">
          <c:if test="${index.index < 3}">
          <li><a href="zone.action?do=thread&id=${thread.tid}" class="red" target="_blank"><strong>${thread.subject}</strong></a></li>
          </c:if>
          </c:forEach>
        </ul>
        <div class="focus_news_m clearfix">
          <ul class="l">
          	<c:forEach items="${recommend_threads}" var="thread" varStatus="index">
          	<c:if test="${index.index >= 3 and index.index <= 8}">
          	<li><a href="zone.action?do=thread&id=${thread.tid}" target="_blank">${thread.subject}</a></li>
          	</c:if>
          	</c:forEach>
          </ul>
          
          <ul class="r">
          	<c:forEach items="${recommend_threads}" var="thread" varStatus="index">
          	<c:if test="${index.index >= 9 and index.index <= 14}">
          	<li><a href="zone.action?do=thread&id=${thread.tid}" target="_blank">${thread.subject}</a></li>
          	</c:if>
          	</c:forEach>
          </ul>
        </div>
      </div>
    </div>
    
    <div class="l" id="sns_search">
        <form method="post" action="zone.action">
			<input name="searchkey" value="" size="32" class="t_input" type="text" style="padding:3px 5px;">
			<select name="do">
				<option value="blog">日志</option>
				<option value="album">相册</option>
				<option value="thread">话题</option>
				<option value="poll">投票</option>
				<option value="event">活动</option>
				<option value="friend">好友</option>
			</select>
			<input name="searchsubmit" value="搜索" class="submit" type="submit">
			<input type="hidden" name="view" value="all" />
			<input type="hidden" name="orderby" value="dateline" />
		</form>
    </div>
    
  </div>
  <div class="mb15 clearfix">
    <div class="home_top2_l l">
      <div class="box1 l" id="industry_news">
        <div class="box1_title">
          <h3><span class="icon-newspaper"></span><a href="http://www.wlkst.com/hyxw/index.jhtml" target="_blank">行业资讯</a></h3>
        </div>
        <div class="box1_main">
          <ul>
          	<!-- 
            <li><a class="red" href="#">[导游]</a><a class="red" href="#">记者调查导游逼购现象：拿回扣成</a></li>
            -->
            <script language="javascript" type="text/javascript" src="http://www.wlkst.com/hyzx/index.jhtml"></script>
          </ul>
        </div>
      </div>
      <div class="box1 r" id="lively">
        <div class="box1_title">
          <h3><span class="icon-fire"></span><a href="zone.action?do=topic" target="_blank">热闹</a></h3>
        </div>
        <div class="box1_main">
          <ul>
          	<c:forEach items="${topics}" var="topic" varStatus="index">
          	<li>
              <div class="l"><a href="zone.action?do=topic&topicid=${topic.topicid}" target="_blank"><img src="${topic.pic}" onerror="this.onerror=null;this.src='image/nologo.jpg'"></a></div>
              <div class="l">
                <p>
                	<b><a href="zone.action?do=topic&topicid=${topic.topicid}" class="${index.index == 0 ? 'red' : ''}" target="_blank">${topic.subject}</a></b><br />
                  	<span class="${index.index == 0 ? 'red' : ''}">${topic.message} ...</span>
                </p>
              </div>
            </li>
            </c:forEach>
          </ul>
        </div>
      </div>
      <div class="box1 l" id="recommend_log">
        <div class="box1_title">
          <h3><span class="icon-document-stroke"></span><a href="zone.action?do=blog&view=all&orderby=dateline&classid=39" target="_blank">印象征文</a></h3>
        </div>
        <div class="box1_main">
          <ul>
             <c:forEach items="${blogs}" var="blog" varStatus="index">
               <c:if test="${blog.classid =='39' }">
                 <li><a href="zone.action?do=blog&id=${blog.blogid}" class="${blog.recommend == 'Y' ? 'red' : ''}" target="_blank">${blog.subject}</a></li>
               </c:if>
            </c:forEach>
          </ul>
        </div>
      </div>
      <div class="box1 r" id="hot_log">
        <div class="box1_title">
          <h3><span class="icon-copy"></span><a href="zone.action?do=blog&view=all&orderby=dateline&classid=22" target="_blank">游记攻略</a></h3>
        </div>
        <div class="box1_main">
          <ul>
          	<c:forEach items="${blogs}" var="blog" varStatus="index">
            <c:if test="${blog.classid =='22' }">
            <li><a href="zone.action?do=blog&id=${blog.blogid}" class="${blog.recommend == 'Y' ? 'red' : ''}" target="_blank">${blog.subject}</a></li>
            </c:if>
            </c:forEach>
          </ul>
        </div>
      </div>
    </div>
    <div class="home_top2_r r">
      <div class="box1" id="groups">
        <div class="box1_title">
          <h3><span class="icon-trophy"></span><a href="zone.action?do=mtag&view=hot" target="_blank">人气群组</a></h3>
        </div>
        <div class="box1_main">
          <ul>
          	<c:forEach items="${mtags}" var="mtag" varStatus="index">
            <li>
              <div class="threadimg60 l">
              	<a href="zone.action?do=mtag&tagid=${mtag.tagid}" target="_blank">
              	  <img src="${mtag.pic}" onerror="this.onerror=null;this.src='image/nologo.jpg'">
              	</a>
              </div>
              <div>
                <p>
                	<b>群名称：</b><a href="zone.action?do=mtag&tagid=${mtag.tagid}" target="_blank">${mtag.tagname}</a><br />
                  	<b>简介：</b>${mtag.title}
                </p>
                <a href="main.action?ac=mtag&op=join&tagid=${mtag.tagid}" class="btn_join" target="_blank">我要加入</a> 
              </div>
            </li>
            </c:forEach>
          </ul>
        </div>
      </div>
      <div class="sns_tags">
        <h3><a href="zone.action?do=tag" target="_blank">社区热词</a></h3>
        <div class="sns_tags_main">
        	<c:forEach items="${tags}" var="tag" varStatus="index">
        	<a href="zone.action?do=tag&id=${tag.tagid}" target="_blank">${tag.tagname}</a>
        	</c:forEach>
        </div>
      </div>
    </div>
  </div>
  <div class="mb15 clearfix">
    <div class="box1 l" id="travel_up">
      <div class="box1_title">
        <h3><span class="icon-user"></span><a href="zone.action?do=top" target="_blank">旅行达人</a></h3>
      </div>
      <div class="box1_main">
        <ul>
          <c:forEach items="${shows}" var="show">
          <li><a href="zone.action?uid=${show.uid}" target="_blank" rel="${sNames[show.uid]}" rev="${show.note}" title="${sNames[show.uid]} : &quot;${show.note}&quot;">${sns:avatar1(show.uid,sGlobal,sConfig)}${sNames[show.uid]}</a></li>
          </c:forEach>
        </ul>
      </div>
    </div>
    <div class="box2 r" id="attractions">
      <div class="box2_title">
        <h3><span class="icon-diamond"></span><a href="zone.action?do=mtag&id=1" target="_blank">推荐景点</a></h3>
      </div>
      <div class="box2_main">
        <div class="l">
          <ul>
          	<c:forEach items="${recommend_threads2}" var="thread" varStatus="index">
          	<c:if test="${index.index < 8}">
            <li><a href="zone.action?do=thread&id=${thread.tid}" target="_blank"><img src="${thread.pic}" onerror="this.onerror=null;this.src='image/nologo.jpg'">${thread.subject}</a></li>
            </c:if>
            </c:forEach>
          </ul>
        </div>
        <div class="r">
          <ul>
          	<c:forEach items="${recommend_threads2}" var="thread" varStatus="index">
          	<c:if test="${index.index >= 8}">
            <li><a href="zone.action?do=thread&id=${thread.tid}" target="_blank"><img src="${thread.pic}" onerror="this.onerror=null;this.src='image/nologo.jpg'"></a></li>
            </c:if>
            </c:forEach>
          </ul>
        </div>
      </div>
    </div>
  </div>
  <div class="mb15 clearfix">
    <div class="home_top2_l l">
      <div class="box1 l" id="industry_news">
        <div class="box1_title">
          <h3><span class="icon-document-stroke"></span><a href="zone.action?do=blog&view=all&orderby=dateline&classid=30" target="_blank">活动聚焦</a></h3>
        </div>
        <div class="box1_main">
          <ul>
            <c:forEach items="${blogs}" var="blog" varStatus="index">
               <c:if test="${blog.classid =='30' }">
                 <li><a href="zone.action?do=blog&id=${blog.blogid}" class="${blog.recommend == 'Y' ? 'red' : ''}" target="_blank">${blog.subject}</a></li>
               </c:if>
            </c:forEach>
          </ul>
        </div>
      </div>
      <div class="box1 r" id="hot_log">
         <div class="box1_title">
          <h3><span class="icon-document-stroke"></span><a href="zone.action?do=blog&view=all&orderby=dateline&classid=20" target="_blank">社会热点</a></h3>
        </div>
        <div class="box1_main">
          <ul>
            <c:forEach items="${blogs}" var="blog" varStatus="index">
               <c:if test="${blog.classid =='20' }">
                 <li><a href="zone.action?do=blog&id=${blog.blogid}" class="${blog.recommend == 'Y' ? 'red' : ''}" target="_blank">${blog.subject}</a></li>
               </c:if>
            </c:forEach>
          </ul>
        </div>
      </div>
      <div class="box1 l" id="recommend_log">
        <div class="box1_title">
          <h3><span class="icon-document-stroke"></span><a href="zone.action?do=blog&view=all&orderby=dateline&classid=16" target="_blank">奇人趣事</a></h3>
        </div>
        <div class="box1_main">
          <ul>
            <c:forEach items="${blogs}" var="blog" varStatus="index">
               <c:if test="${blog.classid =='16' }">
                 <li><a href="zone.action?do=blog&id=${blog.blogid}" class="${blog.recommend == 'Y' ? 'red' : ''}" target="_blank">${blog.subject}</a></li>
               </c:if>
            </c:forEach>
          </ul>
        </div>
      </div>
      <div class="box1 r" id="hot_log">
        <div class="box1_title">
          <h3><span class="icon-copy"></span><a href="zone.action?do=blog&view=all&orderby=dateline&classid=21" target="_blank">开心一刻</a></h3>
        </div>
        <div class="box1_main">
          <ul>
          	 <c:forEach items="${blogs}" var="blog" varStatus="index">
               <c:if test="${blog.classid =='21'}">
                 <li><a href="zone.action?do=blog&id=${blog.blogid}" class="${blog.recommend == 'Y' ? 'red' : ''}" target="_blank">${blog.subject}</a></li>
               </c:if>
            </c:forEach>
          </ul>
        </div>
      </div>
    </div>
    <div class="home_top2_r r">
      <div class="box1" id="new_activity">
        <div class="box1_title">
          <h3><span class="icon-trophy"></span><a href="zone.action?do=mtag&view=hot" target="_blank">最新活动</a></h3>
        </div>
        <div class="box1_main" >
          <ul>
          	<c:forEach items="${events}" var="event">
          	<li>
              <a href="zone.action?do=event&id=${event.eventid}" target="_blank">${event.title}</a><br />
              <div class="threadimg60 l">
              	<a href="zone.action?do=event&id=${event.eventid}" target="_blank"><img src="${event.poster}" onerror="this.onerror=null;this.src='image/nologo.jpg'"></a>
              </div>
              <div class="r">
                <p>
                  	<span class="gray">开始时间:</span> ${event.starttime}<br>
                  	<span class="gray">结束时间:</span> ${event.endtime}<br>
                  	<c:if test="${not empty event.location}">
					<span class="gray">地点:</span> ${event.location}<br />
					</c:if>
					${event.membernum} 人参加<span class="pipe">|</span>${event.follownum} 人关注<br />
                </p>
              </div>
            </li>
			</c:forEach>
          </ul>
        </div>
      </div>
      
    </div>
  </div>
  <div class="mb15 clearfix">
    <div class="box2 l" id="video_share">
      <div class="box2_title">
        <h3><span class="icon-film"></span><a href="zone.action?do=share&view=all&type=video" target="_blank">视频分享</a></h3>
      </div>
      <div class="box2_main">
        <ul class="vodio l">
          <c:set var="shareCount" scope="page" value="0" />
          <c:forEach items="${shares}" var="share" varStatus="index">
          <c:if test="${share.type =='video' and shareCount < 8}">
          <c:set var="shareCount" scope="page" value="${shareCount + 1}" />
          <li>
            <a href="zone.action?uid=${share.uid}&do=share&id=${share.sid}" target="_blank">
          	  <img src="${sns:snsEmpty(share.body_data.flashimg)  ?  'image/vd.gif'  :  share.body_data.flashimg}" onerror="this.onerror=null;this.src='image/nologo.jpg'">
          	  <span>${share.body_data.title}</span>
            </a>
            <p>${sNames[share.uid]} 分享于${share.dateline}</p>
          </li>
          </c:if>
          </c:forEach>
        </ul>
        
        <ul class="popularize r">
          ${sns:showAdById(11)}
        </ul>
      </div>
    </div>
    <div class="box1 r" id="vote">
      <div class="box1_title">
        <h3><span class="icon-chart-alt"></span><a href="zone.action?do=poll&view=new" target="_blank">投票</a></h3>
      </div>
      <div class="box1_main">
        <ul class="npoll">
          <c:forEach items="${polls}" var="poll" varStatus="index">
          <li class="poll_${index.index}"><a href="zone.action?do=poll&pid=${poll.pid}" target="_blank">${poll.subject}</a><c:if test="${index.index == 0}"><p><a href="zone.action?do=poll&pid=${poll.pid}" target="_blank">已有 ${poll.voternum} 位会员投票</a></p></c:if></li>
          </c:forEach>
        </ul>
      </div>
    </div>
  </div>
    <div class="mb15 clearfix">
    <div class="home_top2_l l">
      <div class="box1 l" id="industry_news">
        <div class="box1_title">
          <h3><span class="icon-document-stroke"></span><a href="zone.action?do=blog&view=all&orderby=dateline&classid=23" target="_blank">自驾驴行</a></h3>
        </div>
        <div class="box1_main">
          <ul>
            <c:forEach items="${blogs}" var="blog" varStatus="index">
               <c:if test="${blog.classid =='23' }">
                 <li><a href="zone.action?do=blog&id=${blog.blogid}" class="${blog.recommend == 'Y' ? 'red' : ''}" target="_blank">${blog.subject}</a></li>
               </c:if>
            </c:forEach>
          </ul>
        </div>
      </div>
      <div class="box1 r" id="hot_log">
         <div class="box1_title">
          <h3><span class="icon-document-stroke"></span><a href="zone.action?do=blog&view=all&orderby=dateline&classid=15" target="_blank">风景名胜</a></h3>
        </div>
        <div class="box1_main">
          <ul>
            <c:forEach items="${blogs}" var="blog" varStatus="index">
               <c:if test="${blog.classid =='15' }">
                 <li><a href="zone.action?do=blog&id=${blog.blogid}" class="${blog.recommend == 'Y' ? 'red' : ''}" target="_blank">${blog.subject}</a></li>
               </c:if>
            </c:forEach>
          </ul>
        </div>
      </div>
      <div class="box1 l" id="recommend_log">
        <div class="box1_title">
          <h3><span class="icon-document-stroke"></span><a href="zone.action?do=blog&view=all&orderby=dateline&classid=24" target="_blank">活动召集</a></h3>
        </div>
        <div class="box1_main">
          <ul>
            <c:forEach items="${blogs}" var="blog" varStatus="index">
               <c:if test="${blog.classid =='24' }">
                 <li><a href="zone.action?do=blog&id=${blog.blogid}" class="${blog.recommend == 'Y' ? 'red' : ''}" target="_blank">${blog.subject}</a></li>
               </c:if>
            </c:forEach>
          </ul>
        </div>
      </div>
      <div class="box1 r" id="hot_log">
        <div class="box1_title">
          <h3><span class="icon-copy"></span><a href="zone.action?do=blog&view=all&orderby=dateline&classid=38" target="_blank">旅游曝光</a></h3>
        </div>
        <div class="box1_main">
          <ul>
          	 <c:forEach items="${blogs}" var="blog" varStatus="index">
               <c:if test="${blog.classid =='38' }">
                 <li><a href="zone.action?do=blog&id=${blog.blogid}" class="${blog.recommend == 'Y' ? 'red' : ''}" target="_blank">${blog.subject}</a></li>
               </c:if>
            </c:forEach>
          </ul>
        </div>
      </div>
    </div>
    <div class="home_top2_r r">
      <div class="box1" id="topuser">
        <div class="box1_title">
          <h3><span class="icon-trophy"></span><a href="zone.action?do=mtag&view=hot" target="_blank">人气排行</a></h3>
        </div>
        <div class="box1_main" >
          <ul>
	        <c:forEach items="${users}" var="show">
	        <li>
	        <div class="eimage l"><a href="zone.action?uid=${show.uid}" target="_blank" rel="${sNames[show.uid]}" rev="${show.note}" title="${sNames[show.uid]} : &quot;${show.note}&quot;">${sns:avatar1(show.uid,sGlobal,sConfig)}</a></div>
	        <div>
	        <p>${sNames[show.uid]}</p>
	        <p><span class="gray">人气:</span>${show.viewnum}</p>
	        <p><span class="gray">经验:</span>${show.experience}</p>
	        <p><span class="gray">好友:</span>${show.friendnum}</p>
	        </div>
	        </li>
	        </c:forEach>
          </ul>
        </div>
      </div>
      
    </div>
  </div>
  <div class="mb15 clearfix">
    <div class="box2 l" id="video_share">
      <div class="box2_title">
        <h3><span class="icon-film"></span><a href="zone.action?do=share&view=all&type=video" target="_blank">图片相册</a></h3>
      </div>
      <div class="box2_main">
        <div class="l">
          <ul>
          <c:set var="picCount" scope="page" value="0" />
            <c:forEach items="${pics}" var="pic" varStatus="index">
          	<c:if test="${pic.recommend == 'Y' and picCount < 10}">
          	<c:set var="picCount" scope="page" value="${picCount + 1}" />
			   <li class="spic_${index.index}">
				 <div class="spic_img">
			       <a href="zone.action?uid=${pic.uid}&do=album&picid=${pic.picid}" target="_blank">
			  	     <img src="${pic.filepath}" alt="${pic.albumname}" height="100" width="100" onerror="this.onerror=null;this.src='image/nologo.jpg'">
				   </a>
				 </div>
				 <p><a href="zone.action?uid=${pic.uid}">${sNames[pic.uid]}</a> ${pic.dateline}</p>
			  </li>
			</c:if>
			</c:forEach>
          </ul>
        </div>
      </div>
    </div>
    <div class="box1 r" id="doing">
      <div class="box1_title">
        <h3><span class="icon-chart-alt"></span><a href="zone.action?do=doing&view=all" target="_blank">心情</a></h3>
      </div>
      <div class="box1_main">
        <ul>
          <c:forEach items="${doings}" var="doing">
		  <li>
		    <p>
		    <a href="zone.action?uid=${doing.uid}&do=doing&doid=${doing.doid}" target="_blank" class="gray r_option dot" style="margin: 0; background-position-y: 0;">${doing.dateline}</a> 
		    <a href="zone.action?uid=${doing.uid}">${sNames[doing.uid]}</a>
		    ${doing.message}
		    </p>
		  </li>
		  </c:forEach>
        </ul>
      </div>
    </div>
  </div>
<jsp:include page="${sns:template(sConfig, sGlobal, 'footer.jsp')}" />