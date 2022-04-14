<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	<title>${nowMenuVO.menu_nm} | 공모전</title>
	<tiles:insertAttribute name="contMeta"/>
	<tiles:insertAttribute name="cmmnScript"/>
	<tiles:insertAttribute name="contScript" ignore="true"/>
	<tiles:insertAttribute name="boardScript" ignore="true"/>
	<tiles:insertAttribute name="srvyScript" ignore="true"/>	
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
			<tiles:insertAttribute name="contHeader"/>
		</header>
		<main id="main">
			<div id="spot">
				<span>2018 성매매방지 국민생각 공모전</span>
				<strong>생각을 바꿀 생각을 찾습니다</strong>
				<%-- <em>5. 28<br />~6. 24</em> --%>
				<p>
					<a href="${cutil:getUrl('/complicity/agree.do', 'srch_menu_nix=v03WS79x', false)}" class="type1">공모전 접수하기</a>
					<a href="${cutil:getUrl('/modedg/contentsView.do', 'srch_menu_nix=6a0c75Ak&ucont_id=CTX000058', false)}" class="type2">공모요강 바로가기</a>
				</p>
			</div>		
			<div class="cont-wrap">
				<c:import url="/SiteMenuWidget/tabmenu2awards.do" >
					<c:param name="use" value="Y" />
				</c:import>
				<div id="contents">
					<div class="cont-mid">
						<tiles:insertAttribute name="contContent"/>
					</div>
				</div>
			</div>
		</main>	
		<footer id="footer">
			<tiles:insertAttribute name="contFooter"/>
		</footer>
	</div>
	<%-- <script type="text/javascript" src="${cutil:url('/js/jquery-2.2.4.min.js')}"></script> --%>
	<script type="text/javascript" src="${cutil:url('/js/jquery.bxslider.min.js')}"></script>
	<script type="text/javascript" src="${cutil:url('/js/kor/layout.js')}"></script>
	<script type="text/javascript" src="${cutil:url('/js/kor/sub.js')}"></script>
</body>
</html>
