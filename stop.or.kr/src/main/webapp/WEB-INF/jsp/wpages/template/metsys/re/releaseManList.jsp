<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!-- content -->
<div id="divMainArticle">

	<form:form name="reqForm" method="post" commandName="releaseVO">
	
		<h3>사전공표목록 관리</h3><br/>
			
			
			<table class="tstyle_list">
				<thead>
					<tr>
                       <th scope="col" width="5%">No.</th>
                       <th scope="col" >분류</th>
                       <th scope="col" >공표목록</th>
                       <th scope="col" width="20%">공표항목</th>
                       <th scope="col" >공표시기</th>
                       <th scope="col" >공표주기</th>
                       <th scope="col" >공표방법</th>
                       <th scope="col" width="10%">삭제</th>
                   </tr>
               </thead>
			<tbody id="list_content">
			
				<c:if test="${!empty releaseNotice}">
					<c:forEach var="resultNotice" items="${releaseNotice}" varStatus="status">
						<c:set var="viewParams" value="seq=${resultNotice.rel_seq}&pageIndex=${pageIndex}" />	
						<tr>
							<td>Notice</td>
							<td><c:out value="${resultNotice.division}"/></td>
							<td><c:out value="${resultNotice.rel_title}"/></td>
							<td><a href="${cutil:getUrl('/metsys/release/releaseForm.do', viewParams, true)}"><c:out value="${resultNotice.rel_content}"/></a></td>
							<td><c:out value="${resultNotice.rel_pblntf_cycle}"/></td>
							<td><c:out value="${resultNotice.rel_era}"/></td>
							<td><c:out value="${resultNotice.rel_mth}"/></td>
							<td><a href="${cutil:getUrl('/metsys/release/deleteRelease.do', viewParams, true)}" class="deleteRelease">삭제</a></td>
						</tr>
					</c:forEach>
				</c:if>

			
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<c:set var="viewParams" value="seq=${result.rel_seq}&pageIndex=${pageIndex}" />	
					<tr>
						<%-- <td><c:out value="${totCnt - (result.rn - 1)}"/></td> --%>
						<td><c:out value="${result.rn}"/></td>
						<td><c:out value="${result.division}"/></td>
						<td>
							<c:if test="${empty result.rel_dept }">
								2020년 이전 공표 자료
							</c:if>
							<c:if test="${not empty result.rel_dept }">
								<c:out value="${result.rel_title}"/>
							</c:if>
						</td>
						<td><a href="${cutil:getUrl('/metsys/release/releaseForm.do', viewParams, true)}"><c:out value="${result.rel_content}"/></a></td>
						<td><c:out value="${result.rel_pblntf_cycle}"/></td>
						<td><c:out value="${result.rel_era}"/></td>
						<td>
							<c:if test="${fn:trim(result.rel_mth) eq '1'}">링크</c:if>
							<c:if test="${fn:trim(result.rel_mth) eq '2'}">첨부파일</c:if>
						</td>
						<td><a href="${cutil:getUrl('/metsys/release/deleteRelease.do', viewParams, true)}" class="deleteRelease">삭제</a></td>
					</tr>
				</c:forEach>
				
				<c:if test="${paginationInfo.totalRecordCount eq 0}">
				<tr>
					<td colspan="4"> 조회 결과가 없습니다 </td>
				</tr>
				</c:if>
				
               </tbody>
		</table>
           
		<c:if test="${paginationInfo.totalPageCount gt 1}">
       		<div class="board_pager">
				<ui:pagination paginationInfo = "${paginationInfo}" type = "image"
					jsFunction = "fn_egov_link_page" />
			</div>
		</c:if>
	
		
		<c:set var="urlPageIndex" value="pageIndex=${pageIndex}" />
		<div class="btn_area_right"><a href="${cutil:getUrl('/metsys/release/releaseForm.do', urlPageIndex, true)}" class="btn_line">추가</a></div>
		
		<form:hidden path="rel_seq" />
		<form:hidden path="edomweivgp" />
		<form:hidden path="pageIndex"/>
		<form:hidden path="srch_mu_site"/>
		<form:hidden path="srch_mu_lang"/>
		
	</form:form>
</div>
<!-- //container -->
