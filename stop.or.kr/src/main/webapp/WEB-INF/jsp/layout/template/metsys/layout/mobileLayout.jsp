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
	<tiles:insertAttribute name="metsysTitle" ignore="true" /> - <c:out value="${SESS_PROP_PRJTNM}"/>
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
	<div id="header">
		<tiles:insertAttribute name="metsysHeader"/>
		<tiles:insertAttribute name="metsysMenu"/>
	</div>
	
	<!-- //header -->
	
	<hr />
		
		
		<!-- content -->
		<div id="container">
			
			<div class="title_area group">
				<h2></h2>
				<p class="path">
					<img src="${pageContext.request.contextPath}/images/template/sub/ico_home.gif" alt="" /> Home &gt; <strong><tiles:insertAttribute name="metsysSubTitle"/></strong> 
				</p>
			</div>
<%-- 		    <tiles:insertAttribute name="metsysSubmenu"/> --%>
	
			<div id="content">
			    <tiles:insertAttribute name="metsysContent"/>
			</div>
		</div>
		<!-- //content -->

    <!-- //content -->
</div>

<hr />

<tiles:insertAttribute name="metsysFooter"/>

</body>
</html>