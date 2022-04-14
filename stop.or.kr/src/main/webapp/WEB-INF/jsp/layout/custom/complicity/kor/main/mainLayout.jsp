<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	<title><tiles:insertAttribute name="mainTitle"/></title>
	<link rel="stylesheet" type="text/css" href="${cutil:url('/css/common.css')}" />
	<!-- 공모전 css 추가 -->
	<link rel="stylesheet" type="text/css" href="${cutil:url('/css/kor/contest.css')}" />
	<link rel="stylesheet" type="text/css" href="${cutil:url('/css/kor/respond/contest.css')}" />
	<!-- //공모전 추가 -->
</head>

<body>
	<!-- Accessibility -->
	<a id="uppermost" href="#contents" class="skip-to">본문 바로가기</a>
	<div id="wrap">
		<header id="header">
			<tiles:insertAttribute name="mainHeader"/>
		</header>
		<main id="main">
			<div class="cont-wrap">
				<div id="contents">
					<div class="cont-mid">
						<tiles:insertAttribute name="mainContent"/>
					</div>
				</div>
			</div>
		</main>	
		<footer id="footer">
			<tiles:insertAttribute name="mainFooter"/>
		</footer>
	</div>
	<script type="text/javascript" src="${cutil:url('/js/jquery-3.6.0.min.js')}"></script>
	<script type="text/javascript" src="${cutil:url('/js/jquery.bxslider.min.js')}"></script>
	<script type="text/javascript" src="${cutil:url('/js/kor/layout.js')}"></script>
	<script type="text/javascript" src="${cutil:url('/js/kor/sub.js')}"></script>
</body>
</html>
