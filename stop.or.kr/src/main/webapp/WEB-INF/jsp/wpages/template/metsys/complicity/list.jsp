<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>

<script type="text/javascript">
jQuery(document).ready(function(){
	cmmfn_set_datepicker(g_context, jQuery("#sdate, #edate"), "%Y-%m-%d");
});
</script> 

<form:form name="searchForm" commandName="complicityItemVO" method="get">
	<form:hidden path="srch_menu_nix" />
	<div class="articles_search">		
		<p class="articles">전체 <span class="txt_bold">${totCnt}건</span>, 현재 페이지 <span class="total">${curPage}</span> / ${totPage } pages</p>		
		<div class="basic_searchForm">
			<form:input path="sdate"/> ~
			<form:input path="edate"/>
			<form:select path="searchCondition">
				<form:options items="${searchCondition}"/>
			</form:select>
			<form:input path="searchKeyword"/>
			<input type="submit" value="검색" class="input_smallBlack" />
		</div>
	</div>
	<form:hidden path="pageIndex" value="1"/>
	<form:hidden path="srch_mu_site"/>
	<form:hidden path="srch_mu_lang"/>
</form:form>

<!-- content -->
<div id="container">
	<table class="tstyle_list">
		<thead>
			<tr>
				<th scope="col" width="5%">번호</th>
				<th scope="col" width="*">접수번호</th>
				<th scope="col" width="10%">글쓴이</th>
				<th scope="col" width="10%">이메일</th>
				<th scope="col" width="10%">연락처</th>
				<th scope="col" width="10%">등록일</th>
				<th scope="col" width="10%">상태</th>
				<th scope="col" width="10%">결과</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td><c:out value="${totCnt - (result.rn - 1)}"/></td>
				<td>
					<c:set var="applicationParams" value="group_id=${result.group_id}&data_id=${result.data_id}" />	
					<a href="${cutil:getUrl('/metsys/complicityApplication.do', applicationParams, true)}"><c:out value="${result.data_id}"/></a>
				</td>
				<td><c:out value="${result.complicityVO.name}"/></td>
				<td><c:out value="${result.complicityVO.email}"/></td>
				<td><c:out value="${result.complicityVO.tel}"/></td>
				<td>${cutil:dateFormat(result.complicityVO.wdt, 'yy. MM. dd')}</td>
				<td>${cutil:complicityState(result.item_state)}</td>
				<td><c:out value="${result.item_awards}"/></td>
			</tr>
		</c:forEach>
		<c:if test = "${fn:length(resultList) eq 0}">
			<tr>
				<td colspan="8">조회 결과가 없습니다.</td>
			</tr>
		</c:if>
		</tbody>
	</table>

	<c:if test="${totPage gt 1}">
		<div class="board_pager">
			<ui:pagination paginationInfo = "${paginationInfo}" type="plani" jsFunction="fn_egov_link_page" />
		</div>
	</c:if>
    <!-- //content -->
     
</div>
<div class="btn_area_right">
	<a href="${cutil:getUrl('/metsys/complicityFileDownload.do', '', true)}" class="btn_line">작품 다운로드</a>
	<%-- <a href="javascript:cmmfn_download_xlsfile('${pageContext.request.contextPath}', '/metsys/complicityXlsDownload.do?srch_menu_nix=${param.srch_menu_nix}')"  class="btn_line">XLS 다운로드</a>--%> 
	<a href="${cutil:getUrl('/metsys/complicityXlsDownload.do', '', true)}"  class="btn_line">XLS 다운로드</a>
	<a href="${cutil:getUrl('/metsys/complicitySrvyXlsDownload.do', '', true)}"  class="btn_line">XLS 설문 다운로드</a>  
</div>
	