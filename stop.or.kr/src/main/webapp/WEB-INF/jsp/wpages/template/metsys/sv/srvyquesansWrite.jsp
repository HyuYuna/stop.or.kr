<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<form:form name="reqForm" commandName="srvyquesansVO" enctype="multipart/form-data">

	<c:choose>
		<c:when test="${srvyquesansVO.edomweivgp eq 'A'}">
			<c:set var="pgname" value="설문 질문 / 답변 추가" />
		</c:when>
		<c:when test="${srvyquesansVO.edomweivgp eq 'M'}">
			<c:set var="pgname" value="설문 질문 / 답변 수정" />
		</c:when>
	</c:choose>
	<h2 class="depth2_bbsTitle">${pgname}</h2>

	<div id="divMainArticle">
		<!-- content -->

		<table class="tstyle_view">
			<caption>${pgname}</caption>
			<colgroup>
				<col width="150" />
				<col />
			</colgroup>
			<tbody>
				<c:forEach var="result" items="${quesansList}" varStatus="status">
					<c:if test="${status.index eq 0}">
						<tr>
							<th scope="row">
								<span class="point01">*</span>
								<label for="ques_type">질문 타입</label>
							</th>
							<td class="left">
								<select name="ques_type" id="ques_type">
									<c:forEach var="resulttype" items="${questypecode}" varStatus="statustype">
										<c:choose>
											<c:when test="${result.ques_type eq resulttype.code_idx}">
												<option value="${resulttype.code_idx}" selected>${resulttype.code_nm}</option>
											</c:when>
											<c:otherwise>
												<option value="${resulttype.code_idx}">${resulttype.code_nm}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
						<th scope="row">
							<span class="point01">*</span>
							<label for="ques_type">답변 빈 값</label>
						</th>
						<td class="left">
							<input type="radio" id="quesans_null_N" name="quesans_null" value="N" <c:if test="${result.quesans_null eq 'N'}">checked</c:if> />
							<label for="quesans_null_N">허용하지 않음</label>
							<input type="radio" id="quesans_null_Y" name="quesans_null" value="Y" <c:if test="${result.quesans_null eq 'Y'}">checked</c:if>/>
							<label for="quesans_null_Y">허용</label>
						</td>
					</tr>
						<tr>
							<th scope="row">
								<span class="point01">*</span>
								<label for="ques_type">질문</label>
							</th>
							<td class="left">
								<textarea name="arr_quesans_cont" cols="100" rows="5" class="text" title="질문 내용">${result.quesans_cont}</textarea>
								<input type="hidden" name="arr_quesans_type" value="Q" /> 
								<input type="hidden" name="arr_ans_need_spl" value="N" /> 
								<input type="hidden" name="arr_ans_ord" value="0" /> 
								<input type="hidden" name="arr_ques_idx" value="${result.ques_idx}" /> 
								<input type="hidden" name="arr_quesans_idx" value="${result.quesans_idx}" />
							</td>
						</tr>
					</c:if>
				</c:forEach>
				<c:if test="${empty quesansList}">
					<tr>
						<th scope="row">
							<span class="point01">*</span>
							<label for="ques_type">질문 타입</label>
						</th>
						<td class="left">
							<select name="ques_type" id="ques_type">
								<c:forEach var="resulttype" items="${questypecode}" varStatus="statustype">
									<option value="${resulttype.code_idx}">${resulttype.code_nm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">
							<span class="point01">*</span>
							<label for="ques_type">답변 빈 값 허용 여부</label>
						</th>
						<td class="left">
							<input type="radio" id="quesans_null_N" name="quesans_null" value="N" checked />
							<label for="quesans_null_N">허용하지 않음</label>
							<input type="radio" id="quesans_null_Y" name="quesans_null" value="Y" />
							<label for="quesans_null_Y">허용</label>
						</td>
					</tr>
					<tr>
						<th scope="row">
							<span class="point01">*</span>
							<label for="ques_type">질문</label>
						</th>
						<td class="left">
							<textarea name="arr_quesans_cont" cols="100" rows="5" class="text" title="질문 내용"></textarea>
							<input type="hidden" name="arr_quesans_type" value="Q" /> 
							<input type="hidden" name="arr_ans_need_spl" value="N" /> 
							<input type="hidden" name="arr_ans_ord" value="0" /> 
							<input type="hidden" name="arr_ques_idx" value="0" /> 
							<input type="hidden" name="arr_quesans_idx" value="0" />
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>

		<br />

		<table class="tstyle_list" id="tblSrvyAnswerArea">
			<caption>${pgname}</caption>
			<colgroup>
				<col width="90px" />
				<col />
				<col width="120px" />
			</colgroup>
			<thead>
				<th scope="row">#</th>
				<th scope="row">답변</th>
				<th scope="row">삭제</th>
			</thead>
			<tbody>
				<c:forEach var="result" items="${quesansList}" varStatus="status">
					<c:if test="${status.index ne 0}">
						<tr>
							<td scope="row">답변 #${status.index}</td>
							<td class="txt_left" style='line-height:250%'>
								<input type="text" name="arr_quesans_cont" size="80" class="text" title="답변 내용" value="${result.quesans_cont}"/>
								<input type="hidden" name="arr_quesans_type" value="A" /> 
								<select name="arr_ans_need_spl">
									<option value="N" <c:if test="${result.ans_need_spl eq 'N'}">selected</c:if>>일반</option>
									<option value="Y" <c:if test="${result.ans_need_spl eq 'Y'}">selected</c:if>>기타(추가답변요구)</option>
								</select> 
								
								<c:forEach var="atchresult" items="${atchfileList}" varStatus="atchstatus">
									<c:if test="${atchresult.atckey_4th eq result.ans_ord}">
										<!-- 대표이미지 -->	
										<p class="fileName">
											<img src="${pageContext.request.contextPath}/cms/images/template/exticos/${elfunc:getImgicoByExt(atchresult.fext)}.gif" width="16" height="16" alt="htp"/>
											<a href="javascript:cmmfn_download_atchfile('${pageContext.request.contextPath}', '${atchresult.vchkcode}')" title="${atchresult.rname}">${elfunc:cutString(atchresult.rname, 25, "... ")} (${atchresult.size_kb}kb)</a>
											<a href="javascript:cmmfn_delete_onefile('${pageContext.request.contextPath}', '${atchresult.vchkcode}', fn_egov_srvyquesans_mod('${result.ques_idx}', '${result.quesans_idx}'))">
												<span class="btn_imgSmall"><img src="${pageContext.request.contextPath}/cms/images/template/cmm/btn_reply_delete.gif" alt="삭제"/></span>
											</a>
										</p>
										<c:set var="empty_file" value="N"/>
									</c:if>
								</c:forEach>
								<input type="file" id="file_upload${result.ans_ord}" name="file_upload" size="80"/>
								<input type="hidden" id="empty_file${result.ans_ord}" name="empty_file${formstat.index}" value="${empty_file}"/>
								<input type="hidden" name="arr_ques_idx" value="${result.ques_idx}" /> 
								<input type="hidden" name="arr_quesans_idx" value="${result.quesans_idx}" />
								<c:set var="empty_file" value="Y"/>
							</td>
							<td class="txt_center">
								<input type="hidden" name="arr_ans_ord" value="${status.index}" size="3" maxlength="2" />
								<c:if test="${param.srvy_act_yn eq 'N'}">
									<a href="javascript:fn_egov_srvyquesans_del('${result.quesans_idx}')" class="btn_lineSmall" style="vertical-align: middle">삭제</a>
								</c:if>
							</td>
						</tr>
					</c:if>
				</c:forEach>
				<c:forEach var="result" begin="${empty quesansList ? 1 : fn:length(quesansList)}" end="10" varStatus="status">
					<tr>
						<td scope="row">답변 #${result}</td>
						<td class="txt_left" style='line-height:250%'><input type="text" name="arr_quesans_cont" size="80" class="text" title="답변 내용" value=""> 
							<input type="hidden" name="arr_quesans_type" value="A" /> 
							<select name="arr_ans_need_spl">
								<option value="N">일반</option>
								<option value="Y">기타(추가답변 요구)</option>
							</select> 
							
							<input type="file" id="file_upload${result + 1}" name="file_upload"/>
							<input type="hidden" id="empty_file${result + 1}" name="empty_file${result + 1}" value="Y"/>
							
							<input type="hidden" name="arr_ques_idx" value="0" /> 
							<input type="hidden" name="arr_quesans_idx" value="0" />
						</td>
						<td class="txt_center">
							<input type="hidden" name="arr_ans_ord" value="${result}" size="3" maxlength="2" />
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<br /> <br />

		<div class="btn_area_right">
			<c:if test="${param.srvy_act_yn eq 'N'}">
				<a href="javascript:fn_egov_srvyquesans_save()" class="btn_line">저장</a>
				<c:if test="${srvyquesansVO.edomweivgp ne 'A'}">
					<a href="javascript:fn_egov_srvyques_del()" class="btn_line">삭제</a>
				</c:if>
			</c:if>
			<a href="javascript:fn_egov_srvyques_list()" class="btn_line">질문목록</a>
		</div>

	</div>

	<form:hidden path="edomweivgp" />
	<form:hidden path="pageIndex" />
	<form:hidden path="searchCondition" />
	<form:hidden path="searchKeyword" />
	<form:hidden path="ques_idx"/>
	<form:hidden path="quesans_idx"/>
	<form:hidden path="srvy_idx"/>
	<form:hidden path="part_idx"/>
	<form:hidden path="srvy_act_yn"/>
		
	<form:hidden path="srch_mu_site"/>
	<form:hidden path="srch_mu_lang"/>
	
	
</form:form>
