<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	<title><c:out value="${boardthmVO.subject}"/><c:out value="${boardarticleVO.subject}"/> ${nowMenuVO.up_menu_nm} > ${nowMenuVO.menu_nm} | 한국여성인권진흥원</title>
	<tiles:insertAttribute name="contMeta"/>
	<tiles:insertAttribute name="cmmnScript"/>
	<tiles:insertAttribute name="contScript" ignore="true"/>
	<tiles:insertAttribute name="boardScript" ignore="true"/>
	<tiles:insertAttribute name="srvyScript" ignore="true"/>	

	<script type="application/ld+json">
	{
	 "@context": "http://schema.org",
	 "@type": "Person",
	 "name": "한국여성인권진흥원",
	 "url": "https://www.stop.or.kr",
	 "sameAs": [
	   "https://blog.naver.com/whrck",
	   "https://www.facebook.com/wrstar",
	   "https://twitter.com/whrik2009",
	   "https://youtube.com/c/한국여성인권진흥원whrik",
	   "https://instagram.com/whrik"
	 ]
	}
	</script>
</head>

<body>
	<!-- Accessibility -->
	<a id="uppermost" href="#contents" class="skip-to">본문 바로가기</a>
	<div id="wrap" class="main2020">
		<header id="header">
			<tiles:insertAttribute name="contHeader"/>
		</header>	
		<main id="main">
		
			<c:import url="/SiteMenuWidget/path.do" >
				<c:param name="use" value="N" />
				<c:param name="viewFile" value="site_sub_visual" />
			</c:import>
			
			<div class="cont-wrap">
				
				<c:import url="/SiteMenuWidget/sidemenu.do" >
					<c:param name="use" value="Y" />
				</c:import>
				
				<div id="contents">
					<div class="cont-top">
						<c:import url="/SiteMenuWidget/path.do" >
							<c:param name="use" value="N" />
							<c:param name="viewFile" value="site_path" />
						</c:import>
					</div>
					<div class="cont-mid">
  
							<!-- 상세콘텐츠 영역 -->
							<c:import url="/SiteMenuWidget/tabmenu.do" >
								<c:param name="use" value="Y" />
							</c:import>
							
							
							<tiles:insertAttribute name="contContent"/>
							
					</div>
				</div>
			</div>
		</main>
		<footer id="footer">
			<tiles:insertAttribute name="contFooter"/>
		</footer>	
	</div>
	<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-2.2.4.min.js"></script> --%>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.bxslider.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/kor/layout.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/kor/sub.js"></script>
</body>

</html>




<!--     //////////////////////////////////////////////////////////////////////////////////////////////////////////   -->



<%--
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>
	${nowMenuVO.menu_nm} - ${SESS_PROP_PRJTNM}
</title>
<tiles:insertAttribute name="contMeta"/>
<tiles:insertAttribute name="cmmnScript"/>
<tiles:insertAttribute name="contScript" ignore="true"/>
</head>


<body>
	
	<!--  ## TPCODE : TPAGE0010 : 컨텐츠 레이아웃 ## -->
	
	<!-- Accessibility -->
	<dl id="accessibility">
		<dt class="hidden"><strong>바로가기 메뉴</strong></dt>
		<dd><a href="#body">본문바로가기</a></dd>
		<dd><a href="#gnavigation">메뉴바로가기</a></dd>
	</dl>
	<!-- //Accessibility -->



	<div id="wrap" class="">
		
		<header id="header">
			<tiles:insertAttribute name="contHeader"/>
		</header>
		
		<section id="body">
			<%--<tiles:insertAttribute name="contSidemenu"/>--%>
			
<%-- 			<c:import url="/widgets/sidemenu.do" >
				<c:param name="mu_site" value="CDIDX00002" />
				<c:param name="mu_lang" value="CDIDX00022" />
				<c:param name="srch_mu_gub" value="USR" />
			</c:import> 
			<c:import url="/SiteMenuWidget/sidemenu.do" >
				<c:param name="use" value="Y" />
			</c:import>
			<!-- 프로젝트마다 변경되는 컨텐츠 내부의 레이아웃은 여기에 추가합니다 Start -->
			<section id="content">
				<%-- <c:import url="/widgets/tabmenu.do" >
				</c:import>
				<c:import url="/SiteMenuWidget/tabmenu.do" >
					<c:param name="use" value="Y" />
				</c:import>
							
			
				<%-- <c:import url="/widgets/path.do" >
					<c:param name="popup_cnt" value="3" />
				</c:import>
				<c:import url="/SiteMenuWidget/path.do" >
					<c:param name="use" value="Y" />
				</c:import>
							
			<!-- 프로젝트마다 변경되는 컨텐츠 내부의 레이아웃은 여기에 추가합니다 End  -->
			
			<tiles:insertAttribute name="contContent"/>
			
			<!-- 프로젝트마다 변경되는 컨텐츠 내부의 레이아웃은 여기에 추가합니다 Start -->
			</section>
			

			<!-- 프로젝트마다 변경되는 게시판 내부의 레이아웃은 여기에 추가합니다 End  -->
			
			
			<tiles:insertAttribute name="contQuicklink"/>
		</section>
		
		<!-- layout-container//-->
		<footer id="footer">
			<tiles:insertAttribute name="contFooter"/>
		</footer>
	</div>	

</body>

</html>



 --%>