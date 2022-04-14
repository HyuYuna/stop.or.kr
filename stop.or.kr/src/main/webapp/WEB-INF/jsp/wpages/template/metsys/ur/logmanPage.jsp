<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>

<form:form name="reqForm" commandName="manlogVO">
	<div class="articles_search">		
		<p class="articles">전체 <span class="txt_bold">${totCnt}건</span>, 현재 페이지 <span class="total">${curPage}</span> / ${totPage } pages</p>		
		<div class="basic_searchForm">
			<c:if test="${SESS_USR_LV le '2'}">
				<form:input path="srchFromDT" title="검색어 입력"/> ~
				<form:input path="srchToDT" title="검색어 입력"/>
				<form:select path="searchCondition">
					<form:option value="log_uid">사용자ID</form:option>
					<form:option value="log_unm">사용자명</form:option>
					<form:option value="log_key_nm">작업분류</form:option>
				</form:select>
				<form:input path="searchKeyword" title="검색어 입력"/>
				<a href="javascript:fn_egov_search_refresh()" id="btnSearchRefresh" class="input_smallBlack">검색</a> 
			</c:if>
		</div>
	</div>
	<table id="tableSysmenuList" class="tstyle_list">
		<thead>
			<tr>
				<th scope="col" width="5%">번호</th>
				<th scope="col" width="10%">ID</th>
				<th scope="col" width="10%">이름</th>
				<th scope="col" width="10%">IP주소</th>
				<th scope="col" width="10%">작업분류</th>
				<th scope="col" width="8%">구분</th>
				<th scope="col" width="*">상세내역</th>
				<th scope="col" width="14%">일시</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr bgcolor="${linebg}">
				<td><c:out value="${result.rn}"/></td>
				<td><c:out value="${result.log_uid}"/></td>
				<td><c:out value="${result.log_unm}"/></td>
				<td><c:out value="${elfunc:decode(result.log_raddr)}"/></td>
				<td class="txt_left"><c:out value="${result.log_key_nm}"/></td>
				<td>
					<c:choose>
						<c:when test="${result.log_job_gb eq 'C'}">등록</c:when> 
						<c:when test="${result.log_job_gb eq 'R'}">상세조회</c:when> 
						<c:when test="${result.log_job_gb eq 'U'}">변경</c:when> 
						<c:when test="${result.log_job_gb eq 'D'}">삭제</c:when> 
						<c:when test="${result.log_job_gb eq 'L'}">목록조회</c:when> 
						<c:when test="${result.log_job_gb eq 'X'}">엑셀저장</c:when> 
						<c:otherwise>기타</c:otherwise>
					</c:choose>	
				</td>
				<td class="txt_left"><c:out value="${result.log_key_dest}"/></td>
				<td><c:out value="${result.log_dt}"/></td>
			</tr>
		</c:forEach>
		<c:if test = "${totCnt eq 0}">
			<tr id="trSysmenuEmpty">
				<td colspan="8">조회 결과가 없습니다.</td>
			</tr>
		</c:if>
		</tbody>
	</table>		
		<c:if test="${paginationInfo.totalPageCount gt 1}">
		<div class="board_pager">
			<ui:pagination paginationInfo = "${paginationInfo}" type="image"
				jsFunction="fn_egov_link_page" />
		</div>		
		</c:if>
	<div class="btn_area_right">
		<a href="javascript:cmmfn_download_xlsfile('${pageContext.request.contextPath}', '/manlog/xlsManlogSave.do?srch_menu_nix=${param.srch_menu_nix}')" class="btn_line">XLS</a>
	</div>
	
	<form:hidden path="edomweivgp"/>
	<form:hidden path="pageIndex"/>	
	<form:hidden path="srch_mu_site"/>
	<form:hidden path="srch_mu_lang"/>
		
</form:form>	