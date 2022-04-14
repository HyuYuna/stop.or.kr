<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>

<form:form name="reqForm" commandName="memberVO" action="${cutil:getUrl('', '', false)}" method="get">
	<form:hidden path="srch_menu_nix" />
	<div class="articles_search">		
		<p class="articles">전체 <span class="txt_bold">${totCnt}건</span>, 현재 페이지 <span class="total">${curPage}</span> / ${totPage } pages</p>		
		<div class="basic_searchForm">
			권한 :
			<form:select path="user_auth_lv">
				<form:option value="0">전체</form:option>
				<form:option value="100">관리자</form:option>
				<form:option value="10000">사용자</form:option>
			</form:select>
			<form:input path="searchKeyword" title="검색어 입력"/>
			<input type="submit" value="검색" class="input_smallBlack" />
			<!-- <a href="javascript:fn_egov_mem_search()" id="btnSearchRefresh" class="input_smallBlack">검색</a>  -->
		</div>
	</div>
</form:form>
	
<table class="tstyle_list">
	<thead>
		<tr> 
			<!--  <th scope="col" width="4%"><input type="checkbox" name="chk" title="선택하기" /></th> -->
			<th scope="col" width="5%">No.</th>
			<th scope="col" width="10%">ID</th>
			<th scope="col" width="10%">성명</th>
			<th scope="col">이메일</th>
			<th scope="col" width="10%">H.P</th>
			<!-- <th scope="col" width="10%">연락처</th> -->
			<th scope="col" width="15%">권한</th>
			<th scope="col" width="15%">등록일</th>
			<th scope="col" width="10%">계정잠김</th>
		</tr>
	</thead>
	<tbody id="list_content">
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td><c:out value="${result.rn}"/></td>
				<c:choose>
					<c:when test="${SESS_USR_LV le 2 or result.user_id eq SESS_USR_ID}">
						<td>
						<%-- <a href="javascript:fn_egov_mem_mod('<c:out value="${result.user_id}"/>')">
							<c:out value="${result.user_id}"/>
							</a> --%>
							<c:set var="viewParams" value="id=${result.user_id}" />	
							<a href="${cutil:getUrl('/modeur/modeurView.do', viewParams, true)}">${result.user_id}</a>
						</td>
					</c:when>
					<c:otherwise>
						<td><c:out value="${result.user_id}"/></td>
					</c:otherwise>
				</c:choose>
				<td><c:out value="${result.user_nm}"/></td>
				<td class="txt_left"><c:out value="${elfunc:decode(result.user_email)}"/></td>
				<td><c:out value="${elfunc:decode(result.user_cp_1)}-${elfunc:decode(result.user_cp_2)}-${elfunc:decode(result.user_cp_3)}"/></td>
				<%-- <td><c:out value="${elfunc:decode(result.user_tel_1)}-${elfunc:decode(result.user_tel_2)}-${elfunc:decode(result.user_tel_3)}"/></td> --%>
				<td><c:out value="${result.user_auth_nm}"/></td>
				<td><c:out value="${result.wdt}"/></td>
				<td><c:out value="${result.is_lock}"/></td>
			</tr>
		</c:forEach>
		<c:if test="${paginationInfo.totalRecordCount eq 0}">
			<tr>
				<td colspan="8">조회 결과가 없습니다.</td>
			</tr>
		</c:if>
	</tbody>
</table>
<c:if test="${paginationInfo.totalPageCount gt 1}">
	<div class="board_pager">
		<ui:pagination paginationInfo = "${paginationInfo}" type="plani" jsFunction="fn_egov_link_page" />
	</div>
</c:if>
<div class="btn_area_right">
	<c:if test="${SESS_USR_LV le 2}"> <a href="${cutil:getUrl('/modeur/modeurView.do', '', false)}" class="btn_line">등록</a> </c:if>
	<%-- <c:if test="${SESS_USR_LV le 2}"> <a href="javascript:fn_egov_mem_add()" class="btn_line">등록</a> </c:if> --%>
	<a href="javascript:cmmfn_download_xlsfile('${pageContext.request.contextPath}', '/modeur/xlsModeurList.do?srch_menu_nix=${param.srch_menu_nix}')"  class="btn_line">XLS</a> 
</div>
	
