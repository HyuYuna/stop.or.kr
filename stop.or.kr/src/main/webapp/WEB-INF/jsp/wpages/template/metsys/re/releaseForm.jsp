<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<form:form name="reqForm" commandName="releaseVO" action="${cutil:getUrl('/metsys/release/releaseSave.do', '', true)}" class="ajax-form-submit_rel" method="post" enctype="multipart/form-data">

<!-- content -->
<div id="divMainArticle">

		<h2>사전공표목록 관리</h2><br/>

		<table class="tstyle_view">
			<colgroup>
				<col width="18%" />
				<col />
			</colgroup>
			<caption>등록 폼</caption>
			<tr>
				<th scope="row"><label for="title">공지</label></th>
				<td>
					<input type="radio" name="is_notice" id="is_notice_y" value="Y" <c:if test="${ fn:trim(releaseVO.is_notice) eq 'Y'}">checked="checked"</c:if>><label for="is_notice_y">사용</label>
					<input type="radio" name="is_notice" id="is_notice_n" value="N" <c:if test="${ fn:trim(releaseVO.is_notice) eq 'N'}">checked="checked"</c:if>><label for="is_notice_n">미사용</label>
				</td>
			</tr>
			
			<tr>
				<th scope="row"><label for="rel_title">제목</label></th>
				<td><form:input path="rel_title" name="rel_title" class="input_width_700" title="제목"/>
				<form:errors path="rel_title"/></td>
			</tr>
			<tr>
				<th scope="row"><label for="division">분류</label></th>
				<td><form:input path="division" name="division" class="input_width_700" title="분류"/>
				<form:errors path="division"/></td>
			</tr>
			<tr>
				<th scope="row"><label for="rel_pblntf_cycle">공개주기</label></th>
				<td><form:input path="rel_pblntf_cycle" name="rel_pblntf_cycle" class="input_width_700" title="공시주기"/>
				<form:errors path="rel_pblntf_cycle"/></td>
			</tr>
			<tr>
				<th scope="row"><label for="rel_era">공개시기</label></th>
				<td><form:input path="rel_era" name="rel_era" class="input_width_700" title="갱신예정일"/>
				<form:errors path="rel_era"/></td>
			</tr>
			<tr id="rel_content">
				<th scope="row"><label for="rel_content">내용</label></th>
				<td>
					<form:textarea path="rel_content" title="내용" cols="90" rows="5"/>
				</td>
			</tr>
			<tr id="rel_mth">
				<th scope="row"><label for="rel_mth">공개방법</label></th>
				<td>
					<input type="radio" name="rel_mth" id="rel_mth_1" value="1" <c:if test="${ fn:trim(releaseVO.rel_mth) eq '1'}">checked="checked"</c:if>><label for="rel_mth_1">링크</label>
					<input type="radio" name="rel_mth" id="rel_mth_2" value="2" <c:if test="${ fn:trim(releaseVO.rel_mth) eq '2' || empty releaseVO.rel_mth}">checked="checked"</c:if>><label for="rel_mth_2">첨부파일</label>
				</td>
			</tr>
			<tr id="rel_url">
				<th scope="row"><label for="rel_url">링크</label></th>
				<td>
					<form:input path="rel_url" name="rel_url" class="input_width_700" title="링크"/>
				</td>
			</tr>
		</table>
		<br/>
		
		<h2>담당자 정보</h2><br/>

		<table class="tstyle_view">
			<colgroup>
				<col width="18%" />
				<col />
			</colgroup>
			<caption>등록 폼</caption>
			<tr>
				<th scope="row"><label for="rel_dept">담당부서</label></th>
				<td>
					<form:input path="rel_dept" name="rel_dept" class="input_width_700" title="담당부서"/>
					<form:errors path="rel_dept"/></td>
			</tr>
			<tr>
				<th scope="row"><label for="rel_charger">담당자</label></th>
				<td><form:input path="rel_charger" name="rel_charger" class="input_width_700" title="담당자"/>
				<form:errors path="rel_charger"/></td>
			</tr>
			<tr>
				<th scope="row"><label for="rel_cttpc">연락처</label></th>
				<td><form:input path="rel_cttpc" name="rel_cttpc" class="input_width_700" title="연락처"/>
				<form:errors path="rel_cttpc"/></td>
			</tr>
		</table>
		
		<br/>
		<div class="fileUpload_area">
			<h2>파일</h2><input type="file" name="file_upload" id="file_upload"/>
			<ul class="fileUpload_progress">
				
				<c:forEach var="result" items="${atchfileList}" varStatus="status">
					<li class="file_li">
						<div id="divAtcharea_${result.atckey_4th}" class="uploadify-queue-item">
							<div class="cancel">
								<a href="javascript:cmmfn_delete_onefile('${pageContext.request.contextPath}', '${result.vchkcode}', fn_rel_page_reload)">X</a>
							</div>
							<div class="file_area">
								<span class="fileName">
									<img src="${pageContext.request.contextPath}/images/template/exticos/${elfunc:getImgicoByExt(result.fext)}.gif" width="16" height="16" alt="htp"/>
									<a href="javascript:cmmfn_download_atchfile('${pageContext.request.contextPath}', '${result.vchkcode}')">${result.rname} (${result.size_kb}kb)</a>
								</span>
								<span class="data"></span>
							</div> 
						</div>
					</li>
				</c:forEach>
				<li><div id="divSelectFileArea"></div></li>
			</ul>
		</div>
		<br/>

		
		<div class="btn_area_right">
			<a href="#" onclick="file_attach_check();return false;" class="btn_line">저장하기</a>
			<a href="javascript:fn_egov_release_list();" class="btn_line">목록보기</a>
		</div>
		<form:hidden path="edomweivgp" />
		<form:hidden path="pageIndex" value="${pageIndex}"/>
		<form:hidden path="rel_seq"/>
		<form:hidden path="srch_mu_site"/>
		<form:hidden path="srch_mu_lang"/>
		
</div>

</form:form>