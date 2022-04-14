//  ## TPCODE : TPAGE0015 : 게시판 목록 / 읽기 스크립트 ## 
var cot_idx = '';

function fn_egov_init_brdcontent()
{

	/**************************************
	 * 버튼 이벤트 바인딩
	 **************************************/
	 if(typeof(fn_egov_brd_add) == "function")
	 	jQuery("#btnBoardAdd").on("click", fn_egov_brd_add);

	jQuery("#btnBoardAllList").on("click", fn_egov_brd_alllist);
	jQuery("#btnBoardSearch").on("click", fn_egov_brd_search);
	 	
 	
	jQuery("#searchKeyword").unbind("keypress");
	jQuery("#searchKeyword").keydown(function(event){
		if(event.keyCode == 13)
		{
			fn_egov_brd_search();
			return false;
		}
	});
	//jQuery("button[id^='btnFaqModify_']").on("click", fn_egov_faq_modbtn);
	 
	 
	/**************************************
	 * 버튼 이벤트 바인딩
	 **************************************/
	
	if(lg_brd_gb == "CDIDX00044")
	{
		// 썸네일 게시판인 경우 action 타겟 처리 
		targetAct = "Boardthm";
		targetGrp = "brdthm";
	}
	else if(lg_brd_gb == "CDIDX00046")
	{
		// 익명 게시판인 경우 action 타겟 처리 
		targetAct = "Boardanonim";
		targetGrp = "brdanm";
	}
	else if(lg_brd_gb == "CDIDX00045")
	{
		// 일정 게시판인 경우 action 타겟 처리 
		targetAct = "Boarddry";
		targetGrp = "brddry";

		cmmfn_set_datepicker(g_context, jQuery("#startdd, #enddd", jQuery("#divSchedule")), "%Y-%m-%d");
		
		if(lg_rw_png >= 2)
		{
			// 일정 입력 폼 초기화
			jQuery("#divSchedule")
				.css('font-size', '0.8em')	
				.dialog({
					title : '일정 정보',
					autoOpen : false,
					modal : true,
					width : 620,
					height : 395,
					buttons : [ 
					           /*
								{ text: "저장", click: function() { fn_egov_schedule_save($(this)); } },
								{ text: "삭제", click: function() { fn_egov_schedule_delete($(this)); } },
					        { text: "닫기", click: function() { $( this ).dialog( "close" ); } }
							*/
					],
					open:function(){
				        $(this).parents(".ui-dialog:first").find(".ui-dialog-titlebar").remove();
				        jQuery(".popup_close").css("height", "22px");
				        jQuery("#noinput_area", jQuery("#divSchedule")).hide();
				        jQuery("#input_area", jQuery("#divSchedule")).show();
				    },
				});
		}
		else
		{
			// 일정 입력 폼 초기화
			jQuery("#divSchedule")
				.css('font-size', '0.8em')	
				.dialog({
					title : '일정 정보',
					autoOpen : false,
					modal : true,
					width : 620,
					height : 370,
					buttons : [ 
					          /*
					        { text: "닫기", click: function() { $( this ).dialog( "close" ); } }
					         */
					],
					open:function(){
				        $(this).parents(".ui-dialog:first").find(".ui-dialog-titlebar").remove();
				        jQuery(".popup_close").css("height", "22px");
				        jQuery("#input_area", jQuery("#divSchedule")).hide();
				        jQuery("#noinput_area", jQuery("#divSchedule")).show();
				    }, 
				});
		}
		
		var valign = cmmfn_get_valignopt();
		
		try{
			// 시간 선택 입력상자 초기화
			jQuery("#starthh, #endhh", jQuery("#divSchedule"))
				.timepicker({
					// http://fgelinas.com/code/timepicker/ 참고
					rows: 4,
				    hourText: '시간',            // Define the locale text for "Hours"
				    minuteText: '분',         	// Define the locale text for "Minute"
				    amPmText: ['', ''],       	// Define the locale text for periods
					showCloseButton: true,      // shows an OK button to confirm the edit
				    closeButtonText: '닫기',     // Text for the confirmation button (ok button)
				    showNowButton: true,        // Shows the 'now' button
				    nowButtonText: 'Now',       // Text for the now button
				    hours: {
				        starts: 8,              // First displayed hour
				        ends: 20                // Last displayed hour
				    },
				    minutes: {
				        starts: 0,              // First displayed minute
				        ends: 50,               // Last displayed minute
				        interval: 10            // Interval of displayed minutes
				    }
				})
				.css({"font-size":"11px","width":"50px","height":"14px","text-align":"center", "z-index":"11", "vertical-align" : valign});
		}catch(err){
			
		}
		
		
		// 일정 관리 Calendar 초기화
		$('#drycalendar').fullCalendar({
			editable: true,
			theme: true, 
			weekends : true,
			allDayText : '종일',
			axisFormat : 'tt h시(:mm분)',
			lazyFetching : false,
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay'
			},
			titleFormat : {
			    month: 'yyyy년 MM월',                             	// September 2009
			    week: "yyyy년 MM월 d일{ ~ [yyyy년][ MM월] d일}", 		// Sep 7 - 13 2009
			    day: 'yyyy년 MM월 d일 ddd요일'                  		// Tuesday, Sep 8, 2009
			},
			columnFormat: {
				month: 'ddd',
				week: 'M월 d일 ddd요일',
				day: 'M월 d일 ddd요일'
			},
			timeFormat: { // for event elements
				'': 'H시(:mm분)' // default
			},
			dayNamesShort : [ '일','월','화','수','목','금','토'],
			buttonText : {
				today : 'Today',
				month : '월간',
				week : '주간',
				day : '일간'
			},
			// 이벤트 렌더링 (이벤트 데이터를 동적으로 불러온다.)
			events : function(start, end, callback) {
							        	
		        $.ajax({
		            url: g_context + '/brddry/boarddryJsonList.do',
		            dataType: 'json',
		            cache : false,
		            data: {
		                // our hypothetical feed requires UNIX timestamps
		                brd_id: lg_brd_id,
		                startdt : cmmfn_date_to_string(start, 'DD', '-'),
		                enddt : cmmfn_date_to_string(end, 'DD', '-')
		            },
		            success: function(data) {
		                
		            	var events = [];
	            		var dt = $('#drycalendar').fullCalendar('getDate');

	            		fn_egov_schedule_defholiday(events, dt);
	            		
		            	for(var i = 0; i < data.length; i++)
		            	{
		            		var holiday_yn = data[i].holiday_yn;
		            		var allday_yn  = data[i].allday_yn;
		            		var repeat_yn  = data[i].repeat_yn;
		            		var startdt = data[i].startdt;
		            		var enddt = data[i].enddt;
		            		var ar_title = data[i].subject;
		            		var ar_start = (holiday_yn == 'Y' && repeat_yn == 'Y') ? dt.getFullYear() + startdt.substr(4, startdt.length) : startdt;
		            		var ar_end = (holiday_yn == 'Y' && repeat_yn == 'Y') ? dt.getFullYear() + enddt.substr(4, enddt.length) : enddt;
		            		var ar_className = (holiday_yn == 'Y') ? 'event-holiday' : allday_yn == 'Y' ? 'event-normal' : 'event-timer';
		            		var ar_allDay = allday_yn  == 'Y' ? true : false;
		            		var writer_nm = data[i].writer_nm;
		            			
		            		//alert(ar_title + " " + ar_start + " " + ar_end);
							events.push(
							{
								id : data[i].cont_idx,
								title : ar_title,
								start : ar_start,										
								end : ar_end,		
								className : ar_className,
								allDay : ar_allDay,
								holiday : holiday_yn == 'Y' ? true : false,
								repeat : repeat_yn == 'Y' ? true : false,
								basicdef : false,
								description : data[i].brd_cont,
								writer_nm : writer_nm
							});				            		
		            	}
		            	
		            	
		                callback(events);
		                
		            }
		        });
		    },
		    // 달력에서 날짜를 클릭했을때 Callback
			dayClick: function(date, allDay, jsEvent, view) {

				if(lg_rw_png >= 2)
				{
					jQuery("#schmode", jQuery("#divSchedule")).val("add");
					jQuery("#subject", jQuery("#divSchedule")).val("");
					jQuery("#brd_cont", jQuery("#divSchedule")).val("");
					jQuery("#allday_yn", jQuery("#divSchedule")).prop("checked", false);
					jQuery("#holiday_yn", jQuery("#divSchedule")).prop("checked", false);
					jQuery("#startdd", jQuery("#divSchedule")).val(cmmfn_date_to_string(date, "DD", "-"));
					jQuery("#enddd", jQuery("#divSchedule")).val(cmmfn_date_to_string(date, "DD", "-"));
					jQuery("#starthh", jQuery("#divSchedule"))
						.val("00:00")
						.prop("disabled", false);
					jQuery("#endhh", jQuery("#divSchedule"))
						.val("00:00")
						.prop("disabled", false);
					jQuery("#divSchedule").dialog('open');

				}
				
		    },
		    // 이벤트를 클릭했을때 Callback
			eventClick: function(calEvent, jsEvent, view) {

		        // 기본 정의된 휴일 / 명절 등일때는 설정창을 보이지 않는다. 
		        if(calEvent.basicdef == true)
		        	return;
				var start = calEvent.start;
				var end = calEvent.end == null ? start : calEvent.end;
				var shh = cmmfn_get_zerofill_string(start.getHours(), 2) + ":" + cmmfn_get_zerofill_string(start.getMinutes(), 2);
				var ehh = cmmfn_get_zerofill_string(end.getHours(), 2) + ":" + cmmfn_get_zerofill_string(end.getMinutes(), 2);

				jQuery("#schmode", jQuery("#divSchedule")).val("mod");
				jQuery("#cont_idx", jQuery("#divSchedule")).val(calEvent.id);
				jQuery("#subject", jQuery("#divSchedule")).val(calEvent.title);
				jQuery("#brd_cont", jQuery("#divSchedule")).val(calEvent.description);
				jQuery("#allday_yn", jQuery("#divSchedule")).prop("checked", calEvent.allDay ? true : false);
				jQuery("#holiday_yn", jQuery("#divSchedule")).prop("checked", calEvent.holiday ? true : false);
				jQuery("#startdd", jQuery("#divSchedule")).val(cmmfn_date_to_string(start, "DD", "-"));
				jQuery("#enddd", jQuery("#divSchedule")).val(cmmfn_date_to_string(end, "DD", "-"));

				jQuery("#div_subject", jQuery("#divSchedule")).html(calEvent.title);
				jQuery("#div_startdt", jQuery("#divSchedule")).html(cmmfn_date_to_string(start, "DD", "-") + " " + shh);
				jQuery("#div_enddt", jQuery("#divSchedule")).html(cmmfn_date_to_string(end, "DD", "-") + " " + ehh);
				jQuery("#div_brd_cont", jQuery("#divSchedule")).html(calEvent.description);
				
				jQuery("#spanWriternm", jQuery("#divSchedule")).html(calEvent.writer_nm);
				
				var disable = calEvent.allDay ? true : false;
				
				jQuery("#starthh", jQuery("#divSchedule"))
					.val(shh)
					.prop("disabled", disable);
				jQuery("#endhh", jQuery("#divSchedule"))
					.val(ehh)
					.prop("disabled", disable);
				
				cmmfn_remove_scrtag(jQuery("#brd_cont", jQuery("#divSchedule")));
				
				jQuery("#divSchedule").dialog('open');


		    },
		    viewRender  : function( view, cell ) { 
		    	/*
		    	alert(view.name);
		    	alert(view.visStart); 	// 달력에 표시되는 앞달의 마지막 날들을 포함한 시작일
		    	alert(view.visEnd); 	// 달력에 표시되는 뒷달의 처음 날들을 포함한 마지막 일
		    	*/
		    }
		});
		
		jQuery("#allday_yn", jQuery("#divSchedule")).click(function(){
			
			if($(this).prop("checked"))
			{
				jQuery("#starthh")
					.val("00:00")
					.prop('disabled', true);
				jQuery("#endhh")
					.val("00:00")
					.prop('disabled', true);
			}
			else
			{
				jQuery("#starthh").prop('disabled', false);

				jQuery("#endhh")
					.val("00:00").prop('disabled', false);
			}
		});
		
		// 시작 시간을 선택하면 종료시간을 같은 시간으로 설정한다. (입력오류를 줄이기 위한 임시 값 설정)
		jQuery("#starthh", jQuery("#divSchedule")).change(function(){
			
			jQuery("#endhh", jQuery("#divSchedule")).val($(this).val());
			
		});
		
		jQuery("#holiday_yn", jQuery("#divSchedule")).change(function(){
			if($(this).prop("checked"))
				jQuery("#allday_yn", jQuery("#divSchedule")).prop("checked", true);
		});
		
	} 
	else if(lg_brd_gb == "CDIDX00043")
	{
		// FAQ 게시판인 경우 action 타겟 처리 
		targetAct = "Boardfaq";
		targetGrp = "brdfaq";
		
		jQuery("tr[id^='trFaqans']").hide();
		jQuery("a[id^='aFaqsubj']").click(function(){
			
			var trid = $(this).attr("id").replace(/aFaqsubj/g, "");
			jQuery("tr[id^='trFaqans']").hide();
			var opentrobj = jQuery("#trFaqans" + trid);
			cmmfn_remove_scrtag(opentrobj);
			opentrobj.show();
			
			jQuery("a[id^='aFaqsubj']").removeClass("on");
			$(this).addClass("on");
			
		    $.ajax({
		        url 	: g_context + '/brdfaq/boardfaqXcnt.do',
		        type  	: "post",
		        data 	: {
		        			brd_id : lg_brd_id,
		        			cont_idx : trid
		        },
		        datatype	: "json",
				async 		: false,	        
		        success 	: function(data){        	
		        }
		    });
			
		});
	} 
	else if(lg_brd_gb == "N")
	{
		// 일반 게시판인 경우 action 타겟 처리 
		targetAct = "Boardnews";
		targetGrp = "brdnws";
	}
	else if(lg_brd_gb == "A")
	{
		// 익명 게시판인 경우 action 타겟 처리 
		targetAct = "Boardanonim";
		targetGrp = "brdanm";
	}
	else
	{
		// 일반 게시판인 경우 action 타겟 처리 
		targetAct = "Boardarticle";
		targetGrp = "brdartcl";
		
	}
	
	cmmfn_remove_scrtag(jQuery("span[id*='spanListSubject']"));
		
	jQuery("tr[id*='trNoticeY']").css("background-color", "#f5f5f5");	
		
	
	
}


function fn_egov_brd_search()
{
	var form = document.reqForm;
	if(jQuery("#searchKeyword").val() == "")
	{
		alert("검색어를 입력해주십시오");
		jQuery("#searchKeyword").focus();
		return; 
	}
		
	form.pageIndex.value = 1;
	fn_egov_brd_list();
}

function fn_egov_brd_list()
{
	var form = document.reqForm;
	fn_egov_move_action(form, "/" + targetGrp + "/" + targetAct.toLowerCase() + "List.do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id + fn_egov_get_argstr()+"&srch_mu_site="+lg_mu_site);
}


function fn_egov_brd_listopn(srchval)
{
	var form = document.reqForm;
	form.srch_open_ccnt.value = srchval;
	fn_egov_move_action(form, "/" + targetGrp + "/" + targetAct.toLowerCase() + "List.do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id + fn_egov_get_argstr());
}


// action 실행
function fn_egov_move_action(form, act)
{
	form.action = g_context + act;
	form.submit();
}

function fn_egov_brd_add()
{
	var form = document.reqForm;
	form.edomweivgp.value = "A";

	fn_egov_move_action(form, "/" + targetGrp + "/" + targetAct.toLowerCase() + "MoveView.do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id + fn_egov_get_argstr());	
}	

function fn_egov_brd_alllist()
{
	var form = document.reqForm;
	form.edomweivgp.value = "A";
	
	if(lg_srch_menu_nix == "IR3T73EE")
	{
		fn_egov_move_action(form, "/modebd/modebdmenuList.do?srch_menu_nix=IR3T73EE" + fn_egov_get_argstr());
	}
	else
	{
		fn_egov_move_action(form, "/modebd/modebdList.do?srch_menu_nix=wZ311Dfx" + fn_egov_get_argstr());
	}
	

}	

function fn_egov_brd_view(cont_idx)
{
	if(lg_ulv > 10000 && lg_off_viewmode == "0")
	{
		// 로그인 하지 않은 사용자에 대한 게시판 권한이 사용 불가
		alert("게시판을 이용할 권한이 없습니다.");
	}
	else if(lg_ulv > 1000 && lg_ulv < 10000 &&  lg_on_viewmode == "0")
	{
		// 로그인한 사용자에 대한 게시판 권한이 사용 불가
		alert("게시판을 이용할 권한이 없습니다.");
	}
	else
	{
		var form = document.reqForm;
		form.edomweivgp.value = "R";
		form.cont_idx.value = cont_idx;
			
		fn_egov_move_action(form, "/" + targetGrp + "/" + targetAct.toLowerCase() + "View.do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id + fn_egov_get_argstr());

	}
	
}

function fn_egov_unauth_scrt()
{
	alert("선택하신 게시물은 비공개이므로 조회하실 수 없습니다.");
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo)
{
	if(lg_ulv > 10000 && lg_off_viewmode == "0")
	{
		// 로그인 하지 않은 사용자에 대한 게시판 권한이 사용 불가
		alert("게시판을 이용할 권한이 없습니다.");
	}
	else if(lg_ulv > 1000 && lg_ulv < 10000 &&  lg_on_viewmode == "0")
	{
		// 로그인한 사용자에 대한 게시판 권한이 사용 불가
		alert("게시판을 이용할 권한이 없습니다.");
	}
	else
	{
		var form = document.reqForm;
		form.pageIndex.value = pageNo;
		
		fn_egov_brd_list();
	}
	
}

// 스케줄 저장
function fn_egov_schedule_save()
{
	
	var data = cmmfn_get_post_data('divSchedule');

	if(data.subject == '')
	{
		alert('일정명을 입력해주십시오');
		jQuery("#subject", jQuery("#divSchedule")).focus();
		return;
	}
	if(data.brd_cont == '')
	{
		alert('내용을 입력해주십시오');
		jQuery("#brd_cont", jQuery("#divSchedule")).focus();
		return;
	}

	data.startdt = data.startdd + " " + data.starthh;
	data.enddt = data.enddd + " " + data.endhh;
	data.repeat_yn = 'N';
	
	if(confirm('일정을 저장하시겠습니까?\n\n일정명 : ' + data.subject + '\n시작일 : ' + data.startdt + "\n종료일 : " + data.enddt) == false)
		return;
	
	var url = (jQuery("#schmode", jQuery("#divSchedule")).val() == 'add') ? g_context + "/brddry/addBoarddry.do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id : 
		g_context + "/brddry/mdfBoarddry.do?brd_id=" + lg_brd_id;
	
    $.ajax({
        url 		: url,
        type  		: "post",
        data 		: data,
        datatype	: "json",
		async 		: false,	        
        success 	: function(data){        	
	        alert("일정이 저장되었습니다.");
	        $('#drycalendar').fullCalendar('refetchEvents');

        },
        error: function(xhr, err){
        	alert("일정 저장 도중 에러가 발생했습니다.");
        }
    });
	
    fn_egov_dialog_close();
}

// 스케줄 삭제
function fn_egov_schedule_delete()
{
	
	var data = cmmfn_get_post_data("divSchedule");
	
	if(confirm('일정을 삭제하시겠습니까?') == false)
		return;
	
    $.ajax({
        url 		: g_context + "/brddry/rmvBoarddry.do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id,
        type  		: "post",
        data 		: data,
        datatype	: "json",
		async 		: false,	        
        success 	: function(data){        	
	        alert("일정이 삭제되었습니다.");
	        $('#drycalendar').fullCalendar('refetchEvents');

        },
        error: function(xhr, err){
        	alert("일정 삭제 도중 에러가 발생했습니다.");
        }
    });
	
    fn_egov_dialog_close();
}

function fn_egov_brd_mod(cont_idx)
{
	var form = document.reqForm;
	form.cont_idx.value = cont_idx;
	form.edomweivgp.value = "M";
	fn_egov_move_action(form, "/" + targetGrp + "/" + targetAct.toLowerCase() + "MoveView.do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id +  fn_egov_get_argstr());
}


// 연중 휴일 / 국경일 / 기념일 정의
function fn_egov_schedule_defholiday(eventobj, dt)
{
	var seolnal = "";
	var booda = "";
	var chooseok = "";
	
	 $.ajax({
	        url 		: g_context + '/brddry/holidaySolarJsonList.do',
	        type  		: "post",
	        data 		: {
	        	searchYr : dt.getFullYear()
	        },
	        datatype	: "json",
			async 		: false,	        
	        success 	: function(data){        	
		        
	        	var sp = data.toString().split(",");
	        	
	        	seolnal = cmmfn_string_to_date(sp[0]);
	        	booda = sp[1];
	        	chooseok = cmmfn_string_to_date(sp[2]);
	        },
	        error: function(xhr, err){
	        	alert("에러가 발생했습니다.");
	        }
	    });
	 
	
	eventobj.push(
	{
		title : '양력설',
		start : dt.getFullYear() + '-01-01 00:00',										
		end : dt.getFullYear() + '-01-01 00:00',										
		className : 'event-holiday',
		allDay : true,
		basicdef : true 
	});
	
	// 신정은 올해것과 다음해 거를 동시에 넣어야 12월달에도 표시가 된다.
	eventobj.push(
	{
		title : '양력설',
		start : (dt.getFullYear() + 1) + '-01-01 00:00',										
		end : (dt.getFullYear() + 1) + '-01-01 00:00',										
		className : 'event-holiday',
		allDay : true,
		basicdef : true
	});
	
	if(seolnal != "")
	{

		eventobj.push(
		{
			title : '음력설',
			start : cmmfn_get_shift_time(seolnal, 0, 0, -1),										
			end : cmmfn_get_shift_time(seolnal, 0, 0, 1),										
			className : 'event-holiday',
			allDay : true,
			basicdef : true
		});
	}
	
	eventobj.push(
	{
		title : '3.1절',
		start : dt.getFullYear() + '-03-01 00:00',										
		end : dt.getFullYear() + '-03-01 00:00',										
		className : 'event-holiday',
		allDay : true,
		basicdef : true
	});

	eventobj.push(
	{
		title : '식목일',
		start : dt.getFullYear() + '-04-05 00:00',										
		end : dt.getFullYear() + '-04-05 00:00',										
		className : 'event-normal',
		allDay : true,
		basicdef : true
	});
	
	eventobj.push(
	{
		title : '노동자의 날',
		start : dt.getFullYear() + '-05-01 00:00',										
		end : dt.getFullYear() + '-05-01 00:00',										
		className : 'event-normal',
		allDay : true,
		basicdef : true
	});
	
	eventobj.push(
	{
		title : '어린이날',
		start : dt.getFullYear() + '-05-05 00:00',										
		end : dt.getFullYear() + '-05-05 00:00',										
		className : 'event-holiday',
		allDay : true,
		basicdef : true
	});

	eventobj.push(
	{
		title : '어버이날',
		start : dt.getFullYear() + '-05-08 00:00',										
		end : dt.getFullYear() + '-05-08 00:00',										
		className : 'event-normal',
		allDay : true,
		basicdef : true
	});

	eventobj.push(
	{
		title : '스승의날',
		start : dt.getFullYear() + '-05-15 00:00',										
		end : dt.getFullYear() + '-05-15 00:00',										
		className : 'event-normal',
		allDay : true,
		basicdef : true
	});

	if(booda != "")
	{
		eventobj.push(
		{
			title : '석가탄신일',
			start : booda + ' 00:00',										
			end : booda + ' 00:00',										
			className : 'event-holiday',
			allDay : true,
			basicdef : true
		});
	}
	eventobj.push(
	{
		title : '현충일',
		start : dt.getFullYear() + '-06-06 00:00',										
		end : dt.getFullYear() + '-06-06 00:00',										
		className : 'event-holiday',
		allDay : true,
		basicdef : true
	});

	eventobj.push(
	{
		title : '광복절',
		start : dt.getFullYear() + '-08-15 00:00',										
		end : dt.getFullYear() + '-08-15 00:00',										
		className : 'event-holiday',
		allDay : true,
		basicdef : true
	});
	
	if(chooseok != "")
	{

		eventobj.push(
		{
			title : '추석',
			start : cmmfn_get_shift_time(chooseok, 0, 0, -1),										
			end : cmmfn_get_shift_time(chooseok, 0, 0, 1),										
			className : 'event-holiday',
			allDay : true,
			basicdef : true
		});
	}
	
	eventobj.push(
	{
		title : '개천절',
		start : dt.getFullYear() + '-10-03 00:00',										
		end : dt.getFullYear() + '-10-03 00:00',										
		className : 'event-holiday',
		allDay : true,
		basicdef : true
	});
	
	eventobj.push(
	{
		title : '한글날',
		start : dt.getFullYear() + '-10-09 00:00',										
		end : dt.getFullYear() + '-10-09 00:00',										
		className : (dt.getFullYear() >= 2013) ? 'event-holiday' : 'event-normal',
		allDay : true,
		basicdef : true
	});

	eventobj.push(
	{
		title : '크리스마스',
		start : dt.getFullYear() + '-12-25 00:00',										
		end : dt.getFullYear() + '-12-25 00:00',										
		className : 'event-holiday',
		allDay : true,
		basicdef : true
	});
	
	
	return eventobj;
}

function fn_egov_dialog_close()
{
	jQuery("#divSchedule").dialog('close');
}

function fn_egov_faq_modbtn(idx)
{
	fn_egov_brd_mod(idx);
}

function fn_egov_brd_cont(tabidx, link)
{
	// 컨텐츠는 Ajax 처리
	if(link.lastIndexOf("/modedg/contentsView.do") >= 0)
	{
		jQuery("li[id^='liTabcont_']").removeClass("on");
		jQuery("#liTabcont_" + tabidx).addClass("on");
		
		jQuery("div[id^='divTabCont_']").hide();
		jQuery("#divTabCont_" + tabidx).fadeIn('slow');
	}
	// 게시판은 submit 처리
	else
	{
		var form = document.reqForm;
		var url = link;
		url += (link.lastIndexOf("?") >= 0 ? "&" : "?") + "srch_menu_nix=" + lg_srch_menu_nix;
		fn_egov_move_action(form, url);
	}
}

function fn_egov_movetab_benefit(idx)
{
	jQuery(".tab_menu > li").removeClass("on");
	jQuery(".tab_menu > li:eq(" + idx + ")").addClass("on");
	
	jQuery("section[id^='benefit0']").hide();
	jQuery("#benefit0" + (idx + 1)).fadeIn('slow');
	
}


function fn_egov_show_pwdlayer(cont_idx)
{
	cot_idx = cont_idx;
	
	jQuery("#cont_idx").val(cont_idx);
	jQuery("#chkpwdval").val("");
	jQuery("#articleChkPwd").layercenter();
	jQuery("#articleChkPwd").fadeIn('slow');
	jQuery("#chkpwdval").focus();
	
}


function fn_egov_hide_pwdlayer()
{

	jQuery("#articleChkPwd").fadeOut('slow');
	jQuery("#contidx_"+cot_idx).closest('td.ellipsis').find('a').focus();

}


function fn_egov_chk_pwd() 
{
	var data = cmmfn_get_post_data("content");
	
	data.add_info_04 = jQuery("#chkpwdval").val();
	
	if(data.add_info_04 == "")
	{
		alert("패스워드를 입력해주십시오");
		return;
	}	
	$.ajax({
        url 		: g_context + "/brdanm/chkBoardPwd.do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id,
        type  		: "post",
        data 		: data,
        datatype	: "text",
		async 		: false,	        
        success 	: function(retval){        				
        	
        	if(retval == "SUCCESS")
        	{
       			var form = document.reqForm;
   				form.brd_pass.value=$("#chkpwdval").val();
           		form.edomweivgp.value = "R";
           		fn_egov_move_action(form, "/" + targetGrp + "/" + targetAct.toLowerCase() + "View.do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id);
        	}
        	else
        	{
        		alert("패스워드가 일치하지 않습니다.");
        	}
        	
        },
        error: function(xhr, err){
            
        	alert("에러가 발생했습니다.");
        }
    }); 
	
	dialog.dialog( "close" );
}
