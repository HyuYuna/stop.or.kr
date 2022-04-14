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
<!-- 
	중요 !!!!!
	이 파일의 내용은 수정하지 않습니다.
	
	또한 퍼블리셔와 협업을 할때
	프로젝트마다 반복되는 작업량을 줄이기 위해
	게시판 테이블의 css 클래스명은 오직 "tstyle_list" 만 사용하기로 했으며,
	새로운 프로젝트 수행시 퍼블리셔는 위 클래스명으로
	/webapp/css/template/metsys/bbs.css 만을 이용해서 작업하기로 협의 되었습니다.   
	
	현 프로젝트에서 기본적인 게시판을 제외한 추가된 부분(레이아웃)이 있으면
	이 파일의 컨텐츠를 감싸고 있는
	/WEB-INF/jsp/layout/custom/web/kor/board/boardLayout.jsp 파일의 표시된 부분에 추가합니다.
	
	2016.3.11 bhhan	
	
	## TPCODE : TPAGE0022: 일반 게시판 상세조회 페이지 ## 
-->

<form:form name="reqForm" commandName="srvymainVO">
	
<c:set var="ques_cnt" value="1"/>
<c:set var="ans_cnt" value="1"/>
	<div id="divMainArticle">
		<!-- 게시글 뷰 -->
		<div id="board-view-wrap" class="board-view-style01">
			<div id="board-view">
				<!-- board-header -->
				<div class="board-header">
					<p class="text-day"><c:out value="${srvymainVO.srvy_start}" /> - <c:out value="${srvymainVO.srvy_end}" /></p>
					<h1 class="depth01-title title01">
						<span>${srvymainVO.srvy_nm}</span>
					</h1>
					<p class="write-name">${srvymainVO.writer_nm}</p>
					<div class="row float-ui">
						<div class="col col-sm-12 col-md-9  col-lg-6">
							<ul class="shared-list">
								<li><span class="icon-favorite">좋아요</span> </li>
								<li><span class="icon-share">공유</span> </li>
								<li><span class="icon-comment">댓글</span></li>
								<li><span class="icon-hit">HIT</span></li>
							</ul>
						</div>
						<div class="col col-sm-12 col-md-3  col-lg-6 text-right">
							<!-- 0209 -->
							<ul class="sns-list02">
								<li><a href="javascript:fn_egov_share_sns(1,'${srvymainVO.srvy_idx}');" onclick="fn_egov_add_share();" class="facebook" title="새창이동"><span class="hidden">페이스북</span></a></li>
								<li><a href="javascript:fn_egov_share_sns(2,'${srvymainVO.srvy_idx}');" onclick="fn_egov_add_share();" class="kakao" id="kakaostory-share-button" title="새창이동"><span class="hidden">카카오스토리</span></a></li>
								<li><a href="javascript:fn_egov_share_sns(3,'${srvymainVO.srvy_idx}');" onclick="fn_egov_add_share();" class="blog" title="새창이동"><span class="hidden">블로그</span></a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<!-- board-view-contents -->
			<div id="board-view-contents">
				<!-- board-content -->
						${elfunc:removeScrtag(srvymainVO.srvy_cont)}
						<input type="hidden" id="brd_cont_base" name="brd_cont_base" value="<c:out value="${srvymainVO.srvy_cont}"/>"/>
				<!-- board-content //-->
			</div>
			<!-- tag-list -->
			<div class="tag-list">
				
			</div>
			<!-- button list -->
			<div class="button-group text-center">
				<a href="javascript:;" class="btn btn-default btn-shard white btn-shard-popup-open " title="클릭하면 공유하기 레이어창이 뜹니다."><span class="icon share">공유하기</span></a>
				<!-- 공유하기 클릭후 0209 -->
				<div class="layer-popup shard-zone">
					<section class="layer-popup-inner">
						<h1 class="title">공유하기</h1>
						<div class="layer-popup-content">
							<div class="sns">
								<ul class="sns-list02">
									<li><a href="javascript:fn_egov_share_sns(1,'${srvymainVO.srvy_idx}');" onclick="fn_egov_add_share();" class="facebook" title="새창이동"><span class="hidden">페이스북</span></a></li>
									<li><a href="javascript:fn_egov_share_sns(2,'${srvymainVO.srvy_idx}');" onclick="fn_egov_add_share();" class="kakao" title="새창이동"><span class="hidden">카카오스토리</span></a></li>
									<li><a href="javascript:fn_egov_share_sns(3,'${srvymainVO.srvy_idx}');" onclick="fn_egov_add_share();" class="blog" title="새창이동"><span class="hidden">블로그</span></a></li>
								</ul>
							</div>
							 <div class="button-group">
					        	<a href="javascript:;" class="btn btn-default black layer-popup-close">닫기</a>
					        </div>
						</div>
					</section>
				</div>
				<!-- 공유하기 클릭후// -->
			</div>
			<c:if test="${srvyVaildDay le 0 and srvymainVO.srvy_open_yn eq 'Y'}">
			<div class="survey-group ing">
				<div class="survey-header">
					<h2 class="title">설문에 참여해주세요! </h2>
					<span class="day"><em><c:out value="${srvymainVO.srvy_end}" /> </em>까지</span>
				</div>
				<div class="survey-content" id="survey-ing">
					<ul class="survey-content-list">
					<c:forEach var="partresult" items="${partList}" varStatus="partstatus">
						<c:forEach var="quesresult" items="${quesansList}" varStatus="quesstatus">	
						<c:if test="${quesresult.part_idx eq partresult.part_idx}">
						<c:if test="${quesresult.quesans_type eq 'Q'}">				
						<li id="divQuesArea_${quesresult.ques_idx}">
				
							<input type="hidden" name="arr_ques_idx" value="${quesresult.ques_idx}"/>
							<input type="hidden" name="arr_ques_type" value="${quesresult.ques_type}"/>
							<input type="hidden" name="arr_answer" value=""/>
								<h3 class="title">
									<span class="num"><fmt:formatNumber var="rn" minIntegerDigits="2" value="${ques_cnt}" type="number"/>${rn}</span>
									${elfunc:nl2br(quesresult.quesans_cont)}
								</h3>
								<c:choose>
									<c:when test="${quesresult.ques_type eq 'CDIDX00084' }">
										<p class="label">(250자 이내로 적어주세요.)</p>
										<!-- 주관식 단답형인 경우 보기가 없으므로 텍스트상자를 바로 표시한다.  -->
										<div class="form">
											<div class="row">
												<span class="textarea-style col-sm-12 col-xs-12 col-lg-12">
													<textarea name="txt_${quesresult.ques_idx}" cols="30" rows="7" title="내용 작성" class="col-xs-12 col-sm-12 col-md-12  col-lg-12" maxlength="250"></textarea>
											</span></div>
										</div>
									</c:when>
									<c:when test="${quesresult.ques_type eq 'CDIDX00087' }">
										<p class="label">(50자 이내로 적어주세요.)</p>
										<!-- 주관식 단답형인 경우 보기가 없으므로 텍스트상자를 바로 표시한다.  -->
										<div class="form">
											<div class="row">
												<span class="input-style col-sm-12 col-xs-12 col-lg-12">
													<label for="input-field03-01" class="hidden">작성란</label>
											  		 <input type="text" name="txt_${quesresult.ques_idx}" class="col-xs-12 col-sm-12 col-md-12  col-lg-12 answ_text" maxlength="50">
												</span>
											</div>
										</div>
									</c:when>
									<c:when test="${quesresult.ques_type eq 'CDIDX00082' }">
										<p class="label">(기타는 50자 이내로 적어주세요.)</p>
									</c:when>
									<c:when test="${quesresult.ques_type eq 'CDIDX00083' }">
										<p class="label">(복수응답가능.)</p>
									</c:when>
								</c:choose>
								
								<c:set var="ques_cnt" value="${ques_cnt + 1}"/>
								<c:set var="ans_cnt" value="${quesresult.ans_cnt}"/>
							<c:forEach var="answresult" items="${quesansList}" varStatus="answstatus">	
								<c:if test="${answresult.ques_idx eq quesresult.ques_idx}">
								<c:if test="${answresult.quesans_type eq 'A'}">
								<c:choose>
									<c:when test="${answresult.ques_type eq 'CDIDX00082'}">
										<!-- 객관식 단답형 -->
											<div class="form">
												<div class="row">
													<span class="form-check radio-style-small <c:if test="${answresult.ans_need_spl eq 'Y'}"> pull-left </c:if>">
														<input type="radio" id="radio_${answresult.ques_idx}_${answresult.ans_ord}" name="radio_${answresult.ques_idx}" value="${answresult.ans_ord}" class="radio-style">
														<label for="radio_${answresult.ques_idx}_${answresult.ans_ord}" >${answresult.quesans_cont}</label>
													</span>
													<c:if test="${answresult.ans_need_spl eq 'Y'}">
													<span class="input-style col-sm-12 col-xs-12 col-lg-8">
														<label for="txt_${answresult.ques_idx}_${answresult.ans_ord}" class="hidden">작성란</label>
												  	 	<input type="text" id="txt_${answresult.ques_idx}_${answresult.ans_ord}" title="기타 내용" class="col-xs-12 col-sm-12 col-md-12  col-lg-12" size="80" maxlength="50" style="display: none;" >
													</span>
													</c:if>
												</div>
											</div>
									</c:when>
									<c:when test="${answresult.ques_type eq 'CDIDX00083'}">
										<!-- 객관식 복수형 -->
											<div class="form">
												<div class="row">
													<span class="form-check check-style-small <c:if test="${answresult.ans_need_spl eq 'Y'}"> pull-left </c:if>">
														<input type="checkbox" id="chk_${answresult.ques_idx}_${answresult.ans_ord}" value="${answresult.ans_ord}" class="checkbox-style">
														<label for="chk_${answresult.ques_idx}_${answresult.ans_ord}" >${answresult.quesans_cont}</label>
													</span>
													<c:if test="${answresult.ans_need_spl eq 'Y'}">
													<span class="input-style col-sm-12 col-xs-12 col-lg-8">
														<label for="txt_${answresult.ques_idx}_${answresult.ans_ord}" class="hidden">작성란</label>
												  	 	<input type="text" id="txt_${answresult.ques_idx}_${answresult.ans_ord}" title="기타 내용" class="col-xs-12 col-sm-12 col-md-12  col-lg-12" size="80" style="display: none;" maxlength="50">
													</span>
													</c:if>
												</div>
											</div>
									</c:when>
									<c:otherwise>
									</c:otherwise>
								</c:choose>
								</c:if>
								</c:if>
							</c:forEach>
						</li>
						</c:if>	
						</c:if>
						</c:forEach>
					</c:forEach>	
					</ul>
					<div class="button-group survey-button-group">
						<button type="button" class="btn btn-default btn-survey red mid"  id="btnSurveyAppl" title="">설문제출</button>
						<button type="button" class="btn btn-default btn-survey black mid"  id="btnSurveyRslt" title="">결과보기</button>
					</div>
					<input type="hidden" id="srvy_appl_nm" name="srvy_appl_nm" class="form-control normal" value="${SESS_USR_NM }" title="응답자 성명"/>
				</div>
				
			</div>
			</c:if>
			<c:if test="${srvyVaildDay gt 0}">
			<!-- survey end-->
			<div class="survey-group end">
				<div class="survey-header">
					<h2 class="title">설문에 참여해주셔서 감사합니다! </h2>
					<span class="day"><em><c:out value="${srvymainVO.srvy_end}" /> </em>까지  <br class="mobile"/>${srvymainVO.srvy_appl_cnt}분이 응답해 주셨습니다.</span>
				</div>
				<div class="survey-content">
					<ul class="survey-content-list">
					<c:forEach var="partresult" items="${partList}" varStatus="partstatus">
						<c:forEach var="quesresult" items="${quesansList}" varStatus="quesstatus">
						<c:if test="${quesresult.part_idx eq partresult.part_idx}">
						<c:if test="${quesresult.quesans_type eq 'Q'}">
						<li>
							<h3 class="title"><span class="num"><fmt:formatNumber var="rn" minIntegerDigits="2" value="${ques_cnt}" type="number"/>${rn}</span>
								${elfunc:nl2br(quesresult.quesans_cont)}
							</h3>
							<c:set var="ques_cnt" value="${ques_cnt + 1}"/>
							<c:set var="ans_cnt" value="${quesresult.ans_cnt}"/>
							<c:choose>
								<c:when test="${quesresult.ques_type eq 'CDIDX00084' or quesresult.ques_type eq 'CDIDX00087'}">
								<p class="label color-red">비공개</p>
								<c:set var="datacont_cnt" value="0"/>
								<c:forEach var="datacont" items="${dataList}" varStatus="quesstatus">
									<c:if test="${rn eq datacont.ques_idx and datacont.quessub_idx eq 1}">
										<c:set var="datacont_cnt" value="${datacont_cnt + 1}"/>
									</c:if>
								</c:forEach>
								<c:if test="${datacont_cnt gt 0 }">
									<c:set value="100%" var="ansPercent" /> 
								</c:if>
								<c:if test="${datacont_cnt eq 0 }">
									<c:set value="0%" var="ansPercent" /> 
								</c:if>
								<div class="result-group">
									<div class="row">
										<span class="result-num  col-xs-12 col-sm-12  col-lg-12">
											<span class="hidden">응답률</span>${datacont_cnt }명 <em class="icon">/</em> <em>${ansPercent }</em>
										</span>
										<div class="percent-graph col-xs-12 col-sm-12  col-lg-12">
											<span class="hidden">위의 결과 퍼센트 이미지</span>
											<span class="graph w${fn:replace(ansPercent,'%','') }"><em class="hidden">${ansPercent }</em></span>
										</div>
									</div>
								</div>	
								</c:when>
								<c:otherwise>
									<c:forEach var="answresult" items="${quesansList}" varStatus="answstatus">	
										<c:if test="${answresult.ques_idx eq quesresult.ques_idx}">
										<c:if test="${answresult.quesans_type eq 'A'}">
											<c:choose>
												<c:when test="${answresult.ques_type eq 'CDIDX00082'}">
												<c:set var="datacont_cnt" value="0"/>
												<c:set var="ans_cnt" value="0"/>
												<c:forEach var="datacont" items="${dataList}" varStatus="quesstatus">
													<c:if test="${answresult.ques_idx eq datacont.ques_idx and datacont.quessub_idx eq 1}">
														<c:set var="datacont_cnt" value="${datacont_cnt + 1}"/>
														<c:if test="${datacont.data_cont eq answresult.ans_ord }">
														<c:set var="ans_cnt" value="${ans_cnt + 1}"/>
														</c:if>
													</c:if>
												</c:forEach>
												<c:if test="${ans_cnt gt 0 }">
													<fmt:parseNumber value="${(ans_cnt / datacont_cnt) * 100}" var="ansPercent" integerOnly="true"/>
													<fmt:parseNumber value="${(ans_cnt / datacont_cnt) * 10}" var="ansPerCls" integerOnly="true"/>
													<c:set value="w${ansPerCls * 10 }" var="ansPerCls"/>
												</c:if>
												<c:if test="${ans_cnt eq 0 }">
													<c:set value="0" var="ansPercent" /> 
													<c:set value="w0" var="ansPerCls" />  
												</c:if>
												<div class="result-group">
													<div class="row">
														<span class="title col-xs-12 col-sm-12 col-md-12  col-lg-6" >${answresult.quesans_cont}</span>
														<span class="result-num  col-xs-12 col-sm-12 col-md-12  col-lg-6">
															<span class="hidden">응답률</span>${ans_cnt }명 <em class="icon">/</em> <em>${ansPercent }%</em>
														</span>
														<div class="percent-graph col-xs-12 col-sm-12 col-md-12  col-lg-12">
															<span class="hidden">위의 결과 퍼센트 이미지</span>
															<span class="graph ${ansPerCls}"><em class="hidden">${ansPercent }%</em></span>
														</div>
													</div>
												</div>	
												</c:when>
												<c:when test="${answresult.ques_type eq 'CDIDX00083'}">
												<c:set var="datacont_cnt" value="0"/>
												<c:set var="ans_cnt" value="0"/>
												<c:forEach var="datacont" items="${dataList}" varStatus="quesstatus">
													<c:if test="${answresult.ques_idx eq datacont.ques_idx and datacont.quessub_idx eq answresult.ans_ord }">
														<c:set var="datacont_cnt" value="${datacont_cnt + 1}"/>
														<c:if test="${datacont.data_cont eq 'Y' }">
														<c:set var="ans_cnt" value="${ans_cnt + 1}"/>
														</c:if>
													</c:if>
												</c:forEach>
												<c:if test="${ans_cnt gt 0 }">
													<fmt:parseNumber value="${(ans_cnt / datacont_cnt) * 100}" var="ansPercent" integerOnly="true"/>
													<fmt:parseNumber value="${(ans_cnt / datacont_cnt) * 10}" var="ansPerCls" integerOnly="true"/>
													<c:set value="w${ansPerCls * 10 }" var="ansPerCls"/>
												</c:if>
												<c:if test="${ans_cnt eq 0 }">
													<c:set value="0" var="ansPercent" /> 
													<c:set value="w0" var="ansPerCls" />  
												</c:if>
												<div class="result-group">
													<div class="row">
														<span class="title col-xs-12 col-sm-12 col-md-12  col-lg-6" >${answresult.quesans_cont}</span>
														<span class="result-num  col-xs-12 col-sm-12 col-md-12  col-lg-6">
															<span class="hidden">응답률</span>${ans_cnt }명 <em class="icon">/</em> <em>${ansPercent }%</em>
														</span>
														<div class="percent-graph col-xs-12 col-sm-12 col-md-12  col-lg-12">
															<span class="hidden">위의 결과 퍼센트 이미지</span>
															<span class="graph ${ansPerCls}"><em class="hidden">${ansPercent }%</em></span>
														</div>
													</div>
												</div>	
												</c:when>
											</c:choose>		
										</c:if>
										</c:if>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</li>
						</c:if>	
						</c:if>
						</c:forEach>
					</c:forEach>
					</ul>
				</div>
			</div>
			</c:if>
			
		</div>
		<!-- 게시글 뷰 //-->
		<!-- content //-->	
			
		<!-- 버튼영역 Start -->
		<!-- 
		<p class="board_butt">
			<span class="button basic"><span class="list"><a href="${pageContext.request.contextPath}/html/web/kor/news/sub020100.jsp">목록</a></span></span>
			<span class="button basic"><span class="write"><a href="${pageContext.request.contextPath}/html/web/kor/news/sub020100_write.jsp">글쓰기</a></span></span>
		</p>
		 -->
		
		<div class="button-group text-center">
	
			<c:if test="${RWAUTH eq 'RW'}">
				<a href="javascript:fn_egov_srvy_mod()" class="btn btn-default"><span class="icon pen ">수정</span></a>
			</c:if>
			<c:if test="${RWAUTH eq 'RWD'}">
				<!-- 수정/삭제권한이 있는 경우 -->
				<a href="javascript:fn_egov_srvy_mod()" class="btn btn-default black"><span class="icon pen ">수정</span></a>
				<a href="javascript:fn_egov_srvy_del()" class="btn btn-default red">삭제</a>
			</c:if>
				<a href="javascript:fn_egov_srvy_list()" class="btn btn-default"><span class="icon list">목록</span></a>
		</div>
		<!-- 버튼영역 End -->
		<!-- contents //-->				
		<!-- container-right //-->
		<br/>	
		<br/>
			
		<form:hidden path="pageIndex"/>
		<form:hidden path="srvy_idx"/>
		<form:hidden path="searchCondition"/>
		<form:hidden path="searchKeyword"/>
		<input type="hidden" id="mod_reply_idx" name="mod_reply_idx" value=""/>
		<input type="hidden" id="srvy" name="srvy" value="srvy"/>
		
	</div>	

	<br/>
	
</form:form>
	
