<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="toDay" class="java.util.Date" />
<fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd" var="today"/>
<fmt:parseDate value="${today}" var="todayPlanDate" pattern="yyyy-MM-dd"/>
<fmt:parseNumber value="${todayPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="todayDate"></fmt:parseNumber>




<form:form name="reqForm" class="reqForm" commandName="srvymainVO">
<div class="table-wrap board">
	<table>
		<caption>설문조사 목록 - 번호, 제목, 설문기간, 상태</caption>
		<colgroup>
			<col class="date">
			<col class="subject">
			<col class="part">
			<col class="date">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">제목</th>
				<th scope="col">설문기간</th>
				<th scope="col">상태</th>
			</tr>
		</thead>
		<tbody>
			
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<fmt:parseDate value="${result.srvy_end}" var="endPlanDate" pattern="yyyy-MM-dd"/>
				<fmt:parseNumber value="${endPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>
				<fmt:parseNumber value="${todayDate - endDate}" integerOnly="true" var="srvyVaildDay"></fmt:parseNumber>
				
				<tr>
					<td><c:out value="${totCnt - (result.rn - 1)}"/></td>
					<td class="subject">
						<c:choose>
							<c:when test="${srvyVaildDay <= 0 and result.srvy_open_yn eq 'Y'}">
								<%-- <a href="javascript:fn_egov_srvymain_view('${result.srvy_idx}')"><c:out value="${result.srvy_nm}" /></a> --%>
								<a href="${pageContext.request.contextPath}/usract/surveySrvydata/srvyView.do?srch_menu_nix=${param.srch_menu_nix}&seltab_idx=1&srvy_idx=${result.srvy_idx}"><c:out value="${result.srvy_nm}" /></a>
							</c:when>
							<c:otherwise>
								<a href="#" onclick="alert('종료된 설문입니다.'); return false;"><c:out value="${result.srvy_nm}" /></a>
							</c:otherwise>
						</c:choose>
						
					</td>
					<td><c:out value="${result.srvy_start}" /> ~ <c:out value="${result.srvy_end}" /></td>
					<td>						
						<c:choose>
							<c:when test="${srvyVaildDay <= 0 and result.srvy_open_yn eq 'Y'}">
								<span class="icon3 type1">진행중</span>
							</c:when>
							<c:otherwise>
								<span class="icon3 type2">완료</span>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
			
		</tbody>
	</table>
</div>

<c:if test="${totPage gt 1}">
	<div class="pager">
		<ui:pagination paginationInfo = "${paginationInfo}" type="user" jsFunction="fn_egov_link_page" />
	</div>
</c:if>

<div class="board-search">
	<label for="searchCondition" class="hidden-text">검색 구분</label>
	<form:select path="searchCondition" title="검색 항목 선택">
		<form:option value="01">제목</form:option>
		<form:option value="02">내용</form:option>
	</form:select>
	<label for="searchKeyword" class="hidden-text">검색어 입력</label>
	<form:input path="searchKeyword" class="input_mid"/>
	<a href="#" onclick="$('form.reqForm').submit();return false;" class="btn">검색</a>
</div>

	<form:hidden path="edomweivgp"/>
	<form:hidden path="pageIndex"/>
	<input type="hidden" id="srvy_idx" name="srvy_idx" value="0"/>
	
	<form:hidden path="srch_mu_site"/>
	<form:hidden path="srch_mu_lang"/>

</form:form>















