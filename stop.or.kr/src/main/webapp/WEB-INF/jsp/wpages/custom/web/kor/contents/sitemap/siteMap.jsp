<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!--   ## TPCODE : TPAGE0019: 사이트맵 페이지 ## --> 
<!-- 상세콘텐츠 영역 -->
<ul class="bul1">
	<li>청소년정책분석평가센터의 메뉴를 한눈에 확인하실 수 있습니다.</li>
</ul>
<ul id="sitemap">
	<c:forEach var="result" items="${sysmenuList}" varStatus="status">
		<c:choose>
			<c:when test="${result.menu_lv eq 1}">
				<li><a href="${pageContext.request.contextPath}${result.menu_link}&srch_menu_nix=${result.menu_nix}" target="_blank"><c:out value="${result.menu_nm}"/></a>
				<div class="depth2">
				<ul>
				<c:forEach var="child" items="${sysmenuList}" varStatus="c_status">
	
					<c:if test="${child.up_menu_idx eq result.menu_idx }">
						<li><a href="${pageContext.request.contextPath}${child.menu_link}&srch_menu_nix=${child.menu_nix}" target="_blank"><c:out value="${child.menu_nm}"/></a></li>		
					</c:if>
				</c:forEach>
				</ul>
				</div>
			</c:when>							
		</c:choose>
		</li>
	</c:forEach>
</ul>




<%-- <ul id="sitemap">
	<c:forEach var="result" items="${sysmenuList}" varStatus="status">
		<c:set var="next_menu_idx" value="${sysmenuList[status.index + 1].menu_idx}"/>
		<c:set var="next_up_menu_idx" value="${sysmenuList[status.index + 1].up_menu_idx}"/>
		<c:choose>
			<c:when test="${result.is_leaf eq 0}">
				<li><c:out value="${result.menu_nm}"/>
				<div class="depth2">
				<ul>
			</c:when>							
			<c:otherwise>
				<li><c:out value="${result.menu_nm}"/></li>		
				<c:if test="${result.up_menu_idx ne next_up_menu_idx}">
					</ul></div></li>
				</c:if>
			</c:otherwise>
			
		</c:choose>
	
	</c:forEach>
</ul> --%>




 