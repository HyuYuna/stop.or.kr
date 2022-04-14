<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!--
	첨부파일 관리 스크립트
	2013.04.16 bhhan
-->	
<script type="text/javascript">

/**************************************************************
 *  			관리자 첨부파일 페이지 초기화 Start
 **************************************************************/
function fn_egov_init_atchinspage()
{
	cmmfn_init_uploadify("file_upload", g_context, 10, 0, 20, "GNR", fn_egov_atch_list);
} 

function fn_egov_custatch_save()
{
	if(cmmfn_get_uploadify_queuelength("file_upload") == 0)
	{
		alert("첨부할 파일을 선택해주십시오.");
		return;
	}
	
	if(confirm("첨부파일을 등록하시겠습니까?") == false)
		return;
		
	var maxcustkey = jQuery("#maxcustkey").val();
	maxcustkey = (parseInt(maxcustkey) + 1);

	cmmfn_set_uploadifykeys('file_upload', "CUST_ATCH", maxcustkey, 1, 'GNR');
	cmmfn_upload_uploadify('file_upload', fn_egov_atch_list);

}

function fn_egov_atch_list()
{
	var form = document.reqForm;
	fn_egov_move_action(form, "/modeatch/customAtchPage.do?srch_menu_nix=${param.srch_menu_nix}");
}


function fn_egov_link_page(pageIndex)
{
	var form = document.reqForm;
	form.pageIndex.value = pageIndex;
	fn_egov_atch_list();
}


/**************************************************************
 *  			관리자 첨부파일 페이지 초기화 End
 **************************************************************/


</script>
