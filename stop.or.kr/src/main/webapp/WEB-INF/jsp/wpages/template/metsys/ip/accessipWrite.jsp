<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	
<form:form name="reqForm" commandName="accessipVO">
	
	<c:choose>
		<c:when test="${accessipVO.edomweivgp eq 'A'}">
			<c:set var="pgname" value="관리자 접근 IP 제한 추가" />
		</c:when>
		<c:when test="${accessipVO.edomweivgp eq 'M'}">
			<c:set var="pgname" value="관리자 접근 IP 제한 수정" />
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
					<th scope="row"><span class="point01">*</span> <label for="auth_cd">권한</label></th>
					<td class"left">
						<form:select path="auth_cd" title="회원유형 상세">
							<form:options items="${authcode}" itemLabel="auth_nm" itemValue="auth_cd"/>
						</form:select>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="access_ip">접근 IP</label></th>
					<td class"left">
						<form:input path="access_ip" size="21" class="text" title="접근 IP"/>&nbsp;
						<span class="point02">( '*'는 모두 허용, IP대역을 이용할때는 xxx.xxx.xxx.* 등의 표현 허용; 단, *는 마지막에 붙어야 합니다.)</span>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="access_ip">설명</label></th>
					<td class"left">
						<form:input path="description" size="100" class="text" title="설명"/>&nbsp;
					</td>
				</tr>
				<!-- 
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="writer">작성자</label></th>
					<td class"left">
						<form:input path="writer" size="29" class="text"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="wdt">작성일</label></th>
					<td class"left">
						<form:input path="wdt" size="30" class="text"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="modifier">수정자</label></th>
					<td class"left">
						<form:input path="modifier" size="29" class="text"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="mdt">수정일</label></th>
					<td class"left">
						<form:input path="mdt" size="30" class="text"/>
					</td>
				</tr>
				<!-- 다음에디터 사용시 주석제거, 아래 FORM: 을 form:으로 변경, clobcolumn_name 을 맞는 컬럼명으로 변경한다 --/>
				<tr>
					<td colspan="2" class="form" id="editorWrapper">
						<div id="editor_frame"></div>
						<FORM:textarea path="clobcolumn_name" class="display_none"></FORM:textarea>
					</td>
				</tr>
				 -->
				<!-- 다음에디터 사용시 주석제거 -->
			</tbody>
		</table>	
		
		<!-- 게시글 리스트 페이징 //-->

		<br/>
		
		<!-- 첨부파일영역 Start : 첨부파일 사용시 주석 제거 --/>
		<c:choose>
			<c:when test="${accessipVO.edomweivgp eq 'P' or accessipVO.edomweivgp eq 'A'}">
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
			<c:choose>
				<c:when test="${accessipVO.edomweivgp eq 'A'}">
					<a href="javascript:fn_egov_accessip_save()" class="btn_line">저장</a>
				</c:when>
				<c:otherwise>
					<a href="javascript:fn_egov_accessip_del()" class="btn_line">삭제</a>
				</c:otherwise>
			</c:choose>
			<a href="javascript:fn_egov_accessip_list()" class="btn_line">목록</a>
		</div>
	
	</div>
	
	<form:hidden path="edomweivgp"/>
	<form:hidden path="pageIndex"/>
	<form:hidden path="searchCondition"/>
	<form:hidden path="searchKeyword"/>
		
	<form:hidden path="srch_mu_site"/>
	<form:hidden path="srch_mu_lang"/>
	
</form:form>
