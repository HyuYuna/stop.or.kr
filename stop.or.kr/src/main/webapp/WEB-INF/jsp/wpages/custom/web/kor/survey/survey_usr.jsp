<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>

<!doctype html>
<html lang="ko">

<head>
<c:import url="/WEB-INF/jsp/layout/custom/web/kor/cmm/metacmmn.jsp"/>

<title><c:out value="${mainVO.srvy_nm}"/></title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/template/cmmn/basic.css" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/template/cmmn/survey.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/utils/datepicker/css/datepicker.css" />


<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/html5.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-ui-1.9.2.custom.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/_cmmn/plani_common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/_cmmn/plani_gen.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/_cmmn/plani_auth.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/utils/datepicker/js/datepicker.js"></script>

<!--[if lt IE 9]>
<script src="${pageContext.request.contextPath}/js/jquery/core/html5.js" ></script> 
<![endif]-->

<script type="text/javascript">
jQuery(document).ready(function(){

	g_context = "${pageContext.request.contextPath}";
	jQuery("#btnSurveyAppl").on("click", fn_egov_survey_appl);
	
	// 추가 답변이 필요없는 경우 input을 보이지 않게 한다.
	$("input[type='radio']").on("change", function(){
		$(this).parent().parent().find("input[type='text']").hide();
		$(this).next().next().show();
	});

});




function fn_egov_survey_appl()
{
	var ques_pass = true;
	
	jQuery("div[id^='divQuesArea_']").each(function(){
		
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
				if(ansval.length > 300)
				{
					alert("주관식 답변은 한글 기준 300자 까지 쓸 수 있습니다.\n현재 답변의 길이 수 : "+ansval.length+ "자");
					jQuery("textarea", divobj).focus();
					ques_pass = false;
					return false;
				}
				jQuery("input[name='arr_answer']", divobj).val(ansval);
				
				break;
			
			// 만족도 선택형
			case "CDIDX00085" : 

				var trpass = true;
				
				// 각 만족도 항목별로 선택되지 않은 것이 있는지 체크한다.
				jQuery("table > tbody > tr", divobj).each(function(){
					
					var trobj = $(this);
					
					if(jQuery(":radio:checked", trobj).length == 0)
					{
						alert("답변이 선택되지 않았습니다.");	
						jQuery(":radio:first", trobj).focus();
						trpass = false;
						return false;
					}
					
				});
				
				if(trpass == false)
				{
					ques_pass = false;
					return false;
				}
				
				
				var ansval = jQuery(":radio:checked", divobj).map(function(){return $(this).val();}).get().join("##");
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
			
		}

	});
	
	if(ques_pass == false || cmmfn_check_inputnull(jQuery("#srvy_appl_nm, #srvy_appl_cp")) == false)
	{
		return;
	}
	var regExp = /^\d{3}-\d{3,4}-\d{4}$/;
	if(!regExp.test($("#srvy_appl_cp").val()))
	{
		alert("숫자와 하이픈(-) 를 사용하여 휴대전화번호를 입력하십시오.");
		$("#srvy_appl_cp").focus();
		return;
	}
	
	if(confirm("설문 내용을 저장하시겠습니까 ? ") == false)
		return;
	var form = document.reqForm;
	fn_egov_move_action(form, "/usract/surveySrvydata/addSrvydata.do");
	
}
</script>


</head>

<body>
<!-- Accessibility -->
<dl id="accessibility">
	<dt class="hidden">바로가기 메뉴</dt>
	<dd><a href="#content">본문 바로가기</a></dd>
</dl>
<!-- //Accessibility -->
<div id="wrap">
	<header class="survey_info">
		<h1><strong>${SESS_PROP_PRJTNM}</strong> <c:out value="${mainVO.srvy_nm}"/></h1>
		<p>${elfunc:removeScrtag(mainVO.srvy_cont)}</p>
	</header>
	<div id="content">
	
		<form name="reqForm" method="post">
		
			<!-- 파트시작 -->
			<section class="part_area">
	
				<c:import url="/WEB-INF/jsp/wpages/template/cmmn/survey/survey_imp.jsp">
					 <c:param name="lc_part_type" value="CDIDX00063"/>
				</c:import>
				
			</section>	
			
			
			<!-- 파트시작 -->
			<section class="part_area demography_area">
				
				<c:import url="/WEB-INF/jsp/wpages/template/cmmn/survey/survey_imp.jsp">
					 <c:param name="lc_part_type" value="CDIDX00062"/>
				</c:import>
			
				<div class="final">
					<p>귀한 시간 내주셔서 대단히 감사합니다.</p>
					<button type="button" class="btn" id="btnSurveyAppl">참여하기</button>
				</div>
			</section>
			<!-- // -->
			
			<input type="hidden" id="srvy_idx" name="srvy_idx" value="${mainVO.srvy_idx}"/>
			
		</form>
	</div>
</div>
</body>
</html>
