<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--
	페이지별로 들어가는 공통적인 명령에 대한 스크립트만 여기에 추가한다.
	ex) 메뉴 페이지 이동 스크립트 등..
	2013.04.16 bhhan
-->	
<script type="text/javascript">

var lg_srch_menu_nix = "";
var popup_idx;
jQuery(document).ready(function(){

	//## TPCODE : TPAGE0007 : 관리자 공통 스크립트 ## 

	g_context = "${pageContext.request.contextPath}";
	lg_srch_menu_nix = "${param.srch_menu_nix}"; 
	seltab_idx = "${param.seltab_idx}";
	jQuery(":text").focus(function(){$(this).select();});
	
	initSiteManagerMenu();
	
	fn_chgclass_menu("_" + lg_srch_menu_nix);
	fn_chgclass_submenu("_" + lg_srch_menu_nix);
	
	if(typeof fn_egov_refresh_menupreview == "function")
		fn_egov_refresh_menupreveiw();
	
	if(typeof fn_egov_init_meminspage == "function")
		fn_egov_init_meminspage();
	
	if(typeof fn_egov_init_continspage == "function")
		fn_egov_init_continspage();
	
	if(typeof fn_egov_init_brdinspage == "function")
		fn_egov_init_brdinspage();
	
	if(typeof fn_egov_init_statpage == "function")
		fn_egov_init_statpage();
	
	if(typeof fn_egov_init_menuinspage == "function")
		fn_egov_init_menuinspage();
	
	if(typeof fn_egov_init_ctgryinspage == "function")
		fn_egov_init_ctgryinspage();
	
	if(typeof fn_egov_init_codeinspage == "function")
		fn_egov_init_codeinspage();
	
	if(typeof fn_egov_init_authinspage == "function")
		fn_egov_init_authinspage();
	
	if(typeof fn_egov_init_popuppage == "function")
		fn_egov_init_popuppage();

	if(typeof fn_egov_init_atchinspage == "function")
		fn_egov_init_atchinspage();

	if(typeof fn_egov_init_log == "function")
		fn_egov_init_log();

	if(typeof fn_egov_init_withdrawal == "function")
		fn_egov_init_withdrawal();
 
	if(typeof fn_egov_init_statdatapage == "function")
		fn_egov_init_statdatapage();
	
	if(typeof fn_egov_init_equipmentpage == "function")
		fn_egov_init_equipmentpage();
	
	if(typeof fn_egov_init_schedulepage == "function")
		fn_egov_init_schedulepage();

	if(typeof fn_egov_init_newsletterpage == "function")
		fn_egov_init_newsletterpage();

	if(typeof fn_egov_init_projectpage == "function")
		fn_egov_init_projectpage();
	
	if("${param.brd_id}" != "")
	{
		var nmenu_nm = ("${nowMenuVO.menu_nm}" == "") ? "${SESS_BRD_INFO.brd_nm} - " : "${nowMenuVO.menu_nm} - ";
		try{
			jQuery("title").html(nmenu_nm + " : PLANI_TMPL"); 
		}catch(err){
			document.title = nmenu_nm + " : PLANI_TMPL"; 
		}
	}

	////////////////////////////////////////////////////////////
	// input 텍스트 길이 지정 Start
	jQuery(":input").each(function(){
		
		var cls = $(this).prop("class");
		
		if(cls != null && cls.startsWith("input_width_"))
		{
			cls = cls.replace(/input_width_/gi, "");
			$(this).css("width", cls + "px");
		}
		
	});
	// input 텍스트 길이 지정 End
	////////////////////////////////////////////////////////////

	////////////////////////////////////////////////////////////////
	// 테이블 마우스 오버시 라인 색상 변경효과 Start
	jQuery(".tstyle_view > tbody > tr").css("line-height", "20px");
	
	var orgbg = null;
	jQuery(".tstyle_list > tbody > tr").mouseenter(function(){
		orgbg = $(this).css("background-color");
		$(this).css("background-color", "rgb(245,245,245)");
	});	
	jQuery(".tstyle_list > tbody > tr").mouseleave(function(){
		$(this).css("background-color", orgbg);
	});
	// 테이블 마우스 오버시 라인 색상 변경효과 End
	////////////////////////////////////////////////////////////////

	jQuery("span[class*='sbjt_width_x']").each(function(){
		
		var class_ = $(this).attr("class");
		var x = parseInt(class_.replace(/sbjt_width_x/g, ""));
		x = x-1;
		
		$(this)
			.css("padding", "0 " + (x * 8) + "px 0 " + (x * 8) + "px");
		
	});
	
});


function fn_egov_refresh_menupreveiw()
{
	
	if(jQuery("#divMenuScriptOnlyArea").length == 0)
		return;		
	
	var css = jQuery("#txtMenuCss").html();
	css = "<style>" + css + "</style>";
	
	var prev = jQuery("#divMenuScriptOnlyArea").html();
	prev = cmmfn_replacetag_div(prev);
	prev = prev.replace(/<[\/]*(span|br)[^>]*>/gi, "");
	prev = prev.replace(/# 메뉴 스크립트 #/gi, "");
	prev = css + prev;
	jQuery("#divMenupPrevArea")
		.height("500px")
		.empty()
		.html(prev);
	
}
 

// 메뉴 이동
function fn_egov_change_menu(url, seltab_idx)
{
	var form = document.reqForm;
	try{
		// 메뉴가 바뀔때 모든 텍스트 파라미터들은 값을 초기화시킨다. (메뉴가 바뀔때 이전메뉴에서 선택했던 옵션들이 따라가는 경우가 있기때문..)
		jQuery(":text,:hidden").each(function(){
			
			var val = $(this).val();
			if((val != null && val != undefined) && (isNaN(val) == true || val.length >= 8))	// 8자리 이상은 숫자로 보지 않는다.
				$(this).val('');
			
		});
	}catch(err){
		
	}
	
	if(form.pageIndex != undefined && form.pageIndex != null) 
		form.pageIndex.value = "1";
	

	if(cmmfn_exist_object("seltab_idx") == true)
	{
		jQuery("#seltab_idx").val(seltab_idx);	
		fn_egov_move_action(form, url);
	}
	else
	{
		fn_egov_move_action(form, url + "&seltab_idx=" + seltab_idx);
	}
}


//메뉴 이동
function fn_egov_change_menumode(mu_gub, srch_menu_nix, seltab_idx)
{
	var form = document.reqForm;

	try{
		// 메뉴가 바뀔때 모든 텍스트 파라미터들은 값을 초기화시킨다. (메뉴가 바뀔때 이전메뉴에서 선택했던 옵션들이 따라가는 경우가 있기때문..)
		jQuery(":text,:hidden").each(function(){
			
			var val = $(this).val();
			if((val != null && val != undefined) && (isNaN(val) == true || val.length >= 8))	// 8자리 이상은 숫자로 보지 않는다.
				$(this).val('');
			
		});
	}catch(err){
		
	}
	
	if(form.pageIndex != undefined && form.pageIndex != null) 
		form.pageIndex.value = "1";
	
	if(jQuery("#srch_mu_gub").prop("type") == "hidden")
	{
		jQuery("#srch_mu_gub").val(mu_gub);
	}
	else
	{
		var gubsel = 0;
		switch(mu_gub){case "USR" : gubsel = 0;break; case "MAN" : gubsel = 1;break;};
		
		jQuery("#srch_mu_gub option:eq(" + gubsel + ")").prop("selected", true);
	}

	if(cmmfn_exist_object("seltab_idx") == true)
	{
		jQuery("#seltab_idx").val(seltab_idx);	
		fn_egov_move_action(form, '/menuctgry/sysmenuList.do?srch_menu_nix=' + srch_menu_nix);
	}
	else
	{
		fn_egov_move_action(form, '/menuctgry/sysmenuList.do?srch_menu_nix=' + srch_menu_nix + "&seltab_idx=" + seltab_idx);
	}
}

// action 실행
function fn_egov_move_action(form, act)
{
	form.action = g_context + act;
	form.submit();
}

// 로그아웃 처리
function fn_egov_logout()
{
	if(confirm("로그아웃 하시겠습니까?") == false)
		return;

	var form = document.reqForm;
	fn_egov_move_action(form, "/metsys/metsysLogout.do");
} 


function fn_chgclass_submenu(act)
{
	jQuery("li[id^='liMetsysSubmenu']").removeClass("on");
	jQuery("#liMetsysSubmenu" + act).addClass("on");
	jQuery("#liMetsysSubmenu" + act).parent().closest("li").addClass("on");
}

function fn_chgclass_menu(act)
{
	jQuery("li[id^='liMetsysMenu']").removeClass("on");
	jQuery("#liMetsysMenu" + act).addClass("on");
}

function fn_egov_under_construct()
{
	alert("현재 페이지 구성 작업 진행중입니다.");
}

</script>