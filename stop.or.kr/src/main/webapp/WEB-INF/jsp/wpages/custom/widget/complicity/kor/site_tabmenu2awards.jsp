<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${nowMenuVO.tabmenu_yn eq 'Y'}">
	<div id="snb">
	<nav>
	<ul class="depth1">
		<c:forEach var="tabmenu" items="${tabmenu}">
			<c:choose> 
				<c:when test="${tabmenu.blank_yn eq 'Y'}">
					<c:set var="target" value="_blank"/>
				</c:when>
				<c:otherwise>
					<c:set var="target" value=""/>
				</c:otherwise>
			</c:choose>
			
			<c:choose> 
				<c:when test="${fn:indexOf(tabmenu.menu_link,'?') > 0}">
					<c:set var="tag_url" value="&"/>
				</c:when>
				<c:otherwise>
					<c:set var="tag_url" value="?"/>
				</c:otherwise>
			</c:choose>
			
			
			<c:choose>
				<c:when test="${fn:indexOf(tabmenu.menu_link,'srch_menu_nix=') < 0}">
					<c:set var="a_link" value="${pageContext.request.contextPath}${tabmenu.menu_link}${tag_url}srch_menu_nix=${tabmenu.menu_nix}&srch_mu_site=${param.srch_mu_site}"/>
				</c:when>
				<c:otherwise>
					<c:choose> 
						<c:when test="${tabmenu.menu_link eq 'UNDER_CONSTRUCT'}">
							<c:set var="a_link" value="javascript:fn_egov_under_construct()"/>
						</c:when>
						
						<c:otherwise>
							<c:set var="a_link" value="${pageContext.request.contextPath}${tabmenu.menu_link}${tag_url}srch_mu_site=${param.srch_mu_site}"/>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
			
			
			<li <c:if test="${tabmenu_idx eq tabmenu.menu_idx}">class="active"</c:if>><a href="${a_link}" <c:if test="${!empty target}">target="${target}"</c:if>>${tabmenu.menu_nm}</a></li>
		</c:forEach>
	</ul>
	</nav>
	</div>
</c:if>

