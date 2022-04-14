<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>

<div class="schedule">
	<article class="calender">
		<div class="title">
			<h2>
				<strong>${SMON}</strong>
				<span> ${CUR_MON_NAME} ${SYEAR}</span>
			</h2>
			<p class="control">
				<c:set var="preparam" value="SrchcalYr=${PREYEAR}&SrchcalMon=${PREMON}"/>
				<c:set var="nextparam" value="SrchcalYr=${NEXTYEAR}&SrchcalMon=${NEXTMON}"/>
				<a href="${cutil:getUrl('',preparam,true)}" class="prev">이전</a>
				<a href="${cutil:getUrl('',nextparam, true)}" class="next">다음</a>
			</p>
		</div>
		<div class="table">
			<table>
				<caption>${SYEAR}년 ${SMON}월 달력</caption>
				<thead>
					<tr>
						<th scope="col" class="point4">Sun</th>
						<th scope="col">Mon</th>
						<th scope="col">Tue</th>
						<th scope="col">Wed</th>
						<th scope="col">Thu</th>
						<th scope="col">Fri</th>
						<th scope="col" class="point5">Sat</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="numW" value="0"/>
					<c:forEach var="result" begin="0" end="${DTO - 1}" varStatus="status">
						<c:if test="${status.index eq 0 or status.index % 7 eq 0}">
							<tr>
						</c:if>							
						<c:choose>
							<c:when test="${status.index lt SDOW or status.index gt (SDOW + SDCNT - 1)}">
								<td>&nbsp;</td>	
							</c:when>
							<c:otherwise>
								<c:set var="clsnm" value=""/>
								<c:forEach var="m_result" items="${mdaylist}" varStatus="m_status">
									<c:if test="${m_result eq status.index - SDOW + 1}">
										<c:set var = "clsnm" value="event"/>
									</c:if>
								</c:forEach>
								<c:choose>
									<c:when test="${status.index % 7 eq 0}">
										<c:if test="${(status.index - SDOW + 1) eq SCURDAY}">
											<c:set var = "clsnm" value="sun today ${clsnm}"/>
										</c:if>
										<c:if test="${(status.index - SDOW + 1) ne SCURDAY}">
											<c:set var = "clsnm" value="sun ${clsnm}"/>
										</c:if>
									</c:when>
									<c:when test="${status.index % 7 eq 6}">
										<c:set var="numW" value="${numW+1 }"/>
										<c:if test="${(status.index - SDOW + 1) eq SCURDAY}">
											<c:set var = "clsnm" value="sat today ${clsnm}"/>
										</c:if>
										<c:if test="${(status.index - SDOW + 1) ne SCURDAY}">
											<c:set var = "clsnm" value="sat ${clsnm}"/>
										</c:if>
									</c:when>
									<c:otherwise>
										<c:if test="${(status.index - SDOW + 1) eq SCURDAY}">
											<c:set var = "clsnm" value="today ${clsnm}"/>
										</c:if>
									</c:otherwise>
								</c:choose>
<%-- 								<c:if test="${SCURMON le SMON and SCURYEAR le SYEAR}">
									<c:set var ="clsnm" value="${clsnm}"/>
								</c:if> --%>
								<td class="${clsnm}" id="ctd${status.index - SDOW + 1}">
									<a href="#none" id="m_day" class="label">${status.index - SDOW + 1}</a>
								</td>
							</c:otherwise>
						</c:choose>								
						<c:if test="${status.index % 7 eq 6}">
							</tr>
						</c:if>							
					</c:forEach>
				</tbody>
			</table>
		</div>
	</article>
	<article class="item">
		<h3 class="title3" id="ttile">${SMON}월 ${SCURDAY}일 행사</h3>
		<div class="list" id="tlist">
			<ul>
				<c:choose>
					<c:when test="${!empty todaylist }">
						<c:forEach var="today" items="${todaylist}">
							<li>${today.subject}</li>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<li>등록된 데이터가 없습니다.</li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</article>
</div>

<h3 class="title3">${SMON}월의 행사</h3>
<div class="table-wrap">
	<table>
		<colgroup>
			<col class="date">
			<col>
		</colgroup>
		<c:choose>
			<c:when test="${!empty monlist }">
				<c:forEach var="monlist" items="${monlist}">
					<c:set var="sdate" value="${monlist.s_date}"/>
					<c:set var="edate" value="${monlist.e_date}"/>
					<%
						Calendar cal = Calendar.getInstance();
						SimpleDateFormat formatter = new SimpleDateFormat("yyyy-mm-dd");
						String s_day = (String)pageContext.getAttribute("sdate") ;
						String e_day = (String)pageContext.getAttribute("edate") ;
						Date s_date = formatter.parse(s_day);
						Date e_date = formatter.parse(e_day);
						cal.setTime(s_date);
						pageContext.setAttribute("s_date",cal.get(Calendar.DAY_OF_MONTH));
						cal.setTime(e_date);
						pageContext.setAttribute("e_date",cal.get(Calendar.DAY_OF_MONTH));
					%>
					<tr>
						<td class="txt-left">${s_date}일 <c:if test="${s_date ne e_date }">~ ${e_date}일</c:if></td>
						<td class="txt-left point1">${monlist.subject}</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr><td colspan="2">등록된 데이터가 없습니다.</td></tr>
			</c:otherwise>
		</c:choose>
	</table>
</div>
				
<script>
$('a#m_day').click(function() {
	
	var  thisDate = new Date();
	var j_year = ("${param.SrchcalYr}")?"${param.SrchcalYr}":thisDate.getFullYear();
	var j_month = ("${param.SrchcalMon}")?"${param.SrchcalMon}":thisDate.getMonth()+1;
	

	$(this).closest('tr').find('td').siblings().removeClass('active');
	$(this).closest('tr').siblings().find('td').removeClass('active');
	$(this).closest('td').addClass('active');
	$('#ttile').html(j_month+"월 "+$(this).html()+"일 행사");
	/*2018-09-05*/
	$.ajax({
       url 		: "${pageContext.request.contextPath}/sch/seldayschlist.do?srch_menu_nix=${param.srch_menu_nix}&s_date="+j_year+"-"+j_month+"-"+$(this).html(),
       datatype	: "json",
	   async 		: false,	        
       success 	: function(data){
    	   
    	   j_data = JSON.parse(data);
    	   
    	   $('div#tlist').find('ul').find('li').remove();
 
    	   if(j_data.length > 0)
   		   {   
    		   $.each(j_data,function(key,value) {
    			  $('div#tlist').find('ul').append("<li>"+value+"</li>");
    		   });
   		   }
    	   else
   		   {
    		   $('div#tlist').find('ul').append("<li>등록된 데이터가 없습니다.</li>");
   		   }
       },
       error: function(xhr, err){
           
       	alert("에러가 발생했습니다.");
       }
    }); 
	
	return false
});
</script>



















<%
if(true) return;
%>

<div class="contentDetail">
	<div class="calendar-wrap">
		<div class="date-select">
			<c:set var="preparam" value="SrchcalYr=${PREYEAR}&SrchcalMon=${PREMON}"/>
			<c:set var="nextparam" value="SrchcalYr=${NEXTYEAR}&SrchcalMon=${NEXTMON}"/>
			<a href="${cutil:getUrl('',preparam,true)}" class="left-arr"><span>이전</span></a> <strong>${SYEAR}</strong>년 <strong>${SMON}</strong>월
			<a href="${cutil:getUrl('',nextparam, true)}" class="right-arr"><span>다음</span></a>
		</div>
		<table class="basic-table calendar">
			<caption>견학신청 달력 - 월요일 ~ 일요일까지 신청 현황</caption>
			<colgroup>
				<col width="14.28%" />
				<col width="14.28%" />
				<col width="14.28%" />
				<col width="14.28%" />
				<col width="14.28%" />
				<col width="14.28%" />
				<col width="14.28%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">일</th>
					<th scope="col">월</th>
					<th scope="col">화</th>
					<th scope="col">수</th>
					<th scope="col">목</th>
					<th scope="col">금</th>
					<th scope="col">토</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="numW" value="0"/>
				<c:forEach var="result" begin="0" end="${DTO - 1}" varStatus="status">
	
					<c:if test="${status.index eq 0 or status.index % 7 eq 0}">
						<tr>
					</c:if>							
					<c:choose>
						<c:when test="${status.index lt SDOW or status.index gt (SDOW + SDCNT - 1)}">
							<td>&nbsp;</td>	
						</c:when>
						<c:otherwise>
							<c:set var="clsnm" value=""/>
							<c:choose>
								<c:when test="${status.index % 7 eq 0}">
									<c:if test="${(status.index - SDOW + 1) eq SCURDAY}">
										<c:set var = "clsnm" value="sun today"/>
									</c:if>
									<c:if test="${(status.index - SDOW + 1) ne SCURDAY}">
										<c:set var = "clsnm" value="sun"/>
									</c:if>
								</c:when>
								<c:when test="${status.index % 7 eq 6}">
									<c:set var="numW" value="${numW+1 }"/>
									<c:if test="${(status.index - SDOW + 1) eq SCURDAY}">
										<c:set var = "clsnm" value="sat today"/>
									</c:if>
									<c:if test="${(status.index - SDOW + 1) ne SCURDAY}">
										<c:set var = "clsnm" value="sat"/>
									</c:if>
								</c:when>
								<c:otherwise>
									<c:if test="${(status.index - SDOW + 1) eq SCURDAY}">
										<c:set var = "clsnm" value="today"/>
									</c:if>
								</c:otherwise>
							</c:choose>
							<c:if test="${SCURMON le SMON and SCURYEAR le SYEAR}">
								<c:set var ="clsnm" value="${clsnm}"/>
							</c:if>
							<td class="${clsnm}" id="ctd${status.index - SDOW + 1}">
							
								${status.index - SDOW + 1}
								
							</td>
						</c:otherwise>
					</c:choose>								
					<c:if test="${status.index % 7 eq 6}">
						</tr>
					</c:if>							
				</c:forEach>
			</tbody>
		</table>
	</div>
	
</div>

		
		
		