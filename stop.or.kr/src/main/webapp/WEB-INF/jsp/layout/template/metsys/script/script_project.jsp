<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/utils/editor/daumeditor-7.4.27/css/editor.css" type="text/css" charset="utf-8"/>
<script src="${pageContext.request.contextPath}/utils/editor/daumeditor-7.4.27/js/editor_loader.js?environment=development" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
<!-- 첨부파일 컴포넌트 -->
<script type="text/javascript" src="/js/egovframework/dev/cmm/fileMngUtil.js?v=20190527055729"></script>
<script type="text/javascript">
function fn_egov_init_projectpage(){
	cmmfn_set_datepicker(g_context, jQuery("#pbd_due_dt"), "%Y-%m-%d");
	cmmfn_remove_scrtag(jQuery("#pbd_req_content"));
	cmmfn_init_editor("pbd_req_content", "G", 400);	
	
	cmmfn_remove_scrtag(jQuery("#pbdResContent"));
	cmmfn_init_editor("pbdResContent", "G", 400);	
	
	cmmfn_remove_scrtag(jQuery("#pbdReqContent"));
	cmmfn_init_editor("pbdReqContent", "G", 400);	
}
function fn_egov_link_page(pageIdx)
{
	var form = document.listFrm;
	form.pageIndex.value = pageIdx;
	form.submit();
}
</script>
