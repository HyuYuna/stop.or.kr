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

<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<title><tiles:insertAttribute name="mainTitle"/></title>
<tiles:insertAttribute name="mainMeta"/>
<tiles:insertAttribute name="cmmnScript"/>
<tiles:insertAttribute name="mainScript"/>
</head>

<body>
<!--  ## TPCODE : TPAGE0008 : 메인 레이아웃 ## -->
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
		</main>
		
		<footer id="footer">
			<tiles:insertAttribute name="mainFooter"/>
		</footer>
	</div>	


	<%-- <c:import url="/widgets/board.do" >
		<c:param name="brd_id" value="BDIDX_h05m420eN43VOGRM8lOyf7" />
		<c:param name="menu_nix" value="CQv80aU3" />
		<c:param name="article_cnt" value="7" />
	</c:import>
	
	<c:import url="/widgets/popup.do" >
		<c:param name="popup_cnt" value="3" />
	</c:import>
	
	<c:import url="/widgets/popupzone.do" >
		<c:param name="popup_cnt" value="3" />
	</c:import> --%>
	


</body>
</html>