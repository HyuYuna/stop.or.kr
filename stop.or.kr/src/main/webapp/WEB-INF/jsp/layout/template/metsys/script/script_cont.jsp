<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


	
<script type="text/javascript">



/**************************************************************
 *  			컨텐츠관리 페이지 초기화 Start
 **************************************************************/
var lg_editor_gb = "G";

function fn_egov_init_continspage()
{
	
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
	

	// 트리테이블 적용
	if(cmmfn_exist_object("tableModedgList") == true)
	{
		jQuery("#tableModedgList").treetable({ expandable: true, column : 1, indent : 18 });
		jQuery("#tableModedgList").treetable("expandAll");
	}
} 


function fn_egov_srch_list()
{
	var form = document.reqForm;
	form.pageIndex.value = "1";
	fn_egov_cont_list();
}

//컨텐츠 추가 페이지로 이동	
function fn_egov_cont_add()
{
	var form = document.reqForm;
	form.ucont_version.value = 0;
	form.edomweivgp.value = "A";
	fn_egov_move_action(form, "/modedg/contentsmanView.do?srch_menu_nix=${param.srch_menu_nix}" + fn_egov_get_argstr());
}

function fn_egov_cont_view(ucont_id)
{
	var form = document.reqForm;
	form.edomweivgp.value = "M";
	form.ucont_version.value = 0;
	form.ucont_id.value = ucont_id;
	fn_egov_move_action(form, "/modedg/contentsmanView.do?srch_menu_nix=${param.srch_menu_nix}" + fn_egov_get_argstr());		
}

//컨텐츠 목록 페이지로 이동
function fn_egov_cont_list() {
	var form = document.reqForm;
	form.ucont_id.value = "";
	
	if(lg_srch_menu_nix == "G0l5opl2")
		fn_egov_move_action(form, "/modedg/modedgmenuList.do?srch_menu_nix=${param.srch_menu_nix}" + fn_egov_get_argstr());
	else
		fn_egov_move_action(form, "/modedg/modedgList.do?srch_menu_nix=${param.srch_menu_nix}" + fn_egov_get_argstr());
	
}

//컨텐츠 메뉴연결 보기 페이지로 이동
function fn_egov_cont_menulist() {
	var form = document.reqForm;
	form.ucont_id.value = "";
	fn_egov_move_action(form, "/modedg/modedgmenuList.do?srch_menu_nix=${param.srch_menu_nix}" + fn_egov_get_argstr());
}

//컨텐츠 목록 페이지로 이동
function fn_egov_cont_mod() {
	var form = reqForm;
	form.edomweivgp.value = "M";
	fn_egov_move_action(form, "/modedg/contentsmanView.do?srch_menu_nix=${param.srch_menu_nix}" + fn_egov_get_argstr());		
}
	

function fn_egov_complete_upload()
{
	alert("저장이 완료되었습니다.");
	fn_egov_cont_mod();
}	
	
function fn_egov_cont_save()
{
	var data = cmmfn_get_post_data("divMainArticle");
	var fupgb = "";
	var addnew = jQuery("#chkAddnew").prop("checked");

	var brd_text = data.ucont_cont;
	
	// 에디터 종류에 따른 입력 값 확인
	if(lg_editor_gb == "B"){
		content = tinyMCE.activeEditor.getContent();
		brd_text = content;
	
	}else if(lg_editor_gb == "C"){
		var editor = CKEDITOR.instances.ucont_cont;
		brd_text = editor.getData();
		brd_text = brd_text.replace(/\r\n/g, "");
		brd_text = brd_text.replace(/\r/g, "");
		brd_text = brd_text.replace(/\n/g, "");
		
	}else if(lg_editor_gb == "D"){
		var hwpctrl = document.getElementById("ucont_cont");
		var ucont_cont = hwpctrl.GetTextFile("HWP", "");
		data.ucont_cont = ucont_cont;
		brd_text = hwpctrl.GetTextFile("UNICODE", "");			
	
	}else if(lg_editor_gb == "G"){
		brd_cont = Editor.getContent();
		data.brd_cont = brd_cont;
		brd_text = brd_cont;			
	}
	
	if(cmmfn_check_inputnull(jQuery("#ucont_subject, #ucont_dft")) == false)
	{
		return;
	}
	
	if(cmmfn_str_trim(brd_text) == "" || brd_text == "<p>&nbsp;</p>")
	{
		alert("내용은 반드시 입력하셔야 합니다.");
		cmmfn_editor_focus();
		return;
	}

	data.ucont_cont = brd_text;

	data.mu_site = jQuery("#sel_mu_site").val();
	data.mu_lang = jQuery("#sel_mu_lang").val();
	data.ref_menu_nix = jQuery("#ref_menu_nix").val();
	data.srch_menu_nix = lg_srch_menu_nix;
	
	var bizst = "";
	var msg_confirm = "";

	if(addnew)
	{
		if(jQuery("#edomweivgp").val() == "A")
		{
			bizst = "add";
			msg_confirm = "컨텐츠를 새로 등록하시겠습니까?";
		}
		else
		{
			bizst = "newver";
			msg_confirm = "새 버전으로 등록하시겠습니까??";
		}
	}
	else
	{
		bizst = "mdf";
		msg_confirm = "수정된 내용을 저장하시겠습니까?";
	}
	
	
	if(confirm(msg_confirm) == false)
		return;
	
	  $.ajax({
	      url 		: "${pageContext.request.contextPath}/modedg/" + bizst + "Contentsman.do?srch_menu_nix=${param.srch_menu_nix}",
	      type  		: "post",
	      data 		: data,
	      datatype	: "json",
			async 		: false,	        
	      success 	: function(data){        	

	      	var key = cmmfn_str_trim(data);
	      	var version = key.replace(/CTX[0-9]{6}_/gi, ""); 
	      	
	      	ucont_id = key.replace(/_[0-9]{1,6}/gi, "");
	      	jQuery("#ucont_id").val(ucont_id);
	      	jQuery("#ucont_version").val(version);
			cmmfn_set_uploadifykeys('file_upload', '${CONTENTS_UPLOAD_KEY}', ucont_id, version, fupgb);
    		cmmfn_upload_uploadify('file_upload', fn_egov_complete_upload);

	      },
	      
	      error: function(){
	          
	      	alert("에러가 발생했습니다.");
	      }
	  });
}


//다음에디터 콜백함수
function validForm(editor) {
	
	var validator = new Trex.Validator();
	var content = editor.getContent();
	
}


function fn_egov_atchimage_set(obj)
{
	obj.html(jQuery("#ucont_cont").val());
	cmmfn_remove_scrtag(jQuery("#divUcont_cont"));
	if(jQuery("input[name='alter_img_atch']").prop("checked") == false)
	{
		return obj.html();
	}
	
	obj.find("img").each(function(){
		
		//alert($(this).prop("src"));
		
		var oldsrc = $(this).prop("src");
		if(oldsrc.indexOf("imageAtchfileByFilename.do") < 0)
		{
			var rname = oldsrc.substr(oldsrc.lastIndexOf("/") + 1, oldsrc.length);
			var newsrc = "${pageContext.request.contextPath}/atchfile/imageAtchfileByFilename.do";
			newsrc += "?atckey_1st=${CONTENTS_UPLOAD_KEY}";
			newsrc += "&atckey_2nd=" + jQuery("#ucont_id").val();
			newsrc += "&atckey_3rd=" + jQuery("#ucont_version").val(); 
			newsrc += "&rname=" + encodeURIComponent(rname);
			
			$(this).prop("src", encodeURI(newsrc));
		}
	});
	
	return obj.html();
	
}

//선택한 버전으로 복원하기
function fn_egov_cont_recyclever(version)
{
	if(confirm("선택하신 버전을 복원하시겠습니까?\n이후에 등록된 버전은 모두 삭제됩니다.") == false)
		return;	
	
	var data = new Object();
	data.ucont_id = jQuery("#ucont_id").val();
	data.ucont_version = version;
	
  $.ajax({
      url 		: g_context + '/modedg/restoreContentsman.do?srch_menu_nix=${param.srch_menu_nix}',
      type  		: "post",
      data 		: data,
      datatype	: "json",
		async 		: false,	        
      success 	: function(data){        	
			
      	alert("복원되었습니다.");
      	jQuery("#ucont_version").val(version);
      	fn_egov_cont_mod();
      },
      error: function(){
          
      	alert("에러가 발생했습니다.");
      }
  });
}



//선택한 버전 미리보기
function fn_egov_cont_mainprev(id, version)
{
	var form = document.prevForm;
	var url = "${pageContext.request.contextPath}/modedg/contentsmanView.do";
	url += "?edomweivgp=" + "P";
	url += "&ucont_id=" + id;
	url += "&ucont_version=" + version;
	url += "&srch_menu_nix=${param.srch_menu_nix}";

	var bw = cmmfn_get_browserinfo(); 
	if(bw.startsWith("IE") )
	{
		cmmfn_open_modaldialog(url, 820, 700, "yes", null);
	}
	else
	{
		window.open('','popPreview','width=820,height=700,left=300,top=100,resizable=no,scroll=yes');
		form.target = 'popPreview';
		form.action = url;
		form.submit();	
		
	}
	
}

//선택한 버전 미리보기
function fn_egov_cont_prev(version)
{
	var form = document.prevForm;
	var url = "${pageContext.request.contextPath}/modedg/contentsmanView.do";
	url += "?edomweivgp=" + "P";
	url += "&ucont_id=" + jQuery("#ucont_id").val();
	url += "&ucont_version=" + version;
	url += "&srch_menu_nix=${param.srch_menu_nix}";
	
	var bw = cmmfn_get_browserinfo(); 
	if(bw.startsWith("IE") )
	{
		cmmfn_open_modaldialog(url, 820, 700, "yes", null);
	}
	else
	{
		window.open('','popPreview','width=820,height=700,left=300,top=100,resizable=no,scroll=yes');
		form.target = 'popPreview';
		form.action = url;
		form.submit();	
		
	}
}

function fn_egov_cont_del()
{
	if(confirm("현재 컨텐츠를 모두 삭제하시겠습니까?\n모든 버전의 컨텐츠가 삭제되며\n삭제된 데이터는 복구되지 않습니다.") == false)
		return;

	var data = new Object();
	data.ucont_id = jQuery("#ucont_id").val();
	data.ucont_version = 0;
	
  $.ajax({
      url 		: g_context + '/modedg/restoreContentsman.do?srch_menu_nix=${param.srch_menu_nix}',
      type  		: "post",
      data 		: data,
      datatype	: "json",
		async 		: false,	        
      success 	: function(data){        	
			
      	alert("삭제되었습니다.");
      	fn_egov_cont_list();
      },
      error: function(){
          
      	alert("에러가 발생했습니다.");
      }
  });
		
}

function fn_egov_link_page(pageIndex)
{
	var form = document.reqForm;
	form.pageIndex.value = pageIndex;
	fn_egov_move_action(form, "/modedg/modedgList.do?srch_menu_nix=${param.srch_menu_nix}" + fn_egov_get_argstr());
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
	if(confirm("현재 컨텐츠와 메뉴의 연동정보를 삭제하시겠습니까 ?") == false)
		return false;
	
	var cont_id = jQuery("#ucont_id").val();
	
	$.ajax({
	    url 		: g_context + '/modedg/rmvRef_srch_menu_nix.do?srch_menu_nix=${param.srch_menu_nix}',
	    type  		: "post",
	    data 		: {
	    	ucont_id : cont_id
	    },
	    datatype	: "json",
		async 		: false,	        
	    success 	: function(data){        	
		
	    	alert("삭제되었습니다.");
	    	fn_egov_cont_mod(cont_id);
	    },
	    error: function(){
	        
	    	alert("에러가 발생했습니다.");
	    }
	});
}

/**************************************************************
 *  			컨텐츠관리 페이지 초기화 End
 **************************************************************/
 
</script>

