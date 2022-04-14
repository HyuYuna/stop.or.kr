<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>
	<c:out value="${SESS_PROP_PRJTNM}"/> : <tiles:insertAttribute name="sitemapTitle" ignore="true" />
</title>
<tiles:insertAttribute name="sitemapMeta"/>
<tiles:insertAttribute name="cmmnScript" ignore="true"/>
<tiles:insertAttribute name="sitemapScript" ignore="true"/>
</head>

<body>

	<!--  ## TPCODE : TPAGE0012 : 사이트맵 레이아웃 ## -->

	<!-- Accessibility -->
	<dl id="accessibility">
		<dt>바로가기 및 건너띄기 링크</dt>
		<dd><a href="#content">본문 바로가기</a></dd>
		<dd><a href="#gnavigation">주메뉴 바로가기</a></dd>
	</dl>
	<!-- Accessibility // -->
	
	<hr class="division" />
	<div id="layout-header">
		<div id="header">
			<tiles:insertAttribute name="sitemapHeader"/>
			<tiles:insertAttribute name="sitemapMenu"/>
		</div>
	</div>
	<!--layout-header// -->

	
		<!-- 공통부분 -->
		<div id="layout-container">
			<div id="container">
				<div id="container-wrap">
		<!-- 공통부분 -->
		
				<!-- layout-container-->
				<tiles:insertAttribute name="sitemapLeftmenu"/>
				<tiles:insertAttribute name="sitemapContent"/>
				
		<!-- 공통부분 -->
				</div>
			</div>
		</div>
		<!-- 공통부분 -->


	<!-- layout-container//--> 
	<tiles:insertAttribute name="sitemapFooter"/>

</body>
</html>