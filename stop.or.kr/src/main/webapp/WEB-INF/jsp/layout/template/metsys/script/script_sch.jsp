<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!--
	스케쥴 관리 스크립트
	2018-07-04 ych
-->	
<script type="text/javascript">
	
	function fn_egov_init_schedulepage() 
	{
		cmmfn_set_datepicker(g_context, jQuery("#s_date, #e_date"), "%Y-%m-%d");
	}
	
	function fn_egov_schedule_list()
	{
		var form = document.reqForm;
		fn_egov_move_action(form, "/mansch/schList.do?srch_menu_nix=${param.srch_menu_nix}");
	}

	
	function fn_egov_link_page(pageIndex)
	{
		var form = document.reqForm;
		form.pageIndex.value = pageIndex;
		fn_egov_schedule_list();
	}
	
</script>
