<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="keywords" content="${SESS_PROP_PRJTNM}" />
<meta name="description" content="${SESS_PROP_PRJTNM}" />
<meta name="copyright" content="Copyright 2013 ${SESS_PROP_PRJTNM} all rights reserved." />
<!-- eGovFrame Common import -->        
<link rel="stylesheet" href="${pageContext.request.contextPath}/utils/fileupload/uploadify/uploadify.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/template/metsys/basic.css"  />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/template/cmmn/fileupload.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/utils/datepicker/css/datepicker.css" />

<c:choose>
	<c:when test="${not empty param.brd_id and SESS_BRD_INFO.editor_gb eq 'A'}">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/utils/editor/cleditor1.4.5/jquery.cleditor.css"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/utils/editor/cleditor1.4.5/jquery.cleditor.js"></script>
	</c:when>
	<c:when test="${not empty param.brd_id and SESS_BRD_INFO.editor_gb eq 'B'}">
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/utils/editor/tinymce/js/tinymce/tinymce.min.js"></script>
	</c:when>
	<c:when test="${not empty param.brd_id and SESS_BRD_INFO.editor_gb eq 'C'}">
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/utils/editor/ckeditor/ckeditor.js"></script>
	</c:when>
	<c:when test="${not empty param.brd_id and SESS_BRD_INFO.editor_gb eq 'D'}">
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/hwp_common.js"></script>
	</c:when>
	<c:when test="${not empty param.brd_id and SESS_BRD_INFO.editor_gb eq 'F'}">
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/utils/editor/smarteditor/js/HuskyEZCreator.js"></script>
	</c:when>
	<c:when test="${not empty param.brd_id and SESS_BRD_INFO.editor_gb eq 'G'}">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/utils/editor/daumeditor-7.4.27/css/editor.css" type="text/css" charset="utf-8"/>
    	<script src="${pageContext.request.contextPath}/utils/editor/daumeditor-7.4.27/js/editor_loader.js?environment=development" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
	</c:when>	
	<c:otherwise>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/utils/editor/daumeditor-7.4.27/css/editor.css" type="text/css" charset="utf-8"/>
    	<script src="${pageContext.request.contextPath}/utils/editor/daumeditor-7.4.27/js/editor_loader.js?environment=development" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
	</c:otherwise>
</c:choose>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-ui-1.9.2.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/plugin/jquery.multiselect.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/plugin/jquery.alphanumeric.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/_cmmn/plani_common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/_cmmn/plani_brd_editor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/_cmmn/plani_gen.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/utils/fileupload/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/utils/datepicker/js/datepicker.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/plugins/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/plugins/jquery-plani.ajax_form_submit.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>

<!-- ▼아래는 IE9 보다 버전이 낮은 브라우저에서만 이 스크립트를 해석하도록 한 것 -->
<!--[if IE]>
 <script src="${pageContext.request.contextPath}/js/plani/html5.js" ></script> 
 <script src="${pageContext.request.contextPath}/js/plani/ie_print.js" ></script> 
<![endif]-->
