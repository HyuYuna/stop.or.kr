<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 파비콘 -->
<link rel="shortcut icon" href="/favicon.ico">

<!--
	페이지별로 들어가는 공통적인 명령에 대한 스크립트만 여기에 추가한다.
	ex) 메뉴 페이지 이동 스크립트 등..
	2013.04.16 bhhan
-->	
<script type="text/javascript">

//## TPCODE : TPAGE0006 : 사용자 공통 스크립트 ## 

var is_allmenu_open = false;
var lastMenuIDLv1 = "";
var lastMenuIDLv2 = "";
var lg_srch_menu_nix = "${param.srch_menu_nix}"; 
var lg_menu_nm = "${nowMenuVO.menu_nm}";
var lg_pg_ret_type = "${param.pg_ret_type}";
var lg_brd_id = "${param.lg_brd_id}";
var lg_brd_nm = "${SESS_BRD_INFO.brd_nm}";

var lg_mu_site = "${param.srch_mu_site}"; 
var lg_mu_lang = "${param.srch_mu_lang}"; 
lg_mu_site = (lg_mu_site == null || lg_mu_site == "") ? "CDIDX00002" : lg_mu_site;
lg_mu_lang = (lg_mu_lang == null || lg_mu_lang == "") ? "CDIDX00022" : lg_mu_lang;

var rcvact = "${param.rcvact}";
jQuery(document).ready(function(){
	
	g_context = "${pageContext.request.contextPath}";
	jQuery(":text").focus(function(){$(this).select();});
	
	// 사이트 초기화
	initSiteTools();

	// 인증 초기화
	if(typeof initSiteAuth == "function")
		initSiteAuth();
	

	jQuery("span[class*='sbjt_width_x']").each(function(){
		
		var class_ = $(this).attr("class");
		var x = parseInt(class_.replace(/sbjt_width_x/g, ""));
		x = x-1;
		
		$(this)
			.css("padding", "0 " + (x * 5) + "px 0 " + (x * 5) + "px");
		
	});
	
	//console.log("페이지 기본설정 로드");
	
	sitePagestatWrite();
});


<c:if test="${SESS_USR_LV lt 101}">
function fn_move_manage()
{
	var form = document.reqForm;
	form.target = "_blank";
	<c:choose>
		<c:when test="${SESS_USR_LV eq 0}">
			fn_egov_move_action(form, "/modedv/modedvPage.do?srch_menu_nix=${param.srch_menu_nix}");
		</c:when>
		<c:otherwise>
			fn_egov_move_action(form, "/modeur/modeurList.do?srch_menu_nix=${param.srch_menu_nix}");
		</c:otherwise>
	</c:choose>
	
}
</c:if>


function sitePagestatWrite(){
	$.ajax({
		url: g_context + '/contents/sitePagestatWrite.do',
		data :{
			srch_menu_nix : lg_srch_menu_nix,
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

function fn_egov_auth_move(form, pg_ret_type)
{
	fn_egov_move_action(form, "/svcmem/sysmemPagemove.do?tgtact=chkUsrcertForm&srch_menu_nix=${param.srch_menu_nix}&pg_ret_type="+pg_ret_type);
};

function fn_egov_loginauth_move(pg_ret_type)
{
	<c:if test="${empty SESS_USR_INFO or SESS_USR_INFO.user_auth_lv gt 1002}">
		alert("로그인 또는 본인확인 후 작성할 수 있습니다.");
	</c:if>
	location.href = g_context + "/svcmem/sysmemPagemove.do?tgtact=loginAuth&srch_menu_nix=${param.srch_menu_nix}&pg_ret_type="+pg_ret_type;
};

function fn_egov_tot_chk(){
	if($(".popupSearch").css("display")=="none"){
		$(".popupSearch").fadeIn(700);
	}else{
		$(".popupSearch").fadeOut(700);
	}
}

</script>