<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>

 <script type="text/javascript">
 
 
 /**************************************************************
  *  			코드관리 페이지 초기화 Start
  **************************************************************/
 function fn_egov_init_codeinspage()
 {
	 fn_egov_code_list();

	$( "#selectable_lv1" ).selectable({
	    
		stop: function() {
	    	$( ".ui-selected", this ).each(function() {
	    		
				var cd = getSelectedItem("selectable_lv1", "CD");
				var nindex = getSelectedItem("selectable_lv1", "NIDX");
			    var txt = getSelectedItem("selectable_lv1", "TXT");

			    if(cd == "" || cd == undefined)
			    	return; 
			    
	 			jQuery("input[name='child_gb']:eq(0)").click();
			    fn_egov_subcode_list(cd);			
				
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
			    
				jQuery("input[name='child_gb']:eq(1)").click();
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
 	jQuery("#codelist").multiselect({
 		header: true,
 		height: 240,
 		minWidth: 300,
 		autoOpen : true,
 		multiple : false,
 		checkAllText: '모두 선택',
 		uncheckAllText: '선택 해제',
 		noneSelectedText: '코드 그룹',
 		selectedText: '코드 그룹',
 		click: function(event, ui){
 	        // event handler here
 	        //ui.value; ui.text; ui.checked;
 	        fn_egov_subcode_list(ui.value);			
 			jQuery("#code_idx").val(ui.value);
 			jQuery("#code_nm").val(ui.text);
 			jQuery("#up_code_idx").val("");
 			jQuery("#code_ord").val(ui.nindex);
 			jQuery("input[name='child_gb']:eq(0)").click();
 			jQuery("input[name='job_gb']:eq(1)").click();
 	    }
 	});
 	
 	jQuery("#subcodelist").multiselect({
 		header: true,
 		height: 240,
 		minWidth: 300,
 		autoOpen : true,
 		multiple : false,
 		checkAllText: '모두 선택',
 		uncheckAllText: '선택 해제',
 		noneSelectedText: '코드 하위항목',
 		selectedText: '코드 하위항목',
 		click: function(event, ui){
 	        // event handler here
 	        //ui.value; ui.text; ui.checked;
 			jQuery("#code_idx").val(ui.value);
 			var upidx = $("#codelist").multiselect("getChecked").map(function(){
 				   return this.value;    
 				}).get();
 			jQuery("#up_code_idx").val(upidx);
 			jQuery("#code_nm").val(ui.text);
 			jQuery("#code_ord").val(ui.nindex);

 			jQuery("input[name='child_gb']:eq(1)").click();
 			jQuery("input[name='job_gb']:eq(1)").click();

 	    }
 	
 	});
 	*/
 	
 	
 	// 카테고리 / 카테고리 항목 or 등록/수정 라디오버튼 선택에 따른 처리
 	jQuery("input[name='child_gb'], input[name='job_gb']").click(function(){
 		fn_egov_procradio_code();			
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

function fn_egov_syscode_save()
{

 	var data = cmmfn_get_post_data("divMainArticle");
 	 
 	if(data.code_nm == "")
 	{
 		alert("항목명을 입력하십시오.");
 		jQuery("#code_nm").focus();
 		return;
 	}
 	
 	var bizst = "";
 	var msg_confirm = "";
 	
 	var child_gb = data.child_gb;
 	
 	if(data.job_gb == "0")
 	{
 		bizst = "add";
 		msg_confirm = "코드를 등록하시겠습니까?";
 		data.code_ord = "1";
 	}
 	else if(data.job_gb == "1")
 	{
 		bizst = "mdf";
 		msg_confirm = "코드를 수정하시겠습니까?";
 		
 		if(data.code_idx == "")
 		{
 			alert("수정하실 코드 하위항목을 선택상자에서 선택하십시오.");
 			return;
 		}
 	}
 	else
 	{
 		alert("등록 / 수정을 선택해주십시오");
 		return;
 	}
 	
 	if(confirm(msg_confirm) == false)
 		return;
 	
 	
 	$.ajax({
 		url 		: g_context + '/menuctgry/' + bizst + 'Syscode.do?srch_menu_nix=${param.srch_menu_nix}',
 		type  		: "post",
 		data 		: data,
 		datatype	: "html",
 		async 		: false,	        
 	   	success 	: function(data){        	
 		
 	    	alert("저장되었습니다.");
 	    	jQuery("#code_nm").val("");
 	    	jQuery("#code_ord").val("");
 	    	
 	    	if(child_gb == "0")
 	    		fn_egov_code_list();
 	    	else
 	    		fn_egov_subcode_list(jQuery("#up_code_idx").val());
 	    	
 	    },
 	    error: function(xhr, err){
 	        
 	    	alert("에러가 발생했습니다.\n");
 	    }
 	});

}

function fn_egov_code_list()
{
 	var data = new Object();
 	
 	$.ajax({
 		url 		: g_context + '/menuctgry/syscodeJsonList.do',
 		type  		: "post",
 		data 		: data,
 		datatype	: "json",
 		async 		: false,	        
 		success 	: function(data){        	
 			jQuery("#selectable_lv1 li").remove();
 			for(var i = 0; i < data.length; i++)
 			{
 				if(data[i].use_yn == "Y")
 					jQuery("#selectable_lv1").append("<li class=\"ui-widget-content\" id=\"" + data[i].code_idx + "\">" + data[i].code_nm + "</li>");
 				else
 					jQuery("#selectable_lv1").append("<li class=\"ui-widget-content ui-state-disabled\" id=\"" + data[i].code_idx + "\">" + data[i].code_nm + "</li>");
 			}
 			
 			if(data.length == 0)
 				jQuery("#selectable_lv1").append("<li>등록된 코드그룹이 없습니다.</li>");
 		},
 	    error: function(xhr, err){
 	         
 	    	alert("코드 정보를 가져오는 도중 오류가 발생했습니다.\n");
 	    }
 	});
}

function fn_egov_subcode_list(up_code_idx)
{
 	var data = new Object();
 	data.up_code_idx = up_code_idx;
 	
 	$.ajax({
 		url 		: g_context + '/menuctgry/syscodeJsonList.do',
 		type  		: "post",
 		data 		: data,
 		datatype	: "json",
 		async 		: false,	        
 	    success 	: function(data){        	

	     	jQuery("#selectable_lv2 li").remove();
 			for(var i = 0; i < data.length; i++)
 			{
 				if(data[i].use_yn == "Y")
					jQuery("#selectable_lv2").append("<li class=\"ui-widget-content\" id=\"" + data[i].code_idx + "\">" + data[i].code_nm + "</li>");
 				else
					jQuery("#selectable_lv2").append("<li class=\"ui-widget-content ui-state-disabled\" id=\"" + data[i].code_idx + "\">" + data[i].code_nm + "</li>");
 			}
 	
 		},
 	    error: function(xhr, err){
 	         
 	     	alert("코드 하위항목 정보를 가져오는 도중 오류가 발생했습니다.\n");
 	    }
 	});
 	
}


function fn_egov_procradio_code()
{
 	var child_gb = jQuery("input[name='child_gb']:checked").val();
 	var job_gb = jQuery("input[name='job_gb']:checked").val();
 	
 	var upidx = ""; 	
 	
 	// 등록 클릭
 	if(job_gb == "0")
 	{
 		jQuery("#code_idx").val("");	
 		jQuery("#code_nm").val("");	
 		jQuery("#code_ord").val("");
 		
 		// 코드그룹 등록인 경우
 		if(child_gb == "0")
 		{
 			jQuery("#up_code_idx").val("");	
 		}
 		
 		// 코드 하위항목 등록인 경우
 		else
 		{
			upidx = getSelectedItem("selectable_lv1", "CD");
 			jQuery("#up_code_idx").val(upidx);
 		}
 		
		jQuery("input[name='use_yn']:eq(0)").click();
 		jQuery("#code_nm").focus();
 	}
 	
 	// 수정 클릭
 	else 
 	{
 		// 코드 수정인 경우
 		if(child_gb == "0")
 		{
			var idx = getSelectedItem("selectable_lv1", "CD");
			var nm = getSelectedItem("selectable_lv1", "TXT");
			var ord = getSelectedItem("selectable_lv1", "NIDX");
			
 			jQuery("#code_idx").val(idx);	
 			jQuery("#code_nm").val(nm);	
 			jQuery("#code_ord").val(ord);	
 			jQuery("#up_code_idx").val("");

 		}
 		
 		// 코드 하위항목 수정인 경우
 		else
 		{
			var idx = getSelectedItem("selectable_lv2", "CD");
			var nm = getSelectedItem("selectable_lv2", "TXT");
			var ord = getSelectedItem("selectable_lv2", "NIDX");

			upidx = getSelectedItem("selectable_lv1", "CD");
 			
 			jQuery("#code_idx").val(idx);	
 			jQuery("#code_nm").val(nm);	
 			jQuery("#code_ord").val(ord);	
 			jQuery("#up_code_idx").val(upidx);	
 			
 		}	
 		
 	}
}

function fn_egov_syscode_del()
{
 	var child_gb = jQuery("input[name='child_gb']:checked").val();

 	var nm = "";
 	var idx = "";
 	
 	// 코드 삭제
 	if(child_gb == "0")
 	{
		
		nm = getSelectedItem("selectable_lv1", "TXT");
		idx = getSelectedItem("selectable_lv1", "CD");	
 		
 		if(idx == "")
 		{
 			alert("삭제할 코드를 선택해주십시오.");
 			return;
 		}
 		
 		if(confirm("코드 그룹 [ " + nm + " ] 과 그 하위 항목들을 삭제하시겠습니까?") == false)
 			return;
 		
 		
 	}
 	
 	// 코드 하위항목 삭제
 	else if(child_gb == "1")
 	{
		nm = getSelectedItem("selectable_lv2", "TXT");	
		idx = getSelectedItem("selectable_lv2", "CD");	

 		if(idx == "")
 		{
 			alert("삭제할 코드 하위항목을 선택해주십시오.");
 			return;
 		}
 		
 		if(confirm("코드 하위항목 [ " + nm + " ] 를 삭제하시겠습니까?") == false)
 			return;

 	}
 	
 	var  data = new Object();
 	data.code_idx = idx + "";
 	
 	$.ajax({
 		url 		: g_context + '/menuctgry/rmvSyscode.do?srch_menu_nix=${param.srch_menu_nix}',
 		type  		: "post",
 		data 		: data,
 		datatype	: "text",
 		async 		: false,	        
 		success 	: function(data){        	
      		alert("삭제되었습니다.");
      		
      		// 코드삭제인 경우
      		if(child_gb == "0")
      		{
      			fn_egov_code_list();
     			jQuery("#selectable_lv2 li").remove();
      		}
 	     	
      		// 코드항목 삭제인 경우 
 	     	else if(child_gb == "1")
 	     	{
	     		var up_idx = getSelectedItem("selectable_lv1", "CD");	   		
 	     		fn_egov_subcode_list(up_idx.toString());
 	     	}
 		},
     	error: function(xhr, err){
      		alert("삭제 도중 오류가 발생했습니다.\n");
      	}
 	});
 	
 }

 
 /**************************************************************
  *  			코드관리 페이지 초기화 End
  **************************************************************/
</script>


 