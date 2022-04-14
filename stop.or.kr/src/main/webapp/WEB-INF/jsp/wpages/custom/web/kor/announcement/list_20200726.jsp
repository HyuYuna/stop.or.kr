<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${param.groupId eq 'IDX000003' }">
	<div class="box1">
		<div class="item">
			<span class="icon"><img src="${pageContext.request.contextPath}/images/kor/sub/icon1.gif" alt="" /></span>
			<p class="txt">채용공고 게시를 원하시는 경우 연구홍보팀으로 문의해 주시기 바랍니다.문의메일 : simhyea@stop.or.kr</p>
		</div>
	</div>
</c:if>

<div class="table-wrap board">
	<table>
		<caption>게시판 목록 - 번호, 제목, 모집기간, 상태 정보제공</caption>
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
				<th scope="col">모집기간</th>
				<th scope="col">상태</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${!empty announcementDataNoticeList}">
			<c:forEach var="resultNotice" items="${announcementDataNoticeList}" varStatus="status">
				<tr>
					<td><span class="notice">NOTICE</span></td>
					<td class="subject" colspan="3">
						<c:set var="viewParams" value="id=${resultNotice.data_id}" />	
						<a href="${cutil:getUrl('/announcement/view.do', viewParams, true)}"><c:out value="${resultNotice.subject}" /></a>
					</td>
				</tr>
			</c:forEach>
		</c:if>		
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td><c:out value="${totCnt - (result.rn - 1)}"/></td>
				<td class="subject">
					<%-- <c:set var="viewParams" value="id=${result.data_id}" /> --%>	
					<%-- <a href="${cutil:getUrl('/announcement/view.do', viewParams, true)}"><c:out value="${result.subject}" /></a> --%>
					<a href="/announcement/view.do?groupId=${result.group_id}&srch_menu_nix=${param.srch_menu_nix }&id=${result.data_id}"><c:out value="${result.subject}" /></a>
					<!-- <span class="new">새글</span> -->
				</td>
				<td>
					<c:choose>
						<c:when test="${result.date_start ne null && result.date_end ne null}">
						${cutil:dateFormat(result.date_start, 'yyyy.MM.dd')} ~ ${cutil:dateFormat(result.date_end, 'yyyy.MM.dd')}
						</c:when>
						<c:otherwise>
						-
						</c:otherwise>
					</c:choose>
				</td>
				<td>${cutil:dateCheck(result.date_start, result.date_end, '-', '진행중', '마감')}</td>
			</tr>
		</c:forEach>
		<c:if test = "${totCnt eq 0}">
			<tr>
				<td colspan="4">조회 결과가 없습니다.</td>
			</tr>
		</c:if>
		</tbody>
	</table>
</div>

<c:if test="${totPage gt 1}">
	<div class="pager">
		<ui:pagination paginationInfo = "${paginationInfo}" type="user" jsFunction="fn_egov_link_page" />
	</div>
</c:if>

<div class="board-search">
	<form:form id="serarchForm" class="search" commandName="announcementDataVO" method="get">
	<input type="hidden" name="groupId" value="${param.groupId}" />
	<input type="hidden" name="srch_menu_nix" value="${param.srch_menu_nix}" />
	<input type="hidden" name="pageIndex" value="1" />
	<form:select path="searchCondition">
		<form:option value="SUBJECT">제목</form:option>
		<form:option value="CONTENT">내용</form:option>
	</form:select>
	<form:input path="searchKeyword" class="keyword" />
	<a href="#" class="btn" onclick="$('#serarchForm').submit(); return false;">검색</a>
	</form:form>
</div>

