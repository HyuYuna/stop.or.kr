<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="board-view">
	<h1 class="view-title">
		<c:out value="${announcementDataVO.is_notice == 'Y' ? '[공지사항]' : '' }" />
		<c:out value="${announcementDataVO.subject}" />
	</h1>
	<ul class="info">
		<c:choose>
			<c:when test="${announcementDataVO.date_start ne null && announcementDataVO.date_end ne null}">
				<li>
					<strong>모집기간</strong> ${cutil:dateFormat(announcementDataVO.date_start, 'yyyy.MM.dd')} ~ ${cutil:dateFormat(announcementDataVO.date_end, 'yyyy.MM.dd')}
				</li>
				<li>
					<strong>상태</strong> ${cutil:dateCheck(announcementDataVO.date_start, fn:replace(announcementDataVO.date_end, '00:00:00', '23:59:59'), '-', '진행중', '마감')}
				</li>
			</c:when>
			<c:otherwise>
			</c:otherwise>
		</c:choose>	
		<li>
			<strong>작성일</strong> ${cutil:dateFormat(announcementDataVO.wdt, 'yyyy-MM-dd')}
		</li>
	</ul>
	<div class="view-content">
		${announcementDataVO.content}
	</div>
	<c:if test="${!empty atchfileList}">
	<div class="download-list">
		<strong class="title">첨부파일</strong>
		<ul>
		<c:forEach var="result" items="${atchfileList}" varStatus="status">
			<li>
				<a href="javascript:cmmfn_download_atchfile('${pageContext.request.contextPath}', '${result.vchkcode}')">${result.rname} (${result.size_kb}kb)</a>
			</li>
		</c:forEach>
		</ul>
	</div>
	</c:if>
</div>


<div class="btns txt-right">
	<a href="${cutil:getUrl('/announcement/list.do', 'id=', true)}" class="btn-m btn1">목록으로</a>
</div>

<%--
<c:set var="message" value="${isModify ? '수정하시겠습니까?' : 'null'}"/>
<script type="text/javascript">
jQuery(document).ready(function(){
	cmmfn_set_datepicker("${pageContext.request.contextPath}", jQuery("#date_start, #date_end"), "%Y-%m-%d");
	cmmfn_init_uploadify("file_upload", "${pageContext.request.contextPath}", 0, 0/*parseInt("${atchfileListCount}")*/, 20, "IMG", fn_egov_complete_upload);
	cmmfn_init_editor("editor-content", lg_editor_gb, null);
	// 에디터에서 자동으로 붙이는 localhost를 삭제
	//var org_cont = jQuery("#editor-content").val();
	//org_cont = org_cont.replace(/https?:\/\/localhost/gi, "");
	//jQuery("#editor-content").val(org_cont);
	$('form#announcementDataVO').AjaxFormSubmit(null, '${message}', function() {
		// 다음에디터 
		if (typeof(Editor) == 'function') {
			$('#editor-content').val(Editor.getContent());
		}
	}
	, function (result){
		if (result.error != true && result.data.data_id) {
   			cmmfn_set_uploadifykeys('file_upload', 'ANNOUNCEMENT', result.data.data_id, 1, 'GNR');
        	cmmfn_upload_uploadify('file_upload');
		}
	});
});

function fn_rel_page_reload() {
	document.location.reload();	
}	
</script>

<form:form name="reqForm" commandName="announcementDataVO">
	<table class="tstyle_view">
		<colgroup>
			<col width="18%" />
			<col />
		</colgroup>
		<caption>등록 폼</caption>
		<tbody>
			<tr>
				<th scope="row"><label for="user_id">공지</label></th>
				<td>
					<form:radiobutton path="is_notice" value="Y" label="사용" />
					<form:radiobutton path="is_notice" value="N" label="미사용" />
					<form:errors path="is_notice"></form:errors>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="user_id">기간</label></th>
				<td>
					<form:input path="date_start" /> ~ <form:input path="date_end" />
					<form:errors path="date_start"></form:errors>
					<form:errors path="date_end"></form:errors>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="user_id">제목</label></th>
				<td>
					<form:input path="subject" class="input_width_500" />
					<form:errors path="subject"></form:errors>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="user_id">내용</label></th>
				<td>
					<div id="editor_frame"></div>
					<form:textarea path="content" id="editor-content" />
					<form:errors path="content"></form:errors>
				</td>
			</tr>
			<c:if test="${isModify == true}">
			<tr>
				<th scope="row">등록일</th>
				<td>
					<c:out value="${announcementDataVO.wdt}"/>
				</td>
			</tr>
			<tr>
				<th scope="row">수정일</th>
				<td>
					<c:out value="${announcementDataVO.mdt}"/>
				</td>
			</tr>
			</c:if>
		</tbody>
	</table>	
	<div class="fileUpload_area">
		<h2>파일</h2><input type="file" name="file_upload" id="file_upload"/>
		<ul class="fileUpload_progress">
			<c:forEach var="result" items="${atchfileList}" varStatus="status">
				<li>
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
	<div class="btn_area_right">
		<c:choose>
			<c:when test="${isModify == false}">
				<input type="submit" value="저장" class="btn_linebold" />
			</c:when>
			<c:otherwise>
				<input type="submit" value="수정" class="btn_linebold" />
				<a href="${cutil:getUrl('/metsys/announcementDataDelete.do', '', true)}" onclick="if (confirm('삭제하시겠습니까?') == false) { return false; }" class="btn_line">삭제</a>
			</c:otherwise>
		</c:choose>
		<a href="${cutil:getUrl('/metsys/announcementDataList.do', 'id=', true)}" class="btn_line">목록</a>
	</div>		
</form:form>
 --%>
