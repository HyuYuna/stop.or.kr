<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!-- content -->
<div id="divMainArticle">

	<form:form name="reqForm" method="post" commandName="popupVO">
	
		<h3> 팝업 관리 </h3><br/>
			
			<%-- <div class="articles_search">		
			<!-- content -->
				<p class="articles">전체 <span class="txt_bold">${totCnt}건</span>, 현재 페이지 <span class="total">${curPage}</span> / ${totPage } pages</p>		
				<div class="basic_searchForm">
					<form:select path="searchPopType">
						<form:option value="">-팝업구분-</form:option>
						<form:option value="W">팝업창</form:option>
						<form:option value="Z">팝업존</form:option>
						<form:option value="V">비주얼</form:option>
						<form:option value="R">배너(관련사이트)</form:option>
					</form:select>
					<a href="javascript:fn_egov_popup_list()" id="btnSearchRefresh" class="input_smallBlack">검색</a> 
					
				</div>
			</div> --%>
			<table class="tstyle_list">
				<thead>
					<tr>
                       <th scope="col" width="5%">No.</th>
                       <th scope="col" width="8%">구분</th>
                       <th scope="col" width="13%">Img</th>
                       <th scope="col">제목</th>
                       <th scope="col" width="20%">기간</th>
                       <th scope="col" width="7%">사용</th>
                       <th scope="col" width="15%">수정/삭제</th>
                       <!-- <th scope="col" width="10%">순서변경</th> -->
                   </tr>
               </thead>
			<tbody id="list_content">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<c:choose>
						<c:when test="${result.use_yn ne 'Y'}">
		            		<tr class="popup_unuse">
		            	</c:when>
		            	<c:otherwise>
		            		<tr>
		            	</c:otherwise>
	            	</c:choose>
							<td><c:out value="${result.rn}"/></td>
							<td>
								<c:choose>
									<c:when test="${result.pop_type eq 'W'}">
										팝업창
									</c:when>
									<c:when test="${result.pop_type eq 'Z'}">
										팝업존
									</c:when>
									<c:when test="${result.pop_type eq 'V'}">
										비주얼
									</c:when>
									<c:when test="${result.pop_type eq 'C'}">
										공모전 비주얼
									</c:when>
									<c:when test="${result.pop_type eq 'R'}">
										관련사이트
									</c:when>
									<c:when test="${result.pop_type eq 'E'}">
										영문비주얼
									</c:when>
								</c:choose>
							<td>
								<img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${result.vchkcode}" width="100" alt="${result.pop_title}"/>
							</td>
							<td class="txt_left"><a href="javascript:fn_egov_popup_view('${result.pop_seq}')"><c:out value="${result.pop_title}"/></a></td>
							<td><c:out value="${result.pop_from} ~ ${result.pop_to}"/></td>
							<td>
								<a href="javascript:fn_egov_popup_usetgl('${result.pop_seq}')">
								<c:choose>
									<c:when test="${result.use_yn eq 'Y'}">사용</c:when>
									<c:otherwise><strike>미사용</strike></c:otherwise>
								</c:choose></a>
							</td>
							<td>
								<a href="javascript:fn_egov_popup_moddrct('${result.pop_seq}')" class="btn_lineSmall">수정</a> 
								<a href="javascript:fn_egov_popup_del('${result.pop_seq}')") class="btn_lineSmall">삭제</a>
							</td>
							<!-- 
							<td>							
								<a href="sortPopup.do?seq=${result.pop_seq}&sort_dir=up&${popVo.urlParams}&srch_menu_nix=${param.srch_menu_nix}">
									<img src="${pageContext.request.contextPath}/images/template/sub/btn_up.gif" alt="위로"/>
								</a>
								<a href="sortPopup.do?seq=${result.pop_seq}&sort_dir=down&${popVo.urlParams}&srch_menu_nix=${param.srch_menu_nix}">
									<img src="${pageContext.request.contextPath}/images/template/sub/btn_down.gif" alt="아래로"/>
								</a>
							</td>
							 -->
						</tr>
				</c:forEach>
				
				<c:if test="${paginationInfo.totalRecordCount eq 0}">
				<tr>
					<td colspan="7"> 조회 결과가 없습니다 </td>
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

		<div class="btn_area_right"><a href="javascript:fn_egov_popup_add()" class="btn_line">추가</a></div>
		
		<form:hidden path="pop_seq" />
		<form:hidden path="edomweivgp" />
		<form:hidden path="pageIndex"/>
		<form:hidden path="srch_mu_site"/>
		<form:hidden path="srch_mu_lang"/>
		
	</form:form>
</div>
<!-- //container -->


    