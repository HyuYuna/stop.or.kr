<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	
<form:form name="reqForm" commandName="srvypartVO">
	
	<c:choose>
		<c:when test="${srvypartVO.edomweivgp eq 'A'}">
			<c:set var="pgname" value="설문 챕터 추가" />
		</c:when>
		<c:when test="${srvypartVO.edomweivgp eq 'M'}">
			<c:set var="pgname" value="설문 챕터 수정" />
		</c:when>
	</c:choose>	
	<h2 class="depth2_bbsTitle">${pgname}</h2>
	
	<div id= "divMainArticle">
		<!-- content -->
		
		<table class="tstyle_view">
			<caption>${pgname}</caption>
			<colgroup>
				<col width="150" />
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="part_nm">챕터 명</label></th>
					<td class = "left">
						<form:hidden path="part_idx" size="20" class="text" title="챕터 번호"/>
						<form:hidden path="srvy_idx" size="20" class="text" title="설문조사 번호"/>
						<form:input path="part_nm" size="100" class="text" title="챕터 명"/>
					</td>
				</tr>
				<tr style="display:none">
					<th scope="row"><span class="point01">*</span> <label for="part_type">챕터 구분</label></th>
					<td class = "left">
						<form:select path="part_type" title="챕터 구분 ">
							<form:options items="${partcode}" itemLabel="code_nm" itemValue="code_idx"/>
						</form:select>
					</td>
				</tr>
				<tr id="trPsnInfo" class="display_none">
					<th scope="row"><label for="part_psn_info">개인정보 수집 안내</label></th>
					<td class = "left">
						<div id="editor_frame"></div>
						<form:textarea path="part_psn_info" class="display_none"></form:textarea>
					</td>
				</tr>
				<c:if test="${param.edomweivgp eq 'M'}">
					<tr>
						<th scope="row"><label for="writer">작성자</label></th>
						<td class = "left">
							<c:out value="${srvypartVO.writer}"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="wdt">작성일</label></th>
						<td class = "left">
							<c:out value="${srvypartVO.wdt}"/>
						</td>
					</tr>
				</c:if>
				<!-- 다음에디터 사용시 주석제거, 아래 FORM: 을 form:으로 변경, clobcolumn_name 을 맞는 컬럼명으로 변경한다 --/>
				<tr>
					<td colspan="2" class="form" id="editorWrapper">
						<div id="editor_frame"></div>
						<FORM:textarea path="clobcolumn_name" class="display_none"></FORM:textarea>
					</td>
				</tr>
				<!-- 다음에디터 사용시 주석제거 -->
			</tbody>
		</table>	
		
		<!-- 게시글 리스트 페이징 //-->

		<br/>
		
		<!-- 첨부파일영역 Start : 첨부파일 사용시 주석 제거 --/>
		<c:choose>
			<c:when test="${srvypartVO.edomweivgp eq 'P' or srvypartVO.edomweivgp eq 'A'}">
				<div class="fileUpload_area">
					<h2>첨부파일</h2><input type="file" name="file_upload" id="file_upload"/>
					<ul class="fileUpload_progress">
						<li><div id="divSelectFileArea"><br/></div></li>
					</ul>
				</div>
			</c:when>
			<c:otherwise>
				<div class="fileUpload_area">
					<h2>첨부파일</h2><input type="file" name="file_upload" id="file_upload"/>
					<ul class="fileUpload_progress">
						
						<c:forEach var="result" items="${atchfileList}" varStatus="status">
							<li>
								<div id="divAtcharea_${result.atckey_4th}" class="uploadify-queue-item">
									<div class="cancel">
										<a href="javascript:cmmfn_delete_onefile('${pageContext.request.contextPath}', '${result.vchkcode}', fn_egov_##BIZNM#_mod)">X</a>
									</div>
									<div class="file_area">
										<span class="fileName">
											<img src="${pageContext.request.contextPath}/images/template/exticos/${elfunc:getImgicoByExt(result.fext)}.gif" width="16" height="16" alt="htp"/>
											<a href="javascript:cmmfn_download_atchfile('${pageContext.request.contextPath}', '${result.vchkcode}')" title="${result.rname}">${elfunc:cutString(result.rname, 25, "... ")} (${result.size_mb}Mb)</a>
										</span>
										<span class="data"></span>
									</div> 
								</div>
							</li>
						</c:forEach>
						<li><div id="divSelectFileArea"></div></li>
					</ul>
				</div>
			</c:otherwise>
		</c:choose>
		<!-- 첨부파일영역 Start -->
		
		<br/>
		
		<div class="btn_area_right">
			<c:if test="${param.srvy_act_yn eq 'N'}">
				<a href="javascript:fn_egov_srvypart_save()" class="btn_line">저장</a>
				<c:if test="${srvypartVO.edomweivgp ne 'A'}">
					<a href="javascript:fn_egov_srvypart_del()" class="btn_line">삭제</a>
				</c:if>
			</c:if>
			<a href="javascript:fn_egov_srvypart_list()" class="btn_line">목록</a>
		</div>
	
	</div>
	
	<form:hidden path="edomweivgp"/>
	<form:hidden path="pageIndex"/>
	<form:hidden path="searchCondition"/>
	<form:hidden path="searchKeyword"/>
	<form:hidden path="srvy_act_yn"/>
	
	<form:hidden path="srch_mu_site"/>
	<form:hidden path="srch_mu_lang"/>
	
</form:form>
