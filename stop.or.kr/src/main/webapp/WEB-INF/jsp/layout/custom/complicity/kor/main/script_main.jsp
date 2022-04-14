<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!--
	메인페이지 스크립트
	ex) 메뉴 페이지 이동 스크립트 등..
	2013.04.16 bhhan
-->	
<script type="text/javascript">
//모바일 여부 확인
var g_ismobile = navigator.userAgent.match(/(iPad)|(iPhone)|(iPod)|(android)|(webOS)/i);

jQuery(document).ready(function(){

	// 통계기록
	fn_egov_mainstat_write();
	
	////////////////////////////////////////////////
	// Layer Popup 처리
	jQuery("#divPopupLayer").show();

	var top = 150;
	var popcnt = 0;
	jQuery("div[id^='layerPopup_']").each(function(){

		var obj = $(this);
		var idx = obj.attr("id");
		idx = idx.replace(/layerPopup_/gi, "");
		
		var ckey = cmmfn_get_cookie("CKPOP_PLANI_TEMP_INFO" + idx);
		if(ckey == "N")
		{
			obj.hide();
			return true;			
		}

		var pop_h = parseInt(jQuery("#pop_h_" + idx).val());
		var pop_w = jQuery("#pop_w_" + idx).val();
		var pop_x = jQuery("#pop_x_" + idx).val();
		var pop_y = jQuery("#pop_y_" + idx).val();
		
		obj.css("position", "absolute")
			.css("background", "#f9f9f9")
			.css("border", "solid 1px #393939")
			.css("box-shadow", "2px 2px 10px #484848")
			.css("z-index", "999")
			.css("left", pop_x + "px")
			.css("width", pop_w + "px")
			.css("height", (pop_h + 40) + "px")
			.css("top", pop_y + "px");
		
	});

	jQuery("input[id^='egov_intro_chk_']").click(function(){

		var id = $(this).attr("id");
		var idx = id.replace(/egov_intro_chk_/g, "");
		if($(this).prop("checked") == true)
		{
			cmmfn_set_cookie("CKPOP_PLANI_TEMP_INFO" + idx, "N", 1);
		}
		else
		{
			cmmfn_set_cookie("CKPOP_PLANI_TEMP_INFO" + idx, "Y", 1);
		}

		popcnt++;
	});

	jQuery(".layer_close")
		.css("margin", "5px 10px 5px 0")
		.css("text-align", "right");
	
	// Layer Popup 처리
	////////////////////////////////////////////////
				
	
	jQuery("#searchKeyword").unbind("keypress");
	jQuery("#searchKeyword").keydown(function(event){
		if(event.keyCode == 13)
		{
			fn_egov_equip_search();
		}
	});	
	
});

function fn_egov_mainstat_write(){
	$.ajax({
		url: g_context + '/contents/siteMainstatWrite.do',
		data : {
			referer : encodeURIComponent("${header.Referer}")
		},
		dataType: 'html',
		cache : false,
		async : true,
		success: function(data) {
		},
		error : function(xhr, err){
       }
   });
}

function fn_egov_selnotice_idx(idx)
{
	jQuery("div[id^=latest]").removeClass("on");
	jQuery("#latest0" + idx).addClass("on");
	jQuery("#latest0" + idx).find("p").show();
	
}

function fn_egov_poplayer_close(idx)
{
	jQuery("#layerPopup_" + idx).hide();
}

</script>