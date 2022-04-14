<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!--
	정보공개목록 스크립트
-->	
<script type="text/javascript">
$(document).ready(function(){
	
	try
	{ 
		//업로드초기화
		if(jQuery("#file_upload").length > 0) cmmfn_init_uploadify("file_upload", g_context, 1, 0, 20, "IMG&PDF&HWP", upload_complete_check);
		
		//게시물 삭제시 확인
		$("a.deleteRelease").click(function()
		{
			if(confirm("삭제 하시겠습니까?") == true)
			{
				return true;
			}
			return false;
		});
		
		// 게시물등록 - Ajax form submit
		$('form.ajax-form-submit_rel').AjaxFormSubmit("","저장 하시겠습니까?","",save_success);

	}
	catch(e)
	{
		console.log(e);
//		$.debug(e);
	}
	
});


function file_attach_check()
{
	$('form.ajax-form-submit_rel').submit();
}

function fn_rel_page_reload()
{
	document.location.reload();	
}

function fn_egov_link_page(pageIdx)
{
	var form = document.reqForm;
	form.pageIndex.value = pageIdx;
	fn_egov_release_list();
}

function fn_egov_release_list()
{
	var form = document.reqForm;
	fn_egov_move_action(form, '/metsys/release/releaseManList.do?srch_menu_nix=${param.srch_menu_nix}' + fn_egov_get_argstr());
}

function fn_egov_get_argstr()
{
	var argstr = "";
	var seltab_idx = "";
	

	if(cmmfn_exist_object("seltab_idx") == true)
		seltab_idx = jQuery("#seltab_idx").val();			
	else
		seltab_idx = "${param.seltab_idx}";

	if(cmmfn_exist_object("seltab_idx") == false && seltab_idx != "")
		argstr += "&seltab_idx=" + seltab_idx;
	
	return argstr;
}

function save_success(result)
{
	/*파일업로드*/
   	if(result.data != 'NULL')
	{	
   		if(result.data.rel_seq)
			{
	   			cmmfn_set_uploadifykeys('file_upload', 'RELEASE', result.data.rel_seq, 1, 'GNR');
	        	cmmfn_upload_uploadify('file_upload');
			}
	}
	
   	if (result.url) {
		location.replace(result.url);
	}
	
}

function upload_complete_check()
{
	
	alert("저장되었습니다.");
	fn_egov_release_list();
	
}



</script>
