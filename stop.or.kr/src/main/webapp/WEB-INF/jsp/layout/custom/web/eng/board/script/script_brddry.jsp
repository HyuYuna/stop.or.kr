<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!--
	페이지별로 들어가는 공통적인 명령에 대한 스크립트만 여기에 추가한다.
	ex) 메뉴 페이지 이동 스크립트 등..
	2013.04.16 bhhan
-->	
<script type="text/javascript">
jQuery(document).ready(function(){
	loadScheduleAll();
	
});
function loadScheduleAll()
{
	
	var calobj = jQuery("#tblSchedulecalAll > tbody");
	var calobj_list = jQuery("#tblSchedulecalList > tbody");
	
	calobj.empty();
	calobj_list.empty();
	
	$.ajax({
	    url 		: g_context + '/brddry/loadScheduleJson.do',
	    type  	: "post",
	    data 		: {
	    	srchcalYr : jQuery("#srchcalYr").val(),
	    	srchcalMon : jQuery("#srchcalMon").val()
		},
		datatype	: "json",
		async 	: false,
		success 	: function(data){
			//console.log(data);
			var yr = data.ST_YEAR;
			var mon = data.ST_MON;
			var dcnt = data.ST_DCNT;
			var dow = data.ST_DOW;
			
			// 달력 표시부분
			jQuery("span[id='spanCalyrAll']").each(function(){
				$(this).html(yr + ".<span> " + mon + "</span>.");
			});
			
			// dnct + dow 보다 크거나 같은 가장 작은 7의 배수를 찾는다.. (날짜가 없는 부분에도 표를 그려주기 위해서..)
			var dto = 7 * ( Math.floor((dcnt + dow) / 7)  + ((dcnt + dow) % 7 == 0 ? 0 : 1));
			
			// 달력 형식에 맞게 날짜 표시함
			var calobjStr="";
			for(var i = 0; i < dto; i++)
			{
				var print = (i - dow + 1) < 1 || (i - dow + 1) > dcnt ? "&nbsp;" : (i - dow + 1);
				
				var clsdt = "";
				var todayChk=0;
				
				if((i - dow + 1) == data.ST_CURDAY){
					clsdt = " class=\"today\"";
					todayChk=1;
				}
				if(i == 0 || i % 7 == 0)
				{
					clsdt = (clsdt == "") ? " class=\"sun\"" : clsdt;
					calobjStr+="<tr>";
					calobjStr+="<td" + clsdt +"><span class='pointNum'>"+ print + "</span><div class='schedule'><ul id='calendar_td"+parseInt(print,10)+"'></ul></div></td>";
					
						//.append("<tr>")
						//.append("<td" + clsdt +"><span>"+ print + "</span><div class='schedule'><ul id='calendar_td"+parseInt(print,10)+"'></ul></div></td>")
					
				}
				else if(i % 7 == 1)
				{
					//clsdt = (clsdt == "") ? " class=\"mon\"" : clsdt;
					/* calobjStr
						.append("<td" + clsdt +"><span>"+ print + "</span><div class='schedule'><ul id='calendar_td"+parseInt(print,10)+"'></ul></div></td>") */
					calobjStr+="<td" + clsdt +"><span class='pointNum'>"+ print + "</span><div class='schedule'><ul id='calendar_td"+parseInt(print,10)+"'></ul></div></td>";
						
				}
				else if(i % 7 == 6)
				{
					clsdt = (clsdt == "") ? " class=\"sat\"" : clsdt;
					/* calobjStr
						.append("<td" + clsdt +"><span>"+ print + "</span><div class='schedule'><ul id='calendar_td"+parseInt(print,10)+"'></ul></div></td>")
						.append("</tr>"); */
					calobjStr+="<td" + clsdt +"><span class='pointNum'>"+ print + "</span><div class='schedule'><ul id='calendar_td"+parseInt(print,10)+"'></ul></div></td>";
					calobjStr+="</tr>";
				}
				else
				{
					/* calobjStr
						.append("<td" + clsdt +"><span>"+ print + "</span><div class='schedule'><ul id='calendar_td"+parseInt(print,10)+"'></ul></div></td>"); */
					calobjStr+="<td" + clsdt +"><span class='pointNum'>"+ print + "</span><div class='schedule'><ul id='calendar_td"+parseInt(print,10)+"'></ul></div></td>";
					
				}
				
				
				
			}
			
			calobj.append(calobjStr);
			
			for(var i = 0; i < dto; i++)
			{
				var print = (i - dow + 1) < 1 || (i - dow + 1) > dcnt ? "&nbsp;" : (i - dow + 1);
				var schedule_type01 = 0;
				var point01Chk = 0;
				var buttonchk =false;
				
					for(var j = 0; j < data.schList.length; j++){
						//document.write(parseInt(print,10)+"\t"+ ((parseInt(data.schList[j].startdt.substring(5,7),10) < mon) && (parseInt(data.schList[j].enddd,10) >=  parseInt(print,10))));
						if(
								print>0&&(((parseInt(data.schList[j].startdd,10) <= parseInt(print,10)) && (parseInt(data.schList[j].enddd,10) >=  parseInt(print,10)))
								|| ((parseInt(data.schList[j].startdt.substring(5,7),10) < mon) && (parseInt(data.schList[j].enddt.substring(5,7),10) > mon))
								|| ((parseInt(data.schList[j].startdd,10) <= parseInt(print,10)) && (parseInt(data.schList[j].enddt.substring(5,7),10) > mon))
								|| ((parseInt(data.schList[j].startdt.substring(5,7),10) < mon) && (parseInt(data.schList[j].enddd,10) >=  parseInt(print,10))))
								
						){
							
							buttonchk=true;
							
							if(data.schList[j].ctgry_idx == "CTIDX00082"){//전시
								$("#calendar_td"+parseInt(print,10)).append("<li><a href='/display/displayView.do?srch_menu_nix=ne37l2c7&disp_idx="+data.schList[j].reference_key.split('|')[1]+"'><img src='${pageContext.request.contextPath}/images/custom/kor/community/schedule_type02.gif' alt='전시'/>"+data.schList[j].subject+"</a></li>");
								
							}else if(data.schList[j].ctgry_idx == "CTIDX00083"){//행사
								$("#calendar_td"+parseInt(print,10)).append("<li><a href='/display/displayView.do?srch_menu_nix=ne37l2c7&disp_idx="+data.schList[j].reference_key.split('|')[1]+"'><img src='${pageContext.request.contextPath}/images/custom/kor/community/schedule_type03.gif' alt='행사'/>"+data.schList[j].subject+"</a></li>");
								
							}else if(data.schList[j].ctgry_idx == "CTIDX00084"){//교육
								$("#calendar_td"+parseInt(print,10)).append("<li><a href='/resvetcman/resvetcmanView.do?&rsv_gb=CDIDX00042&menu_user_se=3&srch_menu_nix=z9dvSySs&rsv_no="+data.schList[j].reference_key.split('|')[2]+"'><img src='${pageContext.request.contextPath}/images/custom/kor/community/schedule_type04.gif' alt='교육'/>"+data.schList[j].subject+"</a></li>");
								
							}else if(data.schList[j].ctgry_idx == "CTIDX00085"){//기타
								$("#calendar_td"+parseInt(print,10)).append("<li><a href=''><img src='${pageContext.request.contextPath}/images/custom/kor/community/schedule_type05.gif' alt='기타'/>"+data.schList[j].subject+"</a></li>");
								
							}else if(data.schList[j].ctgry_idx == "CTIDX00099"){//대체휴무
								//$("#mini_calendar_td"+parseInt(print,10)).attr("class","schedule_type01");
								//$("#mini_calendar_td"+parseInt(print,10)).attr("onclick","");
								buttonchk=false;
								schedule_type01=1;
							}else if(data.schList[j].ctgry_idx == "CTIDX00098"){//공휴일
								//$("#mini_calendar_td"+parseInt(print,10)).addClass("class","point01");
								point01Chk=1;
							}
							
							
							//alert(print);
						}
						
						
					}
					
					if(schedule_type01==1){
						$("#calendar_td"+parseInt(print,10)).parent().parent().addClass("mon");
						$("#calendar_td"+parseInt(print,10)).html("");
						buttonchk=false;
					}
					  if(point01Chk==1){
						if($("#calendar_td"+parseInt(print,10)).parent().parent().attr("class")=="mon"){
							$("#calendar_td"+parseInt(print,10)).parent().parent().attr("class","point01");
						}else{
							$("#calendar_td"+parseInt(print,10)).parent().parent().addClass("point01");
						}
					}  
					if(point01Chk==1&&i % 7 == 1){
						
					}else if(i % 7 == 1&&print>0){
						//alert(i);
						$("#calendar_td"+parseInt(print,10)).parent().parent().attr("class","mon");
						$("#calendar_td"+parseInt(print,10)).html("<li><a href=\"#\"><img src=\"${pageContext.request.contextPath}/images/custom/kor/community/schedule_type01.gif\" alt=\"휴관\">휴관</a></li>");
						buttonchk=false;
					}
					
					if(todayChk==1){
						$("#calendar_td"+parseInt(print,10)).parent().parent().addClass("today");
					}
					
				if(buttonchk){
					$("#calendar_td"+parseInt(print,10)).parent().append("<span class='txt_right'><a href='javascript:calendar_detail_main("+parseInt(print,10)+")'><img src='${pageContext.request.contextPath}/images/custom/kor/community/btn_plus.png' alt='상세일정 펼쳐보기'></a></span>");	
				}
			}
			
			//console.log(data.schList);
			for(var j = 0; j < data.schList.length; j++){
				calobj_list.append("<tr>");
				if(data.schList[j].ctgry_idx == "CTIDX00082"){//전시
					calobj_list.append("<th scope='row'>[전시]</th><td class='txt_left'><a href='/display/displayView.do?srch_menu_nix=ne37l2c7&disp_idx="+data.schList[j].reference_key.split('|')[1]+"'>"+data.schList[j].subject+"</a></td><td class='point01'>"+data.schList[j].startdt+"</td><td>"+data.schList[j].dry_place+"</td>");
				}else if(data.schList[j].ctgry_idx == "CTIDX00083"){//공연
					calobj_list.append("<th scope='row'>[행사]</th><td class='txt_left'><a href='/display/displayView.do?srch_menu_nix=ne37l2c7&disp_idx="+data.schList[j].reference_key.split('|')[1]+"'>"+data.schList[j].subject+"</a></td><td class='point01'>"+data.schList[j].startdt+"</td><td>"+data.schList[j].dry_place+"</td>");
				}else if(data.schList[j].ctgry_idx == "CTIDX00084"){//행사
					calobj_list.append("<th scope='row'>[교육]</th><td class='txt_left'><a href='/resvetcman/resvetcmanView.do?&rsv_gb=CDIDX00042&menu_user_se=3&srch_menu_nix=z9dvSySs&rsv_no="+data.schList[j].reference_key.split('|')[2]+"'>"+data.schList[j].subject+"</a></td><td class='point01'>"+data.schList[j].startdt+"</td><td>"+data.schList[j].dry_place+"</td>");
				}else if(data.schList[j].ctgry_idx == "CTIDX00085"){//교육
					calobj_list.append("<th scope='row'>[기타]</th><td class='txt_left'>"+data.schList[j].subject+"</td><td class='point01'>"+data.schList[j].startdt+"</td><td>"+data.schList[j].dry_place+"</td>");
				}
				calobj_list.append("</tr>");
			}
			
			jQuery("#divCalbtnListAllCtrl > button:eq(0), #divCalbtnSchAllCtrl > button:eq(0)")
				.unbind("click")
				.bind("click", function(){
					var setmon = (mon == 1) ? 12 : mon - 1; 
					var setyr = (setmon == 12) ? yr - 1 : yr;
					
					jQuery("#srchcalYr").val(setyr);
			    	jQuery("#srchcalMon").val(setmon);
			    	loadScheduleAll();
			});
			
			jQuery("#divCalbtnListAllCtrl > button:eq(1), #divCalbtnSchAllCtrl > button:eq(1)")
				.unbind("click")
				.bind("click", function(){
					var setmon = (mon == 12) ? 1 : mon + 1; 
					var setyr = (setmon == 1) ? yr + 1 : yr;
					
					jQuery("#srchcalYr").val(setyr);
			    	jQuery("#srchcalMon").val(setmon);
			    	loadScheduleAll();
			});
			
			
		},
	    error: function(xhr, err){
			alert("에러가 발생했습니다.");
	    }
	});
	
}
function calendar_detail_main(num){
	
	if($("#calendar_td"+num).parent().parent().attr("class")=="spread"){
		$("#calendar_td"+num).parent().parent().attr("class","");
	}else if($("#calendar_td"+num).parent().parent().attr("class")=="sat"){
		$("#calendar_td"+num).parent().parent().attr("class","sat spread");
	}else if($("#calendar_td"+num).parent().parent().attr("class")=="sat spread"){
		$("#calendar_td"+num).parent().parent().attr("class","sat");
	}else if($("#calendar_td"+num).parent().parent().attr("class")=="sun"){
		$("#calendar_td"+num).parent().parent().attr("class","sun spread");
	}else if($("#calendar_td"+num).parent().parent().attr("class")=="sun spread"){
		$("#calendar_td"+num).parent().parent().attr("class","sun");
	}else if($("#calendar_td"+num).parent().parent().attr("class")=="point01"){
		$("#calendar_td"+num).parent().parent().attr("class","point01 spread");
	}else if($("#calendar_td"+num).parent().parent().attr("class")=="sun point01"){
		$("#calendar_td"+num).parent().parent().attr("class","sun point01 spread");
	}else if($("#calendar_td"+num).parent().parent().attr("class")=="point01 spread"){
		$("#calendar_td"+num).parent().parent().attr("class","point01");
	}else if($("#calendar_td"+num).parent().parent().attr("class")=="sun point01 spread"){
		$("#calendar_td"+num).parent().parent().attr("class","sun point01");
	}else{
		$("#calendar_td"+num).parent().parent().attr("class","spread");
	}
	
}


function fn_egov_change_calmode(mode)
{
	
	if(mode == 'list')
	{
		jQuery("#divSchcalendarArea").hide();
		jQuery("#divSchlistArea").fadeIn( "slow", "linear" );
	}
	else
	{
		jQuery("#divSchlistArea").hide();
		jQuery("#divSchcalendarArea").fadeIn( "slow", "linear" );
	}
	
}
</script>