<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>

<div id="divMainArticle">

	<form:form name="reqForm" commandName="withdrawalVO">
		<h3> 탈퇴회원 조회 </h3>
		<div class="srch_area">
			<c:if test="${SESS_USR_LV le '2'}">
				<form:input path="srchFromDT" title="검색어 입력"/> ~
				<form:input path="srchToDT" title="검색어 입력"/>
				<form:select path="searchCondition">
					<form:option value="log_uid">사용자ID</form:option>
					<form:option value="log_unm">사용자명</form:option>
				</form:select>
				<form:input path="searchKeyword" title="검색어 입력"/>
				<button id="btnSearchRefresh"><img src="${pageContext.request.contextPath}/main/images/template/sub/btn_srch.gif" alt="검색" /></button>
			</c:if>
		</div>
		<table id="tableSysmenuList" class="tstyle_list">
			<thead>
				<tr>
					<th scope="col" width="5%">번호</th>
					<th scope="col" width="10%">ID</th>
					<th scope="col" width="10%">이름</th>
					<th scope="col" width="18%">가입일시</th>
					<th scope="col" width="18%">탈퇴일시</th>
					<th scope="col" width="*">탈퇴사유</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr bgcolor="${linebg}">
					<td><c:out value="${result.rn}"/></td>
					<td><c:out value="${result.user_id}"/></td>
					<td><c:out value="${result.user_nm}"/></td>
					<td><c:out value="${result.jdt}"/></td>
					<td><c:out value="${result.wdt}"/></td>
					<td class="txt_left"><c:out value="${result.wreason}"/></td>
				</tr>
			</c:forEach>
			<c:if test = "${totCnt eq 0}">
				<tr id="trSysmenuEmpty">
					<td colspan="6">조회 결과가 없습니다.</td>
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
			<a href="javascript:cmmfn_download_xlsfile('${pageContext.request.contextPath}', '/modeur/xlsWithdrawalSave.do?srch_menu_nix=${param.srch_menu_nix}')" class="btn_line">XLS</a>
		</div>
	
		
		<form:hidden path="edomweivgp"/>
		<form:hidden path="pageIndex"/>
		<form:hidden path="srch_mu_site"/>
		<form:hidden path="srch_mu_lang"/>
		
	</form:form>
	
</div>