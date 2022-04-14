<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<form:form name="reqForm" commandName="accessipVO">

	<!-- content -->
	<div id="container">
	
		<div class="articles_search">		
			<p class="articles">전체 <span class="txt_bold">${totCnt}건</span>, 현재 페이지 <span class="total">${curPage}</span> / ${totPage } pages</p>		
			<div class="basic_searchForm">
				<!-- 검색기능 구현 필요 -->
				<select name="searchCondition" id="" style="margin-left: 20px">
					<option value="">선택</option>
				</select>
				<input id="searchKeyword" name="searchKeyword" title="검색어 입력" type="text" value="">
				<a href="javascript:fn_egov_accessip_search()" class="input_smallBlack">검색</a> 
				<!-- 검색기능 구현 필요 -->
			</div>
		</div>
		
		<div class="tablewrap">
			<table class="tstyle_list"  summary="accessip 목록 조회">
				<caption>accessip</caption>
				<colgroup>
					<col width="50"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="20%"/>
					<col width="10%"/>
					<col width="10%"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="col">순번</th>
						<th scope="col">권한</th>
						<th scope="col">접근 IP</th>
						<th scope="col">설명</th>
						<th scope="col">등록자</th>
						<th scope="col">등록일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td>${(totCnt + 1) - result.rn}</td>
						<td><a href="javascript:fn_egov_accessip_mod('${result.auth_cd}', '${result.access_ip}')"><c:out value="${result.auth_nm}" /></a>
						<td><a href="javascript:fn_egov_accessip_mod('${result.auth_cd}', '${result.access_ip}')"><c:out value="${result.access_ip}" /></a>
						<td class="txt_left"><a href="javascript:fn_egov_accessip_mod('${result.auth_cd}', '${result.access_ip}')"><c:out value="${result.description}" /></a>
						<td><c:out value="${result.writer}" />
						<td><c:out value="${result.wdt}" />
					</tr>
					</c:forEach>
					<c:if test="${totCnt eq 0}">
						<tr>
							<td colspan="6"> 조회 결과가 없습니다 </td>
						</tr>
					</c:if>
				</tbody>
			</table>	
		</div>
		
		<br/>
		
		<div class="btn_area_right">
			<a href="javascript:fn_egov_accessip_add()" class="btn_line">등록</a>
		</div>
		
		<br/>

		<!-- 게시글 리스트 페이징 -->
		<c:if test="${totPage gt 1}">
			<div class="board_pager">
				<ui:pagination paginationInfo="${paginationInfo}" type="image"
					jsFunction="fn_egov_link_page" />
			</div>
		</c:if>
		<!-- 게시글 리스트 페이징 //-->

		<br/>
		
	</div>

	<form:hidden path="edomweivgp"/>
	<form:hidden path="pageIndex"/>
	<form:hidden path="srch_mu_site"/>
	<form:hidden path="srch_mu_lang"/>
	<input type="hidden" id="auth_cd" name="auth_cd"/>
	<input type="hidden" id="access_ip" name="access_ip"/>
	
	
</form:form>

