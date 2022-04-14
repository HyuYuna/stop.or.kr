<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<form:form name="reqForm" commandName="srvymainVO">

	<!-- content -->
	<div id="container">
	
		<div class="articles_search">		
			<!--<p class="articles">전체 <span class="txt_bold">${totCnt}건</span>, 현재 페이지 <span class="total">${curPage}</span> / ${totPage } pages</p>-->		
			<div class="basic_searchForm">
				<!-- 검색기능 구현 필요 -->
				<form:select path="searchCondition">
					<form:option value="">선택</form:option>
					<form:option value="01">설문명</form:option>
				</form:select>
				<form:input path="searchKeyword" title="검색어 입력"/>
				<a href="javascript:fn_egov_srvymain_search()" class="input_smallBlack">검색</a> 
				<!-- 검색기능 구현 필요 -->
			</div>
		</div>
		
		<div class="tablewrap">
			<table class="tstyle_list"  summary="srvymain 목록 조회">
				<caption>srvymain</caption>
				<colgroup>
					<col width="5%"/>
					<col/>
					<col width="15%"/>
					<col width="10%"/>
					<col width="3%"/>
					<col width="150px"/>
					<col width="3%"/>
					<col width="150px"/>
					<col width="10%"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">설문조사 명</th>
						<th scope="col">설문조사 기간</th>
						<th scope="col">설문실시 여부</th>
						<th scope="col" colspan="2">챕터</th>
						<th scope="col" colspan="2">참여결과</th>
						<th scope="col">xls다운</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td><c:out value="${result.srvy_idx}" /></td>
						<td class="txt_left"><a href="javascript:fn_egov_srvymain_mod('${result.srvy_idx}')"><c:out value="${result.srvy_nm}" /></a></td>
						<td><c:out value="${result.srvy_start}" /> ~ <c:out value="${result.srvy_end}" /></td>
						<td><c:out value="${result.srvy_open_yn eq 'Y' ? '설문실시' : '실시안함'}"/></td>
						<td><span class="point01"><c:out value="${result.srvy_part_cnt}"/></span></td> 
						<td>
							<a href="javascript:fn_egov_srvymain_part('${result.srvy_idx}')" class="btn_lineSmall" style="vertical-align:middle">챕터목록</a> 	
						</td>
						<c:choose>
							<c:when test= "${result.srvy_appl_cnt gt 0}">
								<td><c:out value="${result.srvy_appl_cnt}"/></td>
								<td>
									<a href="${pageContext.request.contextPath}/manact/surveySrvymain/srvymainResult.do?srch_menu_nix=${param.srch_menu_nix}&srvy_idx=${result.srvy_idx}" class="btn_lineSmall" style="vertical-align:middle" target="_blank">결과보기</a>
								</td>
								<td>
									<a href="javascript:fn_egov_srvyresult_xls('${result.srvy_idx}')" class="btn_lineSmall" style="vertical-align:middle">XLS</a>
								</td>
							</c:when>
							<c:otherwise>
								<td colspan="2">-</td>
								<td>-</td>
							</c:otherwise>
						</c:choose>
					</tr>
					</c:forEach>
					<c:if test="${totCnt eq 0}">
						<tr>
							<td colspan="9"> 조회 결과가 없습니다 </td>
						</tr>
					</c:if>
				</tbody>
			</table>	
		</div>
		
		<br/>
		
		<div class="btn_area_right">
			<a href="javascript:fn_egov_srvymain_add()" class="btn_line">설문등록</a>
		</div>
		
		<br/>

		<!-- 게시글 리스트 페이징 -->
		<c:if test="${totPage gt 1}">
			<div class="board_pager">
				<ui:pagination paginationInfo="${paginationInfo}" type="image"
					jsFunction="fn_egov_link_page" />
			</div>
		</c:if>
		<!-- 게시글 리스트 페이징 //-->

		<br/>
		
	</div>

	<form:hidden path="edomweivgp"/>
	<form:hidden path="pageIndex"/>
	<input type="hidden" id="srvy_idx" name="srvy_idx" value="0"/>
	
	<form:hidden path="srch_mu_site"/>
	<form:hidden path="srch_mu_lang"/>
	
</form:form>

