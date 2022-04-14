<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!--
	사용자 관리 스크립트
	2013.04.16 bhhan
-->	
<script type="text/javascript">

/**************************************************************
 *  			사용자관리 페이지 초기화 Start
 **************************************************************/
var userid_chkval = false;
function fn_egov_init_meminspage()
{

	jQuery("#up_auth_cd", jQuery("#content")).change(function(){

		$.ajax({
		    url 		: '${pageContext.request.contextPath}/menuctgry/sysauthJsonList.do?srch_menu_nix=${param.srch_menu_nix}',
		    type  	: "post",
		    data 		: {
		    	use_yn : 'Y',
		    	up_auth_cd : $(this).val()
			},
			datatype	: "json",
			async 	: false,	        
			success 	: function(data){        	
		    	jQuery("#user_auth_cd option").remove();
				for(var i = 0; i < data.length; i++)
				{
					jQuery("#user_auth_cd").append("<option value='" + data[i].auth_cd + "'>" + data[i].auth_nm + "</option>");
				}

			},
		    error: function(xhr, err){
				alert("에러가 발생했습니다.");
		    }
		});
	});
	
	jQuery("#user_cp_1,#user_cp_2,#user_cp_3,#user_tel_1,#user_tel_2,#user_tel_3").numeric();
	//jQuery("#user_email").alphanumeric();
	
	//생년월일 달력
	cmmfn_set_datepicker("${pageContext.request.contextPath}", jQuery("#user_birth"), "%Y-%m-%d");

	jQuery("#user_id").unbind("keypress");
	jQuery("#user_id").keyup(function(event){

		userid_chkval = false;

		if($(this).val().length < 8)
		{
			jQuery("#spanIdfeedback").html("( ID가 너무 짧습니다 )");
		}
		else
		{
			jQuery("#spanIdfeedback").html("( ID중복체크를 해주십시오 )");	
		}
		
	});
	
	jQuery("#btnChkdupID").on("click", fn_egov_chkdup_id);
	
	if(cmmfn_exist_object("bizreg_no") == true)
	{
		var bizreg = jQuery("#bizreg_no").val();
		arrbiz = bizreg.split("-");
		
		if(arrbiz.length == 3)
		{
			jQuery("#bizreg_no_1").val(arrbiz[0]);	
			jQuery("#bizreg_no_2").val(arrbiz[1]);	
			jQuery("#bizreg_no_3").val(arrbiz[2]);	
		}
	}
	
} 


<c:if test="${SESS_USR_LV le 2}">

function fn_egov_chkdup_id()
{
	var user_id = jQuery("#user_id").val();	
	if(user_id.length < 8)
	{
		alert("ID는 8자리 이상으로 입력해주십시오");
		return;
	}
	
    $.ajax({
        url: g_context + '/memuser/chkdupMember.do',
        dataType: 'json',
        data : {
        	user_id : user_id
        },
        cache : false,
        async : false,
        success: function(data) {
        	
        	if(parseInt(cmmfn_str_trim(data)) == 0)
        	{
        		jQuery("#spanIdfeedback").html("( 사용가능한 ID입니다 )");
        		userid_chkval = true;
        	}
        	else
        	{
        		jQuery("#spanIdfeedback").html("( 이미 존재하는 ID입니다 )");
        		userid_chkval = false;
        	}
        },
        error : function(xhr, err){
        	alert("에러가 발생했습니다.");
        }
    });
}


function fn_egov_mem_add()
{
	var form = document.reqForm;
	form.edomweivgp.value = "A";
	fn_egov_move_action(form, "/modeur/modeurView.do?srch_menu_nix=${param.srch_menu_nix}");
}
</c:if>

function fn_egov_mem_mod(userid)
{
	var form = document.reqForm;
	form.edomweivgp.value = "M";
	
	if(userid == null || userid == undefined)
		userid = form.user_id.value;
	
	form.user_id.value = userid;
	
	fn_egov_move_action(form, "/modeur/modeurView.do?srch_menu_nix=${param.srch_menu_nix}");
}


function fn_egov_mem_save()
{
	var form = document.reqForm;

	if(cmmfn_check_inputnull(jQuery("#user_nm, #user_email, #user_auth_cd, #allow_ip")) == false)
	{
		return;	
	}

	var scrt1 = jQuery("#user_scrt").val();
	var scrt2 = jQuery("#user_scrt_2").val();
	var scrtorg = jQuery("#user_scrt_org").val();
	var edomweivgp = jQuery("#edomweivgp").val();

	if(scrt1 != scrt2)
	{
		alert("신규 패스워드와 패스워드 확인의 값이 서로 일치하지 않습니다.");
		jQuery("#user_scrt_2").focus();
		return;
	}

	/*
	if(scrt1 != "" && cmmfn_check_validpwd(scrt1) == false)
		return;	
	*/

	if(scrt1 != "" && scrt1.length < 8)
	{
		alert("패스워드는 8자리 이상으로 입력해주십시오");
		jQuery("#user_scrt").focus();
		return;
	}	
	
	/*
	if(cmmfn_check_validemail(jQuery("#user_email").val()) == false)
		return;
	*/

	// 정보 수정
	if(edomweivgp == "M")
	{
		<c:if test="${SESS_USR_LV gt 2}">
			
			if(cmmfn_check_inputnull(jQuery("#user_scrt_org")) == false)
			{
				return;	
			}
			
			
			var chkscrt = false;
	
			$.ajax({
			    url 		: g_context + '/modeur/modeurScrtcheck.do?srch_menu_nix=${param.srch_menu_nix}',
			    type  	: "post",
			    data 		: {
			    	user_id : jQuery("#user_id").val(),
			    	user_scrt : scrtorg
				},
				datatype	: "json",
				async 	: false,	        
				success 	: function(data){
					if(cmmfn_str_trim(data) == "OK")
						chkscrt = true;
				},
			    error: function(xhr, err){
					alert("에러가 발생했습니다.");
			    }
			});
		
			// 시스템 총괄관리자 이상은 패스워드를 원래 패스워드를 몰라도 변경가능함.
			if(chkscrt == false)
			{
				alert("입력하신 패스워드가 현재 패스워드와 일치하지 않습니다.");
				jQuery("#user_scrt_org").focus();
				return;
			}
		</c:if>
		
		if(confirm("사용자 정보를 수정하시겠습니까?") == false)
			return;
		
		fn_egov_move_action(form, "/modeur/mdfModeur.do?srch_menu_nix=${param.srch_menu_nix}");
	}
	
	// 정보 등록
	else if(edomweivgp == "A")
	{
		if(userid_chkval == false)
		{
			alert("ID 중복체크를 통과하지 못했습니다.");
			return;
		}

		if(cmmfn_check_inputnull(jQuery("#user_scrt, #user_scrt_2")) == false)
			return;	
		
		if(cmmfn_check_validid(jQuery("#user_id").val()) == false)
			return;
		
		if(confirm("사용자 정보를 등록하시겠습니까?") == false)
			return;
		
		fn_egov_move_action(form, "/modeur/addModeur.do?srch_menu_nix=${param.srch_menu_nix}");
		
	}
}

function fn_egov_mem_del()
{
	var form = document.reqForm;

	if(confirm("현재 사용자를 삭제하시겠습니까?") == false)
	{
		return;
	}

	fn_egov_move_action(form, "/modeur/rmvModeur.do?srch_menu_nix=${param.srch_menu_nix}");
}

function fn_egov_mem_list()
{
	var form = document.reqForm;
	form.user_id.value = "";
	fn_egov_move_action(form, "/modeur/modeurList.do?srch_menu_nix=${param.srch_menu_nix}");
}

function fn_egov_mem_search()
{
	var form = document.reqForm;
	form.pageIndex.value = 1;
	fn_egov_mem_list();
}

function fn_egov_link_page(pageIndex)
{
	var form = document.reqForm;
	form.pageIndex.value = pageIndex;
	form.user_id.value = "";
	fn_egov_move_action(form, "/modeur/modeurList.do?srch_menu_nix=${param.srch_menu_nix}");
}
	
	
	
/**************************************************************
 *  			사용자관리 페이지 초기화 End
 **************************************************************/



</script>

