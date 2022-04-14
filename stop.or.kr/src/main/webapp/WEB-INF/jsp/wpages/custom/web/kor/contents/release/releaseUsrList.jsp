<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


	        
<!-- 상세콘텐츠 영역 -->
<%-- <div class="box1">
	<span class="bg"><img src="${pageContext.request.contextPath}/images/kor/sub/bg2.gif" alt=""></span>
	<p class="txt">
		한국여성인권진흥원의 성매매 방지, 여성·아동폭력 방지, 가정폭력 방지 등 여성인권 관련 다양한 사업내용을 국민들이 알 수 있도록 진흥원의 보유·관리 정보를 공개합니다.<br /><br />※ 공시주기 : 정기(매월), 최종수정일, 갱신예정일 : 익월 첫주 ~ 둘째주
	</p>
</div> --%>
<ul class="category"> 
	<li class="active"><a href="${pageContext.request.contextPath}/release/releaseUsrListBefore.do?${viewParams }&srch_menu_nix=${param.srch_menu_nix}&beforeRelease=Y" target="_blank" class="btn" title="새창열림">2020년 이전 자료 보기</a></li>
</ul>
<div class="table-wrap board">
	<table>
		<caption>공지사항 목록 - 번호, 분류, 제목, 담당부서, 등록일, 조회수</caption>
		<colgroup>
		<col style="width:5%">
		<col style="width:15%">
		<col style="width:30%">
		<col span="4">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">공표목록</th>
				<th scope="col">공표항목</th>
				<th scope="col">공표시기</th>
				<th scope="col">공표주기</th>
				<th scope="col">공표방법</th>
				<th scope="col">담당부서</th>
			</tr>
		</thead>
		<tbody>
				<c:if test="${!empty releaseNotice}">
					<c:forEach var="resultNotice" items="${releaseNotice}" varStatus="status">
						<c:set var="viewParams" value="seq=${resultNotice.rel_seq}&pageIndex=${pageIndex}" />	
						<tr>
							<td>Notice</td>
							<td class="subject">
								<c:choose>
									<c:when test="${!empty resultNotice.vchkcode}">
										<%-- <a href="javascript:cmmfn_download_atchfile('${pageContext.request.contextPath}', '${resultNotice.vchkcode}')"><c:out value="${resultNotice.rel_title}"/></a> --%>
										<a href="${pageContext.request.contextPath}/release/releaseUsrView.do?${viewParams }&srch_menu_nix=${param.srch_menu_nix}&rel_seq=${result.rel_seq}">
										<c:out value="${resultNotice.rel_title}"/></a>
									</c:when>
									<c:otherwise>
										<c:out value="${resultNotice.rel_title}"/>
									</c:otherwise>
								</c:choose>	
							</td>
							<td><c:out value="${resultNotice.rel_content}"/></td>
							<td><c:out value="${resultNotice.rel_era}"/></td>
							<td><c:out value="${resultNotice.rel_pblntf_cycle}"/></td>
							<td><c:out value="${resultNotice.rel_mth}"/></td>
							<td><c:out value="${resultNotice.rel_dept}"/></td>
						</tr>
					</c:forEach>
				</c:if>

				
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<c:set var="viewParams" value="seq=${result.rel_seq}&pageIndex=${pageIndex}" />	
					<tr>
						<td><c:out value="${totCnt - (result.rn - 1)}"/></td>
						<td>
							<c:if test="${empty result.rel_dept }">
								2020년 이전 공표 자료
							</c:if>
							<c:if test="${not empty result.rel_dept }">
								<c:out value="${result.rel_title}"/>
							</c:if>
						</td>
						<td>
							<a href="${pageContext.request.contextPath}/release/releaseUsrView.do?${viewParams }&srch_menu_nix=${param.srch_menu_nix}&rel_seq=${result.rel_seq}">
								<c:out value="${result.rel_content}"/></a></td>
						<td><c:out value="${result.rel_era}"/></td>
						<td><c:out value="${result.rel_pblntf_cycle}"/></td>
						<td>
							<c:if test="${fn:trim(result.rel_mth) eq '1'}">링크</c:if>
							<c:if test="${fn:trim(result.rel_mth) eq '2'}">첨부파일</c:if>
						</td>
						<td><c:out value="${result.rel_dept}"/></td>
					</tr>
				</c:forEach>
				
				<c:if test="${paginationInfo.totalRecordCount eq 0}">
					<tr>
						<td colspan="7"> 조회 결과가 없습니다 </td>
					</tr>
				</c:if>	
		</tbody>
	</table>	
</div>

<c:if test="${paginationInfo.totalPageCount gt 1}">
	<div class="pager">
		<ui:pagination paginationInfo="${paginationInfo}" type="text" jsFunction="fn_egov_link_page" />
	</div>
</c:if>

<script>
	function fn_egov_link_page(pageNo) {
		var form = document.reqForm;
		form.pageIndex.value = pageNo;

		form.submit();
	}
</script>

<div class="board-search">
	<form:form name="reqForm" class="search" commandName="releaseVO">
		<form:hidden path="pageIndex" value="${pageIndex}" />
		<form:select path="searchCondition">
			<form:option value="SUBJECT">제목</form:option>
		</form:select>
		<form:input path="searchKeyword" class="keyword" />
		<a href="#" class="btn" onclick="$('form.search').submit();">검색</a>
	</form:form>
</div>