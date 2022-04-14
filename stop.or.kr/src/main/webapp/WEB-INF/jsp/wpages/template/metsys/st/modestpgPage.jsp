<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

google.load("visualization", "1", {packages:["corechart"]});
google.setOnLoadCallback(drawChart);

function drawChart() {
		
	// 페이지별 통계 차트
	var data_page = new google.visualization.DataTable();
	data_page.addColumn('string', '페이지');
	data_page.addColumn('number', '접속수');
	data_page.addRows([
	<c:forEach var="page" items="${pageList}" varStatus="status">
	['<c:out value="${page.chartdata_key}"/>', <c:out value="${page.chartdata_val}"/>]
		<c:if test="${status.last eq false}">
		,
		</c:if>
    </c:forEach>
	]);
	
	var options_page = {
    	title: '페이지별 접속 통계'
  	};

	var chart_page = new google.visualization.BarChart(document.getElementById('chart_page'));
	chart_page.draw(data_page, options_page);
	
}


</script>


<form:form name="reqForm" commandName="commstatVO">		 
	
	<div class="articles_search">
		<div class="basic_searchForm">
			<div class="date_choice">
			<span class="txt_bold">단위선택</span>
				<span class="txt_bold"><label for="srchFromDT">기간입력</label></span> 
				<form:input path="srchFromDT" title="시작날짜 입력" maxlength="8"/> ~ 
				<form:input path="srchToDT" title="마지막 날짜 입력" maxlength="8" /> 
				<a href="javascript:fn_egov_statpg_refresh()" class="input_smallBlack">조회</a> 
			</div>
		</div>
	</div>	 
	
	<!-- 
	<br/>
	<div id="divPiechartArea" class="txt_center">	
		<img src="${pageContext.request.contextPath}/modest/viewstatCountry.do?date_choice=${commstatVO.date_choice}&srchFromDT=${commstatVO.srchFromDT}&srchToDT=${commstatVO.srchToDT}">
		<img src="${pageContext.request.contextPath}/modest/viewstatCity.do?date_choice=${commstatVO.date_choice}&srchFromDT=${commstatVO.srchFromDT}&srchToDT=${commstatVO.srchToDT}">
		<br/>
		<br/>
		<img src="${pageContext.request.contextPath}/modest/viewstatOS.do?date_choice=${commstatVO.date_choice}&srchFromDT=${commstatVO.srchFromDT}&srchToDT=${commstatVO.srchToDT}">
		<img src="${pageContext.request.contextPath}/modest/viewstatBrowser.do?date_choice=${commstatVO.date_choice}&srchFromDT=${commstatVO.srchFromDT}&srchToDT=${commstatVO.srchToDT}">
	</div>
	<div>&nbsp;</div>
	<div id="divLinechartAreaHour" class="txt_center">
		<img src="${pageContext.request.contextPath}/modest/viewstatVisitHourly.do?date_choice=${commstatVO.date_choice}&srchFromDT=${commstatVO.srchFromDT}&srchToDT=${commstatVO.srchToDT}">
	</div>
	<div>&nbsp;</div>
	<div id="divLinechartArea" class="txt_center">
		<c:choose>
			<c:when test="${commstatVO.date_choice eq 'YY'}">
				<img src="${pageContext.request.contextPath}/modest/viewstatVisitYearly.do?date_choice=${commstatVO.date_choice}&srchFromDT=${commstatVO.srchFromDT}&srchToDT=${commstatVO.srchToDT}">
			</c:when>
			<c:when test="${commstatVO.date_choice eq 'MM'}">
				<img src="${pageContext.request.contextPath}/modest/viewstatVisitMonthly.do?date_choice=${commstatVO.date_choice}&srchFromDT=${commstatVO.srchFromDT}&srchToDT=${commstatVO.srchToDT}">
			</c:when>
			<c:when test="${commstatVO.date_choice eq 'DD'}">
				<img src="${pageContext.request.contextPath}/modest/viewstatVisitDaily.do?date_choice=${commstatVO.date_choice}&srchFromDT=${commstatVO.srchFromDT}&srchToDT=${commstatVO.srchToDT}">
			</c:when>
		</c:choose>
	</div>
	 -->
	 
	 <div class="chart_area">

		<div id="divLinechartAreaPage" class="full_chart">
			<div id="chart_page" style="width:95%; height: 800px;"></div>
		</div>
		
	</div>
	
	<form:hidden path="srch_mu_site"/>
	<form:hidden path="srch_mu_lang"/>
	
	<p class="btn_area_right">
		<a href="javascript:cmmfn_download_xlsfile('${pageContext.request.contextPath}', '/modest/xlsModestpgPageList.do?srch_menu_nix=${param.srch_menu_nix}')" class="btn_line xls" id="axls" >XLS</a> 
	</p>
</form:form>    