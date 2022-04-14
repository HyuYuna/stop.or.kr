//  ## TPCODE : TPAGE0014 : 사용자 권한처리 스크립트 ## 

/**
 * 로그인 / 회원 관련처리
 * jQuery Version 1.6 이상
 * author : Bhhan
 * date : 2014.3.25
 */
function initSiteAuth()
{ 
	// ID가 쿠키에 저장되어있는 경우
	var ckuid = cmmfn_get_cookie("STCOOK_USER_ID"); 
	if(ckuid != "")
	{
		jQuery("#user_id").val(ckuid);
	}
	
	if(rcvact == "joinCRPozEV")
	{
		alert("회원가입이 완료되었습니다.\n로그인페이지로 이동합니다.");
		fn_egov_move_action(document.reqForm, "/svcmem/siteLogin.do?tgtact=01");
	}
	else if(rcvact == "modmemCRPozEV")
	{
		alert("회원정보 수정이 완료되었습니다.");
		fn_egov_move_action(document.reqForm, "/svcmem/modMemInfo.do?tgtact=05");
	}

	
	jQuery("#btnLoginChk").bind("click", fn_site_login);
	jQuery("#btnCheckDupid").bind("click", fn_egov_check_dupid);
	
}

function fn_memsvc_myinfochange()
{
	var form = document.reqForm;
	fn_egov_move_action(form, "/svcmem/modMemInfo.do?tgtact=05");
}

function fn_memsvc_pagemove(pg)
{
	var form = document.reqForm;
	var url = "/svcmem/sysmemPagemove.do";
	url +="?tgtact=" + pg;
	url +="&srch_menu_nix=p20RQqzK";
	
	if(pg=="recoverId" || pg=="recoverScrt"){
		
		var url = g_context + url;
		window.name ="Parent_window";
		window.open('', 'popupChk', 'width=630, height=450, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
		document.reqForm.action = url;
		document.reqForm.target = "popupChk";
		document.reqForm.submit();	
	}else{
		
		fn_egov_move_action(form, url);
	}
	
}

function fn_site_loginmove()
{
	var form = document.reqForm;
	fn_egov_move_action(form, "/svcmem/siteLogin.do?srch_menu_nix=");
}

function fn_site_logout()
{
	if(confirm('로그아웃 하시겠습니까?') == false)
		return;

	var form = document.reqForm;
	fn_egov_move_action(form, "/svcmem/siteLogout.do");
}

function fn_site_login()
{
	if(cmmfn_check_inputnull(jQuery("#user_id,#user_scrt")) == false)
		return;
	
	$.ajax({
	    url 		: g_context + "/memuser/preCheckMember.do?srch_menu_nix=" + lg_srch_menu_nix,
	    type  	: "post",
	    data 		: {
	    	user_id : jQuery("#user_id").val(),
	    	user_scrt : jQuery("#user_scrt").val()
		},
		datatype	: "json",
		async 	: false,	        
		success 	: function(data){
			var data = cmmfn_str_trim(data); 
			if(data == "SUCCESS")
			{
				if(jQuery("#chkLoginfieldSave").prop("checked") == true)
					cmmfn_set_cookie("STCOOK_USER_ID", jQuery("#user_id").val(), 365);
	
				var form = document.reqForm;
				fn_egov_move_action(form, "/svcmem/siteLoginProc.do?pg_ret_type=" + lg_pg_ret_type);
			}
			else
			{
				alert(data);
				//jQuery("#pLoginerrorArea").html(data);
			}
			
		},
	    error: function(xhr, err){
			alert("에러가 발생했습니다.");
	    }
	});

	
}

function fn_move_sitemap()
{
	var form = document.reqForm;
	fn_egov_move_action(form, "/contents/siteMapView.do");
}

function fn_move_mypage()
{
	var form = document.reqForm;
	fn_egov_move_action(form, "/mypage/memberInfo.do?srch_menu_nix=p20RQqzK");
}

function fn_join_move()
{
	var form = document.forms[0];
	fn_egov_move_action(form, "/svcmem/sysmemPagemove.do?tgtact=memJoinStep01&srch_menu_nix=67rO8E9h");
}

function fn_join_nextstep()
{
	var form = document.reqForm;
	fn_egov_move_action(form, "/memuser/sysmemInputmove.do?tgtact=memJoinStep2&srch_menu_nix=" + lg_srch_menu_nix);
}

function fn_egov_move_action(form, act)
{
	form.action = g_context + act;
	form.submit();
}

function fn_egov_unauth_pageerr()
{	
	alert("선택하신 페이지에 대한 사용권한이 없습니다.\n사용을 원하시면 정회원 가입을 하시거나\n관리자에게 문의하시기 바랍니다.\n\n[업무시간] : 09: 00 ~ 18:00\n[전화] : 053-768-6051\n[팩스] : 053-768-6053");
}


function fn_egov_tot_search()
{
	
	var brd_id = lg_brd_id; 
	
	var form = document.reqForm;
	if(cmmfn_exist_object("searchKeyword") == false)
	{
		var frm = jQuery('form[name="reqForm"]');
		frm.append('<input type="hidden" id="searchKeyword" name="searchKeyword" value="' + jQuery("#search-keyword").val() + '" />');	
	}

	// 게시판인 경우 이미 searchKeyword가 존재한다..
	if(brd_id != "" )
	{
		jQuery("#searchKeyword").val(jQuery("#search-keyword").val());
	}
	
	var query = jQuery("#searchKeyword").val();
	if(query == "" || query == undefined)
	{
		alert("검색어를 입력하세요");
		return;
	}
	
	if(query.length < 2)
	{
		alert("검색어는 최소 2자 이상 입력해주십시오");
		return;
	}
	
	fn_egov_move_action(form, "/contents/mainTotalSearch.do?srch_menu_nix=2Fc1H08o");

}

function fn_egov_tot_type(type)
{
	var form = document.reqForm;
	form.searchType.value = type;
	fn_egov_tot_search();
}

function fn_chk_usrcert_form()
{ 	
	var agree1 = jQuery(':checkbox[name="agree1"]:checked').length;
	if(agree1 == 0){
		jQuery('#agree1').focus();
		alert("서비스이용약관을 동의해주세요.");
		return;
	}
	
	var agree2 = jQuery(':checkbox[name="agree2"]:checked').length;
	if(agree2 == 0){
		jQuery('#agree2').focus();
		alert('개인정보 수집 및 이용을 동의해주세요.');
		return;
	}
	
	var agree3 = jQuery(':checkbox[name="agree3"]:checked').length;
	if(agree3 == 0){
		jQuery('#agree3').focus();
		alert('개인정보 제3자 제공 및 위탁사항을 동의해주세요.');
		return;
	}
	var form = document.reqForm;
	fn_egov_auth_move(form,"A");

}

function fn_chk_usrcert()
{ 	
	//var idType = $(':radio[name="idType"]:checked').val();
	var idType = "phone";
	
	var action = "";
	window.name ="Parent_window";
	
	if(idType == "ipin") {
		
		$("#m").val("pubmain");
		
		window.open('', 'popupIPIN2', 'width=450, height=550, top=100, left=100,fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
		document.reqForm.target = "popupIPIN2";
		document.reqForm.action = "https://cert.vno.co.kr/ipin.cb";
		document.reqForm.submit();
	} else if(idType == "phone") {
		
		jQuery('#EncodeData').val(hpData);
		
		$("#m").val("checkplusSerivce");
		
		window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
		document.form_chkType.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
		document.form_chkType.target = "popupChk";
		document.form_chkType.submit();
	}
	
	/* 
	var form = document.reqForm;
	fn_egov_move_action(form, "/memuser/sysmemInputmove.do?tgtact=memJoinStep2&srch_menu_nix=" + lg_srch_menu_nix);
	 */
	
}

function fn_chk_usrcert_parent(idType){
	var agree1 = jQuery(':checkbox[name="law_agreement"]:checked').length;
	if(agree1 == 0){
		alert('법정대리인 동의를 체크해주세요.');
		return;
	}
	
	jQuery('#param_r1').val("parent");
	
	var action = "http://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
	
	if(idType == "ipin") {
		action = "/G-PIN/AuthRequest.jsp?type=parent";
	} else if(idType == "hp") {
		jQuery('#EncodeData').val(hpData);
	} else if(idType == "cert") {
		jQuery('#EncodeData').val(certData);
	}
	
	window.name ="Parent_window";
	window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
	document.form_chkType.action = action;
	document.form_chkType.target = "popupChk";
	document.form_chkType.submit();
}

function fn_chk_usrcert_parent_complete(type){
	$.ajax({
        url: g_context + '/memuser/parentAuthInfo.do?type=' + type,
        typs : 'get',
        dataType: 'json',
        cache : false,
        async : false,
        success: function(data) {     	
        	var age = parseInt(data);
        	if(age > 20){
        		jQuery('#authDiv').html('<span class="point02" id="spanCheckidArea">인증이 완료되었습니다.</span>');
        		jQuery('#parentAuth').val('Y');
				jQuery('#law_agreement').attr('readonly',true);
        	}else{
        		alert('만 20세 이상만 법적 대리인이 가능합니다.');
        	}
        },
        error : function(xhr, err){
        	alert(err);
        }
    });
}

function fn_egov_under_construct()
{
	alert("현재 페이지 구성 작업 진행중입니다.");
}


function fn_member_join()
{
	var form = document.reqForm;
	
	if(cmmfn_check_inputnull(jQuery("#user_id,#user_nm,#user_scrt,#user_scrt_confirm,#bizreg_no_1,#bizreg_no_2,#bizreg_no_3,#user_tel_1,#user_tel_2,#user_tel_3, #president, #biz_scope, #maj_product")) == false)
		return;
	
	if(fn_egov_memform_validate(form) == false)
			return;
		
	if(jQuery("#user_id_check").val() == "N")
	{
		alert("아이디 중복확인을 통과하지 못했습니다");
		return;
	}
	
	cmmfn_xss_removeobj(jQuery(":input, textarea"));
	
	if(confirm("회원가입을 신청하시겠습니까?") == false)
		return;
	
	fn_egov_move_action(form, "/memuser/addMember.do?srch_menu_nix=" + lg_srch_menu_nix);
	
}

function fn_member_modify()
{
	var form = document.reqForm;
	
	if(cmmfn_check_inputnull(jQuery("#user_nm,#user_scrt_org,#user_tel_1,#user_tel_2,#user_tel_3, #president, #biz_scope, #maj_product")) == false)
		return;
	
	if(fn_egov_memform_validate(form) == false)
		return;
	
	cmmfn_xss_removeobj(jQuery(":input, textarea"));
	
	if(confirm("회원정보를 수정하시겠습니까?") == false)
		return;
	
	fn_egov_move_action(form, "/memuser/mdfMember.do?srch_menu_nix=" + lg_srch_menu_nix);
	
}

function fn_egov_memform_validate(form)
{
	
	var id_obj = jQuery("#user_id");
	if(! cmmfn_check_validid(id_obj.val()))
	{
		id_obj.focus();
		return false;
	}
	
	var pwd_obj = jQuery("#user_scrt");
	if(pwd_obj.val() != "")
	{
		if(! cmmfn_check_validpwd(pwd_obj.val()))
		{
			pwd_obj.focus();
			return false;
		}
		if(form.user_scrt.value != form.user_scrt_confirm.value)
		{
			alert('비밀번호가 서로 일치하지 않습니다.');
			form.user_scrt_confirm.focus();
			return false;		
		}
	}
	
	/*
	jQuery("#user_email").val(jQuery("#user_email_1").val() + "@" + jQuery("#user_email_2").val());
	if(jQuery("#mailing_yn1:checked").length == "1")
	{
		var email_obj = jQuery("#user_email");
		if(! cmmfn_check_validemail(email_obj.val()))
		{
			email_obj.focus();
			return;
		}
	}
	jQuery("#user_zip").val(jQuery("#zipcode1").val() + "-" + jQuery("#zipcode2").val());
	*/

}


function fn_egov_check_dupid()
{
	var id_obj = jQuery("#user_id");
	if(! cmmfn_check_validid(id_obj.val()))
	{
		id_obj.focus();
		return;
	}
	
	var data = new Object();
	data.user_id = id_obj.val();
	
    $.ajax({
        url: g_context + '/memuser/chkdupMember.do',
        dataType: 'json',
        data : data,
        cache : false,
        async : false,
        success: function(data) {
        	if(parseInt(cmmfn_str_trim(data)) == 0)
        	{
        		jQuery("#spanCheckidArea").html("사용 가능한 ID입니다.");
        		jQuery("#user_id_check").val("Y");
        		jQuery("#user_id").prop("readonly", true);
        	}
        	else
        	{
        		jQuery("#spanCheckidArea").html("이미 존재하는 ID입니다.");
        		jQuery("#user_id_check").val("N");
        		jQuery("#user_id").prop("readonly", false);
        	}
        },
        error : function(xhr, err){
        	alert("에러가 발생했습니다.");
        }
    });
        
}



function fn_egov_withdraw_done()
{
	var form = document.reqForm;	

	if(cmmfn_check_inputnull(jQuery("#user_id, #user_scrt_org")) == false)
	{
		return;	
	}
	
	$.ajax({
	    url 		: g_context + "/memuser/checkMemberScrt.do",
	    type  	: "post",
	    data 		: {
	    	user_id : jQuery("#user_id").val(),
	    	user_scrt : jQuery("#user_scrt_org").val()
		},
		datatype	: "json",
		async 	: false,	        
		success 	: function(data){
			if(cmmfn_str_trim(data) == "SUCCESS")
				fn_egov_move_action(form, "/memuser/withdrawMember.do?srch_menu_nix=" + lg_srch_menu_nix);
			else
			{
				alert("입력하신 패스워드가 현재 패스워드와 일치하지 않습니다.");
				jQuery("#user_scrt_org").focus();
				return;	
			}
				
		},
	    error: function(xhr, err){
			alert("에러가 발생했습니다.");
	    }
	});
}


/*

function fn_egov_recover_id()
{
	var form = document.reqForm;
	jQuery("#user_recover_type").val("ID");

	if(cmmfn_check_inputnull(jQuery("#user_nm,#user_email")) == false)
		return;
	
	if(confirm("입력하신 정보로 아이디를 찾으시겠습니까?") == false)
		return;
	
    fn_egov_move_action(form, "/memuser/recoverMember.do?tgtact=recoverScrtinfo&srch_menu_nix=" + lg_srch_menu_nix);
}

function fn_egov_recover_pwd()
{
	var form = document.reqForm;
	jQuery("#user_recover_type").val("PWD");
	
	if(cmmfn_check_inputnull(jQuery("#user_id,#user_nm,#user_cp_2,#user_cp_3,#pinCode")) == false)
		return;
	
	if(fn_egov_check_pin_code() == "fail"){
		alert("인증번호를 확인해 주세요.");
		return;
	}
	
	if(confirm("입력하신 정보로 비밀번호를 찾으시겠습니까?") == false)
		return;
	
	fn_egov_move_action(form, "/memuser/recoverMember.do?tgtact=recoverScrtinfo&srch_menu_nix=" + lg_srch_menu_nix);
}


function fn_egov_check_dupidopen()
{
	var id_obj = jQuery("#user_id");
	if(! cmmfn_check_validid(id_obj.val()))
	{
		id_obj.focus();
		return;
	}
	
	jQuery("#chk_userid", jQuery("#divChkDuplacationID")).val(id_obj.val());
	jQuery("#divChkDuplacationID").dialog("open");
}

function fn_egov_check_useid()
{
	if(jQuery("#user_id_check").val() == "N")
	{
		alert("아이디 중복확인을 통과하지 못했습니다");
		return;
	}
	jQuery("#divChkDuplacationID").dialog("close");
}


function fn_egov_check_dupemailopen()
{
	var email_obj = jQuery("#user_email");
	if(! cmmfn_check_validemail(email_obj.val()))
	{
		email_obj.focus();
		return;
	}
	
	jQuery("#chk_email", jQuery("#divChkDuplacationEmail")).val(email_obj.val());
	jQuery("#divChkDuplacationEmail").dialog("open");
}



function fn_egov_check_dupcp()
{
	
	if(cmmfn_check_inputnull(jQuery("#user_cp_2,#user_cp_3")) == false)
		return;
	
	var data = new Object();
	data.user_cp_1 = jQuery("#user_cp_1").val();
	data.user_cp_2 = jQuery("#user_cp_2").val();
	data.user_cp_3 = jQuery("#user_cp_3").val();
	
    $.ajax({
        url: g_context + '/memuser/chkdupMember.do',
        dataType: 'json',
        data : data,
        cache : false,
        async : false,
        success: function(data) {
        	if(parseInt(cmmfn_str_trim(data)) == 0)
        	{
        		jQuery("#spanCheckcpArea").html("사용 가능한 핸드폰 번호입니다.");
        		jQuery("#user_cp_check").val("Y");
        		jQuery("#user_email").prop("readonly", true);
        	}
        	else
        	{
        		jQuery("#spanCheckcpArea").html("이미 존재하는 핸드폰 번호입니다.");
        		jQuery("#user_cp_check").val("N");
        		jQuery("#user_email").prop("readonly", false);
        	}
        },
        error : function(xhr, err){
        	alert(cmmfn_str_trim(xhr.responseText));
        }
    });
        
}

function fn_egov_check_useemail()
{
	if(jQuery("#user_cp_check").val() == "N")
	{
		alert("이메일 중복확인을 통과하지 못했습니다");
		return;
	}
	jQuery("#divChkDuplacationEmail").dialog("close");
}

function fn_member_save()
{
	var form = document.reqForm;
	if(cmmfn_check_inputnull(jQuery("#user_id, #user_scrt_org, #user_cp_2, #user_cp_3, #user_degree")) == false)
		return;
	
	//비밀번호를 체크한다
	var chkscrt = false;

	$.ajax({
	    url 		: g_context + '/modeur/modeurScrtcheck.do?srch_menu_nix=' + lg_srch_menu_nix,
	    type  	: "post",
	    data 		: {
	    	user_id : jQuery("#user_id").val(),
	    	user_scrt : jQuery("#user_scrt_org").val()
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
	
	if(chkscrt == false)
	{
		alert("입력하신 패스워드가 현재 패스워드와 일치하지 않습니다.");
		jQuery("#user_scrt_org").focus();
		return;
	}
	
	var pwd_obj = jQuery("#user_scrt");
	if(pwd_obj.val() != "")
	{
		if(! cmmfn_check_validpwd(pwd_obj.val()))
		{
			pwd_obj.focus();
			return;
		}
	
		if(form.user_scrt.value != form.user_scrt_confirm.value)
		{
			alert('비밀번호가 서로 일치하지 않습니다.');
			form.user_scrt_confirm.focus();
			return;		
		}
	}
	
	jQuery("#user_email").val(jQuery("#user_email_1").val() + "@" + jQuery("#user_email_2").val());
	var email_obj = jQuery("#user_email");
	if(! cmmfn_check_validemail(email_obj.val()))
	{
		email_obj.focus();
		return;
	}

	
	if(confirm("사용자 정보를 변경하시겠습니까?") == false )
		return;
	
	fn_egov_move_action(form, "/memuser/mdfMember.do?srch_menu_nix=" + lg_srch_menu_nix);
	
}

///////////////////////////////////////
// 마이페이지  Start
///////////////////////////////////////

function fn_member_modify()
{
	var form = document.reqForm;
	
	if(cmmfn_check_inputnull(jQuery("#user_nm,#user_cp_2,#user_cp_3,#user_birth")) == false)
		return;
	
	var pwd_obj = jQuery("#user_scrt");
	if(pwd_obj.val() != "" && !cmmfn_check_validpwd(pwd_obj.val()))
	{
		pwd_obj.focus();
		return;
	}

	if(form.user_scrt.value != "" && form.user_scrt.value != form.user_scrt_confirm.value)
	{
		alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.');
		form.user_scrt_confirm.focus();
		return;		
	}
	
	jQuery("#user_email").val(jQuery("#user_email_1").val() + "@" + jQuery("#user_email_2").val());
	if(jQuery("#mailing_yn1:checked").length == "1")
	{
		var email_obj = jQuery("#user_email");
		if(! cmmfn_check_validemail(email_obj.val()))
		{
			email_obj.focus();
			return;
		}
	}
	
	if(jQuery("#user_cp_check").val() == "N")
	{
		alert("핸드폰 번호 중복확인을 통과하지 못했습니다");
		return;
	}
	
	if(confirm("회원정보 수정을 완료하시겠습니까?") == false)
		return;
	
	// 정회원(일반회원)으로 가입 OK
	fn_egov_move_action(form, "/mypage/mdfMember.do?srch_menu_nix=" + lg_srch_menu_nix);

}

// 핸드폰 번호 변경 이벤트
function changeUserCp(){
	jQuery("#spanCheckcpArea").text("");
	
	if(jQuery("#temp_user_cp_1").val() == jQuery("#user_cp_1").val()
		&& jQuery("#temp_user_cp_2").val() == jQuery("#user_cp_2").val()
		&& jQuery("#temp_user_cp_3").val() == jQuery("#user_cp_3").val())
	{
		jQuery("#user_cp_check").val("Y");
		jQuery("#btnCheckDupcpSpan").hide();
	} else {
		jQuery("#user_cp_check").val("N");
		jQuery("#btnCheckDupcpSpan").show();
	}
}

// 비밀번호 확인
function fn_check_member_scrt()
{
	var userId = jQuery("#temp_id").val();
	var userScrt = jQuery("#user_scrt_org").val();

	var data = new Object();
	data.user_id = userId;
	data.user_scrt = userScrt;

	var result = "fail";
    $.ajax({
        url: g_context + '/memuser/checkMemberScrt.do',
        dataType: 'json',
        data : data,
        cache : false,
        async : false,
        success: function(data) {
        	result = data;
        },
        error : function(xhr, err){
        	alert(xhr.responseText);
        }
    });
    
    return result;
}




function fn_egov_send_pin_code()
{
	if(cmmfn_check_inputnull(jQuery("#user_id,#user_nm,#user_cp_1,#user_cp_2,#user_cp_3")) == false)
		return;
	
	var data = new Object();
	data.user_id = jQuery("#user_id").val();
	data.user_nm = jQuery("#user_nm").val();
	
	data.user_cp_1 = jQuery("#user_cp_1").val();
	data.user_cp_2 = jQuery("#user_cp_2").val();
	data.user_cp_3 = jQuery("#user_cp_3").val();
	data.user_recover_type = "PWD";

    $.ajax({
        url: g_context + '/memuser/sendPinCode.do',
        dataType: 'json',
        data : data,
        type: "POST",
        cache : false,
        async : false,
        success: function(data) {
        	var result = cmmfn_str_trim(data);
        	
        	if(result == "0")
        	{
        		jQuery("#pinCode").val("");
        		alert("인증번호 전송 중에 문제가 발생하였습니다.\n입력하신 정보가 정확하지 않습니다.");
        	}
        	else
        	{
        		alert("인증번호 전송이 완료되었습니다.");
        	}
        },
        error : function(xhr, err){
        	alert(xhr.responseText);
        }
    });
}

function fn_egov_check_pin_code()
{
	if(cmmfn_check_inputnull(jQuery("#user_id,#user_nm,#user_cp_1,#user_cp_2,#user_cp_3,#pinCode")) == false)
		return;
	
	var data = new Object();
	data.user_id = jQuery("#user_id").val();
	data.user_nm = jQuery("#user_nm").val();
	
	data.user_cp_1 = jQuery("#user_cp_1").val();
	data.user_cp_2 = jQuery("#user_cp_2").val();
	data.user_cp_3 = jQuery("#user_cp_3").val();
	
	data.pinCode = jQuery("#pinCode").val();
	data.user_recover_type = "PWD";

	var result = "fail"; 
    $.ajax({
        url: g_context + '/memuser/checkPinCode.do',
        dataType: 'json',
        data : data,
        type: "POST",
        cache : false,
        async : false,
        success: function(data) {
        	result = cmmfn_str_trim(data);
        },
        error : function(xhr, err){
        	alert(xhr.responseText);
        }
    });
    
    return result;
}

function fn_egov_chage_pw() {
	if(cmmfn_check_inputnull(jQuery("#user_scrt,#user_scrt_confirm")) == false){
		return
	}
	var pwd_obj = jQuery("#user_scrt");
	
	if(pwd_obj.val() != "" && !cmmfn_check_validpwd(pwd_obj.val()))	{
		pwd_obj.focus();
		return;
	}
	
	if(jQuery("#user_scrt").val() != jQuery("#user_scrt_confirm").val()){
		alert("비밀번호와 비밀번호 확인이 다릅니다.");
		return
	}
	
	var form = document.reqForm;
	alert("비밀번호 변경이 완료되었습니다.");
	fn_egov_move_action(form, "/memuser/changePw.do");
	close();
}


///////////////////////////////////////
// 마이페이지 End
///////////////////////////////////////

*/