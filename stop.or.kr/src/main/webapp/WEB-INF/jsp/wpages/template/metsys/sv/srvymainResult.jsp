<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html lang="ko">

<head>
<c:import url="/WEB-INF/jsp/layout/custom/web/kor/cmm/metacmmn.jsp"/>

<title>설문 결과 : ${mainVO.srvy_nm}</title>
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js"></script>
<![endif]-->
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/template/cmmn/general.css" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/template/cmmn/survey.css" />

<script type="text/javascript" src="https://www.google.com/jsapi"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/html5.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-ui-1.9.2.custom.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/_cmmn/plani_common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/_cmmn/plani_gen.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/_cmmn/plani_auth.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/utils/datepicker/js/datepicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/kps/jquery.scrollbar.concat.min.js" ></script>

<!--[if lt IE 9]>
<script src="${pageContext.request.contextPath}/js/jquery/core/html5.js" ></script> 
<![endif]-->

<script type="text/javascript">

google.load("visualization", "1", {packages:["corechart"]});

jQuery(document).ready(function(){

	g_context = "${pageContext.request.contextPath}";
	
	// 50개가 넘는 추가 답변 보기
	$("button[name='btnOpenMore']").on("click", function(){
		$(this).parent().parent().find("li[class='more']").show();
		$(this).parent().parent().find("button").show();
		$(this).hide();
	});
	// 50개가 넘는 추가 답변 가리기
	$("button[name='btnCloseMore']").on("click", function(){
		$(this).parent().parent().find("li[class='more']").hide();
		$(this).parent().parent().find("button").show();
		$(this).hide();
	});
	
});
</script>
<style type="text/css">
.final .btn 
{
	width: 150px;
	height: 40px;
	font-size:14px;
	margin-top:10px;
}
</style>

</head>

<dl id="accessibility">
	<dt class="hidden">바로가기 메뉴</dt>
	<dd><a href="#content">본문 바로가기</a></dd>
</dl>
<!-- //Accessibility -->
<div id="wrap">
	<header class="survey_info result">
		<div class="count"><strong>${mainVO.srvy_appl_cnt}</strong>명 응답</div>
		<p>주관식 항목의 응답은 최근 50개까지만 표시됩니다.<br />나머지 응답결과를 확인하려면 <strong>상세보기</strong>를 이용해 주세요.</p>
	</header>

	<div id="content">
	<!-- 파트시작 -->
	<section class="part_area">
	
		<c:set var = "ques_num" value="1"/>
		<c:set var = "demo_num" value="1"/>
		<c:forEach var="partresult" items="${partList}" varStatus="partstatus">
		
		<c:if test="${partresult.part_type ne 'CDIDX00062'}">
			<h2 class="bullet"><span><strong>PART${partstatus.count}.</strong> ${partresult.part_nm}</span></h2>
		</c:if>
		
			<c:forEach var="quesresult" items="${quesansList}" varStatus="quesstatus">
				
				<c:if test="${quesresult.part_idx eq partresult.part_idx}">
					<c:choose>
						<c:when test="${quesresult.quesans_type eq 'Q'}">
						
							<c:if test="${partresult.part_type ne 'CDIDX00062'}">
								<!-- 일반질문 표시 -->
								<h3 class="black_title"><em>Q${ques_num}.</em> <span>${elfunc:nl2br(quesresult.quesans_cont)}</span></h3>
								<c:set var="ques_num" value="${ques_num + 1}"/>
							</c:if>

							<c:set var="ans_cnt" value="${quesresult.ans_cnt}"/>
							
							
							<%-- <c:if test="${quesresult.ques_type eq 'CDIDX00084' and partresult.part_type ne 'CDIDX00062'}"> --%>
							<c:if test="${quesresult.ques_type eq 'CDIDX00084' or quesresult.ques_type eq 'CDIDX00085'}">
								
								<ul class="bg_list">
									<!-- 주관식형 -->
									<c:set var="datacont_cnt" value="1"/>
									<c:forEach var="datacont" items="${dataList}" varStatus="quesstatus">
										<c:if test="${datacont.ques_idx eq quesresult.ques_idx and datacont_cnt le 50}">
											<c:if test="${datacont.quessub_idx ne datacont.srvy_nm_idx and datacont.quessub_idx ne datacont.srvy_cp_idx}">
												<li>${datacont.data_cont}</li>	
												<c:set var="datacont_cnt" value="${datacont_cnt + 1}"/>
											</c:if>
										</c:if>
										<c:if test="${datacont.ques_idx eq quesresult.ques_idx and datacont_cnt gt 50}">
											<c:if test="${datacont.quessub_idx ne datacont.srvy_nm_idx and datacont.quessub_idx ne datacont.srvy_cp_idx}">
												<c:if test="${datacont_cnt eq 51 }"><div class="final"><button type="button" name="btnOpenMore" class="btn">+ 상세보기</button></div></c:if>
												<li class="more" style="display: none;">${datacont.data_cont}</li>	
												<c:set var="datacont_cnt" value="${datacont_cnt + 1}"/>
											</c:if>
										</c:if>
										<c:if test="${quesstatus.last }"><div class="final"><button type="button" name="btnCloseMore" class="btn" style="display: none;">- 닫기</button></div></c:if>
									</c:forEach>
								</ul>
							</c:if>
							
						</c:when>
						<c:otherwise>
						
							<c:choose>
								<c:when test="${quesresult.ques_type eq 'CDIDX00082' and partresult.part_type ne 'CDIDX00062'}">
								<!-- 객관식 단답형 -->
									<c:if test ="${quesresult.ans_ord eq 1}">
										<div class="table_wrap" id="divResultarea_${quesresult.ques_idx}_${quesresult.ans_ord}">
											<div class="graph" id="chart_${quesresult.ques_idx}" height="300px">
												<!-- <img src="${pageContext.request.contextPath}/cms/images/kps/survey/exam_graph.gif" />-->
											</div>
											<ul class="graph_result">
											
											<c:set var="evaltxt" value="var data_${quesresult.ques_idx} = google.visualization.arrayToDataTable([[\"Task\", \"Hours per Day\"]"/>
									</c:if>
											
											<li>
												<strong>${quesresult.quesans_cont}</strong>
												<div class="number">
													<span class="value">${fn:split(quesresult.ans_pct, '_')[0]}</span>
													<span class="percent">${fn:split(quesresult.ans_pct, '_')[1]}</span>
												</div>
											</li>
											<c:if test ="${quesresult.ans_ord eq ans_cnt and fn:split(quesresult.no_ans_pct, '_')[0] ne 0}">
												<li>
													<strong>응답없음</strong>
													<div class="number">
														<span class="value">${fn:split(quesresult.no_ans_pct, '_')[0]}</span>
														<span class="percent">${fn:split(quesresult.no_ans_pct, '_')[1]}</span>
													</div>
												</li>
											</c:if>
											
											<c:set var="evaltxt" value="${evaltxt.concat(',[\"').concat(quesresult.quesans_cont).concat('\",').concat(fn:split(quesresult.ans_pct, '_')[0]).concat(']')}"/>
								
									<c:if test ="${quesresult.ans_ord eq  ans_cnt}">
											</ul>
											<c:set var="evaltxt" value="${evaltxt.concat(']);')}"/>
											<script>
											// 구글파이차트 그리기
											google.setOnLoadCallback(drawChart_${quesresult.ques_idx});
											function drawChart_${quesresult.ques_idx}() 
											{
												${evaltxt}	

												var options_${quesresult.ques_idx} = {
											    	title: '',
											    	'width':500,
											        'height':350
											  	};

												var chart_${quesresult.ques_idx} = new google.visualization.PieChart(document.getElementById('chart_${quesresult.ques_idx}'));
												chart_${quesresult.ques_idx}.draw(data_${quesresult.ques_idx}, options_${quesresult.ques_idx});
											}
											</script>
										</div>
										<!-- 기타 의견 -->
										<c:set var="forEach_break" value="false" />
										<c:forEach var="datacont" items="${dataList}" varStatus="quesstatus">
											<c:if test="${not forEach_break }">
												<c:if test="${datacont.ques_idx eq quesresult.ques_idx }">
													<c:if test="${datacont.quessub_idx ne datacont.srvy_nm_idx and datacont.quessub_idx ne datacont.srvy_cp_idx and not empty datacont.data_spl }">
														<h4 class="tag">추가 답변</h4>
														<c:set var="forEach_break" value="true" />
													</c:if>
												</c:if>
											</c:if>
										</c:forEach>
										
										<c:set var="datacont_cnt" value="1"/>
										<ul class="bg_list">
											<c:forEach var="datacont" items="${dataList}" varStatus="quesstatus">
												<c:if test="${datacont.ques_idx eq quesresult.ques_idx }">
													<c:if test="${datacont.quessub_idx ne datacont.srvy_nm_idx and datacont.quessub_idx ne datacont.srvy_cp_idx and not empty datacont.data_spl and datacont_cnt le 50}">
														<li>${datacont.data_spl}</li>	
														<c:set var="datacont_cnt" value="${datacont_cnt + 1}"/>
													</c:if>
													<c:if test="${datacont.quessub_idx ne datacont.srvy_nm_idx and datacont.quessub_idx ne datacont.srvy_cp_idx and not empty datacont.data_spl and datacont_cnt gt 50}">
														<c:if test="${datacont_cnt eq 51 }"><div class="final"><button type="button" name="btnOpenMore" class="btn">+ 상세보기</button></div></c:if>
														<li class="more">${datacont.data_spl}</li>	
														<c:set var="datacont_cnt" value="${datacont_cnt + 1}"/>
													</c:if>
												</c:if>
												<c:if test="${quesstatus.last }"><div class="final"><button type="button" name="btnCloseMore" class="btn" style="display: none;">- 닫기</button></div></c:if>
											</c:forEach>
										</ul>
									</c:if>
								</c:when>
								<c:when test="${(quesresult.ques_type eq 'CDIDX00083' or quesresult.ques_type eq 'CDIDX00085' or quesresult.ques_type eq 'CDIDX00086') and partresult.part_type ne 'CDIDX00062'}">
								
									<h4 class="tag">${quesresult.quesans_cont}</h4>
									<div class="table_wrap">
										<div class="graph" id="chart_${quesresult.ques_idx}_${quesresult.ans_ord}" height="300px">
											<!-- <img src="${pageContext.request.contextPath}/cms/images/kps/survey/exam_graph.gif" /> -->
										</div>
										<ul class="graph_result">
											
											<c:set var="evaltxt" value="var data_${quesresult.ques_idx}_${quesresult.ans_ord} = google.visualization.arrayToDataTable([[\"Task\", \"Hours per Day\"]"/>
											
											<c:set var="lc_ans_pct" value="${fn:split(quesresult.ans_pct, '##')}"/>
											<c:forEach var="quespct" items="${lc_ans_pct}" varStatus="pctstatus">
												<li>
													<c:choose>
														<c:when test= "${quesresult.ques_type eq 'CDIDX00083'}">
															<c:choose>
																<c:when test="${fn:split(quespct, '_')[0] eq 'N'}">
																	<c:set var = "crt_axis" value="선택안함"/>
																</c:when>
																<c:otherwise>
																	<c:set var = "crt_axis" value="선택함"/>
																</c:otherwise>
															</c:choose>
														</c:when>
														<c:when test= "${quesresult.ques_type eq 'CDIDX00085'}">
															<c:set var = "crt_axis" value="만족도 ${fn:split(quespct, '_')[0]}"/>						
															
														</c:when>
														<c:when test= "${quesresult.ques_type eq 'CDIDX00086'}">
															<c:set var = "crt_axis" value="${fn:split(quespct, '_')[0]}위선택"/>						
														</c:when>
													</c:choose>
													<strong>
														${crt_axis}
													</strong>
													<div class="number">
														<span class="value">${fn:split(quespct, '_')[1]}</span>
														<span class="percent">${fn:split(quespct, '_')[2]}</span>
													</div>
												</li>
												
												<c:set var="evaltxt" value="${evaltxt.concat(',[\"').concat(crt_axis).concat('\",').concat(fn:split(quespct, '_')[1]).concat(']')}"/>
												
											</c:forEach>
											
											<c:set var="evaltxt" value="${evaltxt.concat(']);')}"/>
											<script>
												// 구글파이차트 그리기
												google.setOnLoadCallback(drawChart_${quesresult.ques_idx}_${quesresult.ans_ord});
												function drawChart_${quesresult.ques_idx}_${quesresult.ans_ord}() 
												{
													${evaltxt}	

													var options_${quesresult.ques_idx}_${quesresult.ans_ord} = {
												    	title: '',
												    	'width':500,
												        'height':350
												  	};

													var chart_${quesresult.ques_idx}_${quesresult.ans_ord} = new google.visualization.PieChart(document.getElementById('chart_${quesresult.ques_idx}_${quesresult.ans_ord}'));
													chart_${quesresult.ques_idx}_${quesresult.ans_ord}.draw(data_${quesresult.ques_idx}_${quesresult.ans_ord}, options_${quesresult.ques_idx}_${quesresult.ans_ord});
												}
											</script>
										</ul>
									</div>
									<br/>
								<!-- 객관식 복수형 -->
								</c:when>
								
								
							</c:choose>
						
						</c:otherwise>
					</c:choose>
				</c:if>
			</c:forEach>
		
		
		
		</c:forEach>
	
	</section>
	<!-- // -->
	</div>

	</div>
</div>
</body>
</html>



