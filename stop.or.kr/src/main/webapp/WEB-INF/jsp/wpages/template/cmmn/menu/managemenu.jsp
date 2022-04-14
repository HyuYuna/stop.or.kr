<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>

<div id="gnb">
	<ul>
		<c:forEach var="result" items="${menuList}" varStatus="status">
			<c:choose>
				<c:when test="${result.auth_yn eq 'Y'}">
					<li id="liMetsysMenu<c:out value="${result.srch_menu_nix}"/>"><a href="javascript:fn_egov_change_menu('<c:out value="${(result.menu_link)}"/>', 0)"><c:out value="${result.menu_nm}"/></a></li>
				</c:when>	
				<c:otherwise>
					<!-- <li class="off" id="liMetsysMenu_${status.index}"><c:out value="${result.menu_nm}"/></li> -->
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</ul>
</div>
 
<!-- 
<div id="gnb">
	<ul>
		<c:if test="${SESS_USR_LV eq 0}">
			<li id="liMetsysMenuDV"><a href="javascript:fn_egov_change_menu('00')">개발 도구</a></li>
			<li id="liMetsysMenuDG"><a href="javascript:fn_egov_change_menu('01')">컨텐츠 관리</a></li>
		</c:if>
		<li id="liMetsysMenuUR"><a href="javascript:fn_egov_change_menu('02')">사용자 관리</a></li>
		<li id="liMetsysMenuBD"><a href="javascript:fn_egov_change_menu('03')">게시판 관리</a></li>
		<li id="liMetsysMenuST"><a href="javascript:fn_egov_change_menu('04')">통계</a></li>
		<li id="liMetsysMenuEC"><a href="javascript:fn_egov_change_menu('05_01')">기타 관리</a></li>
	</ul>
</div>
 -->
