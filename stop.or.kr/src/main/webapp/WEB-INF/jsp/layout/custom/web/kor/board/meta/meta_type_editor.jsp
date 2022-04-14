<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/jsp/layout/custom/web/kor/cmm/metacmmn.jsp"/>
<!-- eGovFrame Common import -->        

<link href="${pageContext.request.contextPath}/css/template/jquery/jquery-ui-1.9.2.custom.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/utils/fileupload/uploadify/uploadify.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/css/template/cmmn/fileupload.css" rel="stylesheet"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/custom/web/kor/basic.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/custom/web/kor/content.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/template/metsys/bbs.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/template/metsys/button.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/utils/datepicker/css/datepicker.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/kor/sub.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/kor/respond/sub.css" />


<c:choose>
	<c:when test="${SESS_BRD_INFO.editor_gb eq 'A'}">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/utils/editor/cleditor1.4.5/jquery.cleditor.css"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/utils/editor/cleditor1.4.5/jquery.cleditor.js"></script>
	</c:when>
	<c:when test="${SESS_BRD_INFO.editor_gb eq 'B'}">
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/utils/editor/tinymce/js/tinymce/tinymce.min.js"></script>
	</c:when>
	<c:when test="${SESS_BRD_INFO.editor_gb eq 'C'}">
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/utils/editor/ckeditor/ckeditor.js"></script>
	</c:when>
	<c:when test="${SESS_BRD_INFO.editor_gb eq 'D'}">
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/hwp_common.js"></script>
	</c:when>
	<c:when test="${SESS_BRD_INFO.editor_gb eq 'F'}">
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/utils/editor/smarteditor/js/HuskyEZCreator.js"></script>
	</c:when>
	<c:when test="${SESS_BRD_INFO.editor_gb eq 'G'}">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/utils/editor/daumeditor-7.4.27/css/editor.css" type="text/css"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
		<!-- 20200729 -->
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-ui-1.9.2.custom.min.js"></script>
		<!--// 20200729 -->
    	<script src="${pageContext.request.contextPath}/utils/editor/daumeditor-7.4.27/js/editor_loader.js?environment=development" type="text/javascript"></script>
	</c:when>	
	<c:otherwise>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
		<!-- 20200729 -->
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-ui-1.9.2.custom.min.js"></script>
		<!--// 20200729 -->
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
	</c:otherwise>
</c:choose>

<script type="text/javascript" src="${pageContext.request.contextPath}/utils/fileupload/uploadify/swfobject.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/utils/fileupload/uploadify/jquery.uploadify.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/html5.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/custom/web/kor/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/_cmmn/plani_common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/_cmmn/plani_gen.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/_cmmn/plani_auth.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/_cmmn/plani_brd_editor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/plugins/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/plugins/jquery-plani.ajax_form_submit.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
<%-- <c:if test="${!empty SESS_BRD_INFO}">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/_cmmn/plani_brd_content.js"></script>
</c:if> --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/utils/datepicker/js/datepicker.js"></script>



<!--[if lt IE 9]>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/html5.js"></script>
<![endif]-->

