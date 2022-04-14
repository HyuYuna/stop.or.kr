<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>
	${SESS_BRD_INFO.brd_nm} - ${SESS_PROP_PRJTNM}
</title>
<tiles:insertAttribute name="boardMeta"/>
<tiles:insertAttribute name="cmmnScript"/>
<tiles:insertAttribute name="boardScript"/>
</head>
<body>
	
	<!--  ## TPCODE : TPAGE0009 : 게시판 레이아웃 ## -->
	
	<!-- Accessibility -->
	<dl id="accessibility">
		<dt class="hidden"><strong>바로가기 메뉴</strong></dt>
		<dd><a href="#body">본문바로가기</a></dd>
		<dd><a href="#gnavigation">메뉴바로가기</a></dd>
	</dl>
	<!-- //Accessibility -->

	
	<div id="wrap" class="">
		
		<header id="header">
			<tiles:insertAttribute name="boardHeader"/>
		</header>
		<p class="gnavigation_bg"></p>
		
		<section id="body">
			<tiles:insertAttribute name="boardSidemenu"/>

			<!-- 프로젝트마다 변경되는 게시판 내부의 레이아웃은 여기에 추가합니다 Start -->
			<section id="content">
				<div class="title_wrap">
					<h1 class="stitle"><c:out value="${nowMenuVO.menu_nm}"/></h1>
					<p class="path" id="pLinemenu"><span class="home">홈</span><span class="arrow">&gt;</span> 센터소개 <span class="arrow">&gt;</span> 인사말</p>
				</div>
								
				<c:if test="${nowMenuVO.tabmenu_yn eq 'Y'}">
					<!--탭메뉴-->
					<div class="tabmenu">
						<ul class="sub01">
							<c:forEach var="result" items="${siblmenuList}" varStatus="status">
								<c:choose>
									<c:when test="${fn:startsWith(result.menu_link, 'javascript:fn_egov_under_construct()') eq true}">
										<li id="liTabcont_${status.index}" <c:if test="${param.seltab_idx eq status.index or (empty param.seltab_idx and status.index eq 0)}">class="active"</c:if>><a href="${result.menu_link}"><span>${result.menu_nm}</span><span class="arrow">활성화표시</span></a></li>
									</c:when>
									<c:otherwise>
										<li id="liTabcont_${status.index}" <c:if test="${param.seltab_idx eq status.index or (empty param.seltab_idx and status.index eq 0)}">class="active"</c:if>><a href="javascript:fn_egov_move_action(document.reqForm, '${result.menu_link}&srch_menu_nix=${result.srch_menu_nix}&seltab_idx=${status.index}')"><span>${result.menu_nm}</span><span class="arrow">활성화표시</span></a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</ul>
					</div>
					<!--//탭메뉴-->
				</c:if>
				
				
			<!-- 프로젝트마다 변경되는 게시판 내부의 레이아웃은 여기에 추가합니다 End  -->

				<tiles:insertAttribute name="boardContent"/>
				
			<!-- 프로젝트마다 변경되는 게시판 내부의 레이아웃은 여기에 추가합니다 Start -->
			
			</section>

			<!-- 프로젝트마다 변경되는 게시판 내부의 레이아웃은 여기에 추가합니다 End  -->

			<tiles:insertAttribute name="boardQuicklink"/>
		</section>
		
		<!-- layout-container//-->
		<footer id="footer">
			<tiles:insertAttribute name="boardFooter"/>
		</footer>
	</div>
	
	<div id="articleChkPwd" class="display_none">
		<article class="area_layerpopup">
			<h2><spring:message code="BOARD.PASSWORD-CHECK" /><%-- 비밀번호 확인 --%></h2>
			<div class="area_layerpopup_content">
				<table class="tstyle_list">
					<caption><spring:message code="BOARD.PASSWORD-CHECK" /><%-- 비밀번호 확인 --%></caption>
					<colgroup>
						<col width="25%" />
					</colgroup>
					<tbody>
						<tr>
						   <th scope="row"><label for="chkpwdval"><spring:message code="BOARD.PASSWORD" /><%-- 비밀번호 --%></label></th>
						   <td class="txt_left"><input type="password" name="chkpwdval" id="chkpwdval" value="" ></td>
						</tr>
					</tbody>
				</table>
			</div>
		
			<p class="right">
				<a href="javascript:fn_egov_chk_pwd()"><img src="${pageContext.request.contextPath}/images/template/content/btn_ok.gif" alt="<spring:message code="BOARD.OK" /><%-- 확인 --%>" /></a>
				<a href="javascript:fn_egov_hide_pwdlayer()"><img src="${pageContext.request.contextPath}/images/template/content/btn_close.gif" alt="<spring:message code="BOARD.CLOSE" /><%-- 닫기 --%>" /></a>
			</p>
		</article>
	</div>
</body>
</html>