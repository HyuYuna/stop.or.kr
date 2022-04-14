<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${fn:startsWith(param.srch_menu_nix, '794x409U') eq false}">	
	<p class="linemenu"></p>				
</c:if>

<form:form name="reqForm" commandName="boarddryVO">
	
	<article id="contents">
	
		<div id="divSchlistArea" style="display: none;">
				<p class="schedule_info"> <span class="float_left"></span> <span class="float_right list_choice"> <a href="javascript:fn_egov_change_calmode('cal')" title="전체일정 달력으로 보기 선택 됨">전체일정 달력</a><a>전체일정 목록</a> </span> </p>
				<div class="date_select" id="divCalbtnListAllCtrl">
					<button type="button" class="btn_left">이전 달 이동</button>
					<span id="spanCalyrAll" class="yearSelect">2014.<span> 10</span>.</span>
					<button type="button" class="btn_right">다음 달 이동</button>
				</div>
				<table id="tblSchedulecalList" class="tstyle_list">
					<caption>
					주요일정 전체 목록으로 구분(휴관, 전시, 교육, 공연, 기타) 제목, 기간, 장소에 대한 정보 제공
					</caption>
					<colgroup>
					<col width="7%">
					<col width="*">
					<col width="21%">
					<col width="25%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">구분</th>
							<th scope="col">제목</th>
							<th scope="col">기간</th>
							<th scope="col">장소</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
			<div id="divSchcalendarArea" style="display: block;">
				<p class="schedule_info"> <span class="float_left"><img src="${pageContext.request.contextPath}/images/custom/kor/community/schedule_icon.gif" alt="휴관, 전시, 교육, 공연, 기타"></span> <span class="float_right"> <a>전체일정 달력</a><a href="javascript:fn_egov_change_calmode('list')" title="전체일정 목록으로 보기 선택 됨">전체일정 목록</a> </span> </p>
				<div class="date_select" id="divCalbtnSchAllCtrl">
					<button type="button" class="btn_left">이전 달 이동</button>
					<span id="spanCalyrAll" class="yearSelect">2014.<span> 10</span>.</span>
					<button type="button" class="btn_right">다음 달 이동</button>
				</div>
				<table id="tblSchedulecalAll" class="schedule_calendar">
					<caption>
					주요일정 전체 달력으로 휴관, 전시, 교육, 공연, 기타에 대한 상세 정보 제공
					</caption>
					<thead>
						<tr>
							<th scope="col" class="sun">Sun</th>
							<th scope="col">Mon</th>
							<th scope="col">Tue</th>
							<th scope="col">Wed</th>
							<th scope="col">Thu</th>
							<th scope="col">Fri</th>
							<th scope="col" class="sat">Sat</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
				</table>
			</div>
	</article>
	<input type="hidden" id="srchcalYr" name="srchcalYr" value="${SYEAR}"/>
	<input type="hidden" id="srchcalMon" name="srchcalMon" value="${SMON}"/>
	
</form:form>    


