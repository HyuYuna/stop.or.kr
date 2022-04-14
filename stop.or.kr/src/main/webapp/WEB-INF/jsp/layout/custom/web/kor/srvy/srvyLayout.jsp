<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="toDay" class="java.util.Date" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>
	${SESS_PROP_PRJTNM}
</title>
<meta property="fb:app_id" content="215898692239993" />
<meta property="og:type" content="website" />
<meta id="metaTitle" property="og:title" content="에너지기술혁신톡톡 설문조사" />
<meta id="metaUrl" property="og:url" content="" />
<meta id="metaDesc" property="og:description" content="에너지기술혁신톡톡 설문조사" />
<meta id="metaImage" property="og:image" content="${pageContext.request.contextPath }/images/custom/web/korean/content/icon_general.png" />
<tiles:insertAttribute name="srvyMeta"/>
<tiles:insertAttribute name="cmmnScript"/>
<tiles:insertAttribute name="srvyScript"/>
</head>

<body id="page" class="home sub">
<!-- Accessibility -->
<!-- skip-navigation -->
<ul id="skip-navigation">
	<li><a href="#detail-content">본문바로가기</a></li>
	<li><a href="#gnavigation">메뉴바로가기</a></li>
</ul>
<!-- skip-navigation // -->
<!-- notipcation close or open -->
<div id="notipcation" class="notipcation">
</div>


<div id="wrap" class="home-page">
	
	<header id="header" class="header">
			<tiles:insertAttribute name="srvyHeader"/>
		</header>
	
	<div id="page-body" class="page-body">
		<!--aside-->
		<aside id="side" class="side" >
			<div class="location-util">
				<p class="location" id="pLinemenu">
					<span class='home'><span>HOME</span></span>
					<span class='bullet'><span class='hidden'>&gt;</span></span><c:out value="${nowMenuVO.menu_nm}"/>
				</p>
				<p class="day"><fmt:formatDate value="${toDay}" pattern="yyyy .MM .dd E요일"/></p>
			</div>
			<!--snb-title-->
			<div class="snb-title-wrap">
				<h2 class="snb-title">
					<span class="text">
					<c:choose>
						<c:when test="${nowMenuVO.up_menu_idx eq 'MNIDX02003'}">
							제안하기
						</c:when>
						<c:otherwise>
							<c:out value="${nowMenuVO.menu_nm}"/>
						</c:otherwise>
					</c:choose>
					</span>
				</h2>
			</div>
			<c:if test="${nowMenuVO.tabmenu_yn eq 'Y'}">
			<!-- sub-menu -->
			<span class="sr-only">sub navigation</span>
			<nav id="snavigation" class="snb">
			<!-- snb Navigation // -->
				<ul class="snb-list">
					<c:forEach var="result" items="${siblmenuList}" varStatus="status">
						<c:choose>
							<c:when test="${fn:startsWith(result.menu_link, 'javascript:fn_egov_under_construct()') eq true}">
								<li id="liTabcont_${status.index}" <c:if test="${param.seltab_idx eq status.index or (empty param.seltab_idx and status.index eq 0)}">class="on"</c:if>><a href="${result.menu_link}"><c:out value="${result.menu_nm}"/></a></li>
							</c:when>
							<c:otherwise>
								<li id="liTabcont_${status.index}" <c:if test="${param.seltab_idx eq status.index or (empty param.seltab_idx and status.index eq 0)}">class="on"</c:if>><a href="javascript:fn_egov_move_action(document.reqForm, '${result.menu_link}&srch_menu_nix=${result.menu_nix}&seltab_idx=${status.index}')"><c:out value="${result.menu_nm}"/></a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</ul>
			</nav>
			</c:if>
		</aside>
		<!--aside-->
		<!--content-->
		<section class="content container" id="content">
		<!--detail content-->
			<div class="detail-content" id="detail-content">
			<!-- insert content-->
			<tiles:insertAttribute name="srvyContent"/>
			</div>
		</section>
	</div>	
	<!-- layout-container//-->
	<footer id="footer">
		<tiles:insertAttribute name="srvyFooter"/>
	</footer>
	
	<div class="left-deco">
		<span></span>
		<span></span>
		<span></span>
	</div>
	<div class="right-deco">
		<span></span>
		<span></span>
		<span></span>
	</div>
	
</div>
<!--jquery plugin-->
<script type="text/javascript" src="${pageContext.request.contextPath }/js/_core/jquery/plugin/aos/aos.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/_core/jquery/plugin/modernizr.custom.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/_core/jquery/plugin/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/_core/jquery/plugin/bxslider/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/_core/jquery/plugin/scrollbar/jquery.mCustomScrollbar.js"></script>
<script type='text/javascript' src="${pageContext.request.contextPath }/js/_core/jquery/plugin/jquery.transit/jquery.transit.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/_core/jquery/plugin/prefixfree.jquery.js"></script>
<!-- APPLY SCRIPTS -->
<script type="text/javascript" src="${pageContext.request.contextPath }/js/custom/web/korean/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/custom/web/korean/sub.js"></script>	
</body>
</html>