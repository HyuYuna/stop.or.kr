<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
jQuery(document).ready(function(){
	
	jQuery("#srch_mu_site, #srch_mu_lang").change(function(){
		jQuery("#pageIndex").val(1);
		fn_egov_cont_list();
	});
	
});

</script> 


<form:form name="reqForm" commandName="contentsmanVO">
	
	<!-- content -->
	<div id="container">
		
			<div class="articles_search">		
				<p class="articles">전체 <span class="txt_bold">${totCnt}건</span>, 현재 페이지 <span class="total">${curPage}</span> / ${totPage } pages</p>		
				<div class="basic_searchForm">
					<form:hidden path="srch_mu_gub" value="USR"/>
					사이트 : 
					<form:select path="srch_mu_site" title="사이트구분 선택">
						<form:options items="${sitecode}" itemLabel="code_nm" itemValue="code_idx"/>
					</form:select>
					&nbsp;
					언어 : 
					<form:select path="srch_mu_lang" title="언어구분 선택">
						<form:options items="${langcode}" itemLabel="code_nm" itemValue="code_idx"/>
					</form:select>
					<select name="searchCondition" id="" style="margin-left: 20px">
						<option value="UCONT_SUBJECT">제목</option>
						<option value="UCONT_CONT">내용</option>
						<option value="SC_ALL">제목 + 내용</option>
					</select>
					<input id="searchKeyword" name="searchKeyword" title="검색어 입력" type="text" value="">
					<a href="javascript:fn_egov_srch_list()" id="btnSearchRefresh" class="input_smallBlack">검색</a> 
				</div>
			</div>
			
			<table class="tstyle_list">
				<thead>
					<tr>
						<th scope="col" width="5%">No.</th>
						<th scope="col" width="7%">사이트</th>
						<th scope="col" width="7%">언어</th>
						<th scope="col" width="*">컨텐츠 제목</th>
						<th scope="col" width="10%">등록인</th>
						<th scope="col" width="15%">등록일시</th>
						<th scope="col" width="7%">미리보기</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td><c:out value="${result.rn}"/></td>
						<td>
							<c:choose>
								<c:when test="${result.mu_site eq 'CDIDX00002'}">대표웹</c:when>
								<c:when test="${result.mu_site eq 'CDIDX00003'}">모바일</c:when>
								<c:when test="${result.mu_site eq 'CDIDX00004'}">공모전</c:when>
								<c:when test="${result.mu_site eq 'CDIDX00005'}">여성폭력줌인</c:when>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${result.mu_lang eq 'CDIDX00022'}">국문</c:when>
								<c:when test="${result.mu_lang eq 'CDIDX00023'}">영문</c:when>
								<c:when test="${result.mu_lang eq 'CDIDX00024'}">중문</c:when>
								<c:when test="${result.mu_lang eq 'CDIDX00025'}">일문</c:when>
							</c:choose>
						</td>
						<td class="txt_left"><a href="javascript:fn_egov_cont_view('${result.ucont_id}')"><c:out value="${result.ucont_dft}"/></a></td>
						<td><c:out value="${result.writer_nm}"/></td>
						<td><c:out value="${result.wdt}"/></td>
						<td>
							<a href="javascript:fn_egov_cont_mainprev('${result.ucont_id}', '${result.ucont_version}')">
								<img src="${pageContext.request.contextPath}/images/template/cmm/preview_file.png" width="24" height="24" alt="미리보기">
							</a>
						</td>
					</tr>
				</c:forEach>
				<c:if test = "${totCnt eq 0}">
					<tr>
						<td colspan="7">조회 결과가 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
			</table>

			<c:if test="${totPage gt 1}">
				<div class="board_pager">
					<ui:pagination paginationInfo = "${paginationInfo}" type="image"
						jsFunction="fn_egov_link_page" />
				</div>
			</c:if>
			
			<div class="btn_area_right">
				<a href="javascript:fn_egov_cont_add()" class="btn_line">추가</a>
			</div>
				
	    <!-- //content -->
	     
	</div>
	
	<form:hidden path="edomweivgp"/>
	<form:hidden path="pageIndex"/>
	<form:hidden path="ucont_id"/>
	<form:hidden path="ucont_version"/>

</form:form>

<form name="prevForm" method="post">
</form>    