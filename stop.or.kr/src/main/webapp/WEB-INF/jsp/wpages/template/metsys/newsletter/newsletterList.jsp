<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>

<form:form name="reqForm" commandName="newsletterVO" action="${cutil:getUrl('', '', false)}" method="get">
	<form:hidden path="srch_menu_nix" />
	<div class="articles_search">		
		<p class="articles">전체 <span class="txt_bold">${totCnt}건</span>, 현재 페이지 <span class="total">${curPage}</span> / ${totPage } pages</p>		
		<div class="basic_searchForm">
			<!-- 검색기능 구현 필요 -->
			<form:input path="searchKeyword" title="검색어 입력"/>
			<input type="submit" value="검색" class="input_smallBlack" />
		</div>
	</div>
<%-- 	<form:hidden path="new_idx" /> --%>
<%-- 	<form:hidden path="edomweivgp" /> --%>
	<form:hidden path="pageIndex"/>
	<form:hidden path="srch_mu_site"/>
	<form:hidden path="srch_mu_lang"/>
</form:form>

<div id="container">
	<div class="tablewrap">
		<table class="tstyle_list"  summary="스케쥴관리 목록 조회">
			<caption>스케쥴관리</caption>
			<colgroup>
				<col width="10%"/>
				<col width="*"/>
				<col width="20%"/>
				<col width="20%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
			</colgroup>
			<thead>
				<tr>
					<th scope="col">순번</th>
					<th scope="col">이메일주소</th>
					<th scope="col">신청일</th>
					<th scope="col">취소일</th>
					<th scope="col">상태</th>
					<th scope="col">재동의</th>
					<th scope="col">삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td><c:out value="${totCnt - (result.rn - 1)}"/></td>
					
					<td><a href="${pageContext.request.contextPath}/mannewsletter/newsletterForm.do?srch_menu_nix=${param.srch_menu_nix}&new_idx=${result.new_idx}"><c:out value="${result.email}"/></a></td>
					<td><c:out value="${result.wdt}" /></td>
					<td>
						<c:if test="${!empty result.deldt }">
							${result.deldt }
						</c:if>
					</td>
					<td>
						<c:choose>
							<c:when test="${empty result.deldt }">
								동의
							</c:when>
							<c:otherwise>
								취소
							</c:otherwise>
						</c:choose>
					</td>
					<td><c:out value="${result.agree}" /></td>
					<td><a href="${pageContext.request.contextPath}/mannewsletter/newsletterDelete.do?srch_menu_nix=${param.srch_menu_nix}&new_idx=${result.new_idx}" id="del" class="btn_line">삭제</a></td>
				</tr>
				</c:forEach>
				<c:if test="${totCnt eq 0}">
					<tr>
						<td colspan="7"> 조회 결과가 없습니다 </td>
					</tr>
				</c:if>
			</tbody>
		</table>	
	</div>
	

	
	<div class="btn_area_right">
		<a href="${pageContext.request.contextPath}/mannewsletter/newsletterForm.do?srch_menu_nix=${param.srch_menu_nix}" class="btn_line">등록</a>
		<a href="javascript:download_xlsfile('${pageContext.request.contextPath}', '/mannewsletter/xlsNewsletterList.do?srch_menu_nix=${param.srch_menu_nix}')"  class="btn_line">XLS</a> 
	</div>
	

	<!-- 게시글 리스트 페이징 -->
	<c:if test="${totPage gt 1}">
		<div class="board_pager">
			<ui:pagination paginationInfo="${paginationInfo}" type="image"
				jsFunction="fn_egov_link_page" />
		</div>
	</c:if>
	<!-- 게시글 리스트 페이징 //-->

</div>

<script>
	$('a#del').click(function() {
		if(confirm("삭제 하시겠습니까?") == false) {
			return false;
		}
	});
	
	function download_xlsfile(context, acturl)
	{
		var reason = prompt("엑셀다운로드하는 사유는 무엇입니까?","이메일정보확인");
		if(reason){
			var $form = $('<form></form>');
			$form.attr('action', context + acturl+'&reason='+encodeURI(reason));
		    $form.attr('method', 'post');
		    $form.appendTo('body');
		    $form.submit();
		}else{
			alert('사유를 입력하셔야 다운로드가 가능합니다.');
		}
	}
</script>
