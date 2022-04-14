<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>

<form:form name="reqForm" commandName="mapVO" action="${cutil:getUrl('', '', false)}" method="get">
	<form:hidden path="srch_menu_nix" />
	<div class="articles_search">		
		<p class="articles">전체 <span class="txt_bold">${totCnt}건</span>, 현재 페이지 <span class="total">${curPage}</span> / ${totPage } pages</p>		
		<div class="basic_searchForm">
			<!-- 검색기능 구현 필요 -->
			<form:input path="searchKeyword" title="검색어 입력"/>
			<input type="submit" value="검색" class="input_smallBlack" />
		</div>
	</div>
<%-- 	<form:hidden path="map_idx" />
	<form:hidden path="edomweivgp" /> --%>
	<form:hidden path="pageIndex"/>
	<form:hidden path="srch_mu_site"/>
	<form:hidden path="srch_mu_lang"/>
</form:form>

<div id="container">
	<div class="tablewrap">
		<table class="tstyle_list"  summary="지원관리 목록 조회">
			<caption>지원관리관리</caption>
			<colgroup>
				<col width="10%"/>
				<col width="20%"/>
				<col width="50%"/>
				<col width="20%"/>
				<col width="10%"/>
			</colgroup>
			<thead>
				<tr>
					<th scope="col">순번</th>
					<th scope="col">카테고리</th>
					<th scope="col">지원기관명</th>
					<th scope="col">등록일</th>
					<th scope="col">삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td><c:out value="${totCnt - (result.rn - 1)}"/></td>
					<td><c:out value="${result.category }"/></td>
					<td><a href="${pageContext.request.contextPath}/manmap/mapForm.do?srch_menu_nix=${param.srch_menu_nix}&map_idx=${result.map_idx}"><c:out value="${result.name}"/></a></td>
					<td><c:out value="${result.wdt}" /></td>
					<td><a href="${pageContext.request.contextPath}/manmap/mapDelete.do?srch_menu_nix=${param.srch_menu_nix}&map_idx=${result.map_idx}" id="del" class="btn_line">삭제</a></td>
				</tr>
				</c:forEach>
				<c:if test="${totCnt eq 0}">
					<tr>
						<td colspan="5"> 조회 결과가 없습니다 </td>
					</tr>
				</c:if>
			</tbody>
		</table>	
	</div>
	

	
	<div class="btn_area_right">
		<a href="${pageContext.request.contextPath}/manmap/mapForm.do?srch_menu_nix=${param.srch_menu_nix}" class="btn_line">등록</a>
	</div>
	

	<!-- 게시글 리스트 페이징 -->
	<c:if test="${totPage gt 1}">
		<div class="board_pager">
			<ui:pagination paginationInfo="${paginationInfo}" type="image"
				jsFunction="fn_egov_link_page" />
		</div>
	</c:if>
	<!-- 게시글 리스트 페이징 //-->

</div>

<script>
$('a#del').click(function() {
	if(confirm("삭제 하시겠습니까?") == false) {
		return false;
	}
});
</script>