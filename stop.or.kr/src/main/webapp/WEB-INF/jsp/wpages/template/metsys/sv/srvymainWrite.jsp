<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	
<form:form name="reqForm" commandName="srvymainVO" enctype="multipart/form-data">
	
	<c:choose>
		<c:when test="${srvymainVO.edomweivgp eq 'A'}">
			<c:set var="pgname" value="설문 기본 설정" />
		</c:when>
		<c:when test="${srvymainVO.edomweivgp eq 'M'}"> 
			<c:set var="pgname" value="설문 기본 설정" />
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
					<th scope="row"><span class="point01">*</span> <label for="srvy_nm">설문조사 명</label></th>
					<td class = "left">
						<form:hidden path="srvy_idx" size="20" class="text" title="설문조사 번호"/>
						<form:input path="srvy_nm" size="100" class="text" title="설문조사 명"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="srvy_cont">설문조사 내용</label></th>
					<td class = "left">
						<div id="editor_frame"></div>
						<form:textarea path="srvy_cont" class="display_none"></form:textarea>
					</td>
				</tr>
				
				<tr>
					<th scope="row"><label for="srvy_start">설문조사 기간</label></th>
					<td class = "left">
						<form:input path="srvy_start" size="30" class="text" title="설문조사 시작일"/> ~
						<form:input path="srvy_end" size="30" class="text" title="설문조사 종료일"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="srvy_allow_dup">중복응답 허용여부</label></th>
					<td class = "left">
						<form:select path="srvy_allow_dup" title="중복응답 허용여부 [Y/N]">
							<form:option value="Y">허용</form:option>
							<form:option value="N">허용안함</form:option>
						</form:select>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="srvy_open_yn">설문실시 여부</label></th>
					<td class = "left">
						<form:select path="srvy_open_yn" title="현재시점 설문실시 여부">
							<form:option value="N">준비중</form:option>
							<form:option value="Y">진행중</form:option>
						</form:select>
						<span class="point01">[ 설문기간과 실시여부가 모두 만족되어야 설문이 실시됩니다. ]</span>
					</td>
				</tr>
				<tr style="display:none">
					<th scope="row"><span class="point01">*</span> <label for="srvy_max_ans">선착순 설정</label></th>
					<td class = "left">
						<form:input path="srvy_max_ans" size="20" class="text" title="선착순 설정"/>
						 <span class="point01">[ 0 : 제한없음 ]</span>
					</td>
				</tr>
				
				<c:forEach begin="1" end="1" varStatus="formstat">
					<tr style="display:none">
						<th scope="row"><span class="point01">*</span> <label for="file_upload">팝업이미지</label></th>
						<td class="form">
							<c:set var="empty_file" value="Y"/> <!--첨부파일의 개수만큼 -->
							<c:forEach var="result" items="${atchfileList}" varStatus="status">
								<c:if test="${result.atckey_4th eq formstat.index}">
								<!-- 대표이미지 -->
									<p class="fileName">
										<img src="${pageContext.request.contextPath}/images/template/exticos/${elfunc:getImgicoByExt(result.fext)}.gif" width="16" height="16" alt="htp"/>
										<a href="javascript:cmmfn_download_atchfile('${pageContext.request.contextPath}', '${result.vchkcode}')" title="${result.rname}">${elfunc:cutString(result.rname, 25, "... ")} (${result.size_kb}kb)</a>
										<a href="javascript:cmmfn_delete_onefile('${pageContext.request.contextPath}', '${result.vchkcode}', fn_egov_srvymain_mod('${srvymainVO.srvy_idx}'))">
											<span class="btn_imgSmall"><img src="${pageContext.request.contextPath}/images/template/cmm/btn_reply_delete.gif" alt="삭제"/></span>
										</a>
									</p>
									<c:set var="empty_file" value="N"/>
								</c:if>
							</c:forEach>
							<input type="file" id="file_upload${formstat.index}" name="file_upload" style="width:550px"/>
							<input type="hidden" id="empty_file${formstat.index}" name="empty_file${formstat.index}" value="${empty_file}"/>
						</td>
					</tr>
				</c:forEach>	
				<tr style="display:none">
					<th scope="row"><label for="writer">팝업 설정</label></th>
					<td class = "left">
						<p>
							<form:radiobutton path="srvy_pop_type" value="W" label="팝업창"/>
							<form:radiobutton path="srvy_pop_type" value="Z" label="팝업존"/>
						</p>
						<br/>
						<p>
						X좌표 : <form:input path="srvy_x" size="5" maxlength="4" class="text" title="X좌표"/> 
						Y좌표 : <form:input path="srvy_y" size="5" maxlength="4" class="text" title="Y좌표"/> 
						Width : <form:input path="srvy_w" size="5" maxlength="4" class="text" title="Width"/> 
						Height : <form:input path="srvy_h" size="5" maxlength="4" class="text" title="Height"/>
						</p>
					</td>
				</tr>		
				<c:if test="${param.edomweivgp eq 'M'}">
					<tr>
						<th scope="row"><label for="writer">작성자</label></th>
						<td class = "left">
							<c:out value="${srvymainVO.writer}"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="wdt">작성일</label></th>
						<td class = "left">
							<c:out value="${srvymainVO.wdt}"/>
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>	
		
		<!-- 게시글 리스트 페이징 //-->

		<br/>
		
		<!-- 첨부파일영역 Start : 첨부파일 사용시 주석 제거 --/>
		<c:choose>
			<c:when test="${srvymainVO.edomweivgp eq 'P' or srvymainVO.edomweivgp eq 'A'}">
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
			<a href="javascript:fn_egov_srvymain_save()" class="btn_line">저장</a>
			<c:if test="${srvymainVO.edomweivgp ne 'A'}">
				<a href="javascript:fn_egov_srvymain_del()" class="btn_line">삭제</a>
			</c:if>
			<a href="javascript:fn_egov_srvymain_list()" class="btn_line">목록</a>
		</div>
	
	</div>
	
	<form:hidden path="edomweivgp"/>
	<form:hidden path="pageIndex"/>
	<form:hidden path="searchCondition"/>
	<form:hidden path="searchKeyword"/>
	<form:hidden path="srch_mu_site"/>
	<form:hidden path="srch_mu_lang"/>
	
</form:form>
