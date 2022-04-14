<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/cmmn/jquery-ui-1.8.13.custom.css"/>
<style>
.txt_red {
	text-color : #f00;
	}
.display_none {
	display : none;
}
</style>
<c:choose>
	<c:when test="${param.editor_gb eq 'A'}">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/utils/editor/cleditor1.4.5/jquery.cleditor.css"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/utils/editor/cleditor1.4.5/jquery.cleditor.js"></script>
	</c:when>
	<c:when test="${param.editor_gb eq 'B'}">
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/utils/editor/tinymce/js/tinymce/tinymce.min.js"></script>
	</c:when>
	<c:when test="${param.editor_gb eq 'C'}">
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/utils/editor/ckeditor/ckeditor.js"></script>
	</c:when>
	<c:when test="${param.editor_gb eq 'D'}">
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/hwp_common.js"></script>
	</c:when>
	<c:when test="${param.editor_gb eq 'E'}">
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
	</c:when>
	<c:when test="${param.editor_gb eq 'F'}">
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/utils/editor/smarteditor/js/HuskyEZCreator.js"></script>
	</c:when>
	<c:when test="${param.editor_gb eq 'G'}">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/utils/editor/daumeditor-7.4.27/css/editor.css" type="text/css" charset="utf-8"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
    	<script src="${pageContext.request.contextPath}/utils/editor/daumeditor-7.4.27/js/editor_loader.js?environment=development" type="text/javascript" charset="utf-8"></script>
	</c:when>
	<c:otherwise>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
	</c:otherwise>
</c:choose>


<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-ui-1.8.13.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/_cmmn/plani_common.js"></script>

<script type="text/javascript">

jQuery(document).ready(function(){
	g_context = "${pageContext.request.contextPath}";
	cmmfn_init_editor("brd_cont", "${param.editor_gb}", 200);
	
});


</script>

</head>
<body>

<c:choose>
	<c:when test="${param.editor_gb eq 'D'}">
		<object id="brd_cont" style="LEFT: 0px; TOP: 0px" height="330" width="100%" classid="CLSID:BD9C32DE-3155-4691-8972-097D53B10052">
			<PARAM NAME="TOOLBAR_MENU" VALUE="TRUE">
			<PARAM NAME="TOOLBAR_STANDARD" VALUE="TRUE">
			<PARAM NAME="TOOLBAR_FORMAT" VALUE="TRUE">
			<!-- <PARAM NAME="TOOLBAR_TABLE" VALUE="TRUE"> -->
			<PARAM NAME="SHOW_TOOLBAR" VALUE="TRUE">
			<PARAM NAME="SHOW_STATUSBAR" VALUE="TRUE">
		</object><br/><br/>
	</c:when>
	<c:when test="${param.editor_gb eq 'E'}">
		<table>
			<tr>
				<td width="740px;" height="330px;"><script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/tweditor.js"></script></td>
			</tr>
		</table>
	</c:when>
	<c:when test="${param.editor_gb eq 'G'}">
		<div id="editor_frame"></div>
		<textarea id="brd_cont" name="brd_cont" class="display_none">
		</textarea>
		
	</c:when>
	<c:otherwise>
		<textarea id="brd_cont" name="brd_cont"></textarea>
	</c:otherwise>
</c:choose>
</body>
</html>