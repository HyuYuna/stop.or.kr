<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>



<!--
	관리자 메뉴 / 권한 / 코드 관리 스크립트
	2013.04.16 bhhan
-->	
<script type="text/javascript">


/**************************************************************
 *  			메뉴관리 페이지 초기화 Start
 **************************************************************/
//메뉴 페이지 초기화
function fn_egov_init_menuinspage()
{
	jQuery(".menusetTypeDetail").hide();

	var pgmode = jQuery("#edomweivgp").val();

	/*
	// 목록 페이지인 경우 초기화
	if(pgmode == "" || pgmode == "R")
	{
		jQuery("#divMenuScript").hide();
		
		jQuery("#mu_gub").change(function(){
			fn_egov_sysmenu_list();
		});
		
	}
	*/

	jQuery("#sel_mu_gub").val(jQuery("#srch_mu_gub").val());
	jQuery("#sel_mu_site").val(jQuery("#srch_mu_site").val());
	jQuery("#sel_mu_lang").val(jQuery("#srch_mu_lang").val());
	
	// 상세보기 페이지인 경우 초기화 (추가 / 수정 )
	if(pgmode == "M" || pgmode == "A" || pgmode == "S")
	{
		fn_egov_load_brdlist();		
		jQuery("#selectBrdlist").change(function(){
			jQuery("#menu_nm").val(jQuery("#selectBrdlist option:selected").html());
			jQuery("#menu_link").val($(this).val());
			jQuery("#selectContlist option:eq(0)").prop("selected", true);
		});

		fn_egov_load_contlist();
		jQuery("#selectContlist").change(function(){
			jQuery("#menu_nm").val(jQuery("#selectContlist option:selected").html());
			jQuery("#menu_link").val($(this).val());
			jQuery("#selectBrdlist option:eq(0)").prop("selected", true);
		});
		
		fn_egov_load_announcementlist();
		jQuery("#selectAnnouncementlist").change(function(){
			jQuery("#menu_nm").val(jQuery("#selectAnnouncementlist option:selected").html());
			jQuery("#menu_link").val($(this).val());
			jQuery("#selectAnnouncementlist option:eq(0)").prop("selected", true);
		});

		fn_egov_load_awardslist();
		jQuery("#selectAwardslist").change(function(){
			//jQuery("#menu_nm").val(jQuery("#selectAwardslist option:selected").html());
			jQuery("#menu_link").val($(this).val());
			jQuery("#selectAwardslist option:eq(0)").prop("selected", true);
		});
		
		
		jQuery("#sel_mu_lang").change(function(){
			fn_egov_load_contlist();
		});
		
		jQuery("#menu_nm").focus();
		
		
		
		
	}
	//alert(jQuery("#edomweivgp").val());
	jQuery("input[id^='menu_idx']").click(function(){
		
		fn_egov_sel_submenu($(this).attr("id"), $(this).prop("checked"));
		
	});
	

	jQuery("#selMenusetType").change(function(){
		var val = $(this).val();
		if(val == "C")
		{
			jQuery(".menusetTypeDetail").fadeOut('slow');
		}
		else
		{
			jQuery(".menusetTypeDetail").fadeIn('slow');
		}
	});
	
	// 트리테이블 적용
	if(cmmfn_exist_object("tableSysmenuList") == true)
	{
		jQuery("#tableSysmenuList").treetable({ expandable: true, column : 1, indent : 18 });
		jQuery("#tableSysmenuList").treetable("expandAll");
	}
	
	jQuery(".mn_devonly").hide();
	jQuery(".mn_disable").css("background-color", "rgb(235,235,235)");
	
	
	jQuery("input[id^='menucont_type']").click(function(){
		var val = $(this).val();
		
		switch(val)
		{
			// 일반
			case "N" : 
				jQuery("#menu_link").prop("readonly", false).val("/dummy.do");
				break;
		
			// 상위메뉴
			case "U" : 
				jQuery("#menu_link").prop("readonly", true).val("UPPER");
				break;
		
			// 게시판
			case "B" : 
				jQuery("#menu_link").prop("readonly", true).val("BOARD");
				break;
		
			// 컨텐츠
			case "C" : 
				jQuery("#menu_link").prop("readonly", true).val("CONTENTS");
				break;
		
			// 작업중
			case "R" : 
				jQuery("#menu_link").prop("readonly", true).val("UNDER_CONSTRUCT");
				break;
		}
		
	});
	
}


function fn_egov_menu_allopen(direct)
{
	 jQuery("#tableSysmenuList").treetable("expandAll");
}

function fn_egov_menu_allclose(direct)
{
	 jQuery("#tableSysmenuList").treetable("collapseAll");
}


// 메뉴를 삭제하기 위해 선택했을때 하위메뉴도 모두 선택되도록 한다.
function fn_egov_sel_submenu(selid, chkval)
{

	var info = selid.replace(/menu_idx_/gi, "");
	arrinfo = info.split("_");
	var nowidx = parseInt(arrinfo[0]);
	var nowlv = parseInt(arrinfo[1]);
	
	try{
		
		jQuery("input[id^='menu_idx']").each(function(){
			
			var info = $(this).attr("id").replace(/menu_idx_/gi, "");
			arrinfo = info.split("_");
			
			var idx = parseInt(arrinfo[0]);
			var lv = parseInt(arrinfo[1]);
			
			if(idx <= nowidx)
				return true;
			
			if(lv <= nowlv)
				return false;
			
			$(this).prop("checked", chkval);
			
	});
	
	}catch(err){
		
	}
	
	
}


function fn_egov_load_brdlist()
{
	$.ajax({
        url 		: g_context + '/modebd/modebdJsonList.do',
        type  		: "post",
        data 		: {
        	srch_mu_site : jQuery("#srch_mu_site").val(),
        	srch_mu_lang : jQuery("#srch_mu_lang").val()
        },
        datatype	: "text",
		async 		: false,	        
        success 	: function(data){        	
        	jQuery("#selectBrdlist option").remove();
        	jQuery("#selectBrdlist").append("<option value=''>게시판 연동</option>");
			for(var i = 0; i < data.length; i++)
			{
				if(data[i].ref_menu_nix == null || data[i].ref_menu_nix == "")
				{
					if(data[i].brd_gb == "CDIDX00043")
						jQuery("#selectBrdlist").append("<option value='/brdfaq/boardfaqList.do?brd_id=" + data[i].brd_id + "'>" + data[i].brd_nm + "</option>");
					else if(data[i].brd_gb == "CDIDX00044")
						jQuery("#selectBrdlist").append("<option value='/brdthm/boardthmList.do?brd_id=" + data[i].brd_id + "'>" + data[i].brd_nm + "</option>");
					else if(data[i].brd_gb == "CDIDX00045")
						jQuery("#selectBrdlist").append("<option value='/brddry/boarddryList.do?brd_id=" + data[i].brd_id + "'>" + data[i].brd_nm + "</option>");
					else if(data[i].brd_gb == "CDIDX00046")
						jQuery("#selectBrdlist").append("<option value='/brdanm/boardanonimList.do?brd_id=" + data[i].brd_id + "'>" + data[i].brd_nm + "</option>");
					else
						jQuery("#selectBrdlist").append("<option value='/brdartcl/boardarticleList.do?brd_id=" + data[i].brd_id + "'>" + data[i].brd_nm + "</option>");
				}
			}
			
		},
        error: function(xhr, err){
            
        	alert("테이블 정보를 가져오는 도중 오류가 발생했습니다.");
        }
    });
}

 
function fn_egov_load_contlist()
{
	$.ajax({
        url 		: g_context + '/modedg/modedgJsonList.do',
        type  		: "post",
        data 		: {
        	srch_mu_site :  jQuery("#sel_mu_site").val(),
        	srch_mu_lang :  jQuery("#sel_mu_lang").val()
        },
        datatype	: "text",
		async 		: false,	        
        success 	: function(data){        	

        	jQuery("#selectContlist option").remove();
        	jQuery("#selectContlist").append("<option value=''>컨텐츠 연동</option>");
			for(var i = 0; i < data.length; i++)
			{
				if(data[i].ref_menu_nix == null || data[i].ref_menu_nix == "")
					jQuery("#selectContlist").append("<option value='/modedg/contentsView.do?ucont_id=" + data[i].ucont_id + "'>" + data[i].ucont_subject + "</option>");
			}
			
		},
        error: function(xhr, err){
            
        	alert("테이블 정보를 가져오는 도중 오류가 발생했습니다.");
        }
    });
}

function fn_egov_load_announcementlist() {
	
	$.ajax({
        url 		: g_context + '/metsys/announcementGroupListJson.do',
        type  		: "post",
        data 		: {
        	srch_mu_site :  jQuery("#sel_mu_site").val(),
        	srch_mu_lang :  jQuery("#sel_mu_lang").val()
        },
        datatype	: "json",
		async 		: false,	        
        success 	: function(data){        	

        	jQuery("#selectAnnouncementlist option").remove();
        	jQuery("#selectAnnouncementlist").append("<option value=''>공고 연동</option>");
			for(var i = 0; i < data.length; i++)
			{
				if(data[i].ref_menu_nix == null || data[i].ref_menu_nix == "")
					jQuery("#selectAnnouncementlist").append("<option value='/announcement/list.do?groupId=" + data[i].group_id + "'>" + data[i].name + "</option>");
			}
			
		},
        error: function(xhr, err){
            
        	alert("테이블 정보를 가져오는 도중 오류가 발생했습니다.");
        }
    });
	
	
}

function fn_egov_load_awardslist() {
	
	$.ajax({
        url 		: g_context + '/metsys/awardsGroupListJson.do',
        type  		: "post",
        data 		: {
        	srch_mu_site :  jQuery("#sel_mu_site").val(),
        	srch_mu_lang :  jQuery("#sel_mu_lang").val()
        },
        datatype	: "json",
		async 		: false,	        
        success 	: function(data){        	

        	jQuery("#selectAwardslist option").remove();
        	jQuery("#selectAwardslist").append("<option value=''>수상작 연동</option>");
			for(var i = 0; i < data.length; i++)
			{
				if(data[i].ref_menu_nix == null || data[i].ref_menu_nix == "")
					jQuery("#selectAwardslist").append("<option value='/awards/list.do?groupId=" + data[i].group_id + "'>" + data[i].name + "</option>");
			}
			
		},
        error: function(xhr, err){
            
        	alert("테이블 정보를 가져오는 도중 오류가 발생했습니다.");
        }
    });
	
	
}

function fn_egov_sysmenu_add()
{
	var form = document.reqForm;
	form.edomweivgp.value = "A";
	fn_egov_move_action(form, "/menuctgry/moveSysmenuView.do?srch_menu_nix=${param.srch_menu_nix}"+ fn_egov_get_argstr());
}

function fn_egov_sysmenu_subadd(up_menu_idx)
{
	var form = document.reqForm;
	form.edomweivgp.value = "S";
	fn_egov_move_action(form, "/menuctgry/moveSysmenuView.do?srch_menu_nix=${param.srch_menu_nix}&up_menu_idx=" + up_menu_idx + fn_egov_get_argstr());
}

function fn_egov_sysmenu_list()
{
	var form = document.reqForm;
	form.use_yn.value = "";
	form.edomweivgp.value = "R";
	fn_egov_move_action(form, "/menuctgry/sysmenuList.do?srch_menu_nix=${param.srch_menu_nix}" + fn_egov_get_argstr());
}

function fn_egov_sysmenu_view(menu_idx)
{
	var form = document.reqForm;
	form.edomweivgp.value = "M";
	jQuery("#menu_idx").val(menu_idx);
	fn_egov_move_action(form, "/menuctgry/moveSysmenuView.do?srch_menu_nix=${param.srch_menu_nix}" + fn_egov_get_argstr());
}

function fn_egov_menucont_view(ucont_id)
{
	var form = document.reqForm;
	form.edomweivgp.value = "M";
	form.ucont_version.value = '0';
	form.ucont_id.value = ucont_id;
	
	fn_egov_move_action(form, "/modedg/contentsmanView.do?srch_menu_nix=z0k797D5");		
}

function fn_egov_menubrd_view(brd_id)
{
	var form = document.reqForm;
	form.edomweivgp.value = "M";
	form.brd_id.value = brd_id;
	fn_egov_move_action(form, "/modebd/modebdView.do?srch_menu_nix=wZ311Dfx");		
}


function fn_egov_sysmenu_save()
{

	var data = cmmfn_get_post_data("divMainArticle");
	
	if(data.menu_nm == "")
	{
		alert("메뉴 명을 입력하십시오.");
		jQuery("#menu_nm").focus();
		return;
	}

	var pgmode = "${sysmenuVO.edomweivgp}";
	var menucont_type = jQuery("input[id^='menucont_type']:checked").val();
	
	
	// 수정모드에서 링크가 비어있는 경우
	if((pgmode == "M" && data.menu_link == "") ||
		//추가모드이고 일반유형에서 링크가 비어있는 경우
		( (pgmode == "A" || pgmode == "S" ) && menucont_type == "N" && data.menu_link == ""))
	{
		alert("메뉴 링크를 입력하십시오.");
		jQuery("#menu_link").focus();
		return;
	}
	
	switch(pgmode)
	{
		case 'A' : 
		case 'S' : 
			bizst = "add";
			msg_confirm = "메뉴를 등록하시겠습니까?";
			if(menucont_type == "B")
				msg_confirm += "\n메뉴와 함께 게시판이 생성됩니다.";
			else if(menucont_type == "C")
				msg_confirm += "\n메뉴와 함께 컨텐츠가 생성됩니다.";
			break;
		case 'M' :
			bizst = "mdf";
			msg_confirm = "메뉴를 수정하시겠습니까?";
			break;
		default :
			return;
	}
	
	data.mu_gub = jQuery("#sel_mu_gub").val();
	data.mu_site = jQuery("#sel_mu_site").val();
	data.mu_lang = jQuery("#sel_mu_lang").val();
	
	
	if(confirm(msg_confirm) == false)
		return;
	
    $.ajax({
        url 		: g_context + '/menuctgry/' + bizst + 'Sysmenu.do?srch_menu_nix=${param.srch_menu_nix}',
        type  		: "post",
        data 		: data,
        datatype	: "html",
		async 		: false,	        
        success 	: function(data){        	
    		
        	alert("저장되었습니다.");
        	fn_egov_sysmenu_list();
        },
        error: function(xhr, err){
            
        	alert("에러가 발생했습니다.\n");
        }
    });

}

function fn_egov_sysmenu_del()
{
	var objs = jQuery(":checkbox:checked"); 
	if(objs == null || objs == undefined || objs.length == 0)
	{
		alert("삭제할 메뉴를 선택해주십시오.");	
		return;
	}
	
	if(confirm("선택하신 메뉴를 삭제하시겠습니까?") == false)
		return;

	var data = new Object();
	data.menu_idx = cmmfn_concat_selector(jQuery("input[type='checkbox']:checked"), ":");
	
    $.ajax({
        url 		: g_context + '/menuctgry/rmvSysmenu.do?srch_menu_nix=${param.srch_menu_nix}',
        type  		: "post",
        data 		: data,
        datatype	: "html",
		async 		: false,	        
        success 	: function(data){        	
    		
        	alert("삭제되었습니다.");
        	fn_egov_sysmenu_list();
        },
        error: function(xhr, err){
            
        	alert("에러가 발생했습니다.\n");
        }
    });
}

function fn_egov_sysmenu_script()
{
	jQuery("#divMenuScript").toggle("slow");
	
}


function fn_egov_get_argstr()
{
	var argstr = "";
	var seltab_idx = "";
	

	if(cmmfn_exist_object("seltab_idx") == true)
		seltab_idx = jQuery("#seltab_idx").val();			
	else
		seltab_idx = "${param.seltab_idx}";

	if(cmmfn_exist_object("seltab_idx") == false && seltab_idx != "")
		argstr += "&seltab_idx=" + seltab_idx;
	
	return argstr;
}


/**************************************************************
 *  			메뉴관리 페이지 초기화 End
 **************************************************************/
 </script>

 