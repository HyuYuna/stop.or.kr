<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>

<!-- content -->
<div id="container">



	<div style="text-align:center; font-size:20px; padding-bottom:20px"><strong>${announcementGroupVO.name}</strong></div>

	<form:form name="reqForm" commandName="announcementDataVO" method="get">
	<input type="hidden" name="groupId" value="${param.groupId}" />
	<input type="hidden" name="srch_menu_nix" value="${param.srch_menu_nix}" />
	<input type="hidden" name="pageIndex" value="1" />
	
		<div class="articles_search">		
			<p class="articles">전체 <span class="txt_bold">${totCnt}건</span>, 현재 페이지 <span class="total">${curPage}</span> / ${totPage } pages</p>		
			<div class="basic_searchForm">
				<form:select path="searchCondition">
					<form:option value="SUBJECT">제목</form:option>
					<form:option value="CONTENT">내용</form:option>
				</form:select>				
				<form:input path="searchKeyword" class="keyword" />
				<input type="submit" class="input_smallBlack" value="검색" />
			</div>
		</div>
	</form:form>


	<table class="tstyle_list">
		<thead>
			<tr>
				<th scope="col" width="5%">번호</th>
				<th scope="col" width="*">제목</th>
				<th scope="col" width="15%">모집기간</th>
				<th scope="col" width="15%">상태</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${!empty announcementDataNoticeList}">
			<c:forEach var="resultNotice" items="${announcementDataNoticeList}" varStatus="status">
				<tr>
					<td><span class="notice">NOTICE</span></td>
					<td class="txt_left" colspan="3">
						<c:set var="viewParams" value="id=${resultNotice.data_id}" />	
						<a href="${cutil:getUrl('/metsys/announcementDataForm.do', viewParams, true)}"><c:out value="${resultNotice.subject}" /></a>
					</td>
				</tr>
			</c:forEach>
		</c:if>		
	
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td><c:out value="${totCnt - (result.rn - 1)}"/></td>
				<td class="txt_left">
					<c:set var="viewParams" value="id=${result.data_id}" />	
					<a href="${cutil:getUrl('/metsys/announcementDataForm.do', viewParams, true)}"><c:out value="${result.subject}" /></a>
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

	<c:if test="${totPage gt 1}">
		<div class="board_pager">
			<ui:pagination paginationInfo = "${paginationInfo}" type="plani" jsFunction="fn_egov_link_page" />
		</div>
	</c:if>
	
	<div class="btn_area_right">
		<c:set var="groupListParam" value="page=&pageIndex=${param.page}" />
		<a href="${cutil:getUrl('/metsys/announcementGroupList.do', groupListParam, false)}" class="btn_line">공고목록</a>
		<c:set var="formParam" value="groupId=${param.groupId}&page=${param.page}" />
		<a href="${cutil:getUrl('/metsys/announcementDataForm.do', formParam, false)}" class="btn_line">등록</a>
	</div>
			
    <!-- //content -->
     
</div>
	


<form name="prevForm" method="post">
</form>    