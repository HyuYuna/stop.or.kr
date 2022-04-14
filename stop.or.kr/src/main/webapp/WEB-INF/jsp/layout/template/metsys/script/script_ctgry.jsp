<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>


<script type="text/javascript">
/**************************************************************
 *  			카테고리 페이지 초기화 Start
 **************************************************************/
function fn_egov_init_ctgryinspage()
{
 	// 카테고리 목록 조회
 	fn_egov_category_list();
 	
	$( "#selectable_lv1" ).selectable({
	    
		stop: function() {
	    	$( ".ui-selected", this ).each(function() {
	    		
				var cd = getSelectedItem("selectable_lv1", "CD");
				var nindex = getSelectedItem("selectable_lv1", "NIDX");
			    var txt = getSelectedItem("selectable_lv1", "TXT");
			    if(cd == "" || cd == undefined)
			    	return; 
			    
			    fn_egov_subcategory_list(cd);			
				
	 			jQuery("input[name='child_gb']:eq(0)").click();
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
 	jQuery("#ctgrylist").multiselect({
 		header: true,
 		height: 240,
 		minWidth: 300,
 		autoOpen : true,
 		multiple : false,
 		checkAllText: '모두 선택',
 		uncheckAllText: '선택 해제',
 		noneSelectedText: '카테고리 그룹',
 		selectedText: '카테고리 그룹',
 		click: function(event, ui){
 	        // event handler here
 	        //ui.value; ui.text; ui.checked;
 	        fn_egov_subcategory_list(ui.value);
 			
 			jQuery("#ctgry_idx").val(ui.value);
 			jQuery("#ctgry_nm").val(ui.text);
 			jQuery("#up_ctgry_idx").val("");
 			jQuery("#ctgry_ord").val(ui.nindex);
 			jQuery("input[name='child_gb']:eq(0)").click();
 			jQuery("input[name='job_gb']:eq(1)").click();
 	    }
 	});
 	
 	jQuery("#subctgrylist").multiselect({
 		header: true,
 		height: 240,
 		minWidth: 300,
 		autoOpen : true,
 		multiple : false,
 		checkAllText: '모두 선택',
 		uncheckAllText: '선택 해제',
 		noneSelectedText: '카테고리 하위항목',
 		selectedText: '카테고리 하위항목',
 		click: function(event, ui){
 	        // event handler here
 	        //ui.value; ui.text; ui.checked;
 			jQuery("#ctgry_idx").val(ui.value);
 			var upidx = $("#ctgrylist").multiselect("getChecked").map(function(){
 				   return this.value;    
 				}).get();
 			jQuery("#up_ctgry_idx").val(upidx);
 			jQuery("#ctgry_nm").val(ui.text);
 			jQuery("#ctgry_ord").val(ui.nindex);

 			jQuery("input[name='child_gb']:eq(1)").click();
 			jQuery("input[name='job_gb']:eq(1)").click();

 	    }
 	});
 	*/
 	
 	// 카테고리 / 카테고리 하위항목 or 등록/수정 라디오버튼 선택에 따른 처리
 	jQuery("input[name='child_gb'], input[name='job_gb']").click(function(){
 		fn_egov_procradio_ctgry();			
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

function fn_egov_sysctgry_save()
{
	
 	var data = cmmfn_get_post_data("divMainArticle");
 	 
 	if(data.ctgry_nm == "")
 	{
 		alert("항목명을 입력하십시오.");
 		jQuery("#ctgry_nm").focus();
 		return;
 	}
 	
 	
 	var bizst = "";
 	var msg_confirm = "";
 	
 	var child_gb = data.child_gb;
 	
 	if(data.job_gb == "0")
 	{
 		bizst = "add";
 		msg_confirm = "카테고리를 등록하시겠습니까?";
 		data.ctgry_ord = "1";
 	}
 	
 	else if(data.job_gb == "1")
 	{
 		bizst = "mdf";
 		msg_confirm = "카테고리를 수정하시겠습니까?";
 		
 		if(data.ctgry_idx == "")
 		{
 			alert("수정하실 카테고리 하위항목을 선택상자에서 선택하십시오..");
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
 	    url 		: g_context + '/menuctgry/' + bizst + 'Syscategory.do?srch_menu_nix=${param.srch_menu_nix}',
 	    type  		: "post",
 	    data 		: data,
 	    datatype	: "html",
 		async 		: false,	        
 	    success 	: function(data){        	
 			
 	    	alert("저장되었습니다.");
 	    	jQuery("#ctgry_nm").val("");
 	    	jQuery("#ctgry_ord").val("");
 	    	
 	    	if(child_gb == "0")
 	    		fn_egov_category_list();
 	    	else
 	    		fn_egov_subcategory_list(jQuery("#up_ctgry_idx").val());
 	    	
 	    },
 	    error: function(xhr, err){
 	        
 	    	alert("에러가 발생했습니다.\n");
 	    }
 	});

}

function fn_egov_category_list()
{
 	var data = new Object();

 	$.ajax({
 		url 		: g_context + '/menuctgry/syscategoryJsonList.do',
 		type  		: "post",
 		data 		: data,
 		datatype	: "json",
 		async 		: false,	        
   	   	success 	: function(data){        	
   	   		jQuery("#selectable_lv1 li").remove();
 			for(var i = 0; i < data.length; i++)
 			{
 				if(data[i].use_yn == "Y")
					jQuery("#selectable_lv1").append("<li class=\"ui-widget-content\" id=\"" + data[i].ctgry_idx + "\">" + data[i].ctgry_nm + "</li>");
 				else
 					jQuery("#selectable_lv1").append("<li class=\"ui-widget-content ui-state-disabled\" id=\"" + data[i].ctgry_idx + "\">" + data[i].ctgry_nm + "</li>");

 			}
 			 			
 			if(data.length == 0)
 				jQuery("#selectable_lv1").append("<li>등록된 카테고리 그룹이 없습니다.</li>");

 		},
      	error: function(xhr, err){
      		alert("카테고리 정보를 가져오는 도중 오류가 발생했습니다.\n");
      	}
 	});
 	
 }

 function fn_egov_subcategory_list(up_ctgry_idx)
 {
 	var data = new Object();
 	data.up_ctgry_idx = up_ctgry_idx;

 	$.ajax({
 		url 		: g_context + '/menuctgry/syscategoryJsonList.do',
 		type  		: "post",
 		data 		: data,
 		datatype	: "json",
 		async 		: false,	        
    		success 	: function(data){        	
 	     	
   			jQuery("#selectable_lv2 li").remove();
 	     	for(var i = 0; i < data.length; i++)
 			{
 	     		if(data[i].use_yn == "Y")
					jQuery("#selectable_lv2").append("<li class=\"ui-widget-content\" id=\"" + data[i].ctgry_idx + "\">" + data[i].ctgry_nm + "</li>");
 	     		else
 	     			jQuery("#selectable_lv2").append("<li class=\"ui-widget-content ui-state-disabled\" id=\"" + data[i].ctgry_idx + "\">" + data[i].ctgry_nm + "</li>");
 			}

 		},
     	error: function(xhr, err){
          
      		alert("카테고리 하위항목 정보를 가져오는 도중 오류가 발생했습니다.\n");
      	}
 	});
 	
 }


 function fn_egov_procradio_ctgry()
 {
 	var child_gb = jQuery("input[name='child_gb']:checked").val();
 	var job_gb = jQuery("input[name='job_gb']:checked").val();

 	var upidx = ""; 	
 	
 	// 등록 클릭
 	if(job_gb == "0")
 	{
 		jQuery("#ctgry_idx").val("");	
 		jQuery("#ctgry_nm").val("");	
 		jQuery("#ctgry_ord").val("");
 		
 		// 카테고리 등록인 경우
 		if(child_gb == "0")
 		{
 			jQuery("#up_ctgry_idx").val("");	
 		}
 		
 		// 카테고리 하위항목 등록인 경우
 		else
 		{
			upidx = getSelectedItem("selectable_lv1", "CD");
			jQuery("#up_ctgry_idx").val(upidx);
 		}
 		
		jQuery("input[name='use_yn']:eq(0)").click();
 		jQuery("#ctgry_nm").focus();
 	}
 	
 	// 수정 클릭
 	else 
 	{
 		// 카테고리 수정인 경우
 		if(child_gb == "0")
 		{
			var idx = getSelectedItem("selectable_lv1", "CD");
			var nm = getSelectedItem("selectable_lv1", "TXT");
			var ord = getSelectedItem("selectable_lv1", "NIDX");
			
 			jQuery("#ctgry_idx").val(idx);	
 			jQuery("#ctgry_nm").val(nm);	
 			jQuery("#ctgry_ord").val(ord);	
 			jQuery("#up_ctgry_idx").val("");

 		}
 		
 		// 카테고리 하위항목 수정인 경우
 		else
 		{
			var idx = getSelectedItem("selectable_lv2", "CD");
			var nm = getSelectedItem("selectable_lv2", "TXT");
			var ord = getSelectedItem("selectable_lv2", "NIDX");

			upidx = getSelectedItem("selectable_lv1", "CD");
 			
 			jQuery("#ctgry_idx").val(idx);	
 			jQuery("#ctgry_nm").val(nm);	
 			jQuery("#ctgry_ord").val(ord);	
 			jQuery("#up_ctgry_idx").val(upidx);	
 			
 		}	
 		
 	}
 }

 function fn_egov_sysctgry_del()
 {
 	var child_gb = jQuery("input[name='child_gb']:checked").val();

 	var nm = "";
 	var idx = "";
 	
 	// 카테고리 삭제
 	if(child_gb == "0")
 	{

		nm = getSelectedItem("selectable_lv1", "TXT");
		idx = getSelectedItem("selectable_lv1", "CD");	
 		
 		if(idx == "")
 		{
 			alert("삭제할 카테고리를 선택해주십시오.");
 			return;
 		}
 		
 		if(confirm("카테고리 그룹 [ " + nm + " ] 과 그 하위 항목들을 삭제하시겠습니까?") == false)
 			return;
 		
 		
 	}
 	
 	// 카테고리 하위항목 삭제
 	else if(child_gb == "1")
 	{
		nm = getSelectedItem("selectable_lv2", "TXT");	
		idx = getSelectedItem("selectable_lv2", "CD");	

 		if(idx == "")
 		{
 			alert("삭제할 카테고리 하위항목을 선택해주십시오.");
 			return;
 		}
 		
 		if(confirm("카테고리 하위항목 [ " + nm + " ] 를 삭제하시겠습니까?") == false)
 			return;

 	}
 	
 	
 	var  data = new Object();
 	data.ctgry_idx = idx + "";
 	
 	$.ajax({
 		url 		: g_context + '/menuctgry/rmvSyscategory.do?srch_menu_nix=${param.srch_menu_nix}',
 		type  		: "post",
 		data 		: data,
 		datatype	: "text",
 		async 		: false,	        
 		success 	: function(data){        	

 			alert("삭제되었습니다.");

 	 		// 코드삭제인 경우
 	 		if(child_gb == "0")
 	 		{
 	 			fn_egov_category_list();
     			jQuery("#selectable_lv2 li").remove();
 	 		}
 	     	
 	 		// 코드항목 삭제인 경우 
 	     	else if(child_gb == "1")
 	     	{
	     		var up_idx = getSelectedItem("selectable_lv1", "CD");	   		
 	     		fn_egov_subcategory_list(up_idx.toString());
 	     	}
      	
 		},
 	    error: function(xhr, err){
 	         
 	     	alert("삭제 도중 오류가 발생했습니다.\n");
 	    }
 	});
 	
 }

 /**************************************************************
  *  			카테고리 페이지 초기화 End
  **************************************************************/
  
 </script> 
  
 