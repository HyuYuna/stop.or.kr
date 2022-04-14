<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>




<!--
	권한관리 스크립트
	2013.04.16 bhhan
-->	
<script type="text/javascript">
/**************************************************************
 *  			권한관리 페이지 초기화 Start
 **************************************************************/
function fn_egov_init_authinspage()
{
	// 권한 목록 조회
	fn_egov_auth_list();
	
	$( "#selectable_lv1" ).selectable({
	    
		stop: function() {
	    	$( ".ui-selected", this ).each(function() {
	    		
				var cd = getSelectedItem("selectable_lv1", "CD");
				var nindex = getSelectedItem("selectable_lv1", "NIDX");
			    var txt = getSelectedItem("selectable_lv1", "TXT");
			    
			    fn_egov_subauth_list(cd);			
				if(cd.startsWith("M"))
					jQuery("#spanAuthInfomation").html("관리자 페이지에 접근할 수 있는 관리자 권한입니다.");
				else if(cd.startsWith("B"))
					jQuery("#spanAuthInfomation").html("사용자 컨텐츠를 관리할 수 있는 권한입니다. (관리자페이지 접근 불가)");
				else if(cd.startsWith("U"))
					jQuery("#spanAuthInfomation").html("일반 사용자권한으로 사용자 페이지에 대한 제한된 권한을 갖습니다. ");
				else if(cd.startsWith("G"))
					jQuery("#spanAuthInfomation").html("손님권한으로 사용자 페이지에 대한 매우 제한된 권한을 갖습니다. ");
				
				//jQuery("input[name='child_gb']:eq(0)").click();
				jQuery("input[name='job_gb']:eq(1)").click();

				////////////////////////////////////////////////////////////
			    // 사용여부에 따른 (사용여부) 라디오버튼 표시
			    var cls = $(this).prop("class");
			    if(cls.indexOf("ui-state-disabled") >= 0)
			    	jQuery("input[name='use_yn']:eq(1)").click();
			    else
			    	jQuery("input[name='use_yn']:eq(0)").click();
				////////////////////////////////////////////////////////////
				
         	});
        }
	});
	
	$( "#selectable_lv2" ).selectable({
	    
		stop: function() {
			
			$( ".ui-selected", this ).each(function() {

				var cd = getSelectedItem("selectable_lv2", "CD");
				var upcd = getSelectedItem("selectable_lv1", "CD");
				var nindex = getSelectedItem("selectable_lv2", "NIDX");
			    var txt = getSelectedItem("selectable_lv2", "TXT");
			    
				//jQuery("input[name='child_gb']:eq(1)").click();
				jQuery("input[name='job_gb']:eq(1)").click();
				
				
				////////////////////////////////////////////////////////////
			    // 사용여부에 따른 (사용여부) 라디오버튼 표시
			    var cls = $(this).prop("class");
			    if(cls.indexOf("ui-state-disabled") >= 0)
			    	jQuery("input[name='use_yn']:eq(1)").click();
			    else
			    	jQuery("input[name='use_yn']:eq(0)").click();
				////////////////////////////////////////////////////////////

          	});
        }
	});
	

/*
	jQuery("#authlist").multiselect({
		header: true,
		height: 240,
		minWidth: 300,
		autoOpen : true,
		multiple : false,
		checkAllText: '모두 선택',
		uncheckAllText: '선택 해제',
		noneSelectedText: '권한 그룹',
		selectedText: '권한 그룹',
		click: function(event, ui){
	        // event handler here
	        //ui.value; ui.text; ui.checked;
	        fn_egov_subauth_list(ui.value);			
			jQuery("#auth_cd").val(ui.value);
			jQuery("#auth_nm").val(ui.text);
			jQuery("#up_auth_cd").val("");
			jQuery("#auth_ord").val(ui.nindex);
			//jQuery("input[name='child_gb']:eq(0)").click();
			jQuery("input[name='job_gb']:eq(1)").click();
			
			if(ui.value.startsWith("M"))
				jQuery("#spanAuthInfomation").html("관리자 페이지에 접근할 수 있는 관리자 권한입니다.");
			else if(ui.value.startsWith("B"))
				jQuery("#spanAuthInfomation").html("사용자 컨텐츠를 관리할 수 있는 권한입니다. (관리자페이지 접근 불가)");
			else if(ui.value.startsWith("U"))
				jQuery("#spanAuthInfomation").html("일반 사용자권한으로 사용자 페이지에 대한 제한된 권한을 갖습니다. ");
	    }
	});
	
	jQuery("#subauthlist").multiselect({
		header: true,
		height: 240,
		minWidth: 300,
		autoOpen : true,
		multiple : false,
		checkAllText: '모두 선택',
		uncheckAllText: '선택 해제',
		noneSelectedText: '권한 하위항목',
		selectedText: '권한 하위항목',
		click: function(event, ui){
	        // event handler here
	        //ui.value; ui.text; ui.checked;
			jQuery("#auth_cd").val(ui.value);
			var upidx = $("#authlist").multiselect("getChecked").map(function(){
				   return this.value;    
				}).get();
			jQuery("#up_auth_cd").val(upidx);
			jQuery("#auth_nm").val(ui.text);
			jQuery("#auth_ord").val(ui.nindex);

			//jQuery("input[name='child_gb']:eq(1)").click();
			jQuery("input[name='job_gb']:eq(1)").click();

	    }
	});
	*/
	

	jQuery("#tblDlgAuthmenuMan").jqGrid({        
	   	url:'',
		datatype: "json",
	   	colNames:['메뉴ID', '메뉴명', '메뉴LV', '메뉴사용 여부'],
	   	colModel:[
	   		{name:'menu_idx',index:'menu_idx', hidden:true},
	   		{name:'menu_nm',index:'menu_nm', width:350},
  	   		{name:'menu_lv',index:'menu_lv', hidden:true},
	   		{name:'auth_yn',index:'auth_yn', width:120, align:'center'}		
	   	],
	   	ajaxGridOptions: {cache: false},
	   	width:380,
	   	height: 460,
	   	sortname: 'id',
	    sortorder: "desc",
	    caption:"관리자 메뉴",
	    multiselect: true
	});


	jQuery("#tblDlgAuthmenuUsr").jqGrid({        
	   	url:'',
		datatype: "json",
	   	colNames:['메뉴ID', '메뉴명', '메뉴LV', '메뉴사용 여부'],
	   	colModel:[
  	   		{name:'menu_idx',index:'menu_idx', hidden:true},
	   		{name:'menu_nm',index:'menu_nm', width:350},
  	   		{name:'menu_lv',index:'menu_lv', hidden:true},
	   		{name:'auth_yn',index:'auth_yn', width:120, align:'center'}		
	   	],
	   	ajaxGridOptions: {cache: false},
	   	width:380,
	   	height: 460,
	   	sortname: 'id',
	    sortorder: "desc",
	    caption:"사용자 메뉴",
	    multiselect: true
	});


	// 권한 메뉴 설정 폼 초기화
	jQuery("#divDlgAuthmenu")
		.css('font-size', '0.8em')	
		.dialog({
			title : '권한별 메뉴 설정',
			autoOpen : false,
			modal : true,
			width : 830,
			height : 650,
			buttons : [ 
					{ text: "저장", click: function() { fn_egov_authmenu_save($(this)); } },
			        { text: "닫기", click: function() { $(this).dialog("close"); } } 
			],
			close : function (event, ui){
				fn_egov_sysauth_menuhide();
			}
		});

	
	// 카테고리 / 카테고리 항목 or 등록/수정 라디오버튼 선택에 따른 처리
	jQuery("input[name='child_gb'], input[name='job_gb']").click(function(){
		fn_egov_procradio_auth();			
	});
			

}

function getSelectedItem(id, type)
{
	var nidx = 0;
	var txt = "";
	var code = "";
	jQuery( ".ui-selected", jQuery("#" + id) ).each(function() {
		nidx = $( "#" + id + " li" ).index( this ) + 1;
		code = $(this).attr("id");
	    txt = cmmfn_str_trim($(this).html());
	});
	
	var returnval = "";
	
	switch(type)
	{
		case "TXT" : returnval = txt; break; 
		case "CD" : returnval = code; break; 
		case "NIDX" : returnval = nidx; break; 
	
	}
	
	return returnval;
	
}


function fn_egov_sysauth_save()
{
	var data = cmmfn_get_post_data("divMainArticle");
	
	if(data.auth_nm == "")
	{
		alert("항목명을 입력하십시오.");
		jQuery("#auth_nm").focus();
		return;
	}
	
	var bizst = "";
	var msg_confirm = "";
	
	var child_gb = data.child_gb;
	
	if(data.job_gb == "0")
	{
		bizst = "add";
		msg_confirm = "권한을 등록하시겠습니까?";
		data.auth_ord = "1";
	}
	else if(data.job_gb == "1")
	{
		bizst = "mdf";
		msg_confirm = "권한을 수정하시겠습니까?";
		
		if(data.auth_cd == "")
		{
			alert("수정하실 권한 하위항목을 선택상자에서 선택하십시오.");
			return;
		}
	}
	
	if(confirm(msg_confirm) == false)
		return;
	
	$.ajax({
		url 		: g_context + '/menuctgry/' + bizst + 'Sysauth.do?srch_menu_nix=${param.srch_menu_nix}',
		type  		: "post",
		data 		: data,
		datatype	: "html",
		async 		: false,	        
		success 	: function(data){        	
		
	    	alert("저장되었습니다.");
	    	jQuery("#auth_nm").val("");
	    	jQuery("#auth_ord").val("");
	    	
	    	if(child_gb == "0")
	    		fn_egov_auth_list();
	    	else
	    		fn_egov_subauth_list(jQuery("#up_auth_cd").val());
	    	
	    },
	    error: function(xhr, err){
	        
	    	alert("에러가 발생했습니다.\n");
	    }
	});

}

function fn_egov_auth_list()
{
	var data = new Object();
	
	$.ajax({
		url 		: g_context + '/menuctgry/sysauthJsonList.do?srch_menu_nix=${param.srch_menu_nix}',
		type  		: "post",
		data 		: data,
		datatype	: "json",
		async 		: false,	        
		success 	: function(data){        	
	     	jQuery("#selectable_lv1 li").remove();
			for(var i = 0; i < data.length; i++)
			{
				//jQuery("#authlist").append("<option value='" + data[i].auth_cd + "'>" + data[i].auth_nm + "</option>");
				if(data[i].use_yn == "Y")
					jQuery("#selectable_lv1").append("<li class=\"ui-widget-content\" id=\"" + data[i].auth_cd + "\">" + data[i].auth_nm + "</li>");
				else
					jQuery("#selectable_lv1").append("<li class=\"ui-widget-content ui-state-disabled\" id=\"" + data[i].auth_cd + "\">" + data[i].auth_nm + "</li>");
			}
			
		},
	    error: function(xhr, err){
	         
	    	alert("권한 정보를 가져오는 도중 오류가 발생했습니다.\n");
	    }
	});
}

function fn_egov_subauth_list(up_auth_cd)
{
	var data = new Object();
	data.up_auth_cd = up_auth_cd;
	
	$.ajax({
		url 		: g_context + '/menuctgry/sysauthJsonList.do?srch_menu_nix=${param.srch_menu_nix}',
		type  		: "post",
		data 		: data,
		datatype	: "json",
		async 		: false,	        
	    success 	: function(data){        	

	     	jQuery("#selectable_lv2 li").remove();
			for(var i = 0; i < data.length; i++)
			{
				if(data[i].use_yn == "Y")
					jQuery("#selectable_lv2").append("<li class=\"ui-widget-content\" id=\"" + data[i].auth_cd + "\">" + data[i].auth_nm + "</li>");
				else
					jQuery("#selectable_lv2").append("<li class=\"ui-widget-content ui-state-disabled\" id=\"" + data[i].auth_cd + "\">" + data[i].auth_nm + "</li>");

			}
		},
	    error: function(xhr, err){
	         
	     	alert("권한 하위항목 정보를 가져오는 도중 오류가 발생했습니다.\n");
	    }
	});
	
}


function fn_egov_procradio_auth()
{
	var child_gb = jQuery("input[name='child_gb']:checked").val();
	var job_gb = jQuery("input[name='job_gb']:checked").val();

	var upidx = ""; 
	
	// 등록 클릭
	if(job_gb == "0")
	{
		jQuery("#auth_cd").val("");	
		jQuery("#auth_nm").val("");	
		jQuery("#auth_ord").val("");
		
		// 권한그룹 등록인 경우
		if(child_gb == "0")
		{
			jQuery("#up_auth_cd").val("");	
		}
		
		// 권한 하위항목 등록인 경우
		else
		{
			upidx = getSelectedItem("selectable_lv1", "CD");
			jQuery("#up_auth_cd").val(upidx);
		}
		
		jQuery("input[name='use_yn']:eq(0)").click();
		jQuery("#auth_nm").focus();
	}
	
	// 수정 클릭
	else 
	{
		// 권한 수정인 경우
		if(child_gb == "0")
		{
			var idx = getSelectedItem("selectable_lv1", "CD");
			var nm = getSelectedItem("selectable_lv1", "TXT");
			var ord = getSelectedItem("selectable_lv1", "NIDX");
			
			jQuery("#auth_cd").val(idx);	
			jQuery("#auth_nm").val(nm);	
			jQuery("#auth_ord").val(ord);	
			jQuery("#up_auth_cd").val("");

		}
		
		// 권한 하위항목 수정인 경우
		else
		{
			var idx = getSelectedItem("selectable_lv2", "CD");
			var nm = getSelectedItem("selectable_lv2", "TXT");
			var ord = getSelectedItem("selectable_lv2", "NIDX");
			
			upidx = getSelectedItem("selectable_lv1", "CD");
			
			jQuery("#auth_cd").val(idx);	
			jQuery("#auth_nm").val(nm);	
			jQuery("#auth_ord").val(ord);	
			jQuery("#up_auth_cd").val(upidx);	
			
		}	
		
	}
}

function fn_egov_sysauth_del()
{
	var child_gb = jQuery("input[name='child_gb']:checked").val();

	var nm = "";
	var idx = "";
	
	// 권한 삭제
	if(child_gb == "0")
	{
		
		nm = getSelectedItem("selectable_lv1", "TXT");
		idx = getSelectedItem("selectable_lv1", "CD");	
		
		if(idx == "")
		{
			alert("삭제할 권한를 선택해주십시오.");
			return;
		}
		
		if(confirm("권한 그룹 [ " + nm + " ] 과 그 하위 항목들을 삭제하시겠습니까?") == false)
			return;
		
		
	}
	
	// 권한 하위항목 삭제
	else if(child_gb == "1")
	{
		nm = getSelectedItem("selectable_lv2", "TXT");	
		idx = getSelectedItem("selectable_lv2", "CD");	
		
		if(idx == "")
		{
			alert("삭제할 권한 하위항목을 선택해주십시오.");
			return;
		}
		
		if(confirm("권한 하위항목 [ " + nm + " ] 를 삭제하시겠습니까?") == false)
			return;

	}
	
	var  data = new Object();
	data.auth_cd = idx + "";
	
	$.ajax({
		url 		: g_context + '/menuctgry/rmvSysauth.do?srch_menu_nix=${param.srch_menu_nix}',
		type  		: "post",
		data 		: data,
		datatype	: "text",
		async 		: false,	        
		success 	: function(data){        	
     		alert("삭제되었습니다.");
     		
     		// 권한삭제인 경우
     		if(child_gb == "0")
     		{
     			fn_egov_auth_list();
     			jQuery("#selectable_lv2 li").remove();
     		}
	     	
     		// 권한항목 삭제인 경우 
	     	else if(child_gb == "1")
	     	{
	     		var up_idx = getSelectedItem("selectable_lv1", "CD");	   		
	     		fn_egov_subauth_list(up_idx);
	     	}
		},
		
    	error: function(xhr, err){
     		alert("삭제 도중 오류가 발생했습니다.\n");
     	}
	});
	
}

// 권한별 메뉴설정 다이얼로그 보이기
function fn_egov_sysauth_menushow()
{
	var nm = getSelectedItem("selectable_lv2", "TXT");	   		
	var auth_cd = getSelectedItem("selectable_lv2", "CD");	   		
	var up_auth_cd = getSelectedItem("selectable_lv1", "CD");	   		
	
	if(nm == "")
	{
		alert("사용 가능 메뉴를 설정할 권한 하위항목을\n오른쪽 선택상자에서 선택하십시오.");
		return;
	}
	
	jQuery("#divDlgAuthmenu")
		.dialog("option", {title: "[ " + nm + " ] 권한 으로 사용가능한 메뉴 설정"});
	 
	// 관리자인 경우에만 관리자 메뉴를 보여준다.
	if(up_auth_cd.startsWith("D") || up_auth_cd.startsWith("M"))
	{
		// 관리자 메뉴 설정 가져오기
		fn_get_authmenulist('tblDlgAuthmenuMan', 'MAN', auth_cd);
	}
	else 
	{
		jQuery("#tblDlgAuthmenuMan").clearGridData(true);	
	}
	
	// 사용자 메뉴 설정 가져오기
	fn_get_authmenulist('tblDlgAuthmenuUsr', 'USR', auth_cd);
	
	//fn_multiselect_showhide("close");
	jQuery("#divDlgAuthmenu").dialog("open");
}

//권한별 메뉴설정 다이얼로그 숨기기
function fn_egov_sysauth_menuhide()
{
	//fn_multiselect_showhide("open");
}

function fn_multiselect_showhide(flag)
{
	/*
	사용하지 않음
	$("#authlist").multiselect(flag);
	$("#subauthlist").multiselect(flag);
	*/
}

// 권한별 메뉴설정을 가져온다.
function fn_get_authmenulist(gridid, mu_gub, auth_cd)
{
	jQuery("#" + gridid).jqGrid("resetSelection");

	$.ajax({
		url 		: g_context + '/menuctgry/sysauthmenuJsonList.do?srch_menu_nix=${param.srch_menu_nix}',
		type  		: 'post',
		data 		: {
			mu_gub : mu_gub,
			auth_cd : auth_cd
		},
		datatype	: "json",
		async 		: false,	        
		success 	: function(data){        	
			
			// 가져온 메뉴목록을 grid에 insert함.
			jQuery("#" + gridid).clearGridData(true);
			for(var i = 0; i < data.length; i++)
			{
				// 레벨에 따른 들여쓰기 설정
				var addblank = "";
				for(var j = 0; j < (parseInt(data[i].menu_lv) - 1) * 4; j++)
				{
					addblank += " ";
				}
				
				var datarow = {
						menu_idx : data[i].menu_idx, 
						menu_nm : addblank + data[i].menu_nm, 
						menu_lv : data[i].menu_lv, 
						auth_yn : (data[i].auth_yn == "Y") ? "O" : "X"
					};
				jQuery("#" + gridid).jqGrid("addRowData", data[i].menu_idx, datarow, 'last');
				
				if(data[i].auth_yn == 'Y')
					jQuery("#" + gridid).jqGrid("setSelection", data[i].menu_idx);
			}
		},
    	error: function(xhr, err){
     		alert("조회도중 오류가 발생했습니다.\n");
     	}
	});
	
}

// 권한 메뉴를 저장한다.
function fn_egov_authmenu_save(obj)
{
	var idsMan = jQuery("#tblDlgAuthmenuMan").jqGrid('getGridParam','selarrrow');
	var idsUsr = jQuery("#tblDlgAuthmenuUsr").jqGrid('getGridParam','selarrrow');
	
	// 선택된 관리자 / 사용자 메뉴ID 합체 !!
	jQuery.merge(idsMan, idsUsr);
	
	var idx = getSelectedItem("selectable_lv2", "CD");	   			
	
	if(confirm("현재 권한에 대한 사용가능 메뉴를 설정하시겠습니까? ") == false)
		return;
	
	$.ajax({
		url 		: g_context + '/menuctgry/addSysauthmenu.do?srch_menu_nix=${param.srch_menu_nix}',
		type  		: 'post',
		data 		: {
			auth_cd : idx,
			menuList : idsMan.toString()
		},
		datatype	: "json",
		async 		: false,	        
		success 	: function(data){        	
			alert("메뉴에 대한 권한이 설정되었습니다.");

			var auth_cd = getSelectedItem("selectable_lv2", "CD");	   		
			
			if(auth_cd.startsWith("M") == true || auth_cd.startsWith("D") == true)
				fn_get_authmenulist("tblDlgAuthmenuMan", "MAN", auth_cd);
			fn_get_authmenulist("tblDlgAuthmenuUsr", "USR", auth_cd);
		},
    	error: function(xhr, err){
     		alert("메뉴 권한 설정 도중 오류가 발생했습니다.\n");
     	}
	});
		
}


/**************************************************************
 *  			권한관리 페이지 초기화 End
 **************************************************************/

</script>

