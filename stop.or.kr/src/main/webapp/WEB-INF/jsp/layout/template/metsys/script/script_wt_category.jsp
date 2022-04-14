<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!--
	카드뉴스 스크립트
-->	
<script type="text/javascript">
$(document).ready(function(){
	
	try
	{ 

		//게시물 삭제시 확인
		$("a.deletewebtoon").click(function()
		{
			if(confirm("삭제 하시겠습니까?") == true)
			{
				return true;
			}
			return false;
		});
		
		
		// 게시물등록 - Ajax form submit
		
		$('form.ajax-form-submit_wt').AjaxFormSubmit("","저장 하시겠습니까?","",save_success);
		
		


	}
	catch(e)
	{
		console.log(e);

	}
	
});

function fn_cn_page_reload()
{
	document.location.reload();	
}

function fn_egov_link_page(pageIdx)
{
	var form = document.reqForm;
	form.pageIndex.value = pageIdx;
	fn_egov_card_news_list();
}

function fn_egov_card_news_list()
{
	var form = document.reqForm;
	fn_egov_move_action(form, '/metsys/webtooncategory/webtooncategoryManList.do?srch_menu_nix=${param.srch_menu_nix}' + fn_egov_get_argstr());
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
	console.log(result);
   	if (result.url) {
		location.replace(result.url);
	}
	
}

function upload_complete_check()
{
	
	alert("저장 되었습니다.");
	fn_egov_card_news_list();
	
}



</script>
