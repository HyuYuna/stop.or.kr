<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!--
	스크립트
-->	
<script type="text/javascript">

var attached_file_count = 2 - "${atchfileList.size()}";
var now_attache_count = 0;
var img_file_li_count = 0;
var file_li_count = 0;

$(document).ready(function(){
	
	try
	{ 
		img_file_li_count = $("li.img_file_li").length;
		file_li_count = $("li.file_li").length;
		
		//업로드초기화
		if(jQuery("#file_upload").length > 0) cmmfn_init_uploadify("file_upload", g_context, 1, 0, 200, "IMG" , upload_complete_check);
		//업로드초기화
		if(jQuery("#file_upload2").length > 0) cmmfn_init_uploadify("file_upload2", g_context, 1, 0, 200, "GNR", upload_complete_check);
		
		//게시물 삭제시 확인
		$("a.deleteMultiCms").click(function()
		{
			if(confirm("삭제 하시겠습니까?") == true)
			{
				return true;
			}
			return false;
		});
		
		// 게시물등록 - Ajax form submit
		$('form.ajax-form-submit_mc').AjaxFormSubmit("","저장 하시겠습니까?","",save_success);
		
		
		if(img_file_li_count > 0)
		{
			$("#file_upload").hide();
			
		}
		if(file_li_count > 0)
		{
			
			$("#file_upload2").hide();
			
		}
		
		
	}
	catch(e)
	{
		console.log(e);
//		$.debug(e);
	}
	
});



function file_attach_check()
{	
	// 첨부된 파일도 없고, 큐에도 없는지 확인
	if(img_file_li_count <= 0)
	{
		if(cmmfn_get_uploadify_queuelength("file_upload") == 0)
		{
			alert("첨부할 이미지를 선택해주십시오.");
			return false;
		}
	}
	
	if(file_li_count <= 0)
	{
		if(cmmfn_get_uploadify_queuelength("file_upload2") == 0)
		{
			alert("첨부할 파일을 선택해주십시오.");
			return false;
		}
	}
	
	content = Editor.getContent();
	$("#mc_content").val(content);
	$('form.ajax-form-submit_mc').submit();
	
}	

function fn_mc_page_reload()
{
	document.location.reload();	
}

function fn_egov_link_page(pageIdx)
{
	var form = document.reqForm;
	form.pageIndex.value = pageIdx;
	fn_egov_multi_cms_list();
}

function fn_egov_multi_cms_list()
{
	var form = document.reqForm;
	fn_egov_move_action(form, '/metsys/multicms/multiCmsManList.do?category=${param.category}&srch_menu_nix=${param.srch_menu_nix}' + fn_egov_get_argstr());
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
   		if(result.data.mc_seq)
		{
   			if(cmmfn_get_uploadify_queuelength("file_upload") > 0 )
   			{
	   			cmmfn_set_uploadifykeys('file_upload', 'MULTI_CMS', result.data.mc_seq, 1, 'THM');
	   			cmmfn_upload_uploadify('file_upload');
   			}
   			if(cmmfn_get_uploadify_queuelength("file_upload2") > 0)
   			{
   				cmmfn_set_uploadifykeys('file_upload2', 'MULTI_CMS', result.data.mc_seq, 2, 'GNR');
	   			cmmfn_upload_uploadify('file_upload2');
   			}
		}
   		
	}
	
   	if(cmmfn_get_uploadify_queuelength("file_upload") == 0 && cmmfn_get_uploadify_queuelength("file_upload2") == 0)
	{
	   	if (result.url) {
			alert("저장되었습니다.");
			location.replace(result.url);
		}
	}
	
   	
}

function upload_complete_check()
{
	
	//두개의 파일이 모두 올라갔는지 체크후 페이지 이동
	
	now_attache_count++;	
	if(now_attache_count == attached_file_count)
	{
		alert("저장되었습니다.");
		fn_egov_multi_cms_list();
	}
	
}


</script>
