<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!--
	회원서비스 페이지 스크립트
	2013.04.16 bhhan
-->
<script type="text/javascript">
var hpData = "${hpData}";
var certData = "${certData}";
jQuery(document).ready(function(){
	
	if("${param.tgtact}" == "01")
	{
		jQuery("#user_scrt").unbind("keypress");
		jQuery("#user_scrt").keydown(function(event){
			if(event.keyCode == 13)
			{
				fn_site_login();
			}
		});	
	}
	
	if(cmmfn_exist_object("bizreg_no") == true)
	{
		jQuery("#bizreg_no_1, #bizreg_no_2, #bizreg_no_3, #user_tel_1, #user_tel_2, #user_tel_3").numeric();
	}
	
});


</script>

