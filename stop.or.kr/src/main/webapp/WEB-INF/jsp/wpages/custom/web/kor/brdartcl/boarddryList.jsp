<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<form:form name="reqForm" commandName="boarddryVO">
<c:if test="${boarddryVO.srch_menu_nix eq 'eZ5zT3co' }">

	<div class="title_area group">
		<h2>기타관리</h2>
		<p class="path">
			<img src="${pageContext.request.contextPath}/images/template/sub/ico_home.gif" alt="" /> Home &gt; 기타관리 &gt; <strong>전체일정관리</strong> 
		</p>
	</div>
	<h3>전체일정관리
	</h3><br/>

</c:if>		
	<section id="content"> 
		
		<p class="schedule_info"><span class="float_left"><img src="${pageContext.request.contextPath}/images/custom/kor/main/schedule_icon.gif" alt="휴관, 전시, 교육, 공연, 행사"/></span> 
		<span class="float_right">
		<a href="javascript:fn_egov_dry_viewmode('CAL')" title="전체일정 달력으로 보기 선택 됨">전체일정 달력</a>
		<a href="javascript:fn_egov_dry_viewmode('LIST')">전체일정 목록</a>
		</span></p>	
		
		<div id="divCalbtnCtrl" class="date_select">
			<button type="button" class="btn_left">이전 달 이동</button> 
			<span class="yearSelect">${SYEAR}.<span>${elfunc:getZerofillStr(SMON, 2)}</span></span> 
			<button type="button" class="btn_right">다음 달 이동</button>
		</div>
		
		<div >
			<button type="button" id="btnDryForm">일정등록</button>
		</div>
		
		<c:choose>
			<c:when test="${empty param.modeV or param.modeV eq 'CAL'}">
				
								 		
					<!-- 
					<form id="search_form" class="search_form" name="search_form" method="post" action="" onsubmit="return check(this)">
						<fieldset>
							<legend>검색</legend>			
							<input id="srchFromDT" name="srchFromDT" title="시작 날짜 입력" type="date" value="" placeholder="예)20140506" size="10" maxlength="8"/> ~ <input id="srchToDT" name="srchToDT" title="종료 날짜 입력" type="date" placeholder="예)20140510" value="" size="10" maxlength="8"/> 
							<input id="searchKeyword" name="searchKeyword" title="검색어 입력" type="text" value="" placeholder="공연명"/><input name="" type="image" src="${pageContext.request.contextPath}/images/custom/kor/common/btn_search.gif" alt="검색" />
						</fieldset>
					</form>
					 -->
					
				<table class="schedule_calendar" summary="주요일정 전체 달력으로 휴관, 전시, 교육, 공연, 행사에 대한 상세 정보 제공">
					<caption>주요일정 달력</caption>
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
						<c:if test="${DTO}">
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
												<c:set var = "clsnm" value="class=\"sun\""/>
											</c:when>
											<c:when test="${status.index % 7 eq 6}">
												<c:set var = "clsnm" value="class=\"sat\""/>
											</c:when>
										</c:choose>
										<td ${clsnm}>
											${status.index - SDOW + 1}
											
											<ul class="schedule">
												<c:if test="${status.index % 7 eq 1}">
												<li><img src="${pageContext.request.contextPath}/images/custom/kor/main/schedule_type01.gif" alt="전시" style="padding-right: 5px"/>휴관</li>
												</div>
											</c:if>
												<c:forEach var="result" items="${resultList}" varStatus="substat">
													
													<c:if test="${(result.startdd <= status.index - SDOW + 1 and result.enddd >= status.index - SDOW + 1) 
													or (fn:substring(result.startdt, 5, 7) < SMON and fn:substring(result.enddt, 5, 7) > SMON)
													or (result.startdd <= status.index - SDOW + 1 and fn:substring(result.enddt, 5, 7) > SMON)
													or (fn:substring(result.startdt, 5, 7) < SMON and result.enddd >= status.index - SDOW + 1)}">
														<c:choose>
															<c:when test="${result.ctgry_idx eq 'CTIDX00082'}">
																<li><a href="javascript:fn_egov_dry_view('${result.cont_idx}')"><img src="${pageContext.request.contextPath}/images/custom/kor/main/schedule_type02.gif" alt="전시"/>${result.subject}</a></li>
															</c:when>
															<c:when test="${result.ctgry_idx eq 'CTIDX00083'}">
																<li><a href="javascript:fn_egov_dry_view('${result.cont_idx}')"><img src="${pageContext.request.contextPath}/images/custom/kor/main/schedule_type03.gif" alt="행사"/>${result.subject}</a></li>
															</c:when>
															<c:when test="${result.ctgry_idx eq 'CTIDX00084'}">
																<li><a href="javascript:fn_egov_dry_view('${result.cont_idx}')"><img src="${pageContext.request.contextPath}/images/custom/kor/main/schedule_type04.gif" alt="교육"/>${result.subject}</a></li>
															</c:when>
															<c:otherwise>
																<li><a href="javascript:fn_egov_dry_view('${result.cont_idx}')"><img src="${pageContext.request.contextPath}/images/custom/kor/main/schedule_type05.gif" alt="기타"/>${result.subject}</a></li>
															</c:otherwise>
														</c:choose>
													</c:if>
												</c:forEach>
											</ul>
										</td>
									</c:otherwise>
								</c:choose>	
								
								<c:if test="${status.index % 7 eq 6}">
									</tr>
								</c:if>
								
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</c:when>
			<c:otherwise>
				
				
				
				<table class="tstyle_list" summary="주요일정 전체 목록으로 구분(휴관, 전시, 교육, 공연, 행사) 제목, 기간, 장소에 대한 정보 제공">
				<caption>주요일정 목록</caption>
				<colgroup>
					<col width="7%" />
					<col width="*" />
					<col width="21%" />
					<col width="25%" />
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
					<c:forEach var="result" items="${resultList}" varStatus="substat">
					<tr>
						<th scope="row">
							<c:if test="${result.ctgry_idx eq 'CTIDX00082'}">
								[전시]
							</c:if>
							<c:if test="${result.ctgry_idx eq 'CTIDX00083'}">
								[공연]
							</c:if>
							<c:if test="${result.ctgry_idx eq 'CTIDX00084'}">
								[행사]
							</c:if>
							<c:if test="${result.ctgry_idx eq 'CTIDX00085'}">
								[교육]
							</c:if>
						</th>
						
							<td class="txt_left"><a href="javascript:fn_egov_dry_view('${result.cont_idx}')">${result.subject}</a></td>
							<td class="point01">${fn:substring(result.startdt, 0, 10) } ~ ${fn:substring(result.enddt, 0, 10) }</td>
							<td>${result.dry_place}</td>
						
					</tr>
					</c:forEach>
					<!-- <tr>
						<th scope="row">[공연]</th>
						<td class="txt_left">토요야간개장 연계공연 '피터팬과 우당탕탕 해적단'</td>
						<td class="point01">2014-04-13 ~ 2014-08-18</td>
						<td>국립부여박물관 사비마루 공연장</td>
					</tr>
					<tr>
						<th scope="row">[행사]</th>
						<td class="txt_left">보고·듣고·느끼는 호기심 박물관 "교과서 속 백제문화재</td>
						<td class="point01">2014-04-13 ~ 2014-08-18</td>
						<td>국립부여박물관 사비마루 공연장</td>
					</tr> -->
				</tbody>
			</table>
				
				
				
			<c:if test="${paginationInfo.totalPageCount gt 1}">
				<div class="board_pager">
					<ui:pagination paginationInfo = "${paginationInfo}" type = "image"
						jsFunction = "fn_egov_link_pfrm" />
				</div>
			</c:if>
			
			</c:otherwise>
		</c:choose>
				
	</section>
	<form:hidden path="edomweivgp"/>
	<form:hidden path="brd_id"/>
	<form:hidden path="cont_idx"/>
	<form:hidden path="modeV"/>
	<%-- <form:hidden path="srchcalYr" value="${SYEAR}"/>
	<form:hidden path="srchcalMon" value="${SMON}"/> --%>
	<input type="hidden" id="srchcalYr" name="srchcalYr" value="${SYEAR}"/>
	<input type="hidden" id="srchcalMon" name="srchcalMon" value="${SMON}"/>
	
</form:form>    


