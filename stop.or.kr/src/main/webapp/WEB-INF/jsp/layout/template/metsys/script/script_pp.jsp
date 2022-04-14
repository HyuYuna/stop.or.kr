<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!--
	팝업 관리 스크립트
	2013.04.16 bhhan
-->	
<script type="text/javascript">



/**************************************************************
 *  			팝업관리 페이지 초기화 Start
 **************************************************************/

 
function fn_egov_init_popuppage()
{
	/*팝업 메뉴 셋팅한이유는?*/
	/* if(lg_srch_menu_nix != "wmy4igLC")
		return; */
	
	cmmfn_set_datepicker(g_context, jQuery("#searchFrom, #searchTo, #pop_from, #pop_to"), "%Y-%m-%d");
	
	//팝업 사이즈에 숫자만 입력
	$('#pop_w, #pop_h').keydown(function(){
		var key = event.keyCode;
		if( !((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || key == 8 || key == 9) )
		{	//숫자 0~9, 숫자패드 0~9, backspace, delete 키만 허용
			return false;
		}			
	});
	
	//팝업 구분선택에 따른 스크립팅
	$('input[id^=pop_type]').bind({
		'click': fn_egov_toggle_poptype,
		'keypress': fn_egov_toggle_poptype
	});
	
	if(jQuery("#file_upload").length > 0)
		// 현재 카운트로 수정해야 함... <= 수정하고 이 주석을 삭제할 것
		cmmfn_init_uploadify("file_upload", g_context, 1, 0, 20, "IMG", fn_egov_complete_upload);
	
	{
		var pop_type = jQuery("input[id^=pop_type]:checked").val();
		if(pop_type == '' || pop_type == 'W'){//기본값은 창팝업
			$('#tr_pop_wh').show();
			$('#tr_pop_xy').show();
			$('#tr_pop_due').show();
			$('#tr_pop_content').show();
		}
		else if(pop_type == 'Z'){
			$('#tr_pop_wh').hide();
			$('#tr_pop_wh').find('input').val('');
			$('#tr_pop_due').show();
			$('#tr_pop_xy').hide();
			$('#tr_pop_xy').find('input').val('');	
			$('#tr_pop_content').hide();
			$('#tr_pop_content').find('textarea').val('');
		}
		else{
			$('#tr_pop_wh').hide();
			$('#tr_pop_wh').find('input').val('');
			$('#tr_pop_due').hide();
			$('#tr_pop_xy').hide();
			$('#tr_pop_xy').find('input').val('');	
			$('#tr_pop_content').hide();
			$('#tr_pop_content').find('textarea').val('');
		}
	}
	
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


function fn_egov_popup_list()
{
	var form = document.reqForm;
	fn_egov_move_action(form, '/popup/popupList.do?srch_menu_nix=${param.srch_menu_nix}' + fn_egov_get_argstr());
}

function fn_egov_popup_view(pop_seq)
{
	var form = document.reqForm;
	form.edomweivgp.value = "R";
	form.pop_seq.value = pop_seq;
	fn_egov_move_action(form, '/popup/popupView.do?srch_menu_nix=${param.srch_menu_nix}' + fn_egov_get_argstr());
}

function fn_egov_popup_mod()
{
	var form = document.reqForm;
	form.edomweivgp.value = "M";
	fn_egov_move_action(form, '/popup/popupWrite.do?srch_menu_nix=${param.srch_menu_nix}' + fn_egov_get_argstr());
}

function fn_egov_popup_moddrct(pop_seq)
{
	var form = document.reqForm;
	form.edomweivgp.value = "M";
	form.pop_seq.value = pop_seq;
	fn_egov_move_action(form, '/popup/popupWrite.do?srch_menu_nix=${param.srch_menu_nix}' + fn_egov_get_argstr());
}

function fn_egov_popup_add()
{
	var form = document.reqForm;
	form.edomweivgp.value = "A";
	fn_egov_move_action(form, '/popup/popupWrite.do?srch_menu_nix=${param.srch_menu_nix}' + fn_egov_get_argstr());
}

function fn_egov_link_page(pageIdx)
{
	var form = document.reqForm;
	form.pageIndex.value = pageIdx;
	fn_egov_popup_list();
}

// 팝업 저장
function fn_egov_popup_save()
{
	var frm = document.reqForm;
	var popup_type = jQuery("input[id^='pop_type']:checked").val();
	
	var chkobj = "";
	if(popup_type == "W")
		chkobj = "#pop_title, #pop_from, #pop_to, #pop_link";
	else
		chkobj = "pop_title";
	if(cmmfn_check_inputnull(jQuery(chkobj)) == false)
		return;
	
	
	if(confirm("입력하신 팝업(팝업존/비주얼/관련사이트)를 저장하시겠습니까?") == false)
		return;
	
	var data = cmmfn_get_post_data('divMainArticle');   

	
	var pgmode = jQuery("#edomweivgp").val();
	var url = "";
	if(pgmode == "M")
		url = "/popup/mdfPopup.do";
	else
		url = "/popup/addPopup.do";
		
	
		
	$.ajax({
        url 		: g_context + url + "?srch_menu_nix=${param.srch_menu_nix}",
        type  		: 'post',
        data 		: data,
        datatype	: 'json',
		async 		: false,	        
        success 	: function(data){
        	popup_idx = cmmfn_str_trim(data);
        	if(popup_idx.replace(/^[0-9]+$/gi, '') != ''){
        		alert('게시물 등록 도중 오류가 발생하였습니다.');
        	}
        	else{
        		// 이미지를 등록하고 썸네일을 생성한다.
	        	cmmfn_set_uploadifykeys('file_upload', 'POPUP', popup_idx, 1, 'GNR');
	        	cmmfn_upload_uploadify('file_upload', fn_egov_complete_upload);
        	}
        	
        },
        error: function(xhr, err){
        	alert("에러가 발생했습니다.\n");
        }
    });
}

function fn_egov_complete_upload()
{
	alert("저장되었습니다");
	fn_egov_popup_list();
}

function fn_egov_popup_usetgl(pop_seq)
{
	var form = document.reqForm;
	form.pop_seq.value = pop_seq;
	fn_egov_move_action(form, "/popup/popupToggleUse.do?srch_menu_nix=${param.srch_menu_nix}" + fn_egov_get_argstr());
}


//팝업 삭제
function fn_egov_popup_del(pop_seq)
{
	if(confirm('선택하신 팝업을 삭제하시겠습니까?') == false) 
		return;
	var form = document.reqForm;	
	form.pop_seq.value = pop_seq;
	fn_egov_move_action(form, "/popup/rmvPopup.do?srch_menu_nix=${param.srch_menu_nix}" + fn_egov_get_argstr());
}

/**
 * 창팝업/팝업존 선택변경에 따른 스크립팅
 */
function fn_egov_toggle_poptype(){
	if($(this).val() == '' || $(this).val() == 'W'){//기본값은 창팝업
		$('#tr_pop_wh').show();
		$('#tr_pop_xy').show();
		$('#tr_pop_due').show();
		$('#tr_pop_content').show();
	}
	else if($(this).val() == 'Z'){
		$('#tr_pop_wh').hide();
		$('#tr_pop_wh').find('input').val('');
		$('#tr_pop_due').show();
		$('#tr_pop_xy').hide();
		$('#tr_pop_xy').find('input').val('');	
		$('#tr_pop_content').hide();
		$('#tr_pop_content').find('textarea').val('');
	}
	else{
		$('#tr_pop_wh').hide();
		$('#tr_pop_wh').find('input').val('');
		$('#tr_pop_due').hide();
		$('#tr_pop_xy').hide();
		$('#tr_pop_xy').find('input').val('');	
		$('#tr_pop_content').hide();
		$('#tr_pop_content').find('textarea').val('');
	}
}

	
function fn_egov_show_poppreview()
{
	popobj = new Object();
	popobj.pop_x = 0;
	popobj.pop_y = 0;
	popobj.pop_w = 400;
	popobj.pop_h = 500;
	popobj.atckey_2nd = jQuery("#atckey_2nd").val();
	popobj.atckey_3rd = jQuery("#atckey_3rd").val();
	popobj.atckey_4th = jQuery("#atckey_4th").val();
	popobj.vchkcode = jQuery("#vchkcode").val();
	popobj.pop_link = "";
	popobj.pop_target = "";
	popobj.pop_title = "팝업미리보기";
	cmmfn_show_popview(popobj);
}
	

/**************************************************************
 *  			팝업관리 페이지 초기화 End
 **************************************************************/



</script>
