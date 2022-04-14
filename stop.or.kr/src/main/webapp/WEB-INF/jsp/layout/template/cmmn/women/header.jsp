<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%/* 언어 설정만 필요한 경우 */%>
<c:set var="languageParam" value="srch_mu_lang=${param.srch_mu_lang}" />
<!--  ## TPCODE : TPAGE0002 : 헤더 ## -->
<h1 class="logo"><a href="${pageContext.request.contextPath}/women"><img src="${pageContext.request.contextPath}/images/kor/zoomin/logo.png" alt="한국여성인권진흥원" /></a></h1>

<nav>
	<ul id="gnb">
		<c:import url="/SiteMenuWidget/menu.do" >
			<c:param name="use" value="Y"/>
		</c:import>	
	</ul>
</nav>

<div class="util">
	<!-- 20180822 추가 -->
		<!--a href="${pageContext.request.contextPath}/" class="go-link"><i class="xi-home"></i><span>진흥원 바로가기</span></a-->
		<a href="${pageContext.request.contextPath}/" class="go-home"><span>진흥원 바로가기</span></a>
	<!-- //20180822 추가 -->
	
	<form:form name="search_form" id="search_form"  action="${pageContext.request.contextPath}/contents/mainTotalSearch.do" method="get">
		<div class="search">
			<p class="form">
				<input type="hidden" name="srch_mu_site" value="CDIDX00005"/>
				<input type="hidden" name="srch_menu_nix" value="3c76Sg13"/>
				<input type="text" name="searchKeyword" placeholder="검색어를 입력해주세요" title="검색어" value="<c:out value='${param.searchKeyword}'/>"/>
				<input type="hidden" name="searchType" value="CONT"/>
				<input type="submit" class="btn" value="검색"/>
			</p>
			<a href="#none" class="control open">검색</a>
		</div>
	</form:form>

	<a href="#allmenu" class="all-menu">전체메뉴</a>
</div>
<article class="layerpopup" id="allmenu">
	<ul class="allmenu">
		<c:import url="/SiteMenuWidget/menu.do" >
			<c:param name="use" value="Y"/>
			<c:param name="type" value="site_allmenu"/>
		</c:import>	
	</ul>
</article>

















<%--

<h1 class="logo"></h1>
<article class="tsidemenu">
	<ul>
		<c:choose>
			<c:when test="${cutil:isLogin() == true}">
				<li><a href="javascript:fn_site_logout()">로그아웃</a></li>
				<li><a href="${cutil:getUrl('/svcmem/memUserInfo.do', languageParam, false)}">회원정보수정</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="${cutil:getUrl('/svcmem/siteLogin.do', languageParam, false)}">로그인 </a></li>
				<li><a href="${cutil:getUrl('/svcmem/memJoinForm.do', languageParam, false)}">회원가입</a></li>
			</c:otherwise>
		</c:choose>
		<li>
			<a href="javascript:fn_egov_tot_chk();"><img src="/images/custom/web/kor/common/btn_search.gif" alt="검색"></a>	
			<div class="popupSearch" style="display:none;">
				<input type="text" title="검색어입력" id="search-keyword" placeholder="검색어를 입력하세요">
				<input type="submit" onclick="fn_egov_tot_search()" value="SEARCH">
			</div>
		</li>
		<li><a href="${cutil:getUrl('/', '', false)}">국문</a></li>
		<li><a href="${cutil:getUrl('/', 'srch_mu_lang=CDIDX00023', false)}">영문</a></li>
	</ul>
</article>
<%-- <c:import url="/widgets/menu.do" >
	<c:param name="mu_site" value="CDIDX00002" />
	<c:param name="mu_lang" value="CDIDX00022" />
	<c:param name="srch_mu_gub" value="USR" />
</c:import>
<c:import url="/SiteMenuWidget/menu.do" >
	<c:param name="use" value="Y"/>
</c:import>
--%>