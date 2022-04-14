<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>

<!-- content -->
<div id="container">
	<table class="tstyle_list">
		<thead>
			<tr>
				<th scope="col" width="5%">번호</th>
				<th scope="col" width="*">수상작 그룹</th>
				<th scope="col" width="10%">수상작 관리</th>
				<th scope="col" width="15%">등록일</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td><c:out value="${totCnt - (result.rn - 1)}"/></td>
				<td class="txt_left">
					<c:set var="viewParams" value="id=${result.group_id}" />	
					<a href="${cutil:getUrl('/metsys/awardsGroupForm.do', viewParams, true)}"><c:out value="${result.name}" /></a>
				</td>
				<td>
					<c:set var="viewParams" value="groupId=${result.group_id}&pageIndex=&page=${param.pageIndex}" />	
					<a href="${cutil:getUrl('/metsys/awardsDataList.do', viewParams, true)}">수상작 관리</a>
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
		<a href="${cutil:getUrl('/metsys/awardsGroupForm.do', '', false)}" class="btn_line">등록</a>
	</div>
			
    <!-- //content -->
     
</div>
	


<form name="prevForm" method="post">
</form>    