<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
jQuery(document).ready(function(){

	
	cmmfn_remove_scrtag(jQuery("#mc_content"));
	/*
	var cont = jQuery("#ucont_cont").val();
	cont = cont.replace(/http:\/\/localhost/gi, "");
	jQuery("#ucont_cont").val(cont);
	*/
	cmmfn_init_editor("mc_content", "G", null);
	
	// 에디터에서 자동으로 붙이는 localhost를 삭제
	var org_cont = jQuery("#mc_content").val();
	org_cont = org_cont.replace(/https?:\/\/localhost/gi, "");
	jQuery("#mc_content").val(org_cont);


});

</script>

<form:form name="reqForm" commandName="multiCmsVO" action="${cutil:getUrl('/metsys/multicms/multiCmsSave.do', '', true)}" class="ajax-form-submit_mc" method="post" enctype="multipart/form-data">

<!-- content -->
<div id="divMainArticle">

		<h2>목록 등록/수정</h2><br/>

		<table class="tstyle_view">
			<colgroup>
				<col width="18%" />
				<col />
			</colgroup>
			<caption>등록 폼</caption>
		
			<tr>
				<th scope="row"><label for="mc_title">제목</label></th>
				<td><form:input path="mc_title" name="mc_title" class="input_width_700" title="제목"/>
				<form:errors path="mc_title"/></td>
			</tr>			
			<tr>
				<th scope="row"><label for="title">내용</label></th>
				<td>
					<div id="editor_frame"></div>
					<form:textarea path="mc_content" name="mc_content" class="display_none"></form:textarea>
				</td>
			</tr>
			
		</table>
		<br/>
		<div class="fileUpload_area">
			<h2>이미지</h2><input type="file" name="file_upload" id="file_upload"/>
			<ul class="fileUpload_progress">
				
				<c:forEach var="result" items="${atchfileList}" varStatus="status">
					
					<c:if test="${fn:indexOf(result.fext,'jpg') != -1 || fn:indexOf(result.fext,'png') != -1 || fn:indexOf(result.fext,'bmp') != -1 || fn:indexOf(result.fext,'gif') != -1 || fn:indexOf(result.fext,'JPG') != -1 || fn:indexOf(result.fext,'PNG') != -1 || fn:indexOf(result.fext,'BMP') != -1 || fn:indexOf(result.fext,'GIF') != -1}">
						<li class="img_file_li">
							<div id="divAtcharea_${result.atckey_4th}" class="uploadify-queue-item">
								<div class="cancel">
									<a href="javascript:cmmfn_delete_onefile('${pageContext.request.contextPath}', '${result.vchkcode}', fn_mc_page_reload)">X</a>
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
					</c:if>
				</c:forEach>
				<li><div id="divSelectFileArea"></div></li>
			</ul>
		</div>
		<br/>
		<div class="fileUpload_area">
			<h2>첨부파일</h2><input type="file" name="file_upload2" id="file_upload2"/>
			<ul class="fileUpload_progress">
				
				<c:forEach var="result" items="${atchfileList_f}" varStatus="status">
					<c:if test="${fn:indexOf(result.fext,'jpg') == -1 && fn:indexOf(result.fext,'png') == -1 && fn:indexOf(result.fext,'bmp') == -1 && fn:indexOf(result.fext,'gif') == -1}">
						<li class="file_li">
							<div id="divAtcharea_${result.atckey_4th}" class="uploadify-queue-item">
								<div class="cancel">
									<a href="javascript:cmmfn_delete_onefile('${pageContext.request.contextPath}', '${result.vchkcode}', fn_mc_page_reload)">X</a>
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
					</c:if>
				</c:forEach>
				<li><div id="divSelectFileArea2"></div></li>
			</ul>
		</div>

		
		<div class="btn_area_right">
			<a href="#" onclick="file_attach_check();return false;" class="btn_line">저장하기</a>
			<a href="javascript:fn_egov_multi_cms_list();" class="btn_line">목록보기</a>
		</div>
		<form:hidden path="edomweivgp" />
		<form:hidden path="pageIndex" value="${pageIndex}"/>
		<form:hidden path="mc_seq"/>
		<form:hidden path="srch_mu_site"/>
		<form:hidden path="srch_mu_lang"/>
		<form:hidden path="mc_category"/>
		
</div>

</form:form>