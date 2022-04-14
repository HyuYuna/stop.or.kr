/*----------------------------------------------------------------------------
 * 공통 실행 스크립
 * ---------------------------------------------------------------------------
 * Author	: (주)플랜아이
 * ---------------------------------------------------------------------------
 * History
 * ---------------------------------------------------------------------------
 * 2018-05-14 (pigcos)	: 최초작성
 * -------------------------------------------------------------------------*/



;jQuery(document).ready(function($)
{
	try
	{
		$('form.ajax-form-submit').AjaxFormSubmit();
		
		var settings = {
				'type'			: 'post',
//				'data'			: {'HTTP_X_REQUESTED_WITH' : 'XMLHttpRequest'},
//				'$form'			: {},
				'dataType'		: 'json',
				'tinymce_name'	: ['content'],
				'tinymce_focus'	: function (name)
				{
//					if (typeof(tinyMCE)!='object') { return false; }
//					if (typeof(this.tinymce_name)!='object') { return false; }
//
//					if ($.inArray(name, this.tinymce_name)!=-1)
//					{
//						tinyMCE.activeEditor.focus();
//					}
				},
				'beforeSubmit'	: function (arr, form, options)
				{
					$form = form;
		//			alert($form.html());
				},
				'success'	: function (result, status, xhr)
				{
					if (result.messages) {
						var type = typeof(result.messages);
						if (type.toLowerCase() == "string") {
							alert(result.messages);
							if(result.messages.captcha_val) {
								fn_egov_captcha_refresh();
							}
						
						} else {
		//					console.log(result.messages);
							var field = "";
							var tagName = "";
							var beforeKey = "";
							var messages = new Array();
							$form.find(":input").each(function () {
								var key = $(this).attr('name');
								if (result.messages[key] && beforeKey != key) {
		//							console.log(result.messages[key]);
									for(var i=0; i<Object.keys(result.messages[key]).length; i++) {
										messages.push(result.messages[key][i]);
									}
									if (!field) {
										field = key;
										tagName = $(this)[0].tagName;
									}
									beforeKey = key;
								}
							});
							if (messages.length > 0) {
								alert(messages[0]);	// 에러메세지 1개 적용
								if(result.messages.captcha_val) {
									fn_egov_captcha_refresh();
								}
		//						alert(messages.join('\n'));	// 에러메세지 여러개 적용
							}
							if (field) {
								$(this).find(tagName+"[name='" + field + "']").focus();
							}
						}
					} else {
						/*파일업로드*/
				       	if(lg_use_atch == "Y")
			        	{
				       		// 게시판별로 데이터 입력 체크
				       		if(lg_brd_gb == "CDIDX00044")
				       		{
				       			fupgb = "THM";
				       		}
				       		else
				       		{
				       			fupgb = "GNR";
				       		}
			        		// UPLOADIFY 사용 저장 처리
			        		if(lg_use_uploadify == "Y")
			        		{
			        			try
			        			{
				        			cmmfn_set_uploadifykeys('file_upload',lg_brd_id,result.data,1,fupgb);
				        			
					       			cmmfn_upload_uploadify('file_upload',fn_egov_complete_upload);
			        			}
			        			catch(e)
			        			{
			        				fn_egov_complete_upload();
			        			}
			        		}
			        	}
					}
					
					if (result.url) {
						location.replace(result.url);
					}
		
				},
				error	: function (xhr, e, status)
				{
//					alert('Error!!');
//					console.log(xhr.responseText);
					var html = $.parseHTML(xhr.responseText);
					var message = $(html).find('#error-message').html();
					if (message && message.length > 0) {
						alert(message);
					} else {
						location.reload();
//						alert('Error!!');
					}
				}
			
		}

	$('form.board-ajax-form-submit')
	.submit(function ()
	{

		if(lg_editor_gb)
		{
			var brd_text = $('#brd_cont').val();

			// 에디터 종류에 따른 입력 값 확인
			if(lg_editor_gb == "B")
			{
				content = tinyMCE.activeEditor.getContent();
				brd_text = content;
				$('#brd_cont').val(brd_text);
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
					$('#brd_cont').val(brd_text);
				}
				
			}
			else if(lg_editor_gb == "D")
			{
				var hwpctrl = document.getElementById("brd_cont");
				var brd_cont = hwpctrl.GetTextFile("HWP", "");
				$('#brd_cont').val(brd_cont);
				brd_text = hwpctrl.GetTextFile("UNICODE", "");			
			
			}
			else if(lg_editor_gb == "F")
			{
				oEditors.getById["brd_cont"].exec("UPDATE_CONTENTS_FIELD", []);
				brd_cont = jQuery("#brd_cont").val();
				$('#brd_cont').val(brd_cont);
				brd_text = brd_cont;
			}
			else if(lg_editor_gb == "G")
			{
				brd_cont = Editor.getContent();
				$('#brd_cont').val(brd_cont);
				brd_text = brd_cont;
			}
			else if(lg_editor_gb == "Z")
			{
				if(lg_srch_menu_nix == 'wZ311Dfx')
				{
					if(lg_brd_id == 'BDIDX_lkc50Gv082E33tD0Zsv2n0' || lg_brd_id == 'BDIDX_gQ7i747CKk4zN0cU1qxlqk')
					{
						brd_cont = Editor.getContent();
						$('#brd_cont').val(brd_cont);
						brd_text = brd_cont;
					}
				}
			
			}
			
		}
	})
	.ajaxForm(settings);

		
	/*익명게시판 패스워드 ajax*/
	$('#pwd_ok').click(function()
	{
		$.ajax({
	        url 		: $(this).attr('data-url'),
	        type  		: "post",
	        data 		: $('body').find('form').eq(0).serialize(),
	        datatype	: "json",
			async 		: false,	        
	        success 	: function(result){
				if (result.messages) {
					var type = typeof(result.messages);
					if (type.toLowerCase() == "string") {
						alert(result.messages);
					} else {
	//					console.log(result.messages);
						var field = "";
						var tagName = "";
						var beforeKey = "";
						var messages = new Array();
						$form.find(":input").each(function () {
							var key = $(this).attr('name');
							if (result.messages[key] && beforeKey != key) {
	//							console.log(result.messages[key]);
								for(var i=0; i<Object.keys(result.messages[key]).length; i++) {
									messages.push(result.messages[key][i]);
								}
								if (!field) {
									field = key;
									tagName = $(this)[0].tagName;
								}
								beforeKey = key;
							}
						});
						if (messages.length > 0) {
							alert(messages[0]);	// 에러메세지 1개 적용
							if(result.messages.captcha_val) {
								fn_egov_captcha_refresh();
							}
	//						alert(messages.join('\n'));	// 에러메세지 여러개 적용
						}
						if (field) {
							$(this).find(tagName+"[name='" + field + "']").focus();
						}
					}
					
				} 
				if (result.url) {
					$('#brd_pass').attr('value',$('#chkpwdval').val());
					$('form').eq(0).attr('action',result.url);
					$('form').eq(0).submit();
				}
	
	        	
	        },
	        error: function(xhr, err){
	            
	        	alert("에러가 발생했습니다.");
	        }
	    }); 
	});
	
	/*클릭시 다운로드 레이어 팝업 ajax*/
	
	$('.btn-layerpopup').on('click', function(){
		$.ajax({
	        url 		: $(this).attr('data-url'),
	        type  		: "get",
	        datatype	: "html",
			async 		: false,	        
	        success 	: function(data){
	        	$('div#contents').after(data);
	        	$('article#downlode').show();
	        }
		});
		var $self = $(this);
		var $target = $('article#downlode');	
		$target.attr('tabindex', '0').focus();

		 $("#downlode .close").click(function(){
			$self.focus();
			$(this).off('click');
		});
		
	});
	

	
	
	}
	catch(e)
	{
		console.log(e);
		$.debug(e);
	}
	
});
//디지털성범죄 링크
$(function(){
	$(window).load(function(){
		if (window.location.href.indexOf("ucont_id=CTX000090&srch_menu_nix=l3vdU8Xo#tab1") > -1) {
			$("#divUcont_cont #tab1").show();
			$("#divUcont_cont #tab2, #divUcont_cont #tab3, #divUcont_cont #tab4, #divUcont_cont #tab5").hide();
			$(".tabmenu").show();
			$(".tabmenu li").eq(0).addClass("active").siblings().removeClass("active");
		}
		if (window.location.href.indexOf("ucont_id=CTX000090&srch_menu_nix=l3vdU8Xo#tab5") > -1) {
			$("#divUcont_cont #tab5").show();
			$("#divUcont_cont #tab1, #divUcont_cont #tab2, #divUcont_cont #tab3, #divUcont_cont #tab4").hide();
			$(".tabmenu").show();
			$(".tabmenu li").eq(1).addClass("active").siblings().removeClass("active");
		}
		if (window.location.href.indexOf("ucont_id=CTX000090&srch_menu_nix=l3vdU8Xo#tab2") > -1) {
			$("#divUcont_cont #tab2").show();
			$("#divUcont_cont #tab1, #divUcont_cont #tab3, #divUcont_cont #tab4, #divUcont_cont #tab5").hide();
			$(".tabmenu").show();
			$(".tabmenu li").eq(2).addClass("active").siblings().removeClass("active");
		}
		if (window.location.href.indexOf("ucont_id=CTX000090&srch_menu_nix=l3vdU8Xo#tab3") > -1) {
			$("#divUcont_cont #tab3").show();
			$("#divUcont_cont #tab1, #divUcont_cont #tab2, #divUcont_cont #tab4, #divUcont_cont #tab5").hide();
			$(".tabmenu").show();
			$(".tabmenu li").eq(3).addClass("active").siblings().removeClass("active");
		}
		if (window.location.href.indexOf("ucont_id=CTX000090&srch_menu_nix=l3vdU8Xo#tab4") > -1) {
			$("#divUcont_cont #tab4").show();
			$("#divUcont_cont #tab1, #divUcont_cont #tab2, #divUcont_cont #tab3, #divUcont_cont #tab5").hide();
			$(".tabmenu").show();
			$(".tabmenu li").eq(4).addClass("active").siblings().removeClass("active");
		}
		if (window.location.href.indexOf("ucont_id=CTX000085&srch_menu_nix=84aAn4cp") > -1) {
			$(".tabmenu").hide();
		}

	});
});

