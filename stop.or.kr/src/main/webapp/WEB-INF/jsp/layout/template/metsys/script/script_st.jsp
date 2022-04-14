<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!--
	통계 관리 스크립트
	2013.04.16 bhhan
-->	
<script type="text/javascript">


/**************************************************************
 *  			통계 페이지 초기화 Start
 **************************************************************/
function fn_egov_init_statpage()
{
	//cmmfn_set_datepicker("${pageContext.request.contextPath}", jQuery("#srchFromDT, #srchToDT"), "%Y%m%d");
	
	jQuery("#srchFromDT")
		.css("width", "70px")
		.css("text-align", "center");
	jQuery("#srchToDT")
		.css("width", "70px")
		.css("text-align", "center");
	

	// 단위선택시 날짜값 초기화
	jQuery("input[id^='date_choice']").click(function(){
		
		var dt = new Date();
		var dtchoice = $(this).val();
		if(dtchoice == "YY")
		{
			jQuery("#srchFromDT").val(cmmfn_date_to_string(cmmfn_get_shift_time(dt, -4, 0, 0), "YY"));
			jQuery("#srchToDT").val(cmmfn_date_to_string(dt, "YY"));
		}
		else if(dtchoice == "MM")
		{
			jQuery("#srchFromDT").val(cmmfn_date_to_string(cmmfn_get_shift_time(dt, 0, -11, 0), "MM"));
			jQuery("#srchToDT").val(cmmfn_date_to_string(dt, "MM"));
		}
		else if(dtchoice == "DD")
		{
			jQuery("#srchFromDT").val(cmmfn_date_to_string(cmmfn_get_shift_time(dt, 0, 0, -30), "DD"));
			jQuery("#srchToDT").val(cmmfn_date_to_string(dt, "DD"));
		}
		
	});
	
	
	if(jQuery(":checked").length == 0)
		jQuery("#rdo_day").trigger("click");
	
	jQuery("#btnStatView").click(function(){
		fn_egov_stat_refresh();
	});
	
}

function fn_egov_stat_refresh()
{
	var dtchoice = jQuery("input[id^='date_choice']:checked").val();
	
	var dtlen_from = jQuery("#srchFromDT").val().length; 
	var dtlen_to = jQuery("#srchToDT").val().length; 
	if(dtchoice == "YY" && (dtlen_from != 4 || dtlen_to != 4))
	{
		alert("날짜(연단위) 형식에 맞게\n4자리 연도 [ YYYY ]을 입력해주십시오.");
		return;
	}
	else if(dtchoice == "MM" && (dtlen_from != 6 || dtlen_to != 6))
	{
		alert("날짜(월단위) 형식에 맞게\n6자리 연월 [ YYYYMM ]을 입력해주십시오.");
		return;
	}
	else if(dtchoice == "DD" && (dtlen_from != 8 || dtlen_to != 8))
	{
		alert("날짜(일단위) 형식에 맞게\n8자리 연월일 [ YYYYMMDD ]를 입력해주십시오.");
		return;
	}
	
	var form = document.reqForm;
	fn_egov_move_action(form, "/modest/modestPage.do?srch_menu_nix=Ap778PvY"); 
	
}

function fn_egov_statpg_refresh()
{
	var dtlen_from = jQuery("#srchFromDT").val().length; 
	var dtlen_to = jQuery("#srchToDT").val().length; 
	
	var form = document.reqForm;
	fn_egov_move_action(form, "/modest/modestpgPage.do?srch_menu_nix=Ap778PvY"); 
}

/**************************************************************
 *  			통계 페이지 초기화 End
 **************************************************************/


</script>

