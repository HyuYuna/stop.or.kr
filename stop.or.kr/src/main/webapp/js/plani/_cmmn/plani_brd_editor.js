//  ## TPCODE : TPAGE0016 : 게시판 쓰기 스크립트 ##

function fn_egov_init_brdeditor()
{
	
	/**************************************
	 * 버튼 이벤트 바인딩
	 **************************************/
	 
	if(typeof(fn_egov_brd_reply) == "function")
		jQuery("#btnBoardReply").on("click", fn_egov_brd_reply);
	if(typeof(fn_egov_brd_mod) == "function")
		jQuery("#btnBoardMod").on("click", fn_egov_brd_mod);
	if(typeof(fn_egov_brd_del) == "function")
		jQuery("#btnBoardDel").on("click", fn_egov_brd_del);
	if(typeof(fn_egov_brd_list) == "function")
		jQuery("#btnBoardList").on("click", fn_egov_brd_list);
	if(typeof(fn_egov_brd_save) == "function")
		jQuery("#btnBoardSave").on("click", fn_egov_brd_save);
	if(typeof(fn_egov_brd_info) == "function")
		jQuery("#btnBoardInfo").on("click", fn_egov_brd_info);
	 
	
	jQuery("#btnBoardModPwd").on("click", fn_egov_brd_mod_pwd);
	jQuery("#btnBoardDelPwd").on("click", fn_egov_brd_del_pwd);
	
		
	/**************************************
	 * 버튼 이벤트 바인딩
	 **************************************/
	
	
	if(lg_brd_gb == "CDIDX00044")
	{
		// 썸네일 게시판인 경우 action 타겟 처리 
		targetAct = "Boardthm";
		targetGrp = "brdthm";
		jQuery("#brd_utb").css("width", "100%");
		
	}
	else if(lg_brd_gb == "CDIDX00043")
	{
		// FAQ 게시판인 경우 action 타겟 처리 
		targetAct = "Boardfaq";
		targetGrp = "brdfaq";
	}	
	else if(lg_brd_gb == "CDIDX00046")
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
	
	cmmfn_remove_scrtag(jQuery("#subject"));
	cmmfn_remove_scrtag(jQuery("#reply_cont"));
	jQuery("div[id^='spanReplyArea_']").each(function(){
		var val = $(this).html();
		val = fn_egov_reply_tagdiv(val);
		$(this).html(val);
	});
	
	if(lg_pgmode == "R")
	{

		// 페이지가 읽기모드인 경우 처리
		jQuery("#subject").prop("readOnly", true);
				
		// 컨텐츠영역 초기화
		if(lg_brd_gb == "CDIDX00042" || lg_brd_gb == "CDIDX00043" || lg_brd_gb == "CDIDX00046")
		{
			var cont_obj = jQuery("#divBrd_cont");
			// 일반 게시판인 경우에만 내용관련 부분을 초기화한다.
		 	/*
			cont_obj.hide();
			cmmfn_remove_scrtag(cont_obj);
			var val = cont_obj.html();
			val = val.replace(/&amp;nbsp;/gi, "&nbsp;");
			val = val.replace(/&amp;nbsp/gi, "&nbsp;");
			cont_obj.html(val);
			*/
			if(jQuery('div#divBrd_cont img').length == 0)
			{
				var h = cont_obj.height();
				if (h < 100)
					cont_obj.height(150);
				
			}
			cont_obj.show();
			
			// 한글컨트롤인 경우 초기화
			if(lg_editor_gb == "D")
			{
				fn_egov_load_hwpdata();
				var hwpctrl = document.getElementById("brd_cont");	
				hwpctrl.EditMode = 0;
			}

		}
		else
		{
			
		}

		jQuery("div#divBrd_cont > p.cls_center")
			.css("text-align", "center");
	}
	else
	{
		// 페이지가 읽기모드가 아닌 경우 처리
		
		// 에디터 초기화
		if(lg_brd_gb == "CDIDX00042" || lg_brd_gb == "CDIDX00043"|| lg_brd_gb == "CDIDX00044" || lg_brd_gb == "CDIDX00046")
		{
			if(lg_editor_gb == "D")
			{
				if(lg_pgmode == "M")
					fn_egov_load_hwpdata();
				
	   			cmmfn_init_editor("brd_cont", lg_editor_gb, null);
			}
			else if(lg_editor_gb == "Z")
			{
				if(lg_srch_menu_nix == 'wZ311Dfx')
				{
					if(lg_brd_id == 'BDIDX_lkc50Gv082E33tD0Zsv2n0' || lg_brd_id == 'BDIDX_gQ7i747CKk4zN0cU1qxlqk')
					{
						// 그 밖의 에디터를 사용하는 경우 저장된 내용 html 처리
						cmmfn_remove_scrtag(jQuery("#brd_cont"));
			   			cmmfn_init_editor("brd_cont", "G", null);
					}
				}
				else
				{
					cmmfn_init_editor("brd_cont", lg_editor_gb, null);
				}
			}
			else
			{
				
				// 그 밖의 에디터를 사용하는 경우 저장된 내용 html 처리
				cmmfn_remove_scrtag(jQuery("#brd_cont"));
	   			cmmfn_init_editor("brd_cont", lg_editor_gb, null);
			}
			
		}
		
		// 첨부파일 초기화
		if(lg_use_atch == "Y")
		{
			// 이미지 게시판인 경우 이미지파일만 등록가능하도록 한다.
			if(lg_use_uploadify == "Y")
			{
				// uploadify 사용시 초기화
				if(lg_brd_gb == "CDIDX00044") // 갤러리/이미지 게시판
				{
					//cmmfn_init_uploadify("file_upload", g_context, lg_atch_ctlimit, lg_atch_cnt, lg_atch_szlimit, "IMG", fn_egov_complete_upload);
					cmmfn_init_uploadify("file_upload", g_context, lg_atch_ctlimit, lg_atch_cnt, lg_atch_szlimit, "IMG&PDF&ZIP", fn_egov_complete_upload);
				}
				else
				{
					cmmfn_init_uploadify("file_upload", g_context, lg_atch_ctlimit, lg_atch_cnt, lg_atch_szlimit, "GNR", fn_egov_complete_upload);
				}
			}
			else
			{
				//////////////////////////////////////////////////////////
				// 파일이 첨부되어있는 경우 파일선택 폼필드를 숨긴다.
				jQuery("input[id^='empty_file']").each(function(){
					var idx = $(this).attr('id');
					idx = idx.replace(/empty_file/g, "");
					
					if($(this).val() == "N")
						jQuery("#file_upload" + idx).hide();
				});
				//
				//////////////////////////////////////////////////////////
			}
		}
		
		if(lg_editor_gb == "E")
		{
			jQuery("#editorWrapper").css("height", "900px").css("width", "100%");
		}
		else if(lg_editor_gb == "G")
		{
			jQuery("#editorWrapper").css("padding-left", "5px").css("padding-right", "5px");
		}
		
	}
		

	jQuery("img[id^='imgViewImage']").each(function(){
    	
		var idx = $(this).attr("id").replace(/imgViewImage_/g, "");
    	var w = parseInt(jQuery("#img_width_" + idx).val());
    	var h = parseInt(jQuery("#img_height_" + idx).val());
    	
    	if(w > 620)
    	{
    		var rate = 620 / w;
    		w = 620;
    		h = Math.round(h * rate);
    	}

		$(this).prop("width", w);	    	
    	$(this).prop("height", h);
    	
	});
	
	// 이미지 크기 조정
	if(cmmfn_exist_object("divBrd_cont")){
		jQuery('div#divBrd_cont img').each(function(){

			var bodyWidth = jQuery('#divBrd_cont').width();
			var bodyHeight = jQuery('#divBrd_cont').height();
			
			var imgWidth = jQuery(this).width();
			var imgHeight = jQuery(this).height();
			
			if(imgWidth - bodyWidth > 0){
				var reduceRate = bodyWidth / imgWidth;
				jQuery(this).width(bodyWidth);
				jQuery(this).height(imgHeight * reduceRate);
			}

		});
	}
	
	if(cmmfn_exist_object("spanResponseArea") == true)
	{
		jQuery("#spanResponseArea").html(cmmfn_date_to_string(new Date(), "DD", "-"));	
	}
	
}


function fn_egov_load_hwpdata()
{
	var hwpctrl = document.getElementById("brd_cont");	
	var cont = jQuery("#brd_cont_base").val();
	hwpctrl.SetTextFile(cont, "HWP", "");
}

function fn_egov_complete_upload()
{
	alert("저장이 완료되었습니다.");
	fn_egov_brd_list();
}
	
	
// 페이지에 대한 쓰기 이상의 권한을 가지고 있는 경우에만 오픈되는 함수를 정의한다.
function fn_egov_brd_save()
{
	
	var data = cmmfn_get_post_data("divMainArticle");
	var fupgb = "";
	var pgmode = lg_pgmode;
	
	if(lg_use_ctgry == "Y" && data.ctgry_idx == "" )
	{
		alert("카테고리는 반드시 선택하셔야 합니다.");
		return;
	}
	
	if(lg_off_viewmode == "2")
	{
		if(cmmfn_check_inputnull(jQuery("#add_info_01", jQuery("#divMainArticle"))) == false)
			return;
		
		if(lg_pgmode == "A" && cmmfn_check_inputnull(jQuery("#add_info_04", jQuery("#divMainArticle"))) == false)
			return;	
	}

	var brd_text = data.brd_cont;
	
	// 에디터 종류에 따른 입력 값 확인
	if(lg_editor_gb == "B")
	{
		content = tinyMCE.activeEditor.getContent();
		brd_text = content;
		data.brd_cont = brd_text;
	}
	else if(lg_editor_gb == "C")
	{
		var editor = CKEDITOR.instances.brd_cont;
		if(editor != null && editor != undefined)
		{
			brd_text = editor.getData();
			brd_text = brd_text.replace(/\r\n/g, "");
			brd_text = brd_text.replace(/\r/g, "");
			brd_text = brd_text.replace(/\n/g, "");
			data.brd_cont = brd_text;
		}
		
	}
	else if(lg_editor_gb == "D")
	{
		var hwpctrl = document.getElementById("brd_cont");
		var brd_cont = hwpctrl.GetTextFile("HWP", "");
		data.brd_cont = brd_cont;
		brd_text = hwpctrl.GetTextFile("UNICODE", "");			
	
	}
	else if(lg_editor_gb == "F")
	{
		oEditors.getById["brd_cont"].exec("UPDATE_CONTENTS_FIELD", []);
		brd_cont = jQuery("#brd_cont").val();
		data.brd_cont = brd_cont;
		brd_text = brd_cont;
	}
	else if(lg_editor_gb == "G")
	{
		brd_cont = Editor.getContent();
		data.brd_cont = brd_cont;
		brd_text = brd_cont;
	}

	// 게시판별로 데이터 입력 체크
	if(lg_brd_gb == "CDIDX00044")
	{
		if(cmmfn_check_inputnull(jQuery("#subject")) == false)
			return;

		fupgb = "THM";

		if(cmmfn_str_trim(brd_text) == "" || cmmfn_str_trim(brd_text) == "<p>&nbsp;</p>")
		{
			alert("내용은 반드시 입력하셔야 합니다.");
			cmmfn_editor_focus();
			return;
		}
	}
	else
	{
		if(cmmfn_check_inputnull(jQuery("#subject")) == false)
			return;
		
		fupgb = "GNR";
		
		if(cmmfn_str_trim(brd_text) == "" || cmmfn_str_trim(brd_text) == "<p>&nbsp;</p>")
		{
			alert("내용은 반드시 입력하셔야 합니다.");
			cmmfn_editor_focus();
			return;
		}
		
	}

	var bizst = "";
	var msg_confirm = "";
	
	switch(pgmode)
	{
		case 'A' : 
		case 'P' :
			bizst = "add";
			msg_confirm = "내용을 등록하시겠습니까?";
			break;
		case 'M' :
			bizst = "mdf";
			msg_confirm = "내용을 수정하시겠습니까?";
			jQuery("#brd_pass").val(jQuery("#chkpwdval").val());	
			break;
		default :
			return;
	}

	if(lg_use_atch == "Y" && lg_use_uploadify == "N")
	{
		////////////////////////////////////////////////////////////////////
		// 파일 확장자 검사, 첨부된 파일이 있는데 또 첨부된 경우
		if(cmmfn_check_fext(jQuery("#file_upload1, #file_upload2, #file_upload3"), "GNR") == false)
		{
			return;	
		}
		
		jQuery("input[id^='empty_file'").each(function(){
			var idx = $(this).attr('id');
			idx = idx.replace(/empty_file/g, "");
			
			if($(this).val() == "N" && jQuery("#file_upload" + idx).val() != "")
			{
				alert("이미 첨부된 파일을 삭제하시고 다시 첨부해주십시오.");
				return false;
			}
		});
		////////////////////////////////////////////////////////////////////
	}
	


	if(cmmfn_exist_object("captcha_val") == true)
	{
	 	var chkcap = false;
		$.ajax({
	        url 		: g_context + "/brdanm/checkBoardanonimCaptcha.do?srch_menu_nix=" + lg_srch_menu_nix,
	        type  		: "post",
	        data 		: {
	        	captcha_val : jQuery("#captcha_val").val()
	        },
	        dataType	: "json",
			async 		: false,	        
	        success 	: function(data){
	        
	        	var ret = cmmfn_str_trim(data);
	        	
	        	if(ret == "SUCCESS")
	        		chkcap = true;
	        },
	        error: function(xhr, status, err){
	            
	        	alert("보안문자를 처리하는 도중 에러가 발생했습니다.\n");
	        	fn_egov_captcha_refresh();
	        }
		});

		if(chkcap == false)
		{
			alert("보안문자를 정확하게 입력해주십시오");
			fn_egov_captcha_refresh();
			jQuery("#captcha_val").focus();
			
			return;
		}
		
	}
	
	
	if(confirm(msg_confirm) == false)
	{
		fn_egov_captcha_refresh();
		return;
	}
	
	var url = "/" + targetGrp + "/" + bizst + targetAct + ".do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id;
    $.ajax({
        url 		: g_context + url,
        type  		: "post",
        data 		: data,
        dataType	: "json",
		async 		: false,	        
        success 	: function(data){    

        	var cont_idx = cmmfn_str_trim(data);

        	jQuery("#cont_idx").val(cont_idx);
        	
        	
        	if(lg_use_atch == "Y")
        	{
        		
        		// UPLOADIFY 사용 저장 처리
        		if(lg_use_uploadify == "Y")
        		{
					cmmfn_set_uploadifykeys('file_upload', lg_brd_id, cmmfn_str_trim(data), 1, fupgb);
        			
	       			cmmfn_upload_uploadify('file_upload', fn_egov_complete_upload);
        		}
        		// FORM 필드 사용 저장 처리
        		else
        		{
        			var form = document.reqForm;
        			form.method = "post";
        			form.action = g_context + "/" + targetGrp + "/upload" + targetAct + "Form.do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id,
        			form.submit();	
        		}
        	}
        	else
        	{
        		alert("저장이 완료되었습니다.");

        		// 저장을 완료한 후 선택된 값이 검색어로 검색되지 않도록 초기화 한다.
        		if(lg_brd_gb == "CDIDX00042" && lg_brd_gb_sub == "F")
					jQuery("#ctgry_idx").val("");					
        		
        		fn_egov_brd_list();
        	}
        },
        error: function(xhr, status, err){
            
        	alert("저장 도중 에러가 발생했습니다.\n");
        	if(cmmfn_exist_object("captcha_val") == true)
        	{
        		fn_egov_captcha_refresh();
        	}
        }

    });
		
}

// 다음에디터 콜백함수
function validForm(editor) {
	
	var validator = new Trex.Validator();
	var content = editor.getContent();
	
	
}

function fn_egov_captcha_refresh()
{
	var d = new Date();
	jQuery("#captcha_img").attr("src", g_context + "/jcaptcha?" + d.getMilliseconds());
}
	

// 읽기, 쓰기 권한 및 삭제권한 까지 가지고 있는 경우에만 오픈되는 함수목록
function fn_egov_brd_del()
{
	
	if(lg_brd_gb == "CDIDX00043")
	{
		
		if(confirm("현재 글을 삭제하시겠습니까?") == false)
			return;

		var form = document.reqForm;
		fn_egov_move_action(form, "/" + targetGrp + "/rmv" + targetAct +".do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id+"&srch_mu_site="+lg_mu_site);
	}
	else
	{
		var form = document.reqForm;
		
		if(lg_reply_gb == "A")
		{		
			if(confirm("현재 글을 삭제하시겠습니까?\n현재 글의 답글(댓글)은 모두 같이 삭제됩니다.") == false)
				return;

			
			if($("#chkpwdval").val())
			{
				form.brd_pass.value = $("#chkpwdval").val();
			}
			fn_egov_move_action(form, "/" + targetGrp + "/rmv" + targetAct +"group.do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id+"&srch_mu_site="+lg_mu_site);
		}
		else
		{
			if(confirm("현재 글을 삭제하시겠습니까?") == false)
				return;
			
			if($("#chkpwdval").val())
			{
				form.brd_pass.value = $("#chkpwdval").val();
			}
			fn_egov_move_action(form, "/" + targetGrp + "/rmv" + targetAct +".do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id+"&srch_mu_site="+lg_mu_site);

		}
	}
	
}


// 읽기, 쓰기 권한을 가지고 있는 경우 오픈되는 함수목록
function fn_egov_brd_mod()
{
	var form = document.reqForm;
	//form.method = "get";
	form.edomweivgp.value = "M";
	location.href="/" + targetGrp + "/" + targetAct.toLowerCase() + "MoveView.do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id+"&srch_mu_site="+lg_mu_site+"&cont_idx="+$("form[name=reqForm]").find('#cont_idx').val()+"&edomweivgp=M";
	//fn_egov_move_action(form, "/" + targetGrp + "/" + targetAct.toLowerCase() + "MoveView.do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id+"&srch_mu_site="+lg_mu_site+"cont_idx="+$("form[name=reqForm]").find('#cont_idx').val()+"&edomweivgp=M");
}


function fn_egov_brd_reply()
{
	var form = document.reqForm;

	form.edomweivgp.value = "P";
	fn_egov_move_action(form, "/" + targetGrp + "/" + targetAct.toLowerCase() + "MoveView.do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id);
}

function fn_egov_brd_preview()
{
	var content = "";
	
	if(lg_editor_gb == 'B')
	{
		content = tinyMCE.activeEditor.getContent();
		
	}
	else if(lg_editor_gb == 'C')
	{
		var editor = CKEDITOR.instances.brd_cont;
		brd_text = editor.getData();
		brd_text = brd_text.replace(/\r\n/g, "");
		brd_text = brd_text.replace(/\r/g, "");
		brd_text = brd_text.replace(/\n/g, "");
		content = brd_text;
		
	}
	else if(lg_editor_gb == 'D')
	{
		var hwpctrl = document.getElementById("brd_cont");
		var brd_cont = hwpctrl.GetTextFile("HWP", "");
		content = brd_cont;

	}
	else if(lg_editor_gb == 'E')
	{
		var str = document.getElementById("twe").MimeValue();
		content = str;
	}
	else
	{
		content = jQuery("#brd_cont").val();
		content = content.replace(/\r\n/g, "<br/>");
		content = content.replace(/\n/g, "<br/>");
	}	
	jQuery('#previewContent').val(content);
	
	var form = document.previewForm;
	var url = g_context + "/brdartcl/boardPreview.do";
	window.open('','popPreview','width=800,height=700,left=300,top=100,resizable=no');
	form.target = 'popPreview';
	form.action = url;
	form.submit();
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
		if(cont_idx == undefined || cont_idx == null)
			form.cont_idx.value = jQuery("#cont_idx").val();
		else
			form.cont_idx.value = cont_idx;
		
		fn_egov_move_action(form, "/" + targetGrp + "/" + targetAct.toLowerCase() + "View.do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id+"&srch_mu_site="+lg_mu_site);
		
	}
	
}

/* 
// form 파일 삭제후 refresh 
function fn_egov_brd_view()
{
	<c:choose>
		<c:when test="${SESS_USR_LV gt 10000 and SESS_BRD_INFO.off_viewmode eq 0}">
			// 로그인 하지 않은 사용자에 대한 게시판 권한이 사용 불가인 경우
			alert("게시판을 이용할 권한이 없습니다.");
		</c:when>
		<c:when test="${SESS_USR_LV gt 1000 and SESS_USR_LV le 10000 and SESS_BRD_INFO.on_viewmode eq 0}">
			// 로그인한 사용자에 대한 게시판 권한이 사용 불가인 경우
			alert("게시판을 이용할 권한이 없습니다.");
		</c:when>
		<c:otherwise>
			var form = document.reqForm;
			form.edomweivgp.value = "R";
			form.cont_idx.value = jQuery("#cont_idx").val();
			fn_egov_move_action(form, "/" + targetGrp + "/" + targetAct.toLowerCase() + "View.do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id);
			
		</c:otherwise>
	</c:choose>
}
 */
 
// action 실행
function fn_egov_move_action(form, act)
{
	form.action = g_context + act;
	form.submit();
}

function fn_egov_brd_search()
{
	var form = document.reqForm;
	form.pageIndex = 1;
	fn_egov_brd_list();
}

function fn_egov_brd_list()
{
	var form = document.reqForm;
	fn_egov_move_action(form, "/" + targetGrp + "/" + targetAct.toLowerCase() + "List.do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id+"&srch_mu_site="+lg_mu_site);
}



// 댓글 저장
function fn_egov_reply_save()
{
	var data = cmmfn_get_post_data("divMainArticle");
	
	data.brd_id = lg_brd_id;
	
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
	        url 		: g_context + "/" + targetGrp + "/" + reply_mode + "Boardreply.do?srch_menu_nix=" + lg_srch_menu_nix,
	        type  		: "post",
	        data 		: data,
	        datatype	: "json",
			async 		: false,	        
	        success 	: function(retval){ 
	        	
        	if(reply_mode == "add")
        	{
        		
	        	var reply_cont = fn_egov_reply_tagdiv(retval.reply_cont);
	        	/*jQuery("ul[id='comment_write']").append("<li id=\"dlidx_" + retval.reply_idx + "\" style='display:none'>\
	        		<strong class=\"comment_write_name\">"+retval.writer+"</strong>\
	        		<span class=\"comment_write_date\">"+retval.wdt+"</span>\
					<div class=\"comment_write_content\" id=\"spanReplyArea_"+retval.reply_idx+"\">"+ reply_cont + "</div>\
					<p class=\"comment_write_btn\">\
						<a href=\"javascript:fn_egov_reply_mod('"+retval.reply_idx+"')\"><img src=\"" + g_context + "/images/template/content/btn_comment_modify.gif\" alt=\"수정\"></a>\
						<a href=\"javascript:fn_egov_reply_del('"+retval.reply_idx+"')\" class=\"background-none\"><img src=\"" + g_context + "/images/template/content/btn_comment_del.gif\" alt=\"삭제\"></a>\
					</p>");	    */   
	        	jQuery("ul[id='comment_write']").append("<li id=\"dlidx_" + retval.reply_idx + "\" style='display:none'>\
		        		<strong>"+retval.writer+"</strong>\
		        		<span>"+retval.wdt+"</span>\
						<p id=\"spanReplyArea_"+retval.reply_idx+"\">"+ reply_cont + "</p>\
						<p class=\"btn\">\
							<a href=\"javascript:fn_egov_reply_mod('"+retval.reply_idx+"')\">수정</a>\
							<a href=\"javascript:fn_egov_reply_del('"+retval.reply_idx+"')\" class=\"background-none\">삭제</a>\
						</p>");	        			
		        						
	        							
	        	
	        	jQuery("#dlidx_" + retval.reply_idx).delay(500).fadeIn(2000);
        		jQuery("#reply_cont").val("");
	        	
	        }
        	
        	else
        	{
        		var modval = jQuery("#reply_cont").val();
        		modval = modval.replace(/\r\n/gi, "<br>");
        		modval = modval.replace(/\n/gi, "<br>");
	        	jQuery("#spanReplyArea_" + retval.reply_idx).delay(500).fadeOut(500, function(){
	        		jQuery("#spanReplyArea_" + retval.reply_idx).html(modval);
	        	});
	        	jQuery("#spanReplyArea_" + retval.reply_idx).delay(500).fadeIn(2000);
        		
        		jQuery("#reply_cont").val("");
        		jQuery("#mod_reply_idx").val("");	
        	}
        },
        error: function(xhr, err){
        	alert("에러가 발생했습니다.");
        }
    });
	
}

//댓글 수정
function fn_egov_reply_mod(idx)
{
	jQuery("#mod_reply_idx").val(idx);
	var modval = jQuery("#spanReplyArea_" + idx).html();
	modval = modval.replace(/<br>/gi, "\r\n");
	jQuery("#reply_cont").val(modval);
	
}

//댓글 수정
function fn_egov_reply_mod_pwd(idx)
{
	$("#mod_reply_idx").val(idx);
	$("#reply_gb").val("mdf");
	
	
	dialog = $( "#dialog-form" ).dialog({
	      autoOpen: false,
	      height: 300,
	      width: 350,
	      modal: true,
	      buttons: {
	        "확인": chkBoardreply,
	        "취소": function() {
	          dialog.dialog( "close" );
	        }
	      },
	      close: function() {
	    	  $("#password").val("");
	      }
	    });
		
	dialog.dialog( "open" );
	
}

// 댓글 삭제
function fn_egov_reply_del(idx)
{
	if(confirm("댓글을 삭제하시겠습니까?") == false)
		return;
	
	var data = cmmfn_get_post_data("divMainArticle");
	data.reply_idx = idx;
	
    $.ajax({
        url 		: g_context + "/" + targetGrp + "/rmvBoardreply.do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id,
        type  		: "post",
        data 		: data,
        datatype	: "text",
		async 		: false,	        
        success 	: function(retval){        				
        	jQuery("#dlidx_" + idx).delay(500).fadeOut(1000);
        }, 
        error: function(xhr, err){
        	alert("에러가 발생했습니다.");
        }
    });
}

function fn_egov_brd_rcmnd()
{
	if(lg_rcmnd_cnt != 0)
	{
		alert("이 게시물에 대해서 이미 추천하셨습니다.");
	}
	
	if(rjctCnt != 0)
	{
		alert("이 게시물에 대해서 이미 반대하셨습니다.");
	}
	
	if(confirm("현재 게시물을 추천하시겠습니까?") == false) 
		return;
	
	var form = document.reqForm;
	form.action = g_context + "/" + targetGrp + "/addBoardrcmnd.do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id + "&rcmnd_gb=R";
	form.submit();

}

function fn_egov_brd_rjct()
{
	if(lg_rcmnd_cnt != 0)
	{
		alert("이 게시물에 대해서 이미 추천하셨습니다.");
	}
	
	if(rjctCnt != 0)
	{
		alert("이 게시물에 대해서 이미 반대하셨습니다.");
	}

	if(confirm("현재 게시물을 반대하시겠습니까?") == false) 
		return;

	var form = document.reqForm;
	form.action = g_context + "/" + targetGrp + "/addBoardrcmnd.do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id + "&rcmnd_gb=J";
	form.submit();

}
	
function fn_egov_atch_notfound()
{
	alert("첨부된 파일이 존재하지 않습니다.");
}
	
function validateKogl() 
{
	var frm = document.reqForm;
	var chkElement = "";

	for(var i=0; i<frm.pKoglUseYn.length; i++) 
	{ 
		if(frm.pKoglUseYn[i].checked == true) 
		{
	   		chkElement = frm.pKoglUseYn[i].value; 
		}
	} 	

	if(chkElement == "Y")
	{
		var chkElement1 = "";
		var chkElement2 = "";
		
		for(var j=0; j<frm.pKoglType1.length; j++) 
		{ 
			if(frm.pKoglType1[j].checked == true) 
			{
		   		chkElement1 = frm.pKoglType1[j].value; 
			}
		}
		
		if(chkElement1 == "")
		{
			alert("공공저작물 유형-상업적 이용표시를 선택하여 주십시오.");
			return false;
		}
		
		for(var k=0; k<frm.pKoglType2.length; k++) 
		{ 
			if(frm.pKoglType2[k].checked == true) 
			{
		   		chkElement2 = frm.pKoglType2[k].value; 
			}
		}		
		
		if(chkElement2 == "")
		{
			alert("공공저작물 유형-변경 허용을 선택하여 주십시오.");
			return false;
		}		
	}
	
	return true;
}

function chkRadio()
{
	var frm = document.reqForm;
	var chkElement = ""; 
	
	for(var i=0; i<frm.pKoglUseYn.length; i++) 
	{ 
		if(frm.pKoglUseYn[i].checked == true) 
		{
	   		chkElement = frm.pKoglUseYn[i].value; 
		}
	} 	
	
	if(chkElement == "N") {
		for(var j=0; j<frm.pKoglType1.length; j++) 
		{ 
	   		frm.pKoglType1[j].checked = false; 
	   		frm.pKoglType2[j].checked = false;
		} 			
	}
}

function setRadio()
{
	var frm = document.reqForm;
	var chkElement = ""; 
	
	for(var i=0; i<frm.pKoglUseYn.length; i++) 
	{ 
		if(frm.pKoglUseYn[i].checked == true)
		{
	   		chkElement = frm.pKoglUseYn[i].value; 
		}
	} 	
	
	if(chkElement == "N") {
		for(var j=0; j<frm.pKoglType1.length; j++) 
		{ 
	   		frm.pKoglType1[j].checked = false; 
	   		frm.pKoglType2[j].checked = false;
		} 			
	}	
}

function fn_egov_thmcont_view(type)
{
	jQuery("li[id^='liThmcont_']").removeClass('on');
	jQuery("#liThmcont_" + type).addClass('on');
	
	jQuery("div[id^='divThmcont_']").hide();
	jQuery("#divThmcont_" + type).fadeIn('slow');
}

var lg_thm_idx = 0;
function fn_egov_thmmove_img(idx)
{
	lg_thm_idx = idx;
	
	var obj = jQuery(".thmb_photo > ul > li:eq(" + idx + ")").find("a");
	if(obj.length == 1)
	{
		jQuery(".list_photo > li").html(obj.html());	
	}
	
	jQuery(".thmb_photo > ul > li").removeClass("on");
	jQuery(".thmb_photo > ul > li:eq(" + idx + ")").addClass("on");
}

function fn_egov_thmmove_prev()
{
	var len = jQuery(".thmb_photo > ul > li").length;
	lg_thm_idx = lg_thm_idx == 0 ? len - 1 : lg_thm_idx - 1;
	fn_egov_thmmove_img(lg_thm_idx);
}

function fn_egov_thmmove_next()
{
	var len = jQuery(".thmb_photo > ul > li").length;
	lg_thm_idx = lg_thm_idx == len - 1 ? 0 : lg_thm_idx + 1;
	fn_egov_thmmove_img(lg_thm_idx);
}

function fn_egov_tabmenu_select(num){
	
	if(num==1)
	{
		$(".view_content_wrap").eq(0).css("display","");
		$(".view_content_wrap").eq(1).css("display","none");
		$(".view_content_wrap").eq(2).css("display","none");
		$(".view_content_tabmenu > li").eq(0).attr("class","on");
		$(".view_content_tabmenu > li").eq(1).attr("class","");
		$(".view_content_tabmenu > li").eq(2).attr("class","");
		
	}
	else if(num==2)
	{
		$(".view_content_wrap").eq(0).css("display","none");
		$(".view_content_wrap").eq(1).css("display","");
		$(".view_content_wrap").eq(2).css("display","none");
		$(".view_content_tabmenu > li").eq(0).attr("class","");
		$(".view_content_tabmenu > li").eq(1).attr("class","on");
		$(".view_content_tabmenu > li").eq(2).attr("class","");
		
	}
	else
	{
		$(".view_content_wrap").eq(0).css("display","none");
		$(".view_content_wrap").eq(1).css("display","none");
		$(".view_content_wrap").eq(2).css("display","");
		$(".view_content_tabmenu > li").eq(0).attr("class","");
		$(".view_content_tabmenu > li").eq(1).attr("class","");
		$(".view_content_tabmenu > li").eq(2).attr("class","on");
	}
}

function fn_egov_brd_mod_pwd()
{
	$('#edomweivgp').val('M')
	$("#mod_gb").val("mod");
	fn_egov_show_pwdlayer();
	
}

function fn_egov_brd_del_pwd()
{
	$("#mod_gb").val("del");
	fn_egov_show_pwdlayer();
}


function fn_egov_show_pwdlayer()
{
	jQuery("#chkpwdval", jQuery("#articleChkPwd")).val("");
	jQuery("#articleChkPwd").layercenter();
	jQuery("#articleChkPwd").fadeIn('slow');
	jQuery("#chkpwdval").focus();
	
}

function fn_egov_hide_pwdlayer()
{
	jQuery("#articleChkPwd").fadeOut('slow');
	var mod = jQuery("#mod_gb").val();
	if(mod == 'mod')
		$('a#mod_mod').focus();
	else if(mod == 'del') 
		$('a#mod_del').focus();
}


function fn_egov_chk_pwd() 
{

	var data = cmmfn_get_post_data("divMainArticle");
	
	data.add_info_04 = jQuery("#chkpwdval", jQuery("#articleChkPwd")).val();

	if(data.add_info_04 == "")
	{
		alert("패스워드를 입력해주십시오");
		return;
	}	
	
	$.ajax({
        url 		: g_context + "/" + targetGrp + "/chkBoardPwd.do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id,
        type  		: "post",
        data 		: data,
        datatype	: "text",
		async 		: true,	        
        success 	: function(retval){
        	
        	if(retval == "SUCCESS")
        	{
        		fn_egov_hide_pwdlayer();

        		if($("#mod_gb").val()=="mod")
        		{
        			var form = document.reqForm;
	           		form.edomweivgp.value = "M";
	    			form.brd_pass.value = jQuery("#chkpwdval").val();

	           		fn_egov_move_action(form, "/" + targetGrp + "/" + targetAct.toLowerCase() + "MoveView.do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id);
        		}
        		else
        		{
        			if(confirm("현재 글을 삭제하시겠습니까?") == false)
        				return;
        			
	           		var form = document.reqForm;
	    			form.brd_pass.value = jQuery("#chkpwdval").val();
	           		fn_egov_move_action(form, "/" + targetGrp + "/rmv" + targetAct + "group.do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id);
        		}
        	}
        	else
        	{
        		alert("비밀번호가 일치하지 않습니다.");
        		fn_egov_hide_pwdlayer();
        	}
        	
        	
        	
        },
        error: function(xhr, err){
            
        	alert("에러가 발생했습니다.");
        }
    }); 
	dialog.dialog( "close" );
}

function chkBoardreply() {
	
	var data = cmmfn_get_post_data("divMainArticle");
	
	data.brd_pwd_chk=$("#chkpwdval", jQuery("#articleChkPwd")).val();
	data.reply_idx=$("#mod_reply_idx").val();
	var idx = $("#mod_reply_idx").val();
	
	$.ajax({
        url 		: g_context + "/" + targetGrp + "/chkBoardreply.do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id,
        type  		: "post",
        data 		: data,
        datatype	: "text",
		async 		: false,	        
        success 	: function(retval){        				
			
        	if(retval){
        		
        		if($("#reply_gb").val()=="mdf"){
        			fn_egov_reply_mod(idx);
        		}else{
            	
	            	var data = cmmfn_get_post_data("divMainArticle");
	            	data.reply_idx = idx;
            	
	                $.ajax({
	                    url 		: g_context + "/" + targetGrp + "/rmvBoardreply.do?srch_menu_nix=" + lg_srch_menu_nix + "&brd_id=" + lg_brd_id,
	                    type  		: "post",
	                    data 		: data,
	                    datatype	: "text",
	            		async 		: false,	        
	                    success 	: function(retval){        				
	                    	jQuery("#dlidx_" + idx).delay(500).fadeOut(1000);
	                    }, 
	                    error: function(xhr, err){
	                    	alert("에러가 발생했습니다.");
	                    }
	                });
        		}
        	}else{
        		alert("비밀번호가 틀렸습니다.")
        	}
        	
        	
        	
        },
        error: function(xhr, err){
            
        	alert("에러가 발생했습니다.");
        }
    }); 
	dialog.dialog( "close" );
}


/**
 * String 내에서 태그 항목들을 처리한다. (XSS관련)
 * 2012.03.24 bhhan
 */
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
