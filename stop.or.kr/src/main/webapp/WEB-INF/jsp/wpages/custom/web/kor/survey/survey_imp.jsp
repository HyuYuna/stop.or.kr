<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>


<c:set var="ques_cnt" value="1"/>
<c:set var="ans_cnt" value="1"/>

<c:forEach var="partresult" items="${partList}" varStatus="partstatus">
				
	
	<c:if test="${partresult.part_type eq param.lc_part_type}">
			
			<c:choose>
				<c:when test="${param.lc_part_type eq 'CDIDX00062'}">
					<h2 class="title"><span>Demography</span></h2>
				</c:when>
				<c:otherwise>
					<h2 class="title"><span><strong>PART ${partstatus.count}.</strong> ${partresult.part_nm}</span></h2>
				</c:otherwise>
			</c:choose>
			
			<c:forEach var="quesresult" items="${quesansList}" varStatus="quesstatus">
				
				<c:if test="${quesresult.part_idx eq partresult.part_idx}">
				
					<c:choose>
						<c:when test="${quesresult.quesans_type eq 'Q'}">
							<!-- 질문 표시 영역 -->
							<div id="divQuesArea_${quesresult.ques_idx}">
								<input type="hidden" name="arr_ques_idx" value="${quesresult.ques_idx}"/>
								<input type="hidden" name="arr_ques_type" value="${quesresult.ques_type}"/>
								<input type="hidden" name="arr_answer" value=""/>
								
								<c:choose>
									<c:when test="${param.lc_part_type eq 'CDIDX00062'}">
										<!-- 개인정보파트 질문 표시 -->
										<h3 class="question"><em>Demo ${ques_cnt}</em> 
											<span>${elfunc:nl2br(quesresult.quesans_cont)}</span>
										</h3>
									</c:when>
									<c:otherwise>
										<!-- 일반파트 질문 표시 -->
										<h3 class="question"><em>Q ${ques_cnt}</em> 
											<span>${elfunc:nl2br(quesresult.quesans_cont)}</span>
										</h3>
									</c:otherwise>
								</c:choose>
								
								<c:choose>
									<c:when test="${quesresult.ques_type eq 'CDIDX00084' }">
										<!-- 주관식 단답형인 경우 보기가 없으므로 텍스트상자를 바로 표시한다.  -->
										<div><textarea name="txt_${quesresult.ques_idx}" class="input_long" rows="7"></textarea></div>
									</c:when>
								</c:choose>
								
								<c:set var="ques_cnt" value="${ques_cnt + 1}"/>
								<c:set var="ans_cnt" value="${quesresult.ans_cnt}"/>
							</c:when>
							<c:otherwise>
								<!-- 보기 표시 영역 -->
								<c:choose>
									<c:when test="${quesresult.ques_type eq 'CDIDX00082'}">
										<!-- 객관식 단답형 -->
										<c:if test ="${quesresult.ans_ord eq 1}">
											<ul class="answer_choice">
										</c:if>
											<li>
												<input type="radio" id="radio_${quesresult.ques_idx}_${quesresult.ans_ord}" name="radio_${quesresult.ques_idx}" value="${quesresult.ans_ord}"  /> <label for="radio_${quesresult.ques_idx}_${quesresult.ans_ord}">${quesresult.quesans_cont}</label>
												<c:if test="${quesresult.ans_need_spl eq 'Y'}">
													&nbsp;&nbsp;&nbsp;<input type="text" id="txt_${quesresult.ques_idx}_${quesresult.ans_ord}" title="기타 내용" class="form-control xl" size="80" style="display: none;"/>
												</c:if>
											</li>
										<c:if test ="${quesresult.ans_ord eq  ans_cnt}">
											</ul>
											</div>
										</c:if>
										
									</c:when>
									<c:when test="${quesresult.ques_type eq 'CDIDX00083'}">
										<!--  객관식 복수형 -->
										<c:if test ="${quesresult.ans_ord eq 1}">
											<div class="table_wrap">
											<table class="tstyle_list">
												<caption>제목</caption>
												<colgroup>
													<col width="10%"/>
													<col/>
													<col width="15%"/>
												</colgroup>
												<thead>
													<tr>
														<th scope="col">번호</th>
														<th scope="col">항목</th>
														<th scope="col">복수응답가능</th>
													</tr>
												</thead>
												<tbody>
										</c:if>
											
												<tr class="even">
													<td>${quesresult.ans_ord}</td>
													<td class="txt_left">${quesresult.quesans_cont}</td>
													<td><input type="checkbox" id="chk_${quesresult.ques_idx}_${quesresult.ans_ord}" value="${quesresult.ans_ord}"/></td>
												</tr>
									
										<c:if test ="${quesresult.ans_ord eq  ans_cnt}">
													</tbody>
												</table>
												</div>
											</div>
										</c:if>
									</c:when>
									<c:when test="${quesresult.ques_type eq 'CDIDX00085'}">
										<!-- 만족도 선택형 -->
										<c:if test ="${quesresult.ans_ord eq 1}">
											<div class="table_wrap">
											<table class="tstyle_list">
												<caption>제목</caption>
												<colgroup>
													<col width="8%"/>
													<col />
													<col width="8%"/>
													<col width="8%"/>
													<col width="8%"/>
													<col width="8%"/>
													<col width="8%"/>
													<col width="8%"/>
													<col width="8%"/>
												</colgroup>
												<thead>
													<tr>
														<th scope="col" rowspan="2" colspan="2">평가항목</th>
														<th scope="col">매우<br />불만족</th>
														<th scope="col"></th>
														<th scope="col"></th>
														<th scope="col">보통</th>
														<th scope="col"></th>
														<th scope="col"></th>
														<th scope="col">매우<br />만족</th>
													</tr>
													<tr>
														<th scope="col">1</th>
														<th scope="col">2</th>
														<th scope="col">3</th>
														<th scope="col">4</th>
														<th scope="col">5</th>
														<th scope="col">6</th>
														<th scope="col">7</th>
													</tr>
												</thead>
												<tbody>
										</c:if>
										
											<tr>
												<td>${quesresult.ans_ord}</td>
												<td class="txt_left">
													<c:out value="${quesresult.quesans_cont}"/>
													<c:if test="${not empty quesresult.vchkcode}">
														<img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${quesresult.vchkcode}" alt="<c:out value="${quesresult.quesans_cont}"/>" width="100%"/></a>
													</c:if>
												</td>
												<td><input type="radio" name="radio_${quesresult.ques_idx}_${quesresult.ans_ord}" value="1"/></td>
												<td><input type="radio" name="radio_${quesresult.ques_idx}_${quesresult.ans_ord}" value="2"/></td>
												<td><input type="radio" name="radio_${quesresult.ques_idx}_${quesresult.ans_ord}" value="3"/></td>
												<td><input type="radio" name="radio_${quesresult.ques_idx}_${quesresult.ans_ord}" value="4"/></td>
												<td><input type="radio" name="radio_${quesresult.ques_idx}_${quesresult.ans_ord}" value="5"/></td>
												<td><input type="radio" name="radio_${quesresult.ques_idx}_${quesresult.ans_ord}" value="6"/></td>
												<td><input type="radio" name="radio_${quesresult.ques_idx}_${quesresult.ans_ord}" value="7"/></td>
											</tr>
										
										
										<c:if test ="${quesresult.ans_ord eq  ans_cnt}">
													</tbody>
												</table>
												</div>
											</div>
										</c:if>
										
									</c:when>
									<c:when test="${quesresult.ques_type eq 'CDIDX00086'}">
										<!-- 선호도 선택형 -->
										
										<c:if test ="${quesresult.ans_ord eq 1}">
										
											<div class="table_wrap">
											<table class="tstyle_list">
												<caption>제목</caption>
												<colgroup>
													<col width="7%" />
													<col width="*" />
													<c:forEach begin="1" end="${ans_cnt}" var="ansspc">
														<col width="7%" />
													</c:forEach> 
												</colgroup>
												<thead>
													<tr>
														<th scope="col" rowspan="2" colspan="2">항목</th>
														<th scope="col" colspan="${ans_cnt}">선택</th>
													</tr>
													<tr>
														<c:forEach begin="1" end="${ans_cnt}" var="ansspc">
															<th scope="col">${ansspc}</th>
														</c:forEach>
													</tr>
												</thead>
												<tbody>
										</c:if>
										
											<tr class="even">
												<td>${quesresult.ans_ord}</td>
												<td class="txt_left">
													<c:out value="${quesresult.quesans_cont}"/>
													<c:if test="${not empty quesresult.vchkcode}">
														<img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${quesresult.vchkcode}" alt="<c:out value="${quesresult.quesans_cont}"/>" width="100%"/></a>
													</c:if>
												</td>
												<c:forEach begin="1" end="${ans_cnt}" var="ansspc">
													<td><input type="radio" name="radio_${quesresult.ques_idx}_${quesresult.ans_ord}" value="${ansspc}"/></td>
												</c:forEach>
											</tr>
										
										<c:if test ="${quesresult.ans_ord eq  ans_cnt}">
													</tbody>
												</table>
												</div>
											</div>
										</c:if>
									</c:when>
								</c:choose>
							</c:otherwise>
					</c:choose>
													
				</c:if>				
			</c:forEach>
			
	</c:if>		
	
	
	<c:if test="${param.lc_part_type eq 'CDIDX00062' and partresult.part_type eq 'CDIDX00062'}">
		<div class="answer_info">
			<p>
				${elfunc:removeScrtag(partresult.part_psn_info)}
			</p>
			<h3 class="subject">응답자정보란</h3>
			<ul class="list">
				<li><label for="srvy_appl_nm">응답자 성명</label> <input type="text" id="srvy_appl_nm" name="srvy_appl_nm" class="form-control normal" title="응답자 성명"/></li>
				<li><label for=srvy_appl_cp>응답자 휴대전화 번호</label> <input type="text" id="srvy_appl_cp" name="srvy_appl_cp" class="form-control normal" title="응답자 휴대폰 번호"/></li>
			</ul>
		</div>
	</c:if>
	
</c:forEach>