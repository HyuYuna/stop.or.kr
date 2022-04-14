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
	<c:choose>
		<c:when test="${param.tgtact eq '01'}">로그인 - </c:when>
		<c:when test="${param.tgtact eq '02'}">회원가입 - </c:when>
	</c:choose>
	<c:out value="${SESS_PROP_PRJTNM}"/>
</title>
<tiles:insertAttribute name="svcmemMeta"/>
<tiles:insertAttribute name="cmmnScript"/>
<tiles:insertAttribute name="svcmemScript"/>
</head>

<body>

<!--  ## TPCODE : TPAGE0011 : 회원서비스 레이아웃 ## -->

<!-- Accessibility -->
<dl id="accessibility">
	<dt class="hidden"><strong>바로가기 메뉴</strong></dt>
	<dd><a href="#body">본문바로가기</a></dd>
	<dd><a href="#gnavigation">메뉴바로가기</a></dd>
</dl>
<!-- //Accessibility -->


	<div id="wrap">
		<header id="header">
			<tiles:insertAttribute name="svcmemHeader"/>
		</header>
		<p class="gnavigation_bg"></p>
		
		<section id="body">
			<tiles:insertAttribute name="svcmemSidemenu"/>
			<tiles:insertAttribute name="svcmemContent"/>
			<tiles:insertAttribute name="svcmemQuicklink"/>
		</section>
		
		<!-- layout-container//-->
		<footer id="footer">
			<tiles:insertAttribute name="svcmemFooter"/>
		</footer>
	</div>	

</body>
	
</body>
</html>