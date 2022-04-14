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
	
	g_context = "${pageContext.request.contextPath}";
	jQuery("#btnSurveyAppl").on("click", fn_egov_chk_srvy);
	jQuery("#btnSurveyRslt").on("click", fn_egov_show_stat);
	jQuery("#btnSurveyIng").on("click", fn_egov_show_ing);
	
	// 추가 답변이 필요없는 경우 input을 보이지 않게 한다.
	$("input[type='radio']").on("change", function(){
		$(this).parent().parent().parent().parent().find("input[type='text']").hide();
		$(this).parent().parent().find("input[type='text']").show();
	});

});




function fn_egov_survey_appl()
{
	var ques_pass = true;
	
	jQuery("article.item").each(function(){
		
		var divobj = $(this);
		
		var ques_type = jQuery("input[name='arr_ques_type']", divobj).val();
		
		switch(ques_type)
		{
			// 객관식 단답형
			case "CDIDX00082" :

				// 라디오 선택이 되지 않은 경우
				if(jQuery(":radio:checked", divobj).length == 0)
				{
					alert("답변이 선택되지 않았습니다.");	
					jQuery(":radio:first", divobj).focus();
					ques_pass = false;
					return false;
				}
				
				var radobj = jQuery(":radio:checked", divobj);
				
				var chkid = radobj.attr("id");
				chkid = chkid.replace(/radio_/gi, "");
				
				// 선택버튼에 추가입력 상자가 딸려있는 경우
				var txtobj = jQuery("#txt_" + chkid);
				var txtval = "";
				if(txtobj.length > 0)
				{
					txtval = txtobj.val();
					if(txtval == "")
					{
						alert("추가 답변을 입력해 주십시오.");
						txtobj.focus();
						ques_pass = false;
						return false;
					}
					if(txtval.lenth > 300)
					{
						alert("추가 답변은 한글 기준 300자 까지 쓸 수 있습니다.\n현재 답변의 길이 수 : "+txtval.length+ "자");
						txtobj.focus();
						ques_pass = false;
						return false;
					}
					txtval = "##" + txtval;
				}
				
				jQuery("input[name='arr_answer']", divobj).val(radobj.val() + txtval);

				break;
			
			// 객관식 복수형
			case "CDIDX00083" :
				// 체크박스가 선택되지 않은 경우
				if(jQuery(":checkbox:checked", divobj).length == 0)
				{
					alert("답변이 선택되지 않았습니다.");	
					jQuery(":checkbox:first", divobj).focus();
					ques_pass = false;
					return false;
				}
				
				// 선택된 값 ##으로 이어붙이기
				
				var ansval = "";
				jQuery(":checkbox", divobj).each(function(){
					ansval += (ansval == "") ? "" : "##";
					ansval += (($(this).prop("checked") == true) ? "Y" : "N"); 
				});
				//var ansval = jQuery(":checkbox:checked", divobj).map(function(){return $(this).val();}).get().join("##");
				jQuery("input[name='arr_answer']", divobj).val(ansval);
				
				break;
			
			// 주관식 단답형
			case "CDIDX00084" : 

				if(jQuery("textarea", divobj).val() == "")
				{
					alert("답변이 입력되지 않았습니다.");	
					jQuery("textarea", divobj).focus();
					ques_pass = false;
					return false;
				}
				var ansval = jQuery("textarea", divobj).val();
				if(ansval.length > 100)
				{
					alert("주관식 답변은 한글 기준 100자 까지 쓸 수 있습니다.\n현재 답변의 길이 수 : "+ansval.length+ "자");
					jQuery("textarea", divobj).focus();
					ques_pass = false;
					return false;
				}
				jQuery("input[name='arr_answer']", divobj).val(ansval);
				
				break;
			
			// 만족도 선택형
			case "CDIDX00085" : 

				if(jQuery("textarea", divobj).val() == "")
				{
					alert("답변이 입력되지 않았습니다.");	
					jQuery("textarea", divobj).focus();
					ques_pass = false;
					return false;
				}
				var ansval = jQuery("textarea", divobj).val();
				if(ansval.length > 250)
				{
					alert("주관식 답변은 한글 기준 250자 까지 쓸 수 있습니다.\n현재 답변의 길이 수 : "+ansval.length+ "자");
					jQuery("textarea", divobj).focus();
					ques_pass = false;
					return false;
				}
				jQuery("input[name='arr_answer']", divobj).val(ansval);
				
				break;
			
			// 선호도 선택형
			case "CDIDX00086" : 
								
				var anscnt = jQuery("table > tbody > tr", divobj).length;
				
				var trpass = true;
				
				// 순위가 2 이상 선택됐거나 하나도 선택되지 않은 경우 에러
				for(var i = 0; i < anscnt; i++)
				{
					var molen = jQuery(":radio[value='" + (i+1) + "']:checked", divobj).length; 
					if( molen != 1)
					{
						alert("순위별로 1개씩 모두 선택해주십시오");
						
						// 하나도 선택되지 않은 경우 해당 순위의 첫번째 버튼을 선택
						if(molen == 0)
							jQuery(":radio[value='" + (i+1) + "']:first", divobj).focus();
						
						// 둘 이상 선택된 경우 선택된 것중 첫번째 버튼을 선택
						else
							jQuery(":radio[value='" + (i+1) + "']:checked:first", divobj).focus();
						
						trpass = false;
						break;
					}
				}
				
				if(trpass == false)
				{
					ques_pass = false;
					return false;
				}
				
				var ansval = jQuery(":radio:checked", divobj).map(function(){return $(this).val();}).get().join("##");
				jQuery("input[name='arr_answer']", divobj).val(ansval);
								
				break;
			
				// 주관식 단답형(단문)
			case "CDIDX00087" : 

				if(jQuery(".answ_text", divobj).val() == "")
				{
					alert("답변이 입력되지 않았습니다.");	
					jQuery(".answ_text", divobj).focus();
					ques_pass = false;
					return false;
				}
				var ansval = jQuery(".answ_text", divobj).val();
				if(ansval.length > 50)
				{
					alert("주관식 답변은 한글 기준 50자 까지 쓸 수 있습니다.\n현재 답변의 길이 수 : "+ansval.length+ "자");
					jQuery(".answ_text", divobj).focus();
					ques_pass = false;
					return false;
				}
				jQuery("input[name='arr_answer']", divobj).val(ansval);
				
				break;
			
		}

	});
	
	if(ques_pass == false || cmmfn_check_inputnull(jQuery("#srvy_appl_nm")) == false)
	{
		return;
	}
	
	//응답자 이메일정보
	<c:if test="${srvymainVO.srvy_allow_dup eq 'N'}">
		if(validateEmail($('#data_addr').val()) == false)
		{
			alert("이메일 정보가 정확하지 않습니다.");
			$('#data_addr').focus();
			return false;
		}
	</c:if>
	
	if(confirm("설문 내용을 저장하시겠습니까 ? ") == false)
		return;
	var form = document.reqForm;
	fn_egov_move_action(form, "/usract/surveySrvydata/addSrvydata.do");
	
}

function fn_egov_srvymain_view(srvy_idx){

	var form = document.reqForm;
	form.srvy_idx.value = srvy_idx;
		
	fn_egov_move_action(form, "/usract/surveySrvydata/srvyView.do?srch_menu_nix=" + lg_srch_menu_nix + "&seltab_idx=1");
}

function fn_egov_reply_tagdiv(val)
{
	val = cmmfn_str_trim(val);
	val = val.replace(/&amp;/gi, "&");
	val = val.replace(/&quot;/gi, "\"");
	val = val.replace(/&apos;/gi, "'");
	val = val.replace(/&amp;nbsp;/gi, " ");
	val = val.replace(/&nbsp;/gi, " ");
	val = val.replace(/&amp;nbsp/gi, " ");
	val = val.replace(/&nbsp/gi, " ");
	
	val = val.replace(/&lt;/gi, "<");
	val = val.replace(/&gt;/gi, ">");
	val = val.replace(/#CONTEXTPATH#/gi, g_context);
	//val = val.replace(/&amp;nbsp;/gi, " ");
	//다음항목들로 시작하지 않는 태그는 html로 보여주지 않는다. 
	val = val.replace(/<(\/*)(\b(?!p|a|b|span|div|strong|img|font|o:p|table|tbody|tfoot|th|tr|td|h1|h2|h3|h4|ul|li|em|ol|hr|input|object|dd|dl|dt|caption|center|section|col|label))([^>]*)>/gi, "&lt;$1$2$3&gt;");
	//val = val.replace(/<(\/*)(\b(?!br))([^>]*)>/g, "&lt;$1$2$3&gt;");
	return val;
}

//댓글 저장
function fn_egov_reply_save()
{
	if(sess_usr_lv > 9999)
	{
		if(confirm("로그인 후 댓글을 등록할 수 있습니다.\n로그인 하시겠습니까?")){
		jQuery(".btn-user").click();
		}
		jQuery("#reply_cont").val("");
		return;
	}
	var data = cmmfn_get_post_data("divMainArticle");
	
	if(data.reply_cont == "")
	{
		alert("댓글 내용을 입력해주십시오.");
		jQuery("#reply_cont").focus();
		return;
	}
	
	
	var reply_mode = jQuery("#mod_reply_idx").val() == "" ? "add" : "mdf";
	if(reply_mode == "mdf")
	{
		data.reply_idx = jQuery("#mod_reply_idx").val();
	}
		
	 $.ajax({
	        url 		: g_context + "/usract/surveySrvydata/" + reply_mode + "Srvyreply.do?srch_menu_nix=" + lg_srch_menu_nix,
	        type  		: "post",
	        data 		: data,
	        datatype	: "json",
			async 		: false,	        
	        success 	: function(retval){ 
        
        	if(reply_mode == "add")
        	{
        	
        		
	        	var reply_cont = fn_egov_reply_tagdiv(retval.reply_cont);
	        	var htmlVal = "<li id=\"dlidx_" + retval.reply_idx + "\" >";
	        		htmlVal += "<div class=\"user-info\">";
	        		htmlVal += "	<span class=\"user-img\"><img src=\"/images/custom/web/korean/common/icon_user_default.gif\" alt=\"프로필 이미지\"></span>";
	        		htmlVal += "	<span class=\"user-name\">"+retval.writer_nm+" 님</span>";
	        		htmlVal += "</div>";
	        		htmlVal += "<div class=\"user-text\" id=\"spanReplyArea_"+retval.reply_idx+"\">"+reply_cont+"</div>";
	        		htmlVal += "<div class=\"comment-info row\">";
	        		htmlVal += "	<div class=\"col col-sm-12  col-xs-6 col-lg-6\">";
	        		htmlVal += "		<span class=\"day\"><em>"+retval.wdt+"</em></span>";
	        		htmlVal += "	</div>";
	        		htmlVal += "	<div class=\"button-group style02 col col-sm-12  col-xs-6 col-lg-6\">";
	        		htmlVal += "		<a class=\"btn btn-default small white\" href=\"javascript:fn_egov_reply_mod('" + retval.reply_idx + "');\" role=\"button\">수정</a>";
	        		htmlVal += "		<a class=\"btn btn-default small white\" href=\"javascript:fn_egov_reply_del('" + retval.reply_idx + "');\" role=\"button\">삭제</a>";
	        		htmlVal += "	</div>";
	        		htmlVal += "</div>";
	        		
				
	        	jQuery("ul[id='comment_write']").prepend(htmlVal);	        			
	        							
	        	$("#no_reply_li").remove();
	        	var totCnt = Number(jQuery(".current").text()) + 1;
	        	$(".current").text(totCnt);
	        	$("#reply_cnt").text(totCnt);
        		jQuery("#reply_cont").val("");
	        	
	        }
        	
        	else
        	{
        		var modval = jQuery("#reply_cont").val();
        		modval = modval.replace(/\r\n/gi, "<br>");
        		modval = modval.replace(/\n/gi, "<br>");
        		alert("댓글이 수정되었습니다.");
        		jQuery("#spanReplyArea_" + retval.reply_idx).html(modval).attr("tabindex", -1).focus();
        		jQuery("#reply_cont").val("");
        		jQuery("#mod_reply_idx").val("");	
        	}
        	
        	
        	
        },
        error: function(xhr, err){
        	alert("에러가 발생했습니다.");
        }
    });
	 $("#reply_div").empty().append("<button type=\"button\" class=\"btn btn-default btn-write01 btn-popup-open white mid\" onclick=\"fn_egov_reply_save();return false;\" title=\"등록버튼\">등록</button>");
}

//댓글 수정
function fn_egov_reply_mod(idx)
{
	jQuery("#mod_reply_idx").val(idx);
	var modval = jQuery("#spanReplyArea_" + idx).html();
	modval = modval.replace(/<br>/gi, "\r\n").trim();
	jQuery("#reply_cont").val(modval).focus();
	$("#reply_div").empty().append("<button type=\"button\" class=\"btn btn-default btn-write01 btn-popup-open green mid\" onclick=\"fn_egov_reply_save();return false;\" title=\"수정버튼\">수정</button>");
	
}


// 댓글 삭제
function fn_egov_reply_del(idx)
{
	if(confirm("댓글을 삭제하시겠습니까?") == false)
		return;
	
	var data = cmmfn_get_post_data("divMainArticle");
	data.reply_idx = idx;
	
    $.ajax({
        url 		: g_context + "/usract/surveySrvydata/rmvSrvyreply.do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=srvy",
        type  		: "post",
        data 		: data,
        datatype	: "text",
		async 		: false,	        
        success 	: function(retval){
        	$("#dlidx_" + idx).remove();
        	var totCnt = Number(jQuery(".current").text()) - 1;
        	$(".current").text(totCnt);
        	$("#reply_cnt").text(totCnt);
        	if(totCnt == 0){
        		jQuery("ul[id='comment_write']").append("<li id=\"no_reply_li\"><div class=\"no-data\">댓글이 없습니다.</div></li>");
        	}
        }, 
        error: function(xhr, err){
        	alert("에러가 발생했습니다.");
        }
    });
}

function fn_egov_srvy_list(){
	
	var form = document.reqForm;
		fn_egov_move_action(form, "/usract/surveySrvydata/srvymainList.do?srch_menu_nix=j6VNF4iN&seltab_idx=1");
}

function fn_egov_add_share()
{
	
	$.ajax({
		url 		: g_context + "/usract/surveySrvydata/shareAddJson.do",
		type  		: "post",
		data 		: { 
						srvy_idx : $("#srvy_idx").val(),
						shares : Number($("#share_cnt").text())
		},
		datatype	: "json",
		async 		: false,	        
		success 	: function(data){
			$("#share_cnt").text(Number($("#share_cnt").text())+1);
		},
		error: function(xhr, err){
			
			alert("공유하기 도중 오류가 발생했습니다.\n");
		}
	});
}

function fn_egov_chk_srvy()
{
	$.ajax({
		url 		: g_context + "/usract/surveySrvydata/chkSrvyJson.do",
		type  		: "post",
		data 		: { srvy_idx : $("#srvy_idx").val(), data_addr : $("#data_addr").val() },
		datatype	: "json",
		async 		: false,	        
		success 	: function(data){
			
			
			if(data == null || data == ""){
				fn_egov_survey_appl();
			}else{
				alert(data);
				return;
			}
			
		},
		error: function(xhr, err){
			
			alert("설문참여 확인 도중 오류가 발생했습니다.\n");
		}
	});
}

function fn_egov_show_stat(){
	$("#survey-stat").show();
	$("#survey-ing").hide();
}
function fn_egov_show_ing(){
	$("#survey-stat").hide();
	$("#survey-ing").show();
}

function validateEmail(email) {
	var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
	return re.test(email);
}

</script>