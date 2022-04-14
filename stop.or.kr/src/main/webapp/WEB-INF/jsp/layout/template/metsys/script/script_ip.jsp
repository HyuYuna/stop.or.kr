<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

/**************************************************************
 *  			관리자 접근 IP 제한 관리자 페이지 초기화 Start
 **************************************************************/
jQuery(document).ready(function(){
	
	jQuery("#access_ip").numericdot();

});

function fn_egov_accessip_save()
{
	var data = cmmfn_get_post_data("divMainArticle");
	
	//null check
	if(cmmfn_check_inputnull(jQuery("#access_ip")) == false)
	{
		return;
	}
	
	// IP 유효성 체크
	if(cmmfn_check_validip(jQuery("#access_ip").val()) == false)
	{
		alert("유효한 IP형식이 아닙니다");
		jQuery("#access_ip").focus();
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
	fn_egov_move_action(form, "/modeip/" + bizst + "Accessip.do?srch_menu_nix=${param.srch_menu_nix}");
	
	/* 
	// ajax / uploadify upload 
  	$.ajax({
      	url 		: "${pageContext.request.contextPath}/modeip/" + bizst + "Accessip.do?srch_menu_nix=${param.srch_menu_nix}",
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

function fn_egov_accessip_search()
{
	var form = document.reqForm;
	form.pageIndex.value = 1;
	fn_egov_accessip_list();
}

function fn_egov_accessip_list()
{
	var form = document.reqForm;
	fn_egov_move_action(form, "/modeip/accessipList.do?srch_menu_nix=${param.srch_menu_nix}");
}

function fn_egov_accessip_add()
{
	var form = document.reqForm;
	form.edomweivgp.value = "A";
	fn_egov_move_action(form, "/modeip/accessipView.do?srch_menu_nix=${param.srch_menu_nix}");
}

function fn_egov_accessip_mod(auth_cd, access_ip)
{
	var form = document.reqForm;
	form.edomweivgp.value = "M";
	form.auth_cd.value = auth_cd;
	form.access_ip.value = access_ip;

	fn_egov_move_action(form, "/modeip/accessipView.do?srch_menu_nix=${param.srch_menu_nix}");
}

function fn_egov_accessip_del()
{
	
	if(confirm("현재 항목을 삭제하시겠습니까?") == false)
		return;
	
	var form = document.reqForm;
	fn_egov_move_action(form, "/modeip/rmvAccessip.do?srch_menu_nix=${param.srch_menu_nix}");
}

function fn_egov_link_page(pageIndex)
{
	var form = document.reqForm;
	form.pageIndex.value = pageIndex;
	fn_egov_accessip_list();
}

/* use uploadify
function fn_egov_complete_upload()
{
	alert("저장이 완료되었습니다.");
	fn_egov_accessip_list();
}	
*/

/**************************************************************
 *  			관리자 접근 IP 제한 관리자 페이지 초기화 End
 **************************************************************/


</script>

