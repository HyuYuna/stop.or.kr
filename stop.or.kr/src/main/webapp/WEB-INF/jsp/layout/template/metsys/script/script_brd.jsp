<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!--
	게시판관리 스크립트
	2013.04.16 bhhan
-->	
<script type="text/javascript">



/**************************************************************
 *  			게시판관리 페이지 초기화 Start
 **************************************************************/
function fn_egov_init_brdinspage()
{
// 	if(lg_srch_menu_nix.indexOf("794x409U") < 0)
// 		return;
	
	//jQuery(".brdsetTypeDetail").hide();
	
	if(jQuery("#edomweivgp").val() == "M")
	{
		jQuery("#sel_mu_site").val(jQuery("#mu_site").val());
		jQuery("#sel_mu_lang").val(jQuery("#mu_lang").val());
	}
	else
	{
		jQuery("#sel_mu_site").val(jQuery("#srch_mu_site").val());
		jQuery("#sel_mu_lang").val(jQuery("#srch_mu_lang").val());
	}
	
	jQuery("#btnRefmenuDel").on("click", fn_egov_refmenu_del);
	jQuery("#brd_id, #writer, #wdt").prop("readonly", true);
	jQuery("#brd_nm").focus();

	jQuery("input[name='editor_gb']").click(function() {
		jQuery("#iframeEditor").prop("src", "${pageContext.request.contextPath}/template/metsys/bd/editorView.stpg?editor_gb=" + $(this).val());
	});

	// 카테고리 선택		
	if (jQuery("#use_ctgry").val() == "N")
		jQuery("#ctgry_idx").prop("disabled", true);

	jQuery("#use_ctgry").change(function(){
		var ch = $(this).val();

		if (ch == "Y") 
		{
			jQuery("#ctgry_idx").prop("disabled", false);
		} 
		else 
		{
			jQuery("#ctgry_idx option:eq(0)").prop("selected", true);
			jQuery("#ctgry_idx").prop("disabled", true);
		}
	});
	
	cmmfn_remove_scrtag(jQuery("#info_cont"));
	cmmfn_init_editor("info_cont", "A", 400);

	
	jQuery("#brd_gb").change(function() {
		var gb = $(this).val();
		fn_egov_brdgb_set(gb);
	});
	
	/*
	jQuery("#brd_gb").change(function() {
		var gb = $(this).val();
		fn_egov_thumbnail_set(gb);
	});

	fn_egov_thumbnail_set(jQuery("#brd_gb").val());
	*/
	
	<c:choose>
		<c:when test="${boardinfoVO.edomweivgp eq 'A'}">
			// 게시판 추가일때 초기화
		</c:when>
		<c:otherwise>
			// 게시판 정보 변경일때 초기화
			//jQuery("#brd_gb").prop("disabled", true);  // 게시판 종류는 수정할 수 없음
			//jQuery("#reply_gb").prop("disabled", true);  // 답글 종류는 수정할 수 없음
		</c:otherwise>
	</c:choose>
	
	
	jQuery("#selBrdsetType").change(function(){
		var val = $(this).val();
		if(val == "C")
		{
			jQuery(".brdsetTypeDetail").fadeOut('slow');
		}
		else
		{
			jQuery(".brdsetTypeDetail").fadeIn('slow');
		}
	});

	// 트리테이블 적용
	if(cmmfn_exist_object("tableModebdList") == true)
	{
		jQuery("#tableModebdList").treetable({ expandable: true, column : 1, indent : 18 });
		jQuery("#tableModebdList").treetable("expandAll");
	}
	
} 

function fn_egov_brd_add()
{
	var form = reqForm;
	form.edomweivgp.value = "A";
	fn_egov_move_action(form, "/modebd/modebdView.do?srch_menu_nix=${param.srch_menu_nix}" + fn_egov_get_argstr());		
}

function fn_egov_brd_mod(brd_id)
{
	var form = reqForm;
	form.edomweivgp.value = "M";
	fn_egov_move_action(form, "/modebd/modebdView.do?srch_menu_nix=${param.srch_menu_nix}" + "&brd_id=" + brd_id + fn_egov_get_argstr());		
}


function fn_egov_brd_save() {
	var form = document.reqForm;
	var pvmode = form.edomweivgp.value;

	var data = cmmfn_get_post_data("body");
	if (data.brd_nm == "") {
		alert("게시판 명을 입력해주십시오.");
		form.brd_nm.focus();
		return;
	}
	if (data.brd_dft == "") {
		alert("게시판 설명을 입력해주십시오.");
		form.brd_dft.focus();
		return;
	}
	
	data.mu_site = jQuery("#sel_mu_site").val();
	data.mu_lang = jQuery("#sel_mu_lang").val();
	
	var url = g_context; 
	
	if (pvmode == "A") 
	{
		if (confirm("게시판을 생성하시겠습니까?") == false)
			return;
		
		url += "/modebd/addBoardinfo.do?srch_menu_nix=${param.srch_menu_nix}" + fn_egov_get_argstr();
	} 
	else if (pvmode == "M") 
	{
		if (confirm("변경된 설정을 저장하시겠습니까?") == false)
			return;

		url += "/modebd/mdfBoardinfo.do?srch_menu_nix=${param.srch_menu_nix}" + fn_egov_get_argstr();
	}
	
	  $.ajax({
	      url 		: url,
	      type  		: "post",
	      data 		:  $('body').find('form').serialize(),
	      datatype	: "json",
			async 		: false,	        
	      success 	: function(data){        	
				
			alert("저장되었습니다");
			fn_egov_brd_list();

	      },
	      
	      error: function(){
	          
	      	alert("에러가 발생했습니다.");
	      }
	  });
	
}

function fn_egov_brd_list() {
	var form = document.reqForm;
	if(cmmfn_exist_object("brd_auth_usr") == true)
		form.brd_auth_usr.value = "";
	
	if(seltab_idx == "1")
	{
		fn_egov_move_action(form, "/modebd/modebdmenuList.do?srch_menu_nix=${param.srch_menu_nix}" + fn_egov_get_argstr());
	}
	else
	{
		fn_egov_move_action(form, "/modebd/modebdList.do?srch_menu_nix=${param.srch_menu_nix}" + fn_egov_get_argstr());
	}
}


function fn_egov_brd_del()
{
	if(confirm("게시판을 삭제하시겠습니까?\n작성된 데이터들은 모두 영구히 삭제되며\n삭제된 데이터는 복구되지 않습니다.") == false)
		return;
	
	var form = reqForm;
	fn_egov_move_action(form, "/modebd/rmvBoardinfo.do?srch_menu_nix=${param.srch_menu_nix}" + fn_egov_get_argstr());		
}

function fn_egov_thumbnail_set(gb) {
	
	// 썸네일 게시판
	if (gb == "CDIDX00044")
	{
		jQuery("#reply_gb option:eq(1)").prop("selected", true);
		jQuery("#trSeleditorArea").slideUp(500);
		jQuery("#trSelPreviewAreaG").hide();
		jQuery("#trSelPreviewAreaT").show();
		jQuery("#trSelPreviewAreaD").hide();
		jQuery("#attach_cnt").val("1");
	
	}
	
	// 일정게시판
	else if (gb == "CDIDX00045") 
	{
		jQuery("#reply_gb option:eq(3)").prop("selected", true);
		jQuery("#trSeleditorArea").slideUp(500);
		jQuery("#trSelPreviewAreaG").hide();
		jQuery("#trSelPreviewAreaT").hide();
		jQuery("#trSelPreviewAreaD").show();
		jQuery("#attach_cnt").val("1");
	}

	// 일반 게시판
	else 
	{
		jQuery("#reply_gb option:eq(0)").prop("selected", true);
		jQuery("#trSeleditorArea").slideDown(500);
		jQuery("#trSelPreviewAreaG").show();
		jQuery("#trSelPreviewAreaT").hide();
		jQuery("#trSelPreviewAreaD").hide();
		jQuery("#attach_cnt").val("5");
	}

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


function fn_egov_refmenu_del()
{
	if(confirm("현재 게시판과 메뉴의 연동정보를 삭제하시겠습니까 ?") == false)
		return false;
	
	var brd_id = jQuery("#brd_id").val();
	
	$.ajax({
	    url 		: g_context + '/modebd/rmvRef_srch_menu_nix.do?srch_menu_nix=${param.srch_menu_nix}',
	    type  		: "post",
	    data 		: {
	    	brd_id : brd_id
	    },
	    datatype	: "json",
		async 		: false,	        
	    success 	: function(data){        	
		
	    	alert("삭제되었습니다.");
	    	fn_egov_brd_mod(brd_id);
	    },
	    error: function(){
	        
	    	alert("에러가 발생했습니다.");
	    }
	});
}

function fn_egov_brdgb_set(brd_gb)
{
	jQuery("#attach_cnt_limit")
		.prop("readonly", false)
		.val("5");

	jQuery("#attach_size_limit")
		.prop("readonly", false)
		.val("20");

	if(brd_gb == "CDIDX00042")
	{
		jQuery("#reply_gb option:first").prop("selected", true);		
		jQuery("#on_viewmode option:eq(0)").prop("selected", true);		
		jQuery("#off_viewmode option:eq(1)").prop("selected", true);		
		jQuery("#use_atch option:eq(1)").prop("selected", true);		
	}
	else if(brd_gb == "CDIDX00043")
	{
		jQuery("#reply_gb option:last").prop("selected", true);		
		jQuery("#on_viewmode option:eq(1)").prop("selected", true);		
		jQuery("#off_viewmode option:eq(1)").prop("selected", true);		
		jQuery("#use_atch option:eq(0)").prop("selected", true);		
	}
	else if(brd_gb == "CDIDX00044")
	{
		jQuery("#reply_gb option:eq(1)").prop("selected", true);		
		jQuery("#on_viewmode option:eq(0)").prop("selected", true);		
		jQuery("#off_viewmode option:eq(1)").prop("selected", true);		
		jQuery("#use_atch option:eq(1)").prop("selected", true);	
	}
	else if(brd_gb == "CDIDX00045")
	{
		jQuery("#reply_gb option:last").prop("selected", true);		
		jQuery("#on_viewmode option:eq(1)").prop("selected", true);		
		jQuery("#off_viewmode option:eq(0)").prop("selected", true);		
		jQuery("#use_atch option:eq(0)").prop("selected", true);		
	}
	else if(brd_gb == "CDIDX00046")
	{
		jQuery("#reply_gb option:first").prop("selected", true);		
		jQuery("#on_viewmode option:eq(0)").prop("selected", true);		
		jQuery("#off_viewmode option:eq(0)").prop("selected", true);		
		jQuery("#use_atch option:eq(1)").prop("selected", true);		
	}	
	
}

/**************************************************************
 *  			게시판관리 페이지 초기화 End
 **************************************************************/

 
</script>

