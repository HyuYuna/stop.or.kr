<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="toDay" class="java.util.Date" />
<fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd" var="today"/>
<fmt:parseDate value="${srvymainVO.srvy_end }" var="strPlanDate" pattern="yyyy-MM-dd"/>
<fmt:parseNumber value="${strPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="strDate"></fmt:parseNumber>
<fmt:parseDate value="${today }" var="endPlanDate" pattern="yyyy-MM-dd"/>
<fmt:parseNumber value="${endPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>
<fmt:parseNumber value="${endDate - strDate}" integerOnly="true" var="srvyVaildDay"></fmt:parseNumber>



<form:form name="reqForm" commandName="srvymainVO">
	
<c:set var="ques_cnt" value="1"/>
<c:set var="ans_cnt" value="1"/>

<c:if test="${srvyVaildDay le 0 and srvymainVO.srvy_open_yn eq 'Y'}">
<div class="board-view">
	<div class="view-event txt-center">
		<h1 class="view-title">${srvymainVO.srvy_nm}</h1>
		<div>${srvymainVO.srvy_cont}</div>
		
		<ul class="info">
			<li>
				<strong>기간</strong> <c:out value="${srvymainVO.srvy_start}" /> ~ <c:out value="${srvymainVO.srvy_end}" />
			</li>
		</ul>
	</div>
	
	<div class="view-survey">
	
		<c:forEach var="partresult" items="${partList}" varStatus="partstatus">
			<article class="group">
				<h2>${partresult.part_nm}</h2>
				<c:forEach var="quesresult" items="${quesansList}" varStatus="quesstatus">
					
					<c:if test="${quesresult.part_idx eq partresult.part_idx}">
						<c:if test="${quesresult.quesans_type eq 'Q'}">
							<article class="item">
								<input type="hidden" name="arr_ques_idx" value="${quesresult.ques_idx}"/>
								<input type="hidden" name="arr_ques_type" value="${quesresult.ques_type}"/>
								<input type="hidden" name="arr_answer" value=""/>
								<h3>${elfunc:nl2br(quesresult.quesans_cont)}</h3>
								
									<c:choose>
										<c:when test="${quesresult.ques_type eq 'CDIDX00084' }">
											<div class="table-wrap board">
												<p class="label">내용 작성 100자 이내로 적어주세요</p>
												<!-- 주관식 단답형인 경우 보기가 없으므로 텍스트상자를 바로 표시한다.  -->
												<label>
												<textarea name="txt_${quesresult.ques_idx}" rows="7" title="내용 작성"  maxlength="100"></textarea>							
												</label>				
											</div>
										</c:when>
										<c:when test="${quesresult.ques_type eq 'CDIDX00085' }">
											<div class="table-wrap board">
												<p class="label">내용 작성 250자 이내로 적어주세요</p>
												<!-- 주관식 단답형인 경우 보기가 없으므로 텍스트상자를 바로 표시한다.  -->
												<label>
												<textarea name="txt_${quesresult.ques_idx}" rows="7" title="내용 작성"  maxlength="250"></textarea>	
												</label>
											</div>
										</c:when>
										<c:otherwise>
											<!-- 객관식형 표출  -->
											<ul class="form-survey">
												<c:forEach var="answresult" items="${quesansList}" varStatus="answstatus">	
													<c:if test="${answresult.ques_idx eq quesresult.ques_idx}">
														<c:if test="${answresult.quesans_type eq 'A'}">
															
															<c:choose>
																<c:when test="${answresult.ques_type eq 'CDIDX00082'}">
																
																	<!-- 객관식 단답형 -->
																	<li class="form-set form-radio">
																		<input type="radio" id="radio_${answresult.ques_idx}_${answresult.ans_ord}" name="radio_${answresult.ques_idx}" value="${answresult.ans_ord}">
																		<label for="radio_${answresult.ques_idx}_${answresult.ans_ord}" >${answresult.quesans_cont}</label>
																		<c:if test="${answresult.ans_need_spl eq 'Y'}">
																			<label for="txt_${answresult.ques_idx}_${answresult.ans_ord}" class="hidden">작성란</label>
																	  	 	<input type="text" id="txt_${answresult.ques_idx}_${answresult.ans_ord}" title="기타 내용"  size="30" maxlength="50" style="display: none;" >
																		</c:if>
																	</li>
																</c:when>
																<c:when test="${answresult.ques_type eq 'CDIDX00083'}">
																	<!-- 객관식 복수형 -->
																		<li class="form-set form-check">
																			<input type="checkbox" id="chk_${answresult.ques_idx}-${answresult.ans_ord}" value="${answresult.ans_ord}" >
																			<label for="chk_${answresult.ques_idx}-${answresult.ans_ord}" >${answresult.quesans_cont}</label>
																			<c:if test="${answresult.ans_need_spl eq 'Y'}">
																				<label for="txt_${answresult.ques_idx}_${answresult.ans_ord}" class="hidden">작성란</label>
																		  	 	<p><input type="text" id="txt_${answresult.ques_idx}_${answresult.ans_ord}" title="기타 내용" style="display: none;" maxlength="50"></p>
																			</c:if>
																		</li>
																</c:when>
															</c:choose>
															
														</c:if>
													</c:if>
												</c:forEach>
											</ul>
										</c:otherwise>
									</c:choose>
								
							</article>
						</c:if>
					</c:if>
						
				</c:forEach>
			</article>
		</c:forEach>
		
		<c:if test="${srvymainVO.srvy_allow_dup eq 'N'}">
			<article class="group">
				<h2>응답자 정보입력</h2>
				
				<article class="item">
					<h3>본인 이메일 정보를 입력해주세요.</h3>
					<label for="data_addr" class="hidden-text">이메일 정보를 입력</label>
					<input type="text" name="data_addr" id="data_addr" size="50" title="이메일">
				</article>
			</article>
		</c:if>
	
	<form:hidden path="pageIndex"/>
	<form:hidden path="srvy_idx"/>
	<form:hidden path="searchCondition"/>
	<form:hidden path="searchKeyword"/>
	<input type="hidden" id="mod_reply_idx" name="mod_reply_idx" value=""/>
	<input type="hidden" id="srvy" name="srvy" value="srvy"/>
		
		
		
	</div>
	
	<p class="btns txt-center">
		<a href="#" id="btnSurveyAppl" onclick="return false;" class="btn-l btn1">제출하기</a>
		<a href="#" onclick="history.back(); return false;" class="btn-l btn2">뒤로가기</a>
	</p>
</div>
</c:if>


</form:form>
	
