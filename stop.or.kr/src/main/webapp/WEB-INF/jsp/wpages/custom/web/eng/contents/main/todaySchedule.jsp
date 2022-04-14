<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>

<h2><img src="${pageContext.request.contextPath}/images/custom/main/title_schedule.gif" alt="오늘의 일정" /></h2>
<div class="btn_page">
	<span class="number"><span class="txt_bold">${paginationInfo.currentPageNo}</span>/${paginationInfo.totalPageCount}</span>
	<span class="btn_control">
		<button type="button" title="오늘의 일정 이전" id="todaySchedulePrev_${prevPageNo}"><img src="${pageContext.request.contextPath}/images/custom/main/btn_prev.gif" alt="이전" /></button><button type="button" title="다음" id="todayScheduleNext_${nextPageNo}"><img src="${pageContext.request.contextPath}/images/custom/main/btn_next.gif" alt="오늘의 일정 다음" /></button>
	</span>
</div>
<div class="today_date">
	<span class="week">
		<c:choose>
			<c:when test="${now_dow eq 1}">
				SUN
			</c:when>
			<c:when test="${now_dow eq 2}">
				MON
			</c:when>
			<c:when test="${now_dow eq 3}">
				TUE
			</c:when>
			<c:when test="${now_dow eq 4}">
				WED
			</c:when>
			<c:when test="${now_dow eq 5}">
				THU
			</c:when>
			<c:when test="${now_dow eq 6}">
				FRI
			</c:when>
			<c:when test="${now_dow eq 7}">
				SAT
			</c:when>
		</c:choose>
	</span> 
	<span class="day">${now_d}</span>
</div>
<ul class="schedule_list">
	<c:forEach var="result" items="${scheduleList}" varStatus="status">
		<li><a href="${pageContext.request.contextPath}/main/brddry/boarddryList.do?brd_id=BDIDX_Ei0PMf1j3dwTy0I6uo7493&amp;srch_menu_nix=FrIhVMuP"><c:out value="${elfunc:cutString(result.subject, 20, '...')}"/></a></li>
	</c:forEach>
	<c:if test="${paginationInfo.totalRecordCount eq 0}">
		<li>일정을 등록해주십시오.</li>
	</c:if>	
</ul>
<p class="more"><a href="${pageContext.request.contextPath}/main/brddry/boarddryList.do?brd_id=BDIDX_Ei0PMf1j3dwTy0I6uo7493&amp;srch_menu_nix=FrIhVMuP"><img src="${pageContext.request.contextPath}/images/custom/main/img_more.gif" alt="오늘의 일정 자세히 보기" /></a></p>