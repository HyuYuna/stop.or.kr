<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 
<div id="rightNav">
    <ul class="nav1">
	    <li><a href="javascript:;" onclick="$('#sitemap').fadeIn('slow');"><img src="${pageContext.request.contextPath}/images/custom/kor/main/navOpen.png" alt="전체메뉴열기" /></a></li>
	    <li><a href="https://www.nie.re.kr/sub08/sub08_01_01.php" target="_blank" title="새창으로 열림"><img src="${pageContext.request.contextPath}/images/custom/kor/main/navLogin.png" alt="로그인" /></a></li>
	    <li><a href="https://www.nie.re.kr/sub08/sub08_01_01.php" target="_blank" title="새창으로 열림"><img src="${pageContext.request.contextPath}/images/custom/kor/main/navJoin.png" alt="회원가입" /></a></li>
    </ul>
    <ul class="nav2">
	    <li><a href="http://www.nie.re.kr/reservation/index.php" target="_blank" title="새창으로 열림"><img src="${pageContext.request.contextPath}/images/custom/kor/main/navReservation.png" alt="온라인예약" /></a></li>
	    <li><a href="#" onclick="$('#total_search').stop().animate({opacity:1,'right':'50px'},1000,'easeInOutCubic',function(){});"><img src="${pageContext.request.contextPath}/images/custom/kor/main/navSearch.png" alt="통합검색" /></a>
	    	<div id="total_search">
	    		<span class="title"><img src="${pageContext.request.contextPath}/images/custom/kor/main/total_search_title.png" alt="국립생태원 통합검색" /></span>
	    		<p><input type="text" id="searchKeywordRnavi" name="searchKeywordRnavi" title="통합검색" /><button type="button" id="btnTotalSearchRnavi"><img src="${pageContext.request.contextPath}/images/custom/kor/main/total_search_btn.gif" alt="검색" /></button></p>
	    		<span class="close"><a href="#" onclick="$('#total_search').stop().animate({opacity:0,'right':'-371px'},500,'easeInOutCubic',function(){});"><img src="${pageContext.request.contextPath}/images/custom/kor/main/total_search_close.gif" alt="닫기" /></a></span>
	    	</div>
	    </li>     
    </ul>
    <ul id="home">
    	<li class="menu0"><a href="${pageContext.request.contextPath}/contents/siteMain.do"><img src="${pageContext.request.contextPath}/images/custom/kor/main/navHome.png" alt="홈" /></a></li>
    </ul>
    <ul id="right_gnb" class="display_none">    	
	    <li class="menu1"><a href="#research"><img src="${pageContext.request.contextPath}/images/custom/kor/main/navResearch.png" alt="생태연구" /></a></li>
	    <li class="menu2"><a href="#edu"><img src="${pageContext.request.contextPath}/images/custom/kor/main/navEdu.png" alt="교육체험" /></a></li>
	    <li class="menu3"><a href="#exhibit"><img src="${pageContext.request.contextPath}/images/custom/kor/main/navExhibit.png" alt="전시관람" /></a></li>
	    <li class="menu4"><a href="#community"><img src="${pageContext.request.contextPath}/images/custom/kor/main/navCommunity.png" alt="커뮤니티" /></a></li>
    </ul>
    <div class="top"><a href="#wrap"><img src="${pageContext.request.contextPath}/images/custom/kor/main/navTop.png" alt="top" /></a></div>
</div>


<div id="sitemap">
   	<a href="javascript:;" onclick="$('#sitemap').fadeOut('fast');" class="navClose"><img src="${pageContext.request.contextPath}/images/custom/kor/main/navClose.png" alt="전체메뉴닫기" /></a>
	<ul id="ulSiteMap" class="sitemap_depth1">
		
	</ul> 
</div>
 --%>

<div id="rightNav">
    <ul class="nav1">
	    <li><a href="javascript:;" onclick="$('#sitemap').fadeIn('slow');"><img src="${pageContext.request.contextPath}/images/custom/kor/main/navOpen.png" alt="전체메뉴열기" /></a></li>
	    <!-- 
	    <c:choose>
	    	<c:when test="${empty SESS_USR_INFO or SESS_USR_INFO.user_auth_lv gt 1002}">
			    <li>
			    	<a href="${pageContext.request.contextPath}/svcmem/sysmemPagemove.do?tgtact=siteLogin&srch_menu_nix=p20RQqzK" title="로그인">
			    		<img src="${pageContext.request.contextPath}/images/custom/kor/main/navLogin.png" alt="로그인" />
			    	</a>
			    </li>
			    <li>
			    	<a href="${pageContext.request.contextPath}/svcmem/sysmemPagemove.do?tgtact=memJoin&srch_menu_nix=p20RQqzK" title="회원가입">
			    		<img src="${pageContext.request.contextPath}/images/custom/kor/main/navJoin.png" alt="회원가입" />
			    	</a>
			    </li>
			</c:when>
			<c:otherwise>
			    <li>
			    	<a href="javascript:fn_sys_logout()" title="로그아웃">
			    		<img src="${pageContext.request.contextPath}/images/custom/kor/main/navLogout.png" alt="로그아웃" />
			    	</a>
			    </li>
			    <li>
			    	<a href="${pageContext.request.contextPath}/svcmem/sysmemPagemove.do?tgtact=modUsrinfo&srch_menu_nix=p20RQqzK" title="회원정보수정">
			    		<img src="${pageContext.request.contextPath}/images/custom/kor/main/navMypage.png" alt="회원정보수정" />
			    	</a>
			    </li>
			</c:otherwise>
			
	    </c:choose>
	     -->
    </ul>
    <ul class="nav2">
	    <li><a href="javascript:;" onclick="$('#online_reservation').stop().animate({opacity:1,'right':'50px'},1000,'easeInOutCubic',function(){});"><img src="${pageContext.request.contextPath}/images/custom/kor/main/navReservation.png" alt="온라인예약" /></a>
	    	<div id="online_reservation">
				<ul>
				<li><a href="${pageContext.request.contextPath}/modedg/contentsView.do?srch_menu_nix=83ym8du8&amp;seltab_idx=0"><img src="${pageContext.request.contextPath}/images/custom/kor/main/navReservation1.png" alt="교육프로그램" /></a></li>
				<li><a href="${pageContext.request.contextPath}/modedg/contentsView.do?srch_menu_nix=83ym8du8&amp;seltab_idx=1"><img src="${pageContext.request.contextPath}/images/custom/kor/main/navReservation2.png" alt="전시해설" /></a></li>
				<li><a href="${pageContext.request.contextPath}/modedg/contentsView.do?srch_menu_nix=83ym8du8&amp;seltab_idx=2"><img src="${pageContext.request.contextPath}/images/custom/kor/main/navReservation3.png" alt="시설대관" /></a></li>
				</ul>
	    		<span class="close"><a href="javascript:;" onclick="$('#online_reservation').stop().animate({opacity:0,'right':'-371px'},500,'easeInOutCubic',function(){});"><img src="${pageContext.request.contextPath}/images/custom/kor/main/total_search_close.gif" alt="닫기" /></a></span>
	    	</div>
	    </li>	
	    <li><a href="javascript:;" onclick="$('#total_search').stop().animate({opacity:1,'right':'50px'},1000,'easeInOutCubic',function(){});"><img src="${pageContext.request.contextPath}/images/custom/kor/main/navSearch.png" alt="통합검색" /></a>
	    	<div id="total_search">
	    		<span class="title"><img src="${pageContext.request.contextPath}/images/custom/kor/main/total_search_title.png" alt="국립생태원 통합검색" /></span>
	    		<p><input type="text" id="searchKeywordRnavi" name="searchKeywordRnavi" title="통합검색" /><button type="button" id="btnTotalSearchRnavi"><img src="${pageContext.request.contextPath}/images/custom/kor/main/total_search_btn.gif" alt="검색" /></button></p>
	    		<span class="close"><a href="javascript:;" onclick="$('#total_search').stop().animate({opacity:0,'right':'-371px'},500,'easeInOutCubic',function(){});"><img src="${pageContext.request.contextPath}/images/custom/kor/main/total_search_close.gif" alt="닫기" /></a></span>
	    	</div>
	    </li>     
    </ul>
    <ul id="home">
    	<li class="menu0"><a href="${pageContext.request.contextPath}/contents/siteMain.do"><img src="${pageContext.request.contextPath}/images/custom/kor/main/navHome.png" alt="홈" /></a></li>
    </ul>
    <ul id="right_gnb" class="display_none">    	
	    <li class="menu1"><a href="#research"><img src="${pageContext.request.contextPath}/images/custom/kor/main/navResearch.png" alt="생태연구" /></a></li>
	    <li class="menu2"><a href="#edu"><img src="${pageContext.request.contextPath}/images/custom/kor/main/navEdu.png" alt="교육체험" /></a></li>
	    <li class="menu3"><a href="#exhibit"><img src="${pageContext.request.contextPath}/images/custom/kor/main/navExhibit.png" alt="전시관람" /></a></li>
	    <li class="menu4"><a href="#community"><img src="${pageContext.request.contextPath}/images/custom/kor/main/navCommunity.png" alt="커뮤니티" /></a></li>
    </ul>
    <div class="top"><a href="#wrap"><img src="${pageContext.request.contextPath}/images/custom/kor/main/navTop.png" alt="top" /></a></div>
</div>


<div id="sitemap">
   	<a href="javascript:;" onclick="$('#sitemap').fadeOut('fast');" class="navClose"><img src="${pageContext.request.contextPath}/images/custom/kor/main/navClose.png" alt="전체메뉴닫기" /></a>
	<ul id="ulSiteMap" class="sitemap_depth1">
		
	</ul> 
</div>
