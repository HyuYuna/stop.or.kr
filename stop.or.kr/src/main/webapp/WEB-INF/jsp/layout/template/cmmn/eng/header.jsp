<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%/* 언어 설정만 필요한 경우 */%>
<c:set var="languageParam" value="srch_mu_lang=${param.srch_mu_lang}" />

<h1 class="logo"><a href="${pageContext.request.contextPath}/eng"><img src="${pageContext.request.contextPath}/images/eng/layout/logo.png" alt="Women's Human Rights Institute of Korea" /></a></h1>
<nav>
	<ul id="gnb">
		<c:import url="/SiteMenuWidget/menu.do" >
			<c:param name="use" value="Y"/>
		</c:import>
	</ul>
</nav>
<div class="util">
	<form:form name="search_form" id="search_form"  action="${pageContext.request.contextPath}/contents/mainTotalSearch.do" method="get">
		<div class="search">
			<p class="form">
				<input type="hidden" name="srch_menu_nix" value="hOMZfiuv"/>
				<input type="text" name="searchKeyword" placeholder="Keyword" title="Keyword" value="<c:if test='${!empty param.searchType}'><c:out value='${param.searchKeyword}'/></c:if>"/>
				<input type="hidden" name="searchType" value="CONT"/>
				<input type="hidden" name="srch_mu_lang" value="CDIDX00023"/>
				<input type="submit" class="btn" value="Search"/>
			</p>
			<a href="#none" class="control open">검색</a>
		</div>
	</form:form>

	<p class="language">
		<a href="${pageContext.request.contextPath}/">KOR</a>
		<a href="${pageContext.request.contextPath}/?srch_mu_lang=CDIDX00023" class="active">ENG</a>
	</p>
	<a href="#allmenu" class="all-menu" title="all menu">all menu</a>
</div>

<article class="layerpopup" id="allmenu">
	<ul class="allmenu">
		<c:import url="/SiteMenuWidget/menu.do" >
			<c:param name="use" value="Y"/>
			<c:param name="type" value="site_allmenu"/>
		</c:import>	
	</ul>
</article>