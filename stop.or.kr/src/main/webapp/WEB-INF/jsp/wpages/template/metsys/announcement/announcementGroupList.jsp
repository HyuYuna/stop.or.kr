<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>

<script type="text/javascript">
jQuery(document).ready(function(){
	
	jQuery("#srch_mu_site, #srch_mu_lang").change(function(){
		jQuery("#pageIndex").val(1);
		fn_egov_cont_list();
	});
	
});
</script> 

<!-- content -->
<div id="container">
	<%-- <form:form name="reqForm" commandName="hireGroupVO">
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
	</form:form> --%>
	<table class="tstyle_list">
		<thead>
			<tr>
				<th scope="col" width="5%">번호</th>
				<th scope="col" width="*">공고 이름</th>
				<th scope="col" width="10%">공고 관리</th>
				<th scope="col" width="15%">등록일</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td><c:out value="${totCnt - (result.rn - 1)}"/></td>
				<td class="txt_left">
					<c:set var="viewParams" value="id=${result.group_id}" />	
					<a href="${cutil:getUrl('/metsys/announcementGroupForm.do', viewParams, true)}"><c:out value="${result.name}" /></a>
				</td>
				<td>
					<c:set var="viewParams" value="groupId=${result.group_id}&pageIndex=&page=${param.pageIndex}" />	
					<a href="${cutil:getUrl('/metsys/announcementDataList.do', viewParams, true)}">공고 관리</a>
				</td>
				<td><c:out value="${result.wdt}"/></td>
			</tr>
		</c:forEach>
		<c:if test = "${totCnt eq 0}">
			<tr>
				<td colspan="4">조회 결과가 없습니다.</td>
			</tr>
		</c:if>
		</tbody>
	</table>

	<c:if test="${totPage gt 1}">
		<div class="board_pager">
			<ui:pagination paginationInfo = "${paginationInfo}" type="plani" jsFunction="fn_egov_link_page" />
		</div>
	</c:if>
	
	<div class="btn_area_right">
		<a href="${cutil:getUrl('/metsys/announcementGroupForm.do', '', false)}" class="btn_line">등록</a>
	</div>
			
    <!-- //content -->
     
</div>
	


<form name="prevForm" method="post">
</form>    