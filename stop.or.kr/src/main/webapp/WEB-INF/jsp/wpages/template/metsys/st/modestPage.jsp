<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

google.load("visualization", "1", {packages:["corechart"]});
google.setOnLoadCallback(drawChart);

function drawChart() {
	
	// 국가별 통계 차트
	var data_country = google.visualization.arrayToDataTable([
	    
	    ['Task', 'Hours per Day'],
		<c:forEach var="country" items="${countryList}" varStatus="status">
			['<c:out value="${country.chartdata_key}"/>', <c:out value="${country.chartdata_val}"/>]
			<c:if test="${status.last eq false}">
			,
			</c:if>
	    </c:forEach>
	]);

	var options_country = {
    	title: '국가별 통계'
  	};

	var chart_country = new google.visualization.PieChart(document.getElementById('chart_country'));
	chart_country.draw(data_country, options_country);

	// 도시별 통계 차트
	var data_city = google.visualization.arrayToDataTable([
	    
	    ['Task', 'Hours per Day'],
		<c:forEach var="city" items="${cityList}" varStatus="status">
		['<c:out value="${city.chartdata_key}"/>', <c:out value="${city.chartdata_val}"/>]
			<c:if test="${status.last eq false}">
			,
			</c:if>
	    </c:forEach>
	]);

	var options_city = {
    	title: '도시별 통계'
  	};

	var chart_city = new google.visualization.PieChart(document.getElementById('chart_city'));
	chart_city.draw(data_city, options_city);
	
	// OS별 통계 차트
	var data_os = google.visualization.arrayToDataTable([
	    
	    ['Task', 'Hours per Day'],
		<c:forEach var="os" items="${osList}" varStatus="status">
		['<c:out value="${os.chartdata_key}"/>', <c:out value="${os.chartdata_val}"/>]
			<c:if test="${status.last eq false}">
			,
			</c:if>
	    </c:forEach>
	]);

	var options_os = {
    	title: 'OS별 통계'
  	};

	var chart_os = new google.visualization.PieChart(document.getElementById('chart_os'));
	chart_os.draw(data_os, options_os);

	
	// 브라우져별 통계 차트
	var data_browser = google.visualization.arrayToDataTable([
	    
	    ['Task', 'Hours per Day'],
		<c:forEach var="browser" items="${browserList}" varStatus="status">
		['<c:out value="${browser.chartdata_key}"/>', <c:out value="${browser.chartdata_val}"/>]
			<c:if test="${status.last eq false}">
			,
			</c:if>
	    </c:forEach>
	]);

	var options_browser = {
    	title: '브라우저별 통계',
    	vAxis: {title: 'Year',  titleTextStyle: {color: 'red'}}
  	};

	var chart_browser = new google.visualization.PieChart(document.getElementById('chart_browser'));
	chart_browser.draw(data_browser, options_browser);

	
	// 시간별 통계 차트
	var data_hourly = new google.visualization.DataTable();
	data_hourly.addColumn('string', '시간');
	data_hourly.addColumn('number', '접속수');
	data_hourly.addRows([
	<c:forEach var="hourly" items="${hourlyList}" varStatus="status">
	['<c:out value="${hourly.chartdata_key}"/>', <c:out value="${hourly.chartdata_val}"/>]
		<c:if test="${status.last eq false}">
		,
		</c:if>
    </c:forEach>
	]);
	
	var options_hourly = {
    	title: '시간별 접속 통계'
  	};

	var chart_hourly = new google.visualization.ColumnChart(document.getElementById('chart_hourly'));
	chart_hourly.draw(data_hourly, options_hourly);
	
	<c:choose>
		<c:when test="${commstatVO.date_choice eq 'DD'}">
			// 일별 통계 차트
			var data_daily = new google.visualization.DataTable();
			data_daily.addColumn('string', '일');
			data_daily.addColumn('number', '접속수');
			data_daily.addRows([
			<c:forEach var="daily" items="${dailyList}" varStatus="status">
			['<c:out value="${daily.chartdata_key}"/>', <c:out value="${daily.chartdata_val}"/>]
				<c:if test="${status.last eq false}">
				,
				</c:if>
		    </c:forEach>
			]);
			
			var options_daily = {
		    	title: '일별 접속 통계'
		  	};
		
			var chart_daily = new google.visualization.ColumnChart(document.getElementById('chart_daily'));
			chart_daily.draw(data_daily, options_daily);
		</c:when>
		
		<c:when test="${commstatVO.date_choice eq 'MM'}">
			// 월별 통계 차트
			var data_monthly = new google.visualization.DataTable();
			data_monthly.addColumn('string', '월');
			data_monthly.addColumn('number', '접속수');
			data_monthly.addRows([
			<c:forEach var="monthly" items="${monthlyList}" varStatus="status">
			['<c:out value="${monthly.chartdata_key}"/>', <c:out value="${monthly.chartdata_val}"/>]
				<c:if test="${status.last eq false}">
				,
				</c:if>
		    </c:forEach>
			]);
			
			var options_monthly = {
		    	title: '월별 접속 통계'
		  	};
		
			var chart_monthly = new google.visualization.ColumnChart(document.getElementById('chart_monthly'));
			chart_monthly.draw(data_monthly, options_monthly);
		</c:when>

		<c:when test="${commstatVO.date_choice eq 'YY'}">
			// 연도별 통계 차트
			var data_yearly = new google.visualization.DataTable();
			data_yearly.addColumn('string', '년');
			data_yearly.addColumn('number', '접속수');
			data_yearly.addRows([
			<c:forEach var="yearly" items="${yearlyList}" varStatus="status">
			['<c:out value="${yearly.chartdata_key}"/>', <c:out value="${yearly.chartdata_val}"/>]
				<c:if test="${status.last eq false}">
				,
				</c:if>
		    </c:forEach>
			]);
			
			var options_yearly = {
		    	title: '연도별 접속 통계'
		  	};
		
			var chart_yearly = new google.visualization.ColumnChart(document.getElementById('chart_yearly'));
			chart_yearly.draw(data_yearly, options_yearly);
		</c:when>
	</c:choose>
	
}


</script>


<form:form name="reqForm" commandName="commstatVO">		 
	
	<div class="articles_search">
		<div class="basic_searchForm">
			<div class="date_choice">
			<span class="txt_bold">단위선택</span>
				<form:radiobutton path="date_choice" value="YY" label = "년단위"/>
				<form:radiobutton path="date_choice" value="MM" label = "월단위"/>
				<form:radiobutton path="date_choice" value="DD" label = "일단위"/>
				
				<span class="txt_bold"><label for="srchFromDT">기간입력</label></span> 
				<form:input path="srchFromDT" title="시작날짜 입력" maxlength="8"/> ~ 
				<form:input path="srchToDT" title="마지막 날짜 입력" maxlength="8" /> 
				<a href="javascript:fn_egov_stat_refresh()" id="btnSearchRefresh" class="input_smallBlack">조회</a> 
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
	 
	<div style="clear:both; margin-left:70px;"><strong>* 접속 횟수 : ${contactInfo.tot_cnt} / 중복포함 접속 횟수 : ${contactInfo.tot_cnt_ignore_dup}</strong></div>
	 
	 <div class="chart_area">
  		<div class="float_wrap chart">
  			<div class="float_left">
  				<div id="chart_country" style="height:430px;"></div>
  			</div>
  			<div class="float_right">
				<div id="chart_city" style="height:430px;"></div>
			</div>
  		</div>
  		<div class="float_wrap chart">
  			<div class="float_left">
  				<div id="chart_os" style="height:430px;"></div>
  			</div>
  				<div class="float_right">
			<div id="chart_browser" style="height:430px;"></div>
			</div>
  		</div>

		<div id="divLinechartAreaHourly" class="full_chart">
			<div id="chart_hourly" style="width:95%; height: 430px;"></div>
		</div>
		
		<c:choose>
			<c:when test="${commstatVO.date_choice eq 'DD'}">
				<div id="divLinechartAreaDaily" class="full_chart">
					<div id="chart_daily" style="width: 95%; height: 430px;"></div>
				</div>
			</c:when>
			<c:when test="${commstatVO.date_choice eq 'MM'}">
				<div id="divLinechartAreaMonthly" class="full_chart">
					<div id="chart_monthly" style="width: 95%; height: 430px;"></div>
				</div>
			</c:when>
			<c:when test="${commstatVO.date_choice eq 'YY'}">
				<div id="divLinechartAreaYearly" class="full_chart">
					<div id="chart_yearly" style="width: 95%; height: 430px;"></div>
				</div>
			</c:when>
		</c:choose>
	</div>
	
	<form:hidden path="srch_mu_site"/>
	<form:hidden path="srch_mu_lang"/>
	
	<p class="btn_area_right">
		<a href="javascript:cmmfn_download_xlsfile('${pageContext.request.contextPath}', '/modest/xlsModestPageList.do?srch_menu_nix=${param.srch_menu_nix}')" class="btn_line xls" id="axls" >XLS</a> 
	</p>
</form:form>    
