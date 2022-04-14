<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script>
	$(function(){
		if (window.location.href.indexOf("/awards/list.do?groupId=IDX000013") > -1) {
			$("h1.title5").text("2020년 여성폭력방지 콘텐츠 공모전");
		}
		if (window.location.href.indexOf("/awards/view.do?groupId=IDX000013") > -1) {
			$("h1.title5").text("2020년 여성폭력방지 콘텐츠 공모전");
		}
		if (window.location.href.indexOf("/awards/list.do?groupId=IDX000014") > -1) {
			$("h1.title5").text("2020년 여성폭력방지 콘텐츠 공모전");
		}
		if (window.location.href.indexOf("/awards/view.do?groupId=IDX000014") > -1) {
			$("h1.title5").text("2020년 여성폭력방지 콘텐츠 공모전");
		}
		if (window.location.href.indexOf("/awards/list.do?groupId=IDX000015") > -1) {
			$("h1.title5").text("2020년 여성폭력방지 콘텐츠 공모전");
		}
		if (window.location.href.indexOf("/awards/view.do?groupId=IDX000015") > -1) {
			$("h1.title5").text("2020년 여성폭력방지 콘텐츠 공모전");
		}
		if (window.location.href.indexOf("/awards/list.do?groupId=IDX000016") > -1) {
			$("h1.title5").text("2021년 여성폭력방지 콘텐츠 공모전");
		}
		if (window.location.href.indexOf("/awards/view.do?groupId=IDX000016") > -1) {
			$("h1.title5").text("2021년 여성폭력방지 콘텐츠 공모전");
		}
		if (window.location.href.indexOf("/awards/list.do?groupId=IDX000017") > -1) {
			$("h1.title5").text("2021년 여성폭력방지 콘텐츠 공모전");
		}
		if (window.location.href.indexOf("/awards/view.do?groupId=IDX000017") > -1) {
			$("h1.title5").text("2021년 여성폭력방지 콘텐츠 공모전");
		}
		if (window.location.href.indexOf("/awards/list.do?groupId=IDX000018") > -1) {
			$("h1.title5").text("2021년 여성폭력방지 콘텐츠 공모전");
		}
		if (window.location.href.indexOf("/awards/view.do?groupId=IDX000018") > -1) {
			$("h1.title5").text("2021년 여성폭력방지 콘텐츠 공모전");
		}
	});
</script>

<h1 class="title5">${tabmenu_nm} 성매매방지 콘텐츠 공모전</h1>
<div class="box1" style="margin-bottom:10px;">
	<div class="item">
		<span class="icon"><img src="../../../images/kor/sub/icon1.gif" alt=""></span>
		<p class="txt">
			작품을 클릭하면 작품 전체 이미지를 볼 수 있습니다.<br />
			본 콘텐츠의 저작권은 수상자에게 있습니다. 자료 사용을 원하시는 경우, 한국여성인권진흥원으로 문의해 주시기 바랍니다<br />
			※ 공모전 문의 : 정책홍보팀 02-6363-8436<br />
			※ 콘텐츠 사용 문의 : 전략기획팀 02-6363-8311 pr@stop.or.kr
		</p>
	</div>
</div>

<ul class="tabmenu">
	<c:forEach var="tabmenu2" items="${tabmenu2}">
		<c:choose>
			<c:when test="${tabmenu2.blank_yn eq 'Y'}">
				<c:set var="target" value="_blank"/>
			</c:when>
			<c:otherwise>
				<c:set var="target" value=""/>
			</c:otherwise>
		</c:choose>

		<c:choose>
			<c:when test="${fn:indexOf(tabmenu2.menu_link,'?') > 0}">
				<c:set var="tag_url" value="&"/>
			</c:when>
			<c:otherwise>
				<c:set var="tag_url" value="?"/>
			</c:otherwise>
		</c:choose>

		<c:choose>
			<c:when test="${fn:indexOf(tabmenu2.menu_link,'srch_menu_nix=') < 0}">
				<c:set var="a_link" value="${pageContext.request.contextPath}${tabmenu2.menu_link}${tag_url}srch_menu_nix=${tabmenu2.menu_nix}&srch_mu_site=${param.srch_mu_site}"/>
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${tabmenu2.menu_link eq 'UNDER_CONSTRUCT'}">
						<c:set var="a_link" value="javascript:fn_egov_under_construct()"/>
					</c:when>

					<c:otherwise>
						<c:set var="a_link" value="${pageContext.request.contextPath}${tabmenu2.menu_link}${tag_url}&srch_mu_site=${param.srch_mu_site}"/>
					</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>
		<li <c:if test="${tabmenu2_idx eq tabmenu2.menu_idx}">class="active"</c:if>><a href="${a_link}" <c:if test="${!empty target}">target="${target}"</c:if>>${tabmenu2.menu_nm}</a></li>
	</c:forEach>
</ul>

