<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<form:form name="reqForm" commandName="srvypartVO">

	<!-- content -->
	<div id="container">
		<h2><span class="point02">[ 설문 : ${mainVO.srvy_nm} ]</span></h2>
		<br/>
		<div class="articles_search">		
			<p class="articles"><span class="txt_bold">챕터 목록</span></p>		
			<div class="basic_searchForm">
				<!-- 검색기능 구현 필요 -->
				<select name="searchCondition" id="">
					<option value="">선택</option>
				</select>
				<input id="searchKeyword" name="searchKeyword" title="검색어 입력" type="text" value="">
				<a href="javascript:fn_egov_srvypart_search()" class="input_smallBlack">검색</a> 
				<!-- 검색기능 구현 필요 -->
			</div>
		</div>
		
		<div class="tablewrap">
			<table class="tstyle_list"  summary="srvypart 목록 조회">
				<caption>srvypart</caption>
				<colgroup>
					<col width="10%"/>
					<col/>
					<col width="15%"/>
					<col width="15%"/>
					<col width="3%"/>
					<col width="120px"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="col">챕터 번호</th>
						<th scope="col">챕터 명</th>
						<th scope="col">챕터 구분</th>
						<th scope="col">생성일</th>
						<th scope="col" colspan="2">하위 질문</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td><c:out value="${result.rn}" /></td>
						<td class="txt_left"><a href="javascript:fn_egov_srvypart_mod('${result.srvy_idx}', '${result.part_idx}')"><c:out value="${result.part_nm}" /></a></td>
						<td><c:out value="${result.part_type eq 'CDIDX00062' ? '개인정보' : '일반챕터'}" /></td>
						<td><c:out value="${result.wdt}" /></td>
						<td><span class="point01"><c:out value="${result.part_ques_cnt}" /></span></td> 
						<td>
							<a href="javascript:fn_egov_srvypart_ques('${result.part_idx}')" class="btn_lineSmall" style="vertical-align:middle">질문목록</a>	
						</td>
					</tr>
					</c:forEach>
					<c:if test="${empty resultList}">
						<tr>
							<td colspan="6"> 조회 결과가 없습니다 </td>
						</tr>
					</c:if>
				</tbody>
			</table>	
		</div>
		
		<br/>
		
		<div class="btn_area_right">
			<c:if test="${mainVO.srvy_act_yn eq 'N'}">
				<a href="javascript:fn_egov_srvypart_add()" class="btn_line">챕터등록</a>
			</c:if>
			<a href="javascript:fn_egov_srvymain_list()" class="btn_line">설문목록</a>
		</div>
		
		<br/>
		<br/>
		
	</div>

	<form:hidden path="edomweivgp"/>
	<form:hidden path="pageIndex"/>
	<form:hidden path="srvy_idx"/>
	<input type="hidden" id="part_idx" name="part_idx" value="0"/>
	<input type="hidden" id="srvy_act_yn" name="srvy_act_yn" value="${mainVO.srvy_act_yn}"/>
	<form:hidden path="srch_mu_site"/>
	<form:hidden path="srch_mu_lang"/>
	
</form:form>

