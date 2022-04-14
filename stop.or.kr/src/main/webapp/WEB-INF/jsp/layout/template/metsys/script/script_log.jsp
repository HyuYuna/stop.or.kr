<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--
	로그 관리 스크립트
	2013.04.16 bhhan
-->	
<script type="text/javascript">

function fn_egov_init_log()
{

	cmmfn_set_datepicker(g_context, jQuery("#srchFromDT, #srchToDT"), "%Y-%m-%d");
	//jQuery("#srchFromDT").val(cmmfn_date_to_string(new Date(), 'DD', '-'));
	//jQuery("#srchToDT").val(cmmfn_date_to_string(new Date(), 'DD', '-'));
	
}


function fn_egov_search_refresh()
{
	var form = document.reqForm;
	form.pageIndex.value = "1";
	fn_egov_log_list();
}

function fn_egov_log_list()
{
	var form = document.reqForm;
	fn_egov_move_action(form, "/manlog/manlogList.do?srch_menu_nix=${param.srch_menu_nix}");	
}

function fn_egov_link_page(pageIndex)
{
	var form = document.reqForm;
	form.pageIndex.value = pageIndex;
	fn_egov_log_list();
}

 
</script>


