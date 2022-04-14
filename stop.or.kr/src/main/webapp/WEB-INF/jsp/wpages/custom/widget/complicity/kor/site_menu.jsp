<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:forEach var="menu" items="${menu}">
<c:if test="${menu.value.use_yn eq 'Y' }">
	<c:choose> 
		<c:when test="${menu.value.blank_yn eq 'Y'}">
			<c:set var="target" value="_blank"/>
		</c:when>
		<c:otherwise>
			<c:set var="target" value=""/>
		</c:otherwise>
	</c:choose>
	
	<c:choose> 
		<c:when test="${fn:indexOf(menu.value.menu_link,'?') > 0}">
			<c:set var="tag_url" value="&"/>
		</c:when>
		<c:otherwise>
			<c:set var="tag_url" value="?"/>
		</c:otherwise>
	</c:choose>
	
	<c:choose>
		<c:when test="${fn:indexOf(menu.value.menu_link,'srch_menu_nix=') < 0}">
			<c:set var="a_link" value="${pageContext.request.contextPath}${menu.value.menu_link}${tag_url}srch_menu_nix=${menu.value.menu_nix}&srch_mu_site=CDIDX00004"/>
		</c:when>
		<c:otherwise>
			<c:choose> 
				<c:when test="${menu.value.menu_link eq 'UNDER_CONSTRUCT'}">
					<c:set var="a_link" value="javascript:fn_egov_under_construct()"/>
				</c:when>
				<c:otherwise>
					<c:set var="a_link" value="${pageContext.request.contextPath}${menu.value.menu_link}&srch_mu_site=CDIDX00004"/>
				</c:otherwise>
			</c:choose>
		</c:otherwise>
	</c:choose>

	<li><a href="${a_link}" target="${target}">${menu.value.menu_nm}</a></li>
	</c:if>
</c:forEach>
