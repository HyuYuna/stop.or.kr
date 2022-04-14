<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

/**************************************************************
 *  	설문 메인 관리자 페이지 스크립트 Start
 **************************************************************/
jQuery(document).ready(function(){

	// datepicker 설정
	cmmfn_set_datepicker(g_context, jQuery("#srvy_start, #srvy_end, #wdt, #mdt"), "%Y-%m-%d");
	 
	// 다음에디터 사용시 쓰기페이지에서 아래 주석해제 (컬럼명은 clob 컬럼명으로 변경한다)
	
	if(cmmfn_exist_object("srvy_cont") == true)
	{
		cmmfn_remove_scrtag(jQuery("#srvy_cont"));
		cmmfn_init_editor("srvy_cont", "G", null);
	}

	if(cmmfn_exist_object("part_psn_info") == true)
	{
		cmmfn_remove_scrtag(jQuery("#part_psn_info"));
		cmmfn_init_editor("part_psn_info", "G", null);
		
		jQuery("#part_type").on("change", fn_egov_part_set);
		
		fn_egov_part_set();
	}

	if(cmmfn_exist_object("ques_type") == true)
	{
		fn_egov_questype_set();	

		jQuery("#ques_type").on("change", fn_egov_questype_set);
		
		jQuery("input[name='arr_ans_ord']").numeric().css("text-align", "right");
	}
	
	// Uploadify 를 사용한 파일전송을 사용하는 경우 아래 주석 해제
	/*
	cmmfn_init_uploadify(
		"file_upload", 
		g_context, 
		10,		// 업로드큐 제한 (최대 업로드 가능 파일 수)  
		0, 		// 만약 수정페이지에서 이미 첨부된 파일이 있다면 그 갯수를 넣어줘야 함 
		5,		// 업로드 파일 사이즈 제한 (mb) 
		"GMR",  // 파일 종류 : 일반파일 (IMG, DOC 등 사용가능)
		fn_egov_complete_upload // 파일 업로드 후 실행할 콜백함수
	);
	*/
	jQuery("#srvy_max_ans").numeric();
	
	//////////////////////////////////////////////////////////
	// 파일이 첨부되어있는 경우 파일선택 폼필드를 숨긴다.
	jQuery("input[id^='empty_file'").each(function(){
		var idx = $(this).attr('id');
		idx = idx.replace(/empty_file/g, "");
		
		if($(this).val() == "N")
			jQuery("#file_upload" + idx).hide();
	});
	//
	//////////////////////////////////////////////////////////

	var is_srvypop_al = false;
	
	jQuery("input[name='srvy_pop_type']").on("click", function(){
	
		if(is_srvypop_al == false)
		{
			alert("팝업창은 이미지의 사이즈에 맞게 Width * Height를 설정해주십시오.\n팝업존은 사이즈가 645 * 145로 고정되어 있으므로\n이미지를 사이즈에 맞춰 등록해 주십시오.");
			is_srvypop_al = true;
		}
		
		
		// 팝업존인 경우
		if($(this).val() == "Z")
		{
			jQuery("#srvy_x").val("0");
			jQuery("#srvy_y").val("0");
			jQuery("#srvy_w").val("645");
			jQuery("#srvy_h").val("145");
		}
		
	});
	
});

function fn_egov_part_set()
{
	
	if(jQuery("#part_type").val() == "CDIDX00062")
	{
		jQuery("#trPsnInfo").show();
	}
	else
		jQuery("#trPsnInfo").hide();

}

function fn_egov_questype_set()
{
	// 주관식인 경우
	if(jQuery("#ques_type").val() == "CDIDX00084" || jQuery("#ques_type").val() == "CDIDX00085")
		jQuery("#tblSrvyAnswerArea").hide();
	else
		jQuery("#tblSrvyAnswerArea").show();
			
	// 첨부파일 보이기 / 숨기기
	if(jQuery("#ques_type").val() == "CDIDX00087" || jQuery("#ques_type").val() == "CDIDX00086")
	{
		//////////////////////////////////////////////////////////
		// 파일이 첨부되어있는 경우 파일선택 폼필드를 숨긴다.
		jQuery("input[id^='empty_file'").each(function(){
			var idx = $(this).attr('id');
			idx = idx.replace(/empty_file/g, "");
			
			if($(this).val() == "N")
			{
				jQuery("#file_upload" + idx).hide();
				$('p[class="fileName"]').show();
			}
			else
				jQuery("#file_upload" + idx).show();
		});
		//
		//////////////////////////////////////////////////////////
	}
	else
	{
		jQuery("input[id^='file_upload']").hide();
		$('p[class="fileName"]').hide();
	}

	// 기타 추가 답변이 필요없는 경우
	if($("#ques_type").val() != "CDIDX00082")
		$("select[name=arr_ans_need_spl]").hide();
	else
		$("select[name=arr_ans_need_spl]").show();
	

	
}

function fn_egov_srvymain_save()
{
	var data = cmmfn_get_post_data("divMainArticle");
	
	if(cmmfn_check_inputnull(jQuery("#srvy_nm, #srvy_max_ans")) == false)
	{
		return;
	}

	////////////////////////////////////////////////////////////////////
	// 파일 확장자 검사, 첨부된 파일이 있는데 또 첨부된 경우
	if(cmmfn_check_fext(jQuery("#file_upload1"), "GNR") == false)
	{
		return;	
	}
	
	jQuery("input[id^='empty_file'").each(function(){
		var idx = $(this).attr('id');
		idx = idx.replace(/empty_file/g, "");
		
		if($(this).val() == "N" && jQuery("#file_upload" + idx).val() != "")
		{
			alert("이미 첨부된 파일을 삭제하시고 다시 첨부해주십시오.");
			return false;
		}
	});
	// 첨부된 파일이 있는데 또 첨부된 경우
	////////////////////////////////////////////////////////////////////

	////////////////////////////////////////////////////////////////////
	// 반드시 첨부되어야 할 파일이 첨부되지 않은 경우
	if(jQuery("#empty_file1").val() == "Y" && jQuery("#file_upload1").val() == "")
	{
		//alert("팝업이미지는 반드시 첨부해주십시오.");	
		//return;
	}
	// 반드시 첨부되어야 할 파일이 첨부되지 않은 경우
	////////////////////////////////////////////////////////////////////


	
	// 다음에디터 사용시 주석해제 (컬럼명은 clob 컬럼명으로 변경한다)
	var srvy_cont = Editor.getContent();
	data.srvy_cont = srvy_cont;
	jQuery("#srvy_cont").val(srvy_cont);
		
	if(cmmfn_str_trim(srvy_cont) == "" || cmmfn_str_trim(srvy_cont) == "<p>&nbsp;</p>")
	{
		alert("내용은 반드시 입력하셔야 합니다.");
		cmmfn_editor_focus();
		return;
	}
	
	var bizst = "";
	var msg_confirm = "";
	
	if(jQuery("#edomweivgp").val() == "A")
	{
		bizst = "add";
		msg_confirm = "입력하신 내용을 저장하시겠습니까?";
	}
	else
	{
		bizst = "mdf";
		msg_confirm = "수정된 내용을 저장하시겠습니까?";
	}
	
	if(confirm(msg_confirm) == false)
		return;
	
	// form upload
	var form = document.reqForm;
	fn_egov_move_action(form, "/manact/surveySrvymain/" + bizst + "Srvymain.do?srch_menu_nix=${param.srch_menu_nix}");
	
	/* 
	// ajax / uploadify upload 
  	$.ajax({
      	url 		: g_context + "/manact/surveySrvymain/" + bizst + "Srvymain.do?srch_menu_nix=${param.srch_menu_nix}",
      	type  		: "post",
    	data 		: data,
    	datatype	: "json",
		async 		: false,	        
      	success 	: function(data){        	

      		var key = cmmfn_str_trim(data);
      		var version = key.replace(/CTX[0-9]{6}_/gi, ""); 
      	
      		ucont_id = key.replace(/_[0-9]{1,6}/gi, "");
      		jQuery("#ucont_id").val(ucont_id);
      		jQuery("#ucont_version").val(version);
			cmmfn_set_uploadifykeys('file_upload', '${CONTENTS_UPLOAD_KEY}', ucont_id, version, fupgb);
			cmmfn_upload_uploadify('file_upload', fn_egov_complete_upload);
      },
      
      error: function(){
          
      	alert("에러가 발생했습니다.");
      }
	});
	*/
}

function fn_egov_srvymain_search()
{
	var form = document.reqForm;
	form.pageIndex.value = 1;
	fn_egov_srvymain_list();
}

function fn_egov_srvymain_list()
{
	var form = document.reqForm;
	fn_egov_move_action(form, "/manact/surveySrvymain/srvymainList.do?srch_menu_nix=${param.srch_menu_nix}");
}

function fn_egov_srvymain_add()
{
	var form = document.reqForm;
	form.edomweivgp.value = "A";
	fn_egov_move_action(form, "/manact/surveySrvymain/srvymainView.do?srch_menu_nix=${param.srch_menu_nix}");
}

function fn_egov_srvymain_mod(srvy_idx)
{
	var form = document.reqForm;
	form.edomweivgp.value = "M";
	form.srvy_idx.value = srvy_idx;

	fn_egov_move_action(form, "/manact/surveySrvymain/srvymainView.do?srch_menu_nix=${param.srch_menu_nix}");
}

function fn_egov_srvymain_del()
{
	
	if(confirm("현재 항목을 삭제하시겠습니까?") == false)
		return;
	
	var form = document.reqForm;
	fn_egov_move_action(form, "/manact/surveySrvymain/rmvSrvymain.do?srch_menu_nix=${param.srch_menu_nix}");
}

function fn_egov_link_page(pageIndex)
{
	var form = document.reqForm;
	form.pageIndex.value = pageIndex;
	fn_egov_srvymain_list();
}

function fn_egov_srvymain_part(srvy_idx)
{
	var form = document.reqForm;
	form.srvy_idx.value = srvy_idx;
	fn_egov_move_action(form, "/manact/surveySrvypart/srvypartList.do?srch_menu_nix=${param.srch_menu_nix}");
}

/* use uploadify
function fn_egov_complete_upload()
{
	alert("저장이 완료되었습니다.");
	fn_egov_srvymain_list();
}	
*/

function fn_egov_srvyresult_xls(srvy_idx)
{
	var form = document.reqForm;
	form.srvy_idx.value = srvy_idx;
	//cmmfn_download_xlsfile(g_context, '/manact/surveySrvymain/xlsSrvyresultSave.do?srch_menu_nix=${param.srch_menu_nix}');
	
	
	var $form = $('<form></form>');
	$form.attr('action', g_context + '/manact/surveySrvymain/xlsSrvyresultSave.do?srch_menu_nix=${param.srch_menu_nix}&srvy_idx='+srvy_idx);
    $form.attr('method', 'post');
    $form.appendTo('body');
    $form.submit();
	
}



/**************************************************************
 *  	설문 메인 관리자 페이지 스크립트 End
 **************************************************************/

 
 
 
 
 

 /**************************************************************
  *  	설문 파트 관리자 페이지 스크립트 Start
  **************************************************************/

 function fn_egov_srvypart_save()
 {
 	var data = cmmfn_get_post_data("divMainArticle");
 	
 	if(cmmfn_check_inputnull(jQuery("#part_nm")) == false)
 	{
 		return;
 	}
 		
 	// 다음에디터 사용
 	if(jQuery("#part_type").val() == "CDIDX00062")
 	{
	 	var part_psn_info = Editor.getContent();
	 	data.part_psn_info = part_psn_info;
	 	jQuery("#part_psn_info").val(part_psn_info); 		
	 	if(cmmfn_str_trim(part_psn_info) == "" || cmmfn_str_trim(part_psn_info) == "<p>&nbsp;</p>" || cmmfn_str_trim(part_psn_info) == "<p><br></p>" )
	 	{
	 		alert("개인정보 수집안내는 반드시 입력하셔야 합니다.");
	 		cmmfn_editor_focus();
	 		return;
	 	}
 	} 	
 	
 	var bizst = "";
 	var msg_confirm = "";
 	
 	if(jQuery("#edomweivgp").val() == "A")
 	{
 		bizst = "add";
 		msg_confirm = "입력하신 내용을 저장하시겠습니까?";
 	}
 	else
 	{
 		bizst = "mdf";
 		msg_confirm = "수정된 내용을 저장하시겠습니까?";
 	}
 	
 	if(confirm(msg_confirm) == false)
 		return;
 	

   	$.ajax({
       	url 		: g_context + "/manact/surveySrvypart/" + bizst + "Srvypart.do?srch_menu_nix=${param.srch_menu_nix}",
       	type  		: "post",
     	data 		: data,
     	datatype	: "json",
 		async 		: false,	        
       	success 	: function(data){
       		alert("저장되었습니다.");
       		fn_egov_srvypart_list();
       },
       
       error: function(){
           
       	alert("에러가 발생했습니다.");
       }
 	});

 }

 function fn_egov_srvypart_search()
 {
 	var form = document.reqForm;
 	form.pageIndex.value = 1;
 	fn_egov_srvypart_list();
 }

 function fn_egov_srvypart_list()
 {
 	var form = document.reqForm;
 	fn_egov_move_action(form, "/manact/surveySrvypart/srvypartList.do?srch_menu_nix=${param.srch_menu_nix}");
 }

 function fn_egov_srvypart_add()
 {
 	var form = document.reqForm;
 	form.edomweivgp.value = "A";
 	fn_egov_move_action(form, "/manact/surveySrvypart/srvypartView.do?srch_menu_nix=${param.srch_menu_nix}");
 }

 function fn_egov_srvypart_mod(srvy_idx, part_idx)
 {
 	var form = document.reqForm;
 	form.edomweivgp.value = "M";
 	form.srvy_idx.value = srvy_idx;
 	form.part_idx.value = part_idx;

 	fn_egov_move_action(form, "/manact/surveySrvypart/srvypartView.do?srch_menu_nix=${param.srch_menu_nix}");
 }

 function fn_egov_srvypart_del()
 {
 	
 	if(confirm("현재 항목을 삭제하시겠습니까?") == false)
 		return;
 	
 	var form = document.reqForm;
 	fn_egov_move_action(form, "/manact/surveySrvypart/rmvSrvypart.do?srch_menu_nix=${param.srch_menu_nix}");
 }


 function fn_egov_srvypart_ques(part_idx)
 {
 	var form = document.reqForm;
 	form.part_idx.value = part_idx;
  	fn_egov_move_action(form, "/manact/surveySrvyquesans/srvyquesList.do?srch_menu_nix=${param.srch_menu_nix}");
 }


 /**************************************************************
  *  	설문 파트 관리자 페이지 스크립트 End
  **************************************************************/

  
  
  

  /**************************************************************
   *  	설문 질문 / 답변 관리자 페이지 스크립트 Start
   **************************************************************/

  function fn_egov_srvyquesans_save()
  {
  	if(cmmfn_check_inputnull(jQuery("textarea[name='arr_quesans_cont']").eq(0)) == false)
  	{
  		return;
  	}
  	
  	// 주관식이 아니면서 답변이 하나도 등록되지 않았을 때
  	if(jQuery("#ques_type").val() != "CDIDX00084" && jQuery("#ques_type").val() != "CDIDX00085")
  	{
  		var inpcnt = 0;
  		jQuery("input[name='arr_quesans_cont']").each(function(){
  			if($(this).val() != "")
  				inpcnt ++;
  		});
  		
  		if(inpcnt == 0)
  		{
  			alert("주관식을 제외한 모든 질문은 답변이 하나 이상 등록되어야 합니다.");
  			return;
  		}
  	}
  		
	////////////////////////////////////////////////////////////////////
	// 파일만 첨부되고 내용이 없는 경우
	var tdpass = true;
	var emtobj = null;
	jQuery("input[id^='file_upload']").each(function(){
		
		var tdobj = $(this).parent();
		if($(this).val() != "" && jQuery(":text:first", tdobj).val() == "")
		{
			emtobj = jQuery(":text:first", tdobj);
			tdpass = false;
			return false;
		}
	});
	
	if(tdpass == false)
	{
		alert("내용을 입력해주십시오");
		emtobj.focus();
		return;
	}
	
	
	if(jQuery("#empty_file1").val() == "Y" && jQuery("#file_upload1").val() == "")
	{
		alert("대표이미지는 반드시 첨부해주십시오.");	
		return;
	}
	// 반드시 첨부되어야 할 팔일이 첨부되지 않은 경우
	////////////////////////////////////////////////////////////////////


  	
  		
  	// 다음에디터 사용시 주석해제 (컬럼명은 clob 컬럼명으로 변경한다)
  	/*
  	var srvyquesans_cont = Editor.getContent();
  	data.srvyquesans_cont = srvyquesans_cont;
  	jQuery("#clobcolumn_name").val(srvyquesans_cont);
  		
  	if(cmmfn_str_trim(srvyquesans_cont) == "" || cmmfn_str_trim(srvyquesans_cont) == "<p>&nbsp;</p>")
  	{
  		alert("내용은 반드시 입력하셔야 합니다.");
  		cmmfn_editor_focus();
  		return;
  	}
  	*/
  	
  	var bizst = "";
  	var msg_confirm = "";
  	
  	if(jQuery("#edomweivgp").val() == "A")
  	{
  		bizst = "add";
  		msg_confirm = "입력하신 내용을 저장하시겠습니까?";
  	}
  	else
  	{
  		bizst = "mdf";
  		msg_confirm = "수정된 내용을 저장하시겠습니까?";
  	}
  	
  	if(confirm(msg_confirm) == false)
  		return;
  	
  	// form upload
  	var form = document.reqForm;
  	fn_egov_move_action(form, "/manact/surveySrvyquesans/" + bizst + "Srvyquesans.do?srch_menu_nix=${param.srch_menu_nix}");
  	
  	/* 
  	// ajax / uploadify upload 
    	$.ajax({
        	url 		: g_context + "/manact/surveySrvyquesans/" + bizst + "Srvyquesans.do?srch_menu_nix=${param.srch_menu_nix}",
        	type  		: "post",
      	data 		: data,
      	datatype	: "json",
  		async 		: false,	        
        	success 	: function(data){        	

        		var key = cmmfn_str_trim(data);
        		var version = key.replace(/CTX[0-9]{6}_/gi, ""); 
        	
        		ucont_id = key.replace(/_[0-9]{1,6}/gi, "");
        		jQuery("#ucont_id").val(ucont_id);
        		jQuery("#ucont_version").val(version);
  			cmmfn_set_uploadifykeys('file_upload', '${CONTENTS_UPLOAD_KEY}', ucont_id, version, fupgb);
  			cmmfn_upload_uploadify('file_upload', fn_egov_complete_upload);
        },
        
        error: function(){
            
        	alert("에러가 발생했습니다.");
        }
  	});
  	*/
  }

  function fn_egov_srvyquesans_search()
  {
  	var form = document.reqForm;
  	form.pageIndex.value = 1;
  	fn_egov_srvyquesans_list();
  }

  function fn_egov_srvyquesans_list()
  {
  	var form = document.reqForm;
  	fn_egov_move_action(form, "/manact/surveySrvyquesans/srvyquesList.do?srch_menu_nix=${param.srch_menu_nix}");
  }

  function fn_egov_srvyques_list()
  {
  	var form = document.reqForm;
  	form.ques_idx.value = "0";
  	fn_egov_move_action(form, "/manact/surveySrvyquesans/srvyquesList.do?srch_menu_nix=${param.srch_menu_nix}");
  }

  function fn_egov_srvyquesans_add()
  {
  	var form = document.reqForm;
  	form.edomweivgp.value = "A";
  	fn_egov_move_action(form, "/manact/surveySrvyquesans/srvyquesansView.do?srch_menu_nix=${param.srch_menu_nix}");
  }

  function fn_egov_srvyquesans_mod(ques_idx)
  {
  	var form = document.reqForm;
  	form.edomweivgp.value = "M";
  	form.ques_idx.value = ques_idx;

  	fn_egov_move_action(form, "/manact/surveySrvyquesans/srvyquesansView.do?srch_menu_nix=${param.srch_menu_nix}");
  }

  function fn_egov_srvyquesans_del(quesans_idx)
  {
  	
  	if(confirm("현재 항목을 삭제하시겠습니까?") == false)
  		return;
  	
  	var form = document.reqForm;
  	form.quesans_idx.value = quesans_idx;
  	fn_egov_move_action(form, "/manact/surveySrvyquesans/rmvSrvyquesans.do?srch_menu_nix=${param.srch_menu_nix}");
  }

  function fn_egov_srvyques_del()
  {
  	
  	if(confirm("현재 항목을 삭제하시겠습니까?") == false)
  		return;
  	
  	var form = document.reqForm;
  	form.quesans_idx.value = 1;
  	fn_egov_move_action(form, "/manact/surveySrvyquesans/rmvSrvyquesans.do?srch_menu_nix=${param.srch_menu_nix}");
  }

  function fn_egov_link_page(pageIndex)
  {
  	var form = document.reqForm;
  	form.pageIndex.value = pageIndex;
  	fn_egov_srvyquesans_list();
  }

  /* use uploadify
  function fn_egov_complete_upload()
  {
  	alert("저장이 완료되었습니다.");
  	fn_egov_srvyquesans_list();
  }	
  */

  /**************************************************************
   *  	설문 질문 / 답변 관리자 페이지 스크립트 End
   **************************************************************/



</script>

