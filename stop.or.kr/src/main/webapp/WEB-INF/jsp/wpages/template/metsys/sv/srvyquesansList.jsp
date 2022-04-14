<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<form:form name="reqForm" commandName="srvyquesansVO">

	<!-- content -->
	<div id="container">
		<h2><span class="point02">[ 설문 : ${partVO.srvy_nm} ] / [ 파트 : ${partVO.part_nm} ]</span></h2>
		<br/>	
		<div class="articles_search">		
			<p class="articles"><span class="txt_bold">질문 목록</span></p>		
			<div class="basic_searchForm">
				<!-- 검색기능 구현 필요 -->
				<select name="searchCondition" id="">
					<option value="">선택</option>
				</select>
				<input id="searchKeyword" name="searchKeyword" title="검색어 입력" type="text" value="">
				<a href="javascript:fn_egov_srvyquesans_search()" class="input_smallBlack">검색</a> 
				<!-- 검색기능 구현 필요 -->
			</div>
		</div>
		
		<div class="tablewrap">
			<table class="tstyle_list"  summary="질문 목록 조회">
				<caption>질문 목록</caption>
				<colgroup>
					<col width="5%"/>
					<col width="10%"/>
					<col/>
					<col width="10%"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="col">순번</th>
						<th scope="col">질문 타입</th>
						<th scope="col">질문</th>
						<th scope="col">작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td><c:out value="${result.rn}" /></td>
						<td><c:out value="${result.ques_type_nm}" /></td>
						<td class="txt_left"><a href="javascript:fn_egov_srvyquesans_mod('${result.ques_idx}', '${result.quesans_idx}')"><c:out value="${result.quesans_cont}" /></a></td>
						<td><c:out value="${result.wdt}" /></td>
					</tr>
					</c:forEach>
					<c:if test="${empty resultList}">
						<tr>
							<td colspan="4"> 조회 결과가 없습니다 </td>
						</tr>
					</c:if>
				</tbody>
			</table>	
		</div>
		
		<br/>
		
		<div class="btn_area_right">
			<c:if test="${param.srvy_act_yn eq 'N'}">
				<a href="javascript:fn_egov_srvyquesans_add()" class="btn_line">질문등록</a>
			</c:if>
			<a href="javascript:fn_egov_srvypart_list()" class="btn_line">챕터목록</a>
		</div>
		
		<br/>
		<br/>
		
	</div>

	<form:hidden path="edomweivgp"/>
	<form:hidden path="pageIndex"/>
	<form:hidden path="srvy_idx"/>
	<form:hidden path="part_idx"/>
	<form:hidden path="srvy_act_yn"/>
	<input type="hidden" id="ques_idx" name="ques_idx" value="0"/>
	
	<form:hidden path="srch_mu_site"/>
	<form:hidden path="srch_mu_lang"/>
	
	
</form:form>

