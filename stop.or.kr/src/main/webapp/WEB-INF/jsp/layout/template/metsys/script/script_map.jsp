<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!--
	스케쥴 관리 스크립트
	2018-07-04 ych
-->	
<script type="text/javascript">
$(document).ready(function(){
	
});
	function fn_egov_map_list()
	{
		var form = document.reqForm;
		fn_egov_move_action(form, "/manmap/mapList.do?srch_menu_nix=${param.srch_menu_nix}");
	}

	
	function fn_egov_link_page(pageIndex)
	{
		var form = document.reqForm;
		form.pageIndex.value = pageIndex;
		fn_egov_map_list();
	}
	
</script>
