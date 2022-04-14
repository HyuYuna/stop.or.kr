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
<tiles:insertAttribute name="metsysTitle" ignore="true" />
-
<c:out value="${SESS_PROP_PRJTNM}"/>
</title>
<tiles:insertAttribute name="metsysMeta"/>
<tiles:insertAttribute name="metsysScript"/>
<tiles:insertAttribute name="metsysSubScript" ignore="true"/>
</head>

<body>

<!-- skipNavi -->
<dl id="accessibility">
	<dt><strong class="hidden">바로가기 메뉴</strong></dt>
	<dd><a href="#main_content">본문바로가기</a></dd>
</dl>
<!-- //skipNavi -->

<hr />
<div id="wrap"> 
	<!-- header -->
	<header id="header">
		<tiles:insertAttribute name="metsysHeader"/>
	</header>
	<!-- //header -->	
	<hr />	
	<div id="body">
		<section id="side">	
			<tiles:insertAttribute name="metsysSubmenu" ignore="true"/>
		</section>
		<section id="content">
			<div class="title_wrap">
				<h1 class="title" id="h1title"></h1>
				<p class="location" id="pLinemenu">Home &gt; <strong></strong> &gt; <strong></strong> </p>
			</div>
			<section id="content_detail">
			
				<!-- 프로젝트마다 변경되는 게시판 내부의 레이아웃은 여기에 추가합니다 Start -->
				
				<h2 class="title_style_01">${SESS_BRD_INFO.brd_nm} 게시판</h2>
				
				<!-- 프로젝트마다 변경되는 게시판 내부의 레이아웃은 여기에 추가합니다 End  -->
				
				<tiles:insertAttribute name="metsysContent"/>

				<!-- 프로젝트마다 변경되는 게시판 내부의 레이아웃은 여기에 추가합니다 Start -->
				
				
				<!-- 프로젝트마다 변경되는 게시판 내부의 레이아웃은 여기에 추가합니다 End  -->
				
			</section>		
		</section>
	</div>	
	<!-- //content --> 
</div>
</body>
</html>