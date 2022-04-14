<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--
	2013.04.16 bhhan
-->	
<script type="text/javascript">

jQuery(document).ready(function(){
	jQuery("#btnDryForm").bind("click", fn_egov_dry_form);
	cmmfn_set_datepicker(g_context, jQuery("#startdt, #enddt"), "%Y-%m-%d");
	
	
	jQuery("#divCalbtnCtrl > button:eq(0)")
		.unbind("click")
		.bind("click", function(){
			
			var yr = parseInt(jQuery("#srchcalYr").val());
			var mon = parseInt(jQuery("#srchcalMon").val());
			var setmon = (mon == 1) ? 12 : mon - 1; 
			var setyr = (setmon == 12) ? yr - 1 : yr;
			
			jQuery("#srchcalYr").val(setyr);
	    	jQuery("#srchcalMon").val(setmon);
	    	
	    	fn_egov_dry_list();
	});
	
	jQuery("#divCalbtnCtrl > button:eq(1)")
		.unbind("click")
		.bind("click", function(){
	
			var yr = parseInt(jQuery("#srchcalYr").val());
			var mon = parseInt(jQuery("#srchcalMon").val());
			var setmon = (mon == 12) ? 1 : mon + 1; 
			var setyr = (setmon == 1) ? yr + 1 : yr;
			
			jQuery("#srchcalYr").val(setyr);
	    	jQuery("#srchcalMon").val(setmon);
	    	
	    	fn_egov_dry_list();
	});
});

function fn_egov_dry_form(){
	var form = document.reqForm;
	form.edomweivgp.value = "A";
	fn_egov_move_action(form, g_context + "/brddry/boarddryView.do?srch_menu_nix=${param.srch_menu_nix}");
}
function fn_egov_mod_dry(){
	var form = document.reqForm;
	form.edomweivgp.value = "M";
	fn_egov_move_action(form, g_context + "/brddry/boarddryView.do?srch_menu_nix=${param.srch_menu_nix}");
}
function fn_egov_dry_view(cont_idx){
	var form = document.reqForm;
	form.edomweivgp.value = "R";
	form.cont_idx.value = cont_idx;
	fn_egov_move_action(form, g_context + "/brddry/boarddryView.do?srch_menu_nix=${param.srch_menu_nix}");
}
function fn_egov_save_dry(){
	
	var data = cmmfn_get_post_data("divMainArticle");
	 
	data.ctgry_idx=$("#ctgry_idx option:selected").val();
	
	switch('${boarddryVO.edomweivgp}')
	{
		case 'A' : 
		case 'S' : 
			bizst = "add";
			msg_confirm = "내용을 등록하시겠습니까?";
			break;
		case 'M' :
			bizst = "mdf";
			msg_confirm = "내용을 수정하시겠습니까?";
			break;
		default :
			return;
	}
	
	if(confirm(msg_confirm) == false)
		return;
	
	$.ajax({
		url 		: g_context + '/brddry/' + bizst + 'Boarddry.do?srch_menu_nix=${param.srch_menu_nix}',
        type  		: 'post',
        data 		: data,
        datatype	: 'json',
		async 		: false,	        
        success 	: function(data){
        	fn_egov_dry_list();
        },
        error: function(xhr, err){
        	alert("에러가 발생했습니다.\n");
        }
    });
}

function fn_egov_dry_list(){
	var form = document.reqForm;
	form.edomweivgp.value = "A";
	$("#startdt").val("");
	$("#enddt").val("");
	fn_egov_move_action(form, g_context + "/brddry/boarddryList.do?srch_menu_nix=${param.srch_menu_nix}");
}

function fn_egov_dry_viewmode(modeV){
	var form = document.reqForm;
	form.modeV.value = modeV;
	fn_egov_dry_list();
}


</script>