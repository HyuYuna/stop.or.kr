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
	
	<title>${nowMenuVO.menu_nm} | 한국여성인권진흥원</title>
	<tiles:insertAttribute name="contMeta"/>
	<tiles:insertAttribute name="cmmnScript"/>
	<tiles:insertAttribute name="contScript" ignore="true"/>
	<tiles:insertAttribute name="boardScript" ignore="true"/>
	<tiles:insertAttribute name="srvyScript" ignore="true"/>	
</head>

<body>
	<!-- Accessibility -->
	<a id="uppermost" href="#contents" class="skip-to">본문 바로가기</a>
	<div id="wrap">
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
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/eng/layout.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/eng/sub.js"></script>
</body>

</html>



