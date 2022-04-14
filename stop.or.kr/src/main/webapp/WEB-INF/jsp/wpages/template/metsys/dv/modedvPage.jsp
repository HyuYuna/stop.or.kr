<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/template/metsys/webadm.css"  />
<script type="text/javascript">
	
	jQuery(document).ready(function(){
		//console.log("${dbtype}");
		var db_type = "${dbtype}";
		/*
		$("#input").cleditor({
			width:        '99%', // width not including margins, borders or padding          
			height:       400, // height not including margins, borders or padding          
		});
		
	    $("#file_upload").uploadify({
	        height      	: 30,
	        width         	: 120,
	        auto     		: false,
	        swf           	: '${pageContext.request.contextPath}/utils/fileupload/uploadify/uploadify.swf',
	        uploader      	: '/uploadify/uploadify.php',
	        itemTemplate 	: '<div id="@{fileID}" class="uploadify-queue-item">\
									<div class="cancel">\
										<a href="javascript:$(\'#@{instanceID}\').uploadify(\'cancel\', \'@{fileID}\')">X</a>\
									</div>\
									<span class="fileName">@{fileName} (@{fileSize})</span><span class="data"></span>\
									<div class="uploadify-progress">\
										<div class="uploadify-progress-bar"><!--Progress Bar--></div>\
									</div>\
								</div>',
			'onSelect' 		: function(file) {
	           						//alert('The file ' + file.name + ' was added to the queue.');
	        					}
	    });
		*/
		
		jQuery("textarea, TEXTAREA")
			.css("height", "300px")
			.prop("disabled", false);
	    
	    jQuery("li[id^='liDevTab']").click(function(){
	    
	    	jQuery("li[id^='liDevTab']").removeClass("on");
	    	$(this).addClass("on");    	
	    });
	    
		jQuery("#dir, #biznm").change(function(){
		
			var dir = jQuery("#dir").val();
			var biznm = jQuery("#biznm").val();
			
			var ctrl = "egovframework.plani.custom.#dir#.web.#biznm#Controller";
			var ctrl_man = "egovframework.plani.template.man.metsys.web.proj_add.Manact#biznm#Controller";
			var vo = "egovframework.plani.custom.#dir#.vo.#biznm#VO";
			var svc = "egovframework.plani.custom.#dir#.service.#biznm#Service";
			var impl = "egovframework.plani.custom.#dir#.service.impl.#biznm#ServiceImpl";
			var dao = "egovframework.plani.custom.#dir#.dao.#biznm#DAO";
			var sqlmap = "egovframework.sqlmap.com.${dbtype}.#biznm#_map";
			
			ctrl = ctrl.replace(/#dir#/g, dir.toLowerCase());
			ctrl = ctrl.replace(/#biznm#/g, cmmfn_get_Upper1stChar(biznm));
			jQuery("#ctrl").val(ctrl);

			ctrl_man = ctrl_man.replace(/#biznm#/g, cmmfn_get_Upper1stChar(biznm));
			jQuery("#ctrl_man").val(ctrl_man);

			vo = vo.replace(/#dir#/g, dir.toLowerCase());
			vo = vo.replace(/#biznm#/g, cmmfn_get_Upper1stChar(biznm));
			jQuery("#vo").val(vo);

			svc = svc.replace(/#dir#/g, dir.toLowerCase());
			svc = svc.replace(/#biznm#/g, cmmfn_get_Upper1stChar(biznm));
			jQuery("#svc").val(svc);

			impl = impl.replace(/#dir#/g, dir.toLowerCase());
			impl = impl.replace(/#biznm#/g, cmmfn_get_Upper1stChar(biznm));
			jQuery("#impl").val(impl);

			dao = dao.replace(/#dir#/g, dir.toLowerCase());
			dao = dao.replace(/#biznm#/g, cmmfn_get_Upper1stChar(biznm));
			jQuery("#dao").val(dao);

			sqlmap = sqlmap.replace(/#biznm#/g, biznm.toLowerCase());
			jQuery("#sqlmap").val(sqlmap);
			
			var lastdir = dir.substr((dir.lastIndexOf(".") < 0 ? 0 : dir.lastIndexOf(".") + 1), dir.length);
			jQuery("#useract_name").val("/usract/" + lastdir.toLowerCase() + cmmfn_get_Upper1stChar(biznm) + "/" + biznm + "List.do");

			jQuery("#manact_name").val("/manact/" + lastdir.toLowerCase()  + cmmfn_get_Upper1stChar(biznm) + "/" + biznm + "List.do");			
		});
		
		jQuery("#selectTablelist").bind("change", changeTablelist);
		jQuery("#codeBiznm, #codeSubBiznm, #codeBizkr, #codeDir").bind("keyup", generateDevCode);
		jQuery("input[name='codeGb']").bind("click", generateDevCode);
		
		
	    fn_egov_move_tab("Sub01");
	    initDivTabSub02();
	    initTableList();
	    
	    generateDevCode();
	    
	});

	// 테이블 목록을 가져옴..
	function initTableList()
	{
		var data = new Object();

		$.ajax({
	        url 		: '${pageContext.request.contextPath}/modedv/selectTableList.do?srch_menu_nix=${param.srch_menu_nix}',
	        type  		: "post",
	        data 		: data,
	        datatype	: "text",
			async 		: false,	        
	        success 	: function(data){        	
				
				for(var i = 0; i < data.length; i++)
				{
					jQuery("#selectTablelist, #baseacttable").append("<option value='" + data[i].table_name + "'>" + data[i].table_name + "</option>");
				}
				
			},
	        error: function(){
	            
	        	alert("테이블 정보를 가져오는 도중 오류가 발생했습니다.");
	        }
	    });
	}
	
	// 서브 탭 이동시 효과
	function fn_egov_move_tab(tabid)
	{
		jQuery("div[id^='divTab']").hide();
		jQuery("#divTab" + tabid).show();
	}

	// 텍스트 상자 기본 설정
	function initDivTabSub02()
	{
		jQuery("#ctrl, #ctrl_man, #svc, #vo, #impl, #dao, #sqlmap").prop("disabled", true);
	}
	
	// 액션파일 추가버튼 클릭
	function fn_egov_make_actfiles()
	{
		
		var chkval = "";
		jQuery(":checked").each(function(){
			chkval += (($(this).val() == "") ? "" : $(this).val() + "|");
		});
		
		if(jQuery("#dir").val() == "" || jQuery("#biznm").val() == "" || jQuery("#binkr").val() == "")
		{
			alert("필요한 설정값을 입력해주십시오.");
			return;
		}

		if(jQuery("#baseacttable").val() == "")
		{
			alert("테이블을 선택해주십시오.");
			return;
		}
		
		var fullpth = jQuery("#src").val();
		fullpth += "/" + jQuery("#pkgnm").val();
		fullpth += "/" + jQuery("#dir").val();
		fullpth = fullpth.replace(/\./gi, "/");
		
		if(confirm("워크스페이스를 포함한 소스경로는 다음과 같습니다.\n\n" + fullpth + "\n\n경로가 맞는지 확인해주십시오.\n파일을 생성하시겠습니까?") == false)
			return;
		
		var data = cmmfn_get_post_data("divTabSub02");
		data.chkval = chkval;
		
		$.ajax({
	        url 		: '${pageContext.request.contextPath}/modedv/generateActfiles.do?srch_menu_nix=${param.srch_menu_nix}',
	        type  		: "post",
	        data 		: data,
	        datatype	: "text",
			async 		: false,	        
	        success 	: function(data){        	
				alert("생성되었습니다.");
			},
	        error: function(){
	            
	        	alert("파일 생성 도중 오류가 발생했습니다.");
	        }
	    });
	}
	
	// 액션삭제 추가버튼 클릭
	function fn_egov_del_actfiles()
	{
		
		var chkval = "";
		jQuery(":checked").each(function(){
			chkval += (($(this).val() == "") ? "" : $(this).val() + "|");
		});
		
		if(jQuery("#dir").val() == "" || jQuery("#biznm").val() == "" || jQuery("#binkr").val() == "")
		{
			alert("필요한 설정값을 입력해주십시오.");
			return;
		}

		if(confirm("파일을 삭제하시겠습니까?") == false)
			return;
		
		var data = cmmfn_get_post_data("divTabSub02");
		data.chkval = chkval;
		
		$.ajax({
	        url 		: '${pageContext.request.contextPath}/modedv/rmvActfiles.do?srch_menu_nix=${param.srch_menu_nix}',
	        type  		: "post",
	        data 		: data,
	        datatype	: "text",
			async 		: false,	        
	        success 	: function(data){        	
				alert("삭제되었습니다.");
			},
	        error: function(){
	            
	        	alert("파일 삭제 도중 오류가 발생했습니다.");
	        }
	    });
	}
	
	// 테이블 컬럼을 기준으로 새로 추가된 액션에 맞는 사용자 L-CRUD 페이지들을 자동으로 생성한다 
	function fn_egov_make_userpages()
	{
		//alert("현재 기능 구상중입니다.\n테이블 컬럼을 기준으로 새로 추가된 액션에 맞는\n사용자 L-CRUD 페이지들을 자동으로 생성합니다.\ntiles 파일 및 script파일도 포함되어,\n생성 후 바로 해당 기능의 기본적인 조회 및 추가삭제 등이 가능합니다.");

		var chkval = "";
		jQuery(":checked").each(function(){
			chkval += (($(this).val() == "") ? "" : $(this).val() + "|");
		});
		
		if(jQuery("#dir").val() == "" || jQuery("#biznm").val() == "" || jQuery("#binkr").val() == "")
		{
			alert("필요한 설정값을 입력해주십시오.");
			return;
		}

		if(jQuery("#baseacttable").val() == "")
		{
			alert("테이블을 선택해주십시오.");
			return;
		}
		
		var fullpth = jQuery("#src").val();
		fullpth += "/" + jQuery("#pkgnm").val();
		fullpth += "/" + jQuery("#dir").val();
		fullpth = fullpth.replace(/\./gi, "/");
		
		if(confirm("테이블 컬럼을 기준으로 새로 추가된 액션에 맞는\n사용자 L-CRUD 페이지들을 자동으로 생성합니다.\ntiles 파일 및 script파일도 포함되어,\n생성 후 바로 해당 기능의 기본적인 조회 및 추가삭제 등이 가능합니다.\n파일을 생성하시겠습니까?") == false)
			return;
		
		var data = cmmfn_get_post_data("divTabSub02");
		data.chkval = chkval;
		
		$.ajax({
	        url 		: '${pageContext.request.contextPath}/modedv/generateUserpagefiles.do?srch_menu_nix=${param.srch_menu_nix}',
	        type  		: "post",
	        data 		: data,
	        datatype	: "text",
			async 		: false,	        
	        success 	: function(data){        	
				alert("생성되었습니다.");
			},
	        error: function(){
	            
	        	alert("파일 생성 도중 오류가 발생했습니다.");
	        }
	    });
		
	}
	
	// 테이블 컬럼을 기준으로 새로 추가된 액션에 맞는 관리자 L-CRUD 페이지들을 자동으로 생성한다 
	function fn_egov_make_manpages()
	{

		var chkval = "";
		jQuery(":checked").each(function(){
			chkval += (($(this).val() == "") ? "" : $(this).val() + "|");
		});
		
		if(jQuery("#dir").val() == "" || jQuery("#biznm").val() == "" || jQuery("#binkr").val() == "")
		{
			alert("필요한 설정값을 입력해주십시오.");
			return;
		}

		if(jQuery("#baseacttable").val() == "")
		{
			alert("테이블을 선택해주십시오.");
			return;
		}
		
		var fullpth = jQuery("#src").val();
		fullpth += "/" + jQuery("#pkgnm").val();
		fullpth += "/" + jQuery("#dir").val();
		fullpth = fullpth.replace(/\./gi, "/");
		
		if(confirm("테이블 컬럼을 기준으로 새로 추가된 액션에 맞는\n관리자 L-CRUD 페이지들을 자동으로 생성합니다.\ntiles 파일 및 script파일도 포함되어,\n생성 후 바로 해당 기능의 기본적인 조회 및 추가삭제 등이 가능합니다.\n파일을 생성하시겠습니까?") == false)
			return;
		
		var data = cmmfn_get_post_data("divTabSub02");
		data.chkval = chkval;
		
		$.ajax({
	        url 		: '${pageContext.request.contextPath}/modedv/generateManpagefiles.do?srch_menu_nix=${param.srch_menu_nix}',
	        type  		: "post",
	        data 		: data,
	        datatype	: "text",
			async 		: false,	        
	        success 	: function(data){        	
				alert("생성되었습니다.");
			},
	        error: function(){
	            
	        	alert("파일 생성 도중 오류가 발생했습니다.");
	        }
	    });
	}
	
	
	function changeTablelist()
	{
		var tbnm = $(this).val();
		var data = new Object();
		data.table_name = tbnm;
	
		$.ajax({
	        url 		: '${pageContext.request.contextPath}/modedv/selectTablecolList.do?srch_menu_nix=${param.srch_menu_nix}',
	        type  		: "post",
	        data 		: data,
	        datatype	: "text",
			async 		: false,	        
	        success 	: function(data){        	
	        	
	        	generateCURDCode(tbnm, data);
	        	
			},
	        error: function(){
	            
	        	//alert("파일 생성 도중 오류가 발생했습니다.");
	        }
	    });
		
	}
		
	function generateCURDCode(tbnm, data)
	{
    	
    	var objList = jQuery("#txtareaCodeList");
    	var objVo = jQuery("#txtareaCodeVo");
    	var objCnt = jQuery("#txtareaCodeCount");
    	var objInsert = jQuery("#txtareaCodeInsert");
    	var objDelete = jQuery("#txtareaCodeDelete");
    	var objUpdate = jQuery("#txtareaCodeUpdate");
    	var objPKCond = jQuery("#txtareaCodePKCond");
    	var objResultmap = jQuery("#txtareaCodeResultmap");
    	var objViewTB = jQuery("#txtareaCodeViewTable");
    	
    	var dtcnt = data.length;
		var pk_cond = "";
		var apnd_insert_nm = "";
		var apnd_insert_val = "";
		var apnd_update = "";
		var apnd_viewtb = "";
		var apnd_viewtbnm = "";
		var apnd_resultmap = "";

    	// List 구문
		objList
			.empty()
    		.css("height", ((dtcnt * 25) + 80) + "px")
    		.prop("disabled", false);

    	// Vo 구문
		objVo
			.empty()
    		.css("height", (dtcnt * 50) + "px")
    		.prop("disabled", false);

    	// Count 구문
		objCnt
			.empty()
    		.css("height", "150px")
    		.prop("disabled", false);
    			
    	// Insert 구문
		objInsert
			.empty()
    		.css("height", ((dtcnt * 35) + 100) + "px")
    		.prop("disabled", false);

    	// Update 구문
		objUpdate
			.empty()
    		.css("height", (dtcnt * 25) + "px")
    		.prop("disabled", false);

    	// Delete 구문
    	objDelete
			.empty()
    		.css("height", "150px")
    		.prop("disabled", false);

    	// PK조건절 구문
    	objPKCond
			.empty()
    		.css("height", "150px")
    		.prop("disabled", false);

    	// PK조건절 구문
    	objResultmap
			.empty()
    		.css("height", "200px")
    		.prop("disabled", false);

    	// 목록 테이블 구문
    	objViewTB
			.empty()
    		.css("height", ((dtcnt * 35) + 100) + "px")
    		.prop("disabled", false);
    	
    	
    	objList
    		.append("SELECT * FROM ( SELECT rownum rn, TB.* FROM (\r\n")
			.append("\r\n")
			.append("\tSELECT\r\n");

    		
    	for(var i = 0; i < data.length; i++)
    	{
    		var apnd_vo = "";
    		var apnd_list = "";
    		
    		switch( (data[i].data_type + "").toUpperCase())
    		{
    			case "DATE" : 
    			case "DATETIME" : 
    			case "TIMESTAMP" : 
    				apnd_list = "\t\tTO_CHAR(" + data[i].column_name + ", 'YYYY/MM/DD HH24:MI:SS') " + data[i].column_name;
    				apnd_vo = "\r\n\t/** " + data[i].comments + " */\r\n";
    				apnd_vo += "\tprivate String " + (data[i].column_name + "").toLowerCase() + ";\r\n";;
    				apnd_insert_nm += "\t" + data[i].column_name;
    				apnd_insert_val += "\tSYSDATE";
    				apnd_update += "\t" + data[i].column_name + " = SYSDATE";	
    				break;
    			case "NVARCHAR" : 
    			case "NVARCHAR2" : 
    			case "VARCHAR" : 
    			case "VARCHAR2" : 
    				apnd_list = "\t\t" + data[i].column_name;
    				apnd_vo = "\r\n\t/** " + data[i].comments + " */\r\n";
    				apnd_vo += "\tprivate String " + (data[i].column_name + "").toLowerCase() + ";\r\n";
    				apnd_insert_nm += "\t" + data[i].column_name;
    				apnd_insert_val += "\t#" + (data[i].column_name + "#").toLowerCase();
    				apnd_update += "\t" + data[i].column_name + " = #" + (data[i].column_name + "").toLowerCase() + "#";	
    				break;
    			case "CLOB" : 
    			case "TEXT" : 
    				apnd_list = "\t\t" + data[i].column_name;
    				apnd_vo = "\r\n\t/** " + data[i].comments + " */\r\n";
    				apnd_vo += "\tprivate String " + (data[i].column_name + "").toLowerCase() + ";\r\n";
    				apnd_insert_nm += "\t" + data[i].column_name;
    				apnd_insert_val += "\t#" + (data[i].column_name + "#").toLowerCase();
    				apnd_update += "\t" + data[i].column_name + " = #" + (data[i].column_name + "").toLowerCase() + "#";	
    				break;
    			case "LONG" : 
    				apnd_list = "\t\t" + data[i].column_name;
    				apnd_vo = "\r\n\t/** " + data[i].comments + " */\r\n";
    				apnd_vo += "\tprivate String " + (data[i].column_name + "").toLowerCase() + ";\r\n";
    				apnd_insert_nm += "\t" + data[i].column_name;
    				apnd_insert_val += "\t#" + (data[i].column_name + "#").toLowerCase();
    				apnd_update += "\t" + data[i].column_name + " = #" + (data[i].column_name + "").toLowerCase() + "#";	
    				break;
    			case "CHAR" : 
    				apnd_list = "\t\t" + data[i].column_name;
    				apnd_vo = "\r\n\t/** " + data[i].comments + " */\r\n";
    				apnd_vo += "\tprivate String " + (data[i].column_name + "").toLowerCase() + ";\r\n";
    				apnd_insert_nm += "\t" + data[i].column_name;
    				apnd_insert_val += "\t#" + (data[i].column_name + "#").toLowerCase();
    				apnd_update += "\t" + data[i].column_name + " = #" + (data[i].column_name + "").toLowerCase() + "#";	
    				break;
    			case "TINYINT" :
    			case "INT" :
    			case "NUMBER" :
    				apnd_list = "\t\t" + data[i].column_name;
    				apnd_vo = "\r\n\t/** " + data[i].comments + " */\r\n";
    				apnd_vo += "\tprivate int " + (data[i].column_name + "").toLowerCase() + ";\r\n";
    				apnd_insert_nm += "\t" + data[i].column_name;
    				apnd_insert_val += "\t#" + (data[i].column_name + "#").toLowerCase();
    				apnd_update += "\t" + data[i].column_name + " = #" + (data[i].column_name + "").toLowerCase() + "#";	
    				break;
    				
    		}
    		
			apnd_viewtb += "\t\t\t<td>&lt;c:out value=\"^{result." + (data[i].column_name + "").toLowerCase() + "}\"/&gt;</td>\r\n";
			apnd_viewtbnm += "\t\t\t<th scope=\"col\" width=\"10%\">" + data[i].comments + "</th>\r\n";
    		objList.append(apnd_list);
    		objList.append(i == (data.length - 1) ? "\r\n" : ",\r\n");
    		objVo.append(apnd_vo);
    		
    		apnd_insert_nm += (i == (data.length - 1) ? "\r\n" : ",\r\n"); 
    		apnd_insert_val += (i == (data.length - 1) ? "\r\n" : ",\r\n"); 
    		apnd_update += (i == (data.length - 1) ? "\r\n" : ",\r\n"); 
    		
    		apnd_resultmap += ("\t\t&lt;result property=\"" + (data[i].column_name + "").toLowerCase() + "\" column=\"" + (data[i].column_name + "").toLowerCase() + "\"/&gt;\r\n");
    		
    		// PK를 이용한 조건절 생성
    		if(data[i].constraint_type == "PK")
    		{
    			pk_cond += (pk_cond == "") ? "" : " AND\r\n";
    			pk_cond += "\t" + data[i].column_name + " = #" + (data[i].column_name + "").toLowerCase() + "#"; 
    		}
    		
    	}
    	
       	objList
			.append("\tFROM\r\n")
			.append("\t\t" + tbnm + "\r\n")
			.append(") TB )  WHERE rn BETWEEN #firstIndex# + 1 AND #firstIndex# + #recordCountPerPage#");
       	
       	objCnt
       		.append("SELECT\r\n")
       		.append("\tCOUNT(*) AS \"totcnt\"\r\n")
			.append("FROM\r\n")
			.append("\t" + tbnm + "\r\n")
	   		.append("WHERE\r\n")
   			.append(pk_cond);

       	objDelete
       		.append("DELETE FROM\r\n")
			.append("\t" + tbnm + "\r\n")
       		.append("WHERE\r\n")
       		.append(pk_cond);
       	
       	objPKCond
       		.append("\r\nWHERE\r\n")
       		.append(pk_cond);

       	objResultmap
       		.append("\t&lt;resultMap id=\"\" class=\"~~~~~~.~~~~VO\"&gt; \r\n")
       		.append(apnd_resultmap)
	   		.append("\t&lt;/resultMap&gt; \r\n");
       	
       	
       	objInsert
       		.append("&lt;selectKey resultClass=\"java.lang.Integer\" keyProperty=\"\"&gt;\r\n")
       		.append("&lt;/selectKey&gt;\r\n")
       		.append("\r\n")
			.append("INSERT INTO " + tbnm + "\r\n")
			.append("(\r\n")
			.append(apnd_insert_nm)
			.append(")\r\n")
			.append("VALUES\r\n")
			.append("(\r\n")
			.append(apnd_insert_val)
			.append(")\r\n");

       	objUpdate
			.append("UPDATE " + tbnm + " SET\r\n")
			.append(apnd_update)
	   		.append("WHERE\r\n")
			.append(pk_cond);
		
       	apnd_viewtb = apnd_viewtb.replace(/</g, "&lt;");
       	apnd_viewtb = apnd_viewtb.replace(/>/g, "&gt;");
       	apnd_viewtbnm = apnd_viewtbnm.replace(/</g, "&lt;");
       	apnd_viewtbnm = apnd_viewtbnm.replace(/>/g, "&gt;");
       	
    	objViewTB
    		.append("&lt;table class=\"tb_style\"&gt;\r\n")    		
    		.append("\t&lt;thead&gt;\r\n")
    		.append("\t\t&lt;tr&gt;\r\n")
    		.append(apnd_viewtbnm)
    		.append("\t\t&lt;/tr&gt;\r\n")
    		.append("\t&lt;/thead&gt;\r\n")
    		.append("\t&lt;tbody&gt;\r\n")
    		.append("\t&lt;c:forEach var=\"result\" items=\"^{resultList}\" varStatus=\"status\"&gt;\r\n")
    		.append("\t\t&lt;tr&gt;\r\n")
    		.append(apnd_viewtb)
    		.append("\t\t&lt;/tr&gt;\r\n")
    		.append("\t&lt;/c:forEach&gt;\r\n")
    		.append("\t&lt;c:if test = \"^{totCnt eq 0}\"&gt;\r\n")
    		.append("\t\t&lt;tr&gt;\r\n")
    		.append("\t\t\t&lt;td colspan=\"" + data.length + "\"&gt;조회 결과가 없습니다.&lt;/td&gt;\r\n")
    		.append("\t\t&lt;/tr&gt;\r\n")
    		.append("\t&lt;/c:if&gt;\r\n")
    		.append("\t&lt;/tbody&gt;\r\n")
    		.append("&lt;/table&gt;\r\n")
    		.append("&lt;div class=\"board_pager\"&gt;\r\n")
    		.append("\t&lt;ui:pagination paginationInfo = \"^{paginationInfo}\"\r\n")
    		.append("\t\ttype=\"image\"\r\n")
    		.append("\t\tjsFunction=\"fn_egov_link_page\" /&gt;\r\n")
    		.append("&lt;/div&gt;\r\n");

    	var tbval = objViewTB.val();
    	tbval = tbval.replace(/\^/g, "$");
    	objViewTB.val(tbval);
    	
	}
	
	function generateDevCode()
	{
		var sel = jQuery(":checked", jQuery("#divTabSub03")).val();
		var biznm = jQuery("#codeBiznm").val().toLowerCase();
		var bizsubnm = jQuery("#codeSubBiznm").val() == "" ? biznm : jQuery("#codeSubBiznm").val().toLowerCase();
		var bizkr = jQuery("#codeBizkr").val();
		var dir = jQuery("#codeDir").val();
		
		var comment = "";
		comment += "\t/**\r\n";
		comment += "\t * #BIZKR# 을/를 #JOBKR#한다.\r\n";
		comment += "\t * @param #BIZNM#VO : #JOBKR#할 정보\r\n";
		comment += "\t * @exception Exception\r\n";
		comment += "\t */\r\n";
		
		var reqmap = "\t@RequestMapping("/")\r\n";
		var resbody = "\t@ResponseBody\r\n";
		
		var ctrl_proto = "\tpublic String #METHODJOB##METHOD##LIST#(\r\n";
		var ctrl_param = "\t\t@ModelAttribute(\"#BIZNM#VO\") #CLSNM#VO #BIZNM#VO,\r\n";
		var ctrl_etc = "\t\tModel model)\r\n";
		ctrl_etc += "\tthrows Exception {\r\n";
		
		var svc_proto = "\tpublic #RTYPE# #JOB##RBIZSUB##LIST#(#CLSNM#VO vo) throws Exception;\r\n";
		var impl_proto = "\tpublic #RTYPE# #JOB##RBIZSUB##LIST#(#CLSNM#VO vo) throws Exception {\r\n";
		var impl_todo = "\t\t// TODO Auto-generated method stub\r\n";
		var impl_return = "\t\t#RETURN##BIZNM#DAO.#JOB##RBIZSUB##LIST#(vo);\r\n";
		
		var dao_return = "\t\t#RETURN# #CAST# #JOB#(\"#BIZNM#DAO.#JOB##RBIZSUB##LIST#\", vo);\r\n";
		
		var sqlmap_def = "<#JOB# id=\"#BIZNM#DAO.#JOB##RBIZSUB##LIST#\" parameterClass=\"#BIZNM#VO\" #RESULT#>\r\n";
		sqlmap_def += "\t\r\n";
		sqlmap_def += "</#JOB#>\r\n";

		if(sel == "List")
		{
			var ctrl_list = comment;
			ctrl_list += reqmap;
			ctrl_list += ctrl_proto;
			ctrl_list += ctrl_param;
			ctrl_list += ctrl_etc;

			ctrl_list += "\t\tList #BIZSUB#List = #BIZNM#Service.select#RBIZSUB#List(#BIZNM#VO);\r\n";
			ctrl_list += "\t\tmodel.addAttribute(\"resultList\", #BIZSUB#List);\r\n";
			ctrl_list += "\t\treturn \"/#DIRNM#/#BIZSUB#List\"\r\n";
			ctrl_list += "\t}\r\n";
			
			ctrl_list = ctrl_list.replace(/#METHOD#/g, bizsubnm);
			ctrl_list = ctrl_list.replace(/#BIZNM#/g, biznm);
			ctrl_list = ctrl_list.replace(/#BIZSUB#/g, bizsubnm);
			ctrl_list = ctrl_list.replace(/#RBIZSUB#/g, cmmfn_get_Upper1stChar(bizsubnm));
			ctrl_list = ctrl_list.replace(/#BIZKR#/g, bizkr);
			ctrl_list = ctrl_list.replace(/#JOB#/g, "");
			ctrl_list = ctrl_list.replace(/#METHODJOB#/g, "");
			ctrl_list = ctrl_list.replace(/#JOBKR#/g, "조회");
			ctrl_list = ctrl_list.replace(/#CLSNM#/g, cmmfn_get_Upper1stChar(biznm));
			ctrl_list = ctrl_list.replace(/#LIST#/g, "List");
			ctrl_list = ctrl_list.replace(/#DIRNM#/g, dir);
			
			jQuery("#txtareaCodeCtrl")
				.empty()
				.val(ctrl_list);
			
			var svc_list = comment;
			svc_list += svc_proto;
			svc_list = svc_list.replace(/#RTYPE#/g, "List");
			svc_list = svc_list.replace(/#CLSNM#/g, cmmfn_get_Upper1stChar(biznm));
			svc_list = svc_list.replace(/#JOB#/g, "select");
			svc_list = svc_list.replace(/#JOBKR#/g, "조회");
			svc_list = svc_list.replace(/#LIST#/g, "List");
			svc_list = svc_list.replace(/#BIZKR#/g, bizkr);
			svc_list = svc_list.replace(/#BIZNM#/g, biznm);
			svc_list = svc_list.replace(/#BIZSUB#/g, bizsubnm);
			svc_list = svc_list.replace(/#RBIZSUB#/g, cmmfn_get_Upper1stChar(bizsubnm));
			
			jQuery("#txtareaCodeSvc")
				.empty()
				.val(svc_list);
			
			var impl_list = comment;
			impl_list += impl_proto; 
			impl_list += impl_todo;
			impl_list += impl_return;
			impl_list += "\t}\r\n";
			impl_list = impl_list.replace(/#RTYPE#/g, "List");
			impl_list = impl_list.replace(/#CLSNM#/g, cmmfn_get_Upper1stChar(biznm));
			impl_list = impl_list.replace(/#JOB#/g, "select");
			impl_list = impl_list.replace(/#JOBKR#/g, "조회");
			impl_list = impl_list.replace(/#LIST#/g, "List");
			impl_list = impl_list.replace(/#BIZNM#/g, biznm);
			impl_list = impl_list.replace(/#BIZKR#/g, bizkr);
			impl_list = impl_list.replace(/#BIZSUB#/g, bizsubnm);
			impl_list = impl_list.replace(/#RBIZSUB#/g, cmmfn_get_Upper1stChar(bizsubnm));
			impl_list = impl_list.replace(/#RETURN#/g, "return ");
			
			jQuery("#txtareaCodeImpl")
				.empty()
				.val(impl_list);
			
			var dao_list = comment;
			dao_list += impl_proto;
			dao_list += dao_return; 
			dao_list += "\t}\r\n";
			dao_list = dao_list.replace(/#RTYPE#/g, "List");
			dao_list = dao_list.replace(/#CLSNM#/g, cmmfn_get_Upper1stChar(biznm));
			dao_list = dao_list.replace(/#JOB#/g, "select");
			dao_list = dao_list.replace(/#JOBKR#/g, "조회");
			dao_list = dao_list.replace(/#LIST#/g, "List");
			dao_list = dao_list.replace(/#BIZNM#/g, biznm);
			dao_list = dao_list.replace(/#BIZKR#/g, bizkr);
			dao_list = dao_list.replace(/#BIZSUB#/g, bizsubnm);
			dao_list = dao_list.replace(/#RBIZSUB#/g, cmmfn_get_Upper1stChar(bizsubnm));
			dao_list = dao_list.replace(/#RETURN#/g, "return ");
			dao_list = dao_list.replace(/#CAST#/g, "(List)");

			jQuery("#txtareaCodeDao")
				.empty()
				.val(dao_list);
			
			var sqlmap_list = sqlmap_def;
			sqlmap_list = sqlmap_list.replace(/#CLSNM#/g, cmmfn_get_Upper1stChar(biznm));
			sqlmap_list = sqlmap_list.replace(/#JOB#/g, "list");
			sqlmap_list = sqlmap_list.replace(/#BIZNM#/g, biznm);
			sqlmap_list = sqlmap_list.replace(/#BIZSUB#/g, bizsubnm);
			sqlmap_list = sqlmap_list.replace(/#RBIZSUB#/g, cmmfn_get_Upper1stChar(bizsubnm));
			sqlmap_list = sqlmap_list.replace(/#LIST#/g, "List");
			sqlmap_list = sqlmap_list.replace(/#RESULT#/g, "resultClass=\"" + biznm + "VO\"");
			
			jQuery("#txtareaCodeSqlmap")
				.empty()
				.val(sqlmap_list);
			
		}
		else if(sel == "Select")
		{
			var ctrl_list = comment;
			ctrl_list += reqmap;
			ctrl_list += ctrl_proto;
			ctrl_list += ctrl_param;
			ctrl_list += ctrl_etc;

			ctrl_list += "\t\t#CLSNM#VO #BIZSUB#VO = #BIZNM#Service.select#RBIZSUB#(#BIZNM#VO);\r\n";
			ctrl_list += "\t\tmodel.addAttribute(\"resultVO\", #BIZSUB#VO);\r\n";
			ctrl_list += "\t\treturn \"/#DIRNM#/#BIZSUB#View\"\r\n";
			ctrl_list += "\t}\r\n";
			
			ctrl_list = ctrl_list.replace(/#METHOD#/g, bizsubnm);
			ctrl_list = ctrl_list.replace(/#BIZNM#/g, biznm);
			ctrl_list = ctrl_list.replace(/#BIZKR#/g, bizkr);
			ctrl_list = ctrl_list.replace(/#BIZSUB#/g, bizsubnm);
			ctrl_list = ctrl_list.replace(/#RBIZSUB#/g, cmmfn_get_Upper1stChar(bizsubnm));
			ctrl_list = ctrl_list.replace(/#JOB#/g, "");
			ctrl_list = ctrl_list.replace(/#METHODJOB#/g, "");
			ctrl_list = ctrl_list.replace(/#JOBKR#/g, "상세조회");
			ctrl_list = ctrl_list.replace(/#CLSNM#/g, cmmfn_get_Upper1stChar(biznm));
			ctrl_list = ctrl_list.replace(/#LIST#/g, "View");
			ctrl_list = ctrl_list.replace(/#DIRNM#/g, dir);
			
			jQuery("#txtareaCodeCtrl")
				.empty()
				.val(ctrl_list);
			
			var svc_list = comment;
			svc_list += svc_proto;
			svc_list = svc_list.replace(/#RTYPE#/g, cmmfn_get_Upper1stChar(biznm) + "VO");
			svc_list = svc_list.replace(/#CLSNM#/g, cmmfn_get_Upper1stChar(biznm));
			svc_list = svc_list.replace(/#JOB#/g, "select");
			svc_list = svc_list.replace(/#JOBKR#/g, "상세조회");
			svc_list = svc_list.replace(/#LIST#/g, "");
			svc_list = svc_list.replace(/#BIZKR#/g, bizkr);
			svc_list = svc_list.replace(/#BIZNM#/g, biznm);
			svc_list = svc_list.replace(/#BIZSUB#/g, bizsubnm);
			svc_list = svc_list.replace(/#RBIZSUB#/g, cmmfn_get_Upper1stChar(bizsubnm));
			
			jQuery("#txtareaCodeSvc")
				.empty()
				.val(svc_list);
			
			var impl_list = comment;
			impl_list += impl_proto; 
			impl_list += impl_todo;
			impl_list += impl_return;
			impl_list += "\t}\r\n";
			impl_list = impl_list.replace(/#RTYPE#/g, cmmfn_get_Upper1stChar(biznm) + "VO");
			impl_list = impl_list.replace(/#CLSNM#/g, cmmfn_get_Upper1stChar(biznm));
			impl_list = impl_list.replace(/#JOB#/g, "select");
			impl_list = impl_list.replace(/#JOBKR#/g, "상세조회");
			impl_list = impl_list.replace(/#LIST#/g, "");
			impl_list = impl_list.replace(/#BIZNM#/g, biznm);
			impl_list = impl_list.replace(/#BIZKR#/g, bizkr);
			impl_list = impl_list.replace(/#BIZSUB#/g, bizsubnm);
			impl_list = impl_list.replace(/#RBIZSUB#/g, cmmfn_get_Upper1stChar(bizsubnm));
			impl_list = impl_list.replace(/#RETURN#/g, "return ");
			
			jQuery("#txtareaCodeImpl")
				.empty()
				.val(impl_list);
			
			var dao_list = comment;
			dao_list += impl_proto;
			dao_list += dao_return; 
			dao_list += "\t}\r\n";
			dao_list = dao_list.replace(/#RTYPE#/g, cmmfn_get_Upper1stChar(biznm) + "VO");
			dao_list = dao_list.replace(/#CLSNM#/g, cmmfn_get_Upper1stChar(biznm));
			dao_list = dao_list.replace(/#JOB#/g, "selectByPk");
			dao_list = dao_list.replace(/#JOBKR#/g, "상세조회");
			dao_list = dao_list.replace(/#LIST#/g, "");
			dao_list = dao_list.replace(/#BIZNM#/g, biznm);
			dao_list = dao_list.replace(/#BIZKR#/g, bizkr);
			dao_list = dao_list.replace(/#BIZSUB#/g, bizsubnm);
			dao_list = dao_list.replace(/#RBIZSUB#/g, cmmfn_get_Upper1stChar(bizsubnm));
			dao_list = dao_list.replace(/#RETURN#/g, "return ");
			dao_list = dao_list.replace(/#CAST#/g, "(" + cmmfn_get_Upper1stChar(biznm) + "VO)");

			jQuery("#txtareaCodeDao")
				.empty()
				.val(dao_list);
			
			var sqlmap_list = sqlmap_def;
			sqlmap_list = sqlmap_list.replace(/#CLSNM#/g, cmmfn_get_Upper1stChar(biznm));
			sqlmap_list = sqlmap_list.replace(/#JOB#/g, "select");
			sqlmap_list = sqlmap_list.replace(/#BIZNM#/g, biznm);
			sqlmap_list = sqlmap_list.replace(/#LIST#/g, "");
			sqlmap_list = sqlmap_list.replace(/#RESULT#/g, "resultClass=\"" + biznm + "VO\"");
			sqlmap_list = sqlmap_list.replace(/#BIZSUB#/g, bizsubnm);
			sqlmap_list = sqlmap_list.replace(/#RBIZSUB#/g, cmmfn_get_Upper1stChar(bizsubnm));
			
			jQuery("#txtareaCodeSqlmap")
				.empty()
				.val(sqlmap_list);
			
		}
		else if(sel == "Insert")
		{
			gencodeCommon(dir, comment, reqmap, ctrl_proto, ctrl_param, ctrl_etc, svc_proto, impl_proto, impl_todo, impl_return, dao_return, sqlmap_def,
					biznm, bizsubnm, bizkr, "insert", "add", "등록", "void", "", "", "", "");
		}
		else if(sel == "Update")
		{
			gencodeCommon(dir, comment, reqmap, ctrl_proto, ctrl_param, ctrl_etc, svc_proto, impl_proto, impl_todo, impl_return, dao_return, sqlmap_def,
					biznm, bizsubnm, bizkr, "update", "mdf", "수정", "void", "", "", "", "");
		}
		else if(sel == "Delete")
		{
			gencodeCommon(dir, comment, reqmap, ctrl_proto, ctrl_param, ctrl_etc, svc_proto, impl_proto, impl_todo, impl_return, dao_return, sqlmap_def,
					biznm, bizsubnm, bizkr, "delete", "rmv", "삭제", "void", "", "", "", "");
			
		}
		else if(sel == "Count")
		{
			gencodeCommon(dir, comment, reqmap, ctrl_proto, ctrl_param, ctrl_etc, svc_proto, impl_proto, impl_todo, impl_return, dao_return, sqlmap_def,
					biznm, bizsubnm, bizkr, "select", "count", "총 개수 조회", "int", "ListTotCnt", "return ", "resultClass=\"int\"", "(Integer)");
			
			jQuery("#txtareaCodeCtrl")
				.empty();
		}
		else if(sel == "Move")
		{
			
		}
		
		
	}
	
	function gencodeCommon(dir, comment, reqmap, ctrl_proto, ctrl_param, ctrl_etc, svc_proto, impl_proto, impl_todo, impl_return, dao_return, sqlmap_def,
			biznm, bizsubnm, bizkr, job, methodjob, jobkr, rtype, list, ret, result, cast)
	{
		var ctrl_list = comment;
		ctrl_list += reqmap;
		ctrl_list += ctrl_proto;
		ctrl_list += ctrl_param;
		ctrl_list += ctrl_etc;

		ctrl_list += "\t\t#BIZNM#Service.#JOB##RBIZSUB#(#BIZNM#VO);\r\n";
		ctrl_list += "\t\treturn \"redirect:/#DIRNM#/#BIZSUB#View\"\r\n";
		ctrl_list += "\t}\r\n";
		
		ctrl_list = ctrl_list.replace(/#METHOD#/g, cmmfn_get_Upper1stChar(bizsubnm));
		ctrl_list = ctrl_list.replace(/#BIZNM#/g, biznm);
		ctrl_list = ctrl_list.replace(/#BIZKR#/g, bizkr);
		ctrl_list = ctrl_list.replace(/#BIZSUB#/g, bizsubnm);
		ctrl_list = ctrl_list.replace(/#RBIZSUB#/g, cmmfn_get_Upper1stChar(bizsubnm));
		ctrl_list = ctrl_list.replace(/#JOB#/g, job);
		ctrl_list = ctrl_list.replace(/#METHODJOB#/g, methodjob);
		ctrl_list = ctrl_list.replace(/#JOBKR#/g, jobkr);
		ctrl_list = ctrl_list.replace(/#CLSNM#/g, cmmfn_get_Upper1stChar(biznm));
		ctrl_list = ctrl_list.replace(/#LIST#/g, list);
		ctrl_list = ctrl_list.replace(/#DIRNM#/g, dir);
		
		jQuery("#txtareaCodeCtrl")
			.empty()
			.val(ctrl_list);
		
		var svc_list = comment;
		svc_list += svc_proto;
		svc_list = svc_list.replace(/#RTYPE#/g, rtype);
		svc_list = svc_list.replace(/#CLSNM#/g, cmmfn_get_Upper1stChar(biznm));
		svc_list = svc_list.replace(/#JOB#/g, job);
		svc_list = svc_list.replace(/#JOBKR#/g, jobkr);
		svc_list = svc_list.replace(/#LIST#/g, list);
		svc_list = svc_list.replace(/#BIZKR#/g, bizkr);
		svc_list = svc_list.replace(/#BIZNM#/g, biznm);
		svc_list = svc_list.replace(/#BIZSUB#/g, bizsubnm);
		svc_list = svc_list.replace(/#RBIZSUB#/g, cmmfn_get_Upper1stChar(bizsubnm));
		
		jQuery("#txtareaCodeSvc")
			.empty()
			.val(svc_list);
		
		var impl_list = comment;
		impl_list += impl_proto; 
		impl_list += impl_todo;
		impl_list += impl_return;
		impl_list += "\t}\r\n";
		impl_list = impl_list.replace(/#RTYPE#/g, rtype);
		impl_list = impl_list.replace(/#CLSNM#/g, cmmfn_get_Upper1stChar(biznm));
		impl_list = impl_list.replace(/#JOB#/g, job);
		impl_list = impl_list.replace(/#JOBKR#/g, jobkr);
		impl_list = impl_list.replace(/#LIST#/g, list);
		impl_list = impl_list.replace(/#BIZNM#/g, biznm);
		impl_list = impl_list.replace(/#BIZKR#/g, bizkr);
		impl_list = impl_list.replace(/#BIZSUB#/g, bizsubnm);
		impl_list = impl_list.replace(/#RBIZSUB#/g, cmmfn_get_Upper1stChar(bizsubnm));
		impl_list = impl_list.replace(/#RETURN#/g, ret);
		
		jQuery("#txtareaCodeImpl")
			.empty()
			.val(impl_list);
		
		var dao_list = comment;
		dao_list += impl_proto;
		dao_list += dao_return; 
		dao_list += "\t}\r\n";
		dao_list = dao_list.replace(/#RTYPE#/g, rtype);
		dao_list = dao_list.replace(/#CLSNM#/g, cmmfn_get_Upper1stChar(biznm));
		dao_list = dao_list.replace(/#JOB#/g, job);
		dao_list = dao_list.replace(/#JOBKR#/g, jobkr);
		dao_list = dao_list.replace(/#LIST#/g, list);
		dao_list = dao_list.replace(/#BIZNM#/g, biznm);
		dao_list = dao_list.replace(/#BIZKR#/g, bizkr);
		dao_list = dao_list.replace(/#BIZSUB#/g, bizsubnm);
		dao_list = dao_list.replace(/#RBIZSUB#/g, cmmfn_get_Upper1stChar(bizsubnm));
		dao_list = dao_list.replace(/#RETURN#/g, ret);
		dao_list = dao_list.replace(/#CAST#/g, cast);

		jQuery("#txtareaCodeDao")
			.empty()
			.val(dao_list);
		
		var sqlmap_list = sqlmap_def;
		sqlmap_list = sqlmap_list.replace(/#CLSNM#/g, cmmfn_get_Upper1stChar(biznm));
		sqlmap_list = sqlmap_list.replace(/#JOB#/g, job);
		sqlmap_list = sqlmap_list.replace(/#BIZNM#/g, biznm);
		sqlmap_list = sqlmap_list.replace(/#BIZSUB#/g, bizsubnm);
		sqlmap_list = sqlmap_list.replace(/#RBIZSUB#/g, cmmfn_get_Upper1stChar(bizsubnm));
		sqlmap_list = sqlmap_list.replace(/#LIST#/g, list);
		sqlmap_list = sqlmap_list.replace(/#RESULT#/g, result);
		
		jQuery("#txtareaCodeSqlmap")
			.empty()
			.val(sqlmap_list);		
	}
	
	function fn_egov_save_props()
	{
		if(confirm("입력하신 내용을 저장하시겠습니까?\n시스템에 중대한 영향을 줄 수 있는 내용이므로\n되도록 확인용도로만 사용하시고, 변경은 신중하게 하시기 바랍니다.\n변경하신 내용은 서버를 재시작한 후 다시 로그인해야 적용됩니다.") == false)
			return;
		
		
		var data = cmmfn_get_post_data("divTabSub01");
		
		$.ajax({
	        url 		: '${pageContext.request.contextPath}/modedv/setGlobalprops.do?srch_menu_nix=${param.srch_menu_nix}',
	        type  		: "post",
	        data 		: data,
	        datatype	: "text",
			async 		: false,	        
	        success 	: function(data){        	
				
				alert("저장되었습니다.");
				
			},
	        error: function(){
	            
	        	alert("테이블 정보를 가져오는 도중 오류가 발생했습니다.");
	        }
	    });

	}
	
</script>

<form:form name="reqForm">

<!-- content -->
<div id="container">
		<ul class="tab_list">
		<li id="liDevTab01" class="on"><a href="javascript:fn_egov_move_tab('Sub01')">프로젝트 기본 설정</a></li>
		<li id="liDevTab02"><a href="javascript:fn_egov_move_tab('Sub02')">액션추가(파일)</a></li>
		<li id="liDevTab02"><a href="javascript:fn_egov_move_tab('Sub03')">액션추가(코드)</a></li>
		<li id="liDevTab02"><a href="javascript:fn_egov_move_tab('Sub04')">테이블 CRUD</a></li>
		<li id="liDevTab02"><a href="javascript:fn_egov_move_tab('Sub05')">페이징</a></li>
		<li id="liDevTab03"><a href="javascript:fn_egov_move_tab('Sub06')">파일첨부</a></li>
		<li id="liDevTab04"><a href="javascript:fn_egov_move_tab('Sub07')">엑셀다운</a></li>
		<li id="liDevTab02"><a href="javascript:fn_egov_move_tab('Sub08')">통계</a></li>
	</ul>
	<div id="content">
		
		<div id="divTabSub00">
			<textarea id="input" name="input"></textarea>
			<input type="file" name="file_upload" id="file_upload" />
			<!-- <div id="upload" class="your class" style="your style"></div> -->
		</div>
		<div id="divTabSub01">
			<div class="info">
				본 페이지는 개발자가 개발시에만 사용하는 페이지로, 보안상 매우 취약하므로 최종배포시에 반드시 삭제하시기 바랍니다.<br/><br/>
				<span class="txt_red">프로젝트 공통항목들이 제대로 설정되었는지 확인하는 용도로만 사용합니다.<br/>
				저장된 내용이 적용되려면 서버를 재시작 한 뒤 재로그인 해야 합니다.</span>
			</div>
			<table class="tstyle_view">
				<colgroup>
					<col width="18%" />
					<col />
				</colgroup>
				<caption>프로젝트 환경설정</caption>
				<tr>
					<th scope="row"><label for="workspace">Workspace</label></th>
					<td>
						<input type="text" id="workspace" name="workspace" value="${SESS_PROP_WORKSPACE}" class="input_width_600"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="javaprjt">JAVA 프로젝트 명</label></th>
					<td>
						<input type="text" id="javaprjt" name="javaprjt" value="${SESS_PROP_JAVAPRJT}" class="input_width_200"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="prjt_nm">프로젝트 명칭</label></th>
					<td>
						<input type="text" id="prjt_nm" name="prjt_nm" value="${SESS_PROP_PRJTNM}" class="input_width_200"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="copyright">Copyright</label></th>
					<td><input type="text" id="copyright" name="copyright" value="${SESS_PROP_COPYRIGHT}" class="input_width_600"/></td>
				</tr>
				<tr>
					<th scope="row"><label for="uploaddir">첨부파일 저장 위치</label></th>
					<td><input type="text" id="uploaddir" name="uploaddir" value="${SESS_PROP_UPLOADDIR}" class="input_width_500"/></td>
				</tr>
			</table>
			
			<div class="btn_area_right">
				<a href="javascript:fn_egov_save_props()" class="btn_line">저장</a>
			</div>
			<br/>
			
		</div>
		<div id="divTabSub02">
			<div class="info">
				본 페이지는 개발자가 개발시에만 사용하는 페이지로, 보안상 매우 취약하므로 최종배포시에 반드시 삭제하시기 바랍니다.<br/><br/>
				액션단위의 비즈니스로직 처리(CRUD)를 위한 최소한의 코드가 생성된 Controller, VO, Service, ServiceImpl, DAO, sqlmap 파일을 자동생성합니다.<br/>
				또한 관리자 및 사용자 조회페이지, 입력페이지, 목록페이지와 그에 따른 기본스크립트, tiles 설정 파일도 자동생성할 수 있습니다.<br/>
				<span class="txt_red">작업 전에 반드시 globals.properties 파일의 Globals.workspacePath 항목에 자신의 이클립스 프로젝트의 workspace 경로를,<br/>
				Globals.javaprjt 항목에 현재 java 프로젝트 명을 설정해야 합니다.<br/></span>
				ex) Globals.workspacePath = D:/JavaDev/workspace/job_egov (경로를 잘못설정하면 파일이 엉뚱한 곳에 생성됩니다.)<br/>
				ex) Globals.javaprjt = KTSTA <br/>
				작업후에는 프로젝트 소스를 refresh 하고 서버를 재시작 합니다.<br/>
				본 페이지의 기능을 이용해 만들어진 코드는 개발에 필요한 가장 기본적이고 반복적인 내용만을 담고 있으며, 
				이 코드만으로 사용자 요구에 맞는 동작을 보장하지 않습니다.<br/>  
			</div>
			
			<table class="tstyle_view">
				<colgroup>
					<col width="18%" />
					<col />
				</colgroup>
				<caption>항목</caption>
				<tr>
					<th scope="row"><label for="title">기준 테이블 선택</label></th>
					<td>
						<select id="baseacttable">	
							<option value=""> 테이블을 선택하세요 </option>
						</select> <span class="txt_blue">테이블을 선택하지 않으면 내용이 빈 파일들이 생성됩니다.</span>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">소스 경로</label></th>
					<td><input type="text" id="src" name="src" value="${SESS_PROP_WORKSPACE}/${SESS_PROP_JAVAPRJT}/src/main" class="input_width_500"/></td>
				</tr>
				<tr>
					<th scope="row"><label for="title">기본 패키지</label></th>
					<td><input type="text" id="pkgnm" name="pkgnm" value="egovframework.plani.custom" class="input_width_200"/></td>
				</tr>
				<tr>
					<th scope="row"><label for="title">서브 패키지(디렉토리)</label></th>
					<td><input type="text" id="dir" name="dir" value=""/></td>
				</tr>
				<tr>
					<th scope="row"><label for="title">단위 액션명 (영문약어)</label></th>
					<td>
						<input type="text" id="biznm" name="biznm" value=""/>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">단위 액션명 (국문)</label></th>
					<td>
						<input type="text" id="bizkr" name="bizkr" value=""/>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">Controller 경로</label></th>
					<td>
						사용자 : <input type="text" id="ctrl" name="ctrl" value="egovframework.plani.custom.#dir#.web.#biznm#Controller" class="input_width_600"/>
						<input type="checkbox" id="useCtrl" checked value="ctrl"/><label for = "useCtrl">생성 여부</label><br/>
						관리자 : <input type="text" id="ctrl_man" name="ctrl_man" value="egovframework.plani.template.man.metsys.web.proj_add.Manact_#biznm#Controller" class="input_width_600"/>
						<input type="checkbox" id="useCtrl" checked value="ctrl_man"/><label for = "useCtrl">생성 여부</label>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">VO 경로</label></th>
					<td>
						<input type="text" id="vo" name="vo" value="egovframework.plani.custom.#dir#.vo.#biznm#VO" class="input_width_500"/>
						<input type="checkbox" id="useVo" checked value="vo"/><label for = "useVo">생성 여부</label>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">Service 경로</label></th>
					<td>
						<input type="text" id="svc" name="svc" value="egovframework.plani.custom.#dir#.service.#biznm#Service" class="input_width_500"/>
						<input type="checkbox" id="useSvc" checked value="svc"/><label for = "useSvc">생성 여부</label>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">ServiceImpl 경로</label></th>
					<td>
						<input type="text" id="impl" name="impl" value="egovframework.plani.custom.#dir#.service.impl.#biznm#ServiceImpl" class="input_width_500"/>
						<input type="checkbox" id="useImpl" checked value="impl"/><label for = "useImpl">생성 여부</label>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">DAO 경로</label></th>
					<td>
						<input type="text" id="dao" name="dao" value="egovframework.plani.custom.#dir#.dao.#biznm#DAO" class="input_width_500"/>
						<input type="checkbox" id="useDao" checked value="dao"/><label for = "useDao">생성 여부</label>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">SQLMap 경로</label></th>
					<td>
						<input type="text" id="sqlmap" name="sqlmap" value="egovframework.sqlmap.com.${dbtype}.#biznm#_map" class="input_width_500"/>
						<input type="checkbox" id="useSqlmap" checked value="sqlmap"/><label for = "useSqlmap">생성 여부</label>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">생성 후 기본 조회 액션</label></th>
					<td>
						사용자 : <input type="text" id="useract_name" name="useract_name" value="" class="input_width_300"/><br/>
						관리자 : <input type="text" id="manact_name" name="manact_name" value="" class="input_width_300"/>
					</td>
				</tr>
			</table>
			<div class="btn_area_right">
				<a href="javascript:fn_egov_make_actfiles()" class="btn_line">소스생성</a>
				<!-- <a href="javascript:fn_egov_del_actfiles()" class="btn_line">소스삭제</a> -->
				&nbsp;&nbsp;&nbsp;
				<a href="javascript:fn_egov_make_userpages()" class="btn_line">사용자페이지 생성</a>
				<a href="javascript:fn_egov_make_manpages()" class="btn_line">관리자페이지 생성</a>
			</div>
			<br/>
			
		</div>
		<div id="divTabSub03">
			<div class="info">
				본 페이지는 개발자가 개발시에만 사용하는 페이지로, 보안상 매우 취약하므로 최종배포시에 반드시 삭제하시기 바랍니다.<br/><br/>
				액션단위의 비즈니스로직 처리(CRUD)를 위한 최소한의 코드가 생성된 Controller, VO, Service, ServiceImpl, DAO, sqlmap 코드를 자동생성합니다.<br/>
				본 페이지의 기능을 이용해 만들어진 코드는 개발에 필요한 가장 기본적인 내용만을 담고 있으며, 이 코드만으로 사용자 요구에 맞는 동작을 보장하지 않습니다.<br/>  
			</div>
			
			<table class="tstyle_view">
				<colgroup>
					<col width="18%" />
					<col />
				</colgroup>
				<caption>항목</caption>
				<tr>
					<th scope="row"><label for="title">서브 디렉토리</label></th>
					<td><input type="text" id="codeDir" name="codeDir" value="" class="input_width_100"/></td>
				</tr>
				<tr>
					<th scope="row"><label for="title">단위 액션명 (영문약어)</label></th>
					<td>
						<p><span class="txt_blue">이미 추가된 기존 액션과 다른 VO를 사용하는 다른 액션을 추가하기 위해 사용</span></p>
						<input type="text" id="codeBiznm" name="codeBiznm" value="" class="input_width_100"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">서브 액션명 (영문약어)</label></th>
					<td>
						<p><span class="txt_blue">이미 추가된 기존 액션과 같은 VO를 사용하는 다른 액션을 추가하기 위해 사용</span></p>
						<p><span class="txt_blue">(기존 액션과 다른 VO를 사용하는 경우에는 입력하지 않아도 됨)</span></p>
						<input type="text" id="codeSubBiznm" name="codeSubBiznm" value="" class="input_width_100"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">서브 액션명 (국문)</label></th>
					<td><input type="text" id="codeBizkr" name="codeBizkr" value="" class="input_width_100"/></td>
				</tr>
				<tr>
					<th scope="row"><label for="title">구분</label></th>
					<td>
						<input type="radio" id="codeGb1" name="codeGb" value="List" checked/><label for="codeGb1">List</label>&nbsp;
						<input type="radio" id="codeGb2" name="codeGb" value="Select"/><label for="codeGb2">Select</label>&nbsp;
						<input type="radio" id="codeGb3" name="codeGb" value="Insert"/><label for="codeGb3">Insert</label>&nbsp;
						<input type="radio" id="codeGb4" name="codeGb" value="Update"/><label for="codeGb4">Update</label>&nbsp;
						<input type="radio" id="codeGb5" name="codeGb" value="Delete"/><label for="codeGb5">Delete</label>&nbsp;
						<input type="radio" id="codeGb6" name="codeGb" value="Count"/><label for="codeGb6">Count</label>&nbsp;
						<!-- <input type="radio" id="codeGb7" name="codeGb" value="Move" class="input_width_500"/><label for="codeGb7">Move</label> -->
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">Controller Code</label></th>
					<td>
						<textarea id="txtareaCodeCtrl" rows="30" cols="130"></textarea>					
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">Service Code</label></th>
					<td>
						<textarea id="txtareaCodeSvc" rows="30" cols="130"></textarea>					
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">Impl Code</label></th>
					<td>
						<textarea id="txtareaCodeImpl" rows="30" cols="130"></textarea>					
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">Dao Code</label></th>
					<td>
						<textarea id="txtareaCodeDao" rows="30" cols="130"></textarea>					
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">Sqlmap Code</label></th>
					<td>
						<textarea id="txtareaCodeSqlmap" rows="30" cols="130"></textarea>					
					</td>
				</tr>
			</table>			
		</div>		
		<div id="divTabSub04">
			<div class="info">
				본 페이지는 개발자가 개발시에만 사용하는 페이지로, 보안상 매우 취약하므로 최종배포시에 반드시 삭제하시기 바랍니다.<br/><br/>
				테이블 목록을 조회하고, 선택한 테이블의 CRUD에 필요한 코드를 생성합니다.<br/>
				본 페이지의 기능을 이용해 만들어진 코드는 개발에 필요한 가장 기본적인 내용만을 담고 있으며, 이 코드만으로 사용자 요구에 맞는 동작을 보장하지 않습니다.<br/>  
			</div>
			<table class="tstyle_view">
				<colgroup>
					<col width="18%" />
					<col />
				</colgroup>
				<caption>항목</caption>
				<tr>
					<th scope="row"><label for="title">테이블 목록</label></th>
					<td>
						<select id="selectTablelist">	
							<option value=""> 테이블을 선택하세요 </option>
						</select>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">VO 코드 (컬럼 생성 용)</label></th>
					<td>
						<textarea id="txtareaCodeVo" rows="30" cols="130"></textarea> 
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">List 구문</label></th>
					<td>
						<textarea id="txtareaCodeList" rows="30" cols="130"></textarea>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">Count 구문</label></th>
					<td>
						<textarea id="txtareaCodeCount" rows="30" cols="130"></textarea>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">Insert 구문</label></th>
					<td>
						<textarea id="txtareaCodeInsert" rows="30" cols="130"></textarea>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">Delete 구문</label></th>
					<td>
						<textarea id="txtareaCodeDelete" rows="30" cols="130"></textarea>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">Update 구문</label></th>
					<td>
						<textarea id="txtareaCodeUpdate" rows="30" cols="130"></textarea>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">PK 조건절</label></th>
					<td>
						<textarea id="txtareaCodePKCond" rows="30" cols="130"></textarea>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">ResultMap<br/>(CLOB컬럼이 있을때 사용)</label></th>
					<td>
						<textarea id="txtareaCodeResultmap" rows="30" cols="130"></textarea>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">목록 테이블<br/>(jsp 화면단)</label></th>
					<td>
						<textarea id="txtareaCodeViewTable" rows="30" cols="130"></textarea>
					</td>
				</tr>
			</table>			
		</div>
		<div id="divTabSub05">
			<div class="info">
				본 페이지는 개발자가 개발시에만 사용하는 페이지로, 보안상 매우 취약하므로 최종배포시에 반드시 삭제하시기 바랍니다.<br/><br/>
				목록의 페이징처리에 필요한 가이드 코드를 제공합니다.
			</div>
			<table class="tstyle_view">
				<colgroup>
					<col width="18%" />
					<col />
				</colgroup>
				<caption>항목</caption>
				<tr>
					<th scope="row"><label for="title">1. Select SQL</label></th>
					<td>
						<textarea rows="30" cols="130">
	
	&lt;!-- 아래와 같이 Select SQL문을 페이징에 필요한 구문으로 감싼다. --&gt;

	SELECT * FROM ( SELECT rownum rn, TB.* FROM (
	
	-----------------
	
	Select Query
	 
	-----------------
	
	) TB )  WHERE rn BETWEEN #firstIndex# + 1 AND #firstIndex# + #recordCountPerPage#
					
						</textarea>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">2. Action Controller</label></th>
					<td>
						<textarea rows="30" cols="130">
					
	/** pageing setting */
	PlaniPaginationInfo paginationInfo = new PlaniPaginationInfo();
	paginationInfo.setContextPath(request.getContextPath());
	paginationInfo.setCurrentPageNo(userinfoVO.getPageIndex());
	paginationInfo.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
	paginationInfo.setPageSize(propertiesService.getInt("pageSize"));
	
	userinfoVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
	userinfoVO.setLastIndex(paginationInfo.getLastRecordIndex());
	userinfoVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
	List userinfoList = userinfoService.selectUserinfoList(userinfoVO);
	model.addAttribute("resultList", userinfoList);
	
	int totCnt = userinfoService.selectUserinfoListTotCnt(userinfoVO);
	paginationInfo.setTotalRecordCount(totCnt);
	model.addAttribute("paginationInfo", paginationInfo);
	
	NumberFormat nf = NumberFormat.getInstance();
	model.addAttribute("curPage", nf.format(paginationInfo.getCurrentPageNo()));
	model.addAttribute("totCnt", nf.format(totCnt));
	model.addAttribute("totPage", nf.format(paginationInfo.getTotalPageCount()));
	
					
						</textarea>
					</td>
				</tr>
			</table>
		</div>
		<div id="divTabSub06">
			<div class="info">
				본 페이지는 개발자가 개발시에만 사용하는 페이지로, 보안상 매우 취약하므로 최종배포시에 반드시 삭제하시기 바랍니다.<br/><br/>
				파일첨부에 필요한 가이드 코드를 제공합니다. [Uploadify V3.2 사용]<br/>
				<span class="txt_red">작업 전에 반드시 globals.properties 파일의 Globals.fileUploadPath 항목에 파일이 저장될 경로를 지정해야 합니다</span>
			</div>
			
			<table class="tstyle_view">
				<colgroup>
					<col width="18%" />
					<col />
				</colgroup>
				<caption>항목</caption>
				<tr>
					<th scope="row"><label for="title">1. 스크립트 추가</label></th>
					<td>
						<p>&lt;link href="#CONTEXT_PATH#/css/ktsta/fileupload.css" rel="stylesheet" rel="stylesheet"/&gt;</p>
						<p>&lt;link href="#CONTEXT_PATH#/utils/fileupload/uploadify/uploadify.css" rel="stylesheet"/&gt;</p>
						<p>&lt;script type="text/javascript" src="#CONTEXT_PATH#/js/plani/plani_common.js"&gt;</p>
						<p>&lt;script type="text/javascript" src="#CONTEXT_PATH#/utils/fileupload/uploadify/jquery.uploadify.js"&gt;</p>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">2. Input File 추가</label></th>
					<td>
						<p><span class="txt_blue">파일첨부할 위치(폼)에 추가한다. name과 id는 변경하지 않는다.</span></p>
						<p>&lt;div class="fileUpload_area"&gt;</p>
						<p>	&lt;h2>첨부파일&lt;/h2&gt;&lt;input type="file" name="file_upload" id="file_upload"/&gt;</p>
						<p>	&lt;ul class="fileUpload_progress"&gt;</p>
						<p>		&lt;li&gt;&lt;div id="divSelectFileArea"&gt;&lt;/div&gt;&lt;/li&gt;</p>
						<p>	&lt;/ul&gt;</p>
						<p>&lt;/div&gt;</p>
						
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">3. Uploadify 초기화</label></th>
					<td>
						<p><span class="txt_red">페이지의 스크립트 시작부분에서 아래 함수를 실행한다. (아래는 함수 프로토타입이며 예제를 참조)</span></p>
						<p><span class="txt_blue">@param INPUT_ID : file object id : file_upload</span></p>
						<p><span class="txt_blue">@param CONTEXT : contextpath ( $ {pageContext.request.contextPath})</span></p>
						<p><span class="txt_blue">@param MAXUPLOADLIMIT : 최대 파일 업로드 개수 제한 (기존에 이미 첨부되어있는 파일까지 포함한 첨부 가능 개수)</span></p>
						<p><span class="txt_blue">@param UPLOADCOUNT : 이미 업로드된 파일 개수 (최대 개수제한에서 이 값을 뺀 값이 0이면 파일첨부버튼이 보이지 않음)</span></p>
						<p><span class="txt_blue">@param FILESIZELIMIT : 파일 사이즈 크기 제한 (MB)</span></p>
						<p><span class="txt_blue">@param FILETYPE : 첨부할 파일 타입 정의 (GNR(제한 없음), IMG, DOC, PDF ...)</span></p>
						<p><span class="txt_blue">@param CALLBACK : 파일전송이 완료되고 실행할 javascript 함수</span></p>
						<p>cmmfn_init_uploadify(#INPUT_ID#, #CONTEXT#, #MAXUPLOADLIMIT#, #UPLOADCOUNT#, #FILESIZELIMIT#, #FILETYPE#, #CALLBACK#);</p>
						<p>&nbsp;</p>
						<p>ex) cmmfn_init_uploadify("file_upload", g_context, 1, 0, 20, "DOC", fn_egov_thesisappl_list);</p>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">4. 파일전송</label></th>
					<td>
						<p><span class="txt_red">실제 파일이 전송되는 부분(스크립트)에서 아래 함수를 실행한다. </span></p>
						<p><span class="txt_blue">파일전송은 시스템 내에서 공통으로 사용되기때문에 파일을 저장할때 구분값으로 복합키를 쓴다. </span></p>
						<p><span class="txt_blue">예를들어 공지사항 게시판(게시판이 아니어도 상관없음)의 5번째 글에 대한 파일첨부라면 </span></p>
						<p><span class="txt_blue">KEY_1 은 공지사항 게시판이라는걸 나타내는 구분값이고,</span></p>
						<p><span class="txt_blue">KEY_2 는 5가 된다.</span></p>
						<p><span class="txt_blue">KEY_3 는 위 2개로 키를 구분하는데 충분하지 않을 경우 사용한다. 기본값은 1로 주어진다.</span></p>
						<p><span class="txt_blue">KEY_4 는 파일업로드시 특수한 처리를 하기 위한 구분 값으로, 일반적인 업로드라면 'GNR' 을 입력한다.</span></p>
						<p><span class="txt_blue">INPUT_ID는 input file의 id값이다.</span></p>
						<p><span class="txt_blue">파일이 3개 첨부됐다면 그에 대한 각각의 일련번호는 파일이 저장될때 매겨진다.</span></p>
						<p>&nbsp;</p>
						<p>cmmfn_set_uploadifykeys(#INPUT_ID#, #KEY_1#, #KEY_2#, #KEY_3#, #KEY_4#);</p>
						<p>cmmfn_upload_uploadify(#INPUT_ID#, #CALLBACK#);</p>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">5. 파일목록 처리</label></th>
					<td>
						<p><span class="txt_red">1-1. 파일목록을 보여줄 action controller에 atchfileService를 injection한다.  </span></p>
						<p>&nbsp;</p>
						<p>/** AtchfileService */</p>
						<p>@Resource(name = "atchfileService")</p>
						<p>private AtchfileService atchfileService;</p>
						<p>&nbsp;</p>
						<p><span class="txt_red">1-2. 파일목록을 조회해서 모델에 넣는다.  </span></p>
						<p><span class="txt_blue">이때 필요한 파라미터는  brd_id => KEY_1, cont_idx => KEY_2 이다.  </span></p>
						<p>&nbsp;</p>
						<p>List fileList = atchfileService.selectAtchfileList(fileVO);</p>
						<p>model.addAttribute("atchfileList", fileList);</p>
						<p>&nbsp;</p>
						<p><span class="txt_red">2.  화면단은 아래와같이 처리한다. (화면단은 자신이 작업한 페이지에 맞게 수정해야 함.)  </span></p>
						<p><span class="txt_blue">커스텀 태그를 사용하기 위해  jsp페이지 상단에 아래구문을 먼저 추가한다.</span></p>
						<p><span class="txt_blue">&lt;%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%&gt; </span></p>
						<p>&nbsp;</p>
						
						<p>&lt;c:forEach var="result" items="$ {atchfileList}" varStatus="status"&gt;</p>
						<p>	&lt;div id="divAtcharea_$ {result.atch_idx}" class="uploadify-queue-item"&gt;</p>
						<p>		&lt;div class="cancel"&gt;</p>
						<p>			&lt;a href="javascript:cmmfn_delete_onefile('$ {pageContext.request.contextPath}', '$ {result.brd_id}', '$ {result.cont_idx}', '$ {result.atch_idx}', '$ {result.vchkcode}', callback)"&gt;X&lt;/a&gt;</p>
						<p>		&lt;/div&gt;</p>
						<p>		&lt;div class="file_area"&gt;</p>
						<p>			&lt;span class="fileName"&gt;</p>
						<p>				&lt;img src="$ {pageContext.request.contextPath}/images/template/exticos/$ {elfunc:getImgicoByExt(result.fext)}.gif" width="16" height="16" alt="htp"/&gt;</p>
						<p>				&lt;a href="javascript:cmmfn_download_atchfile('$ {pageContext.request.contextPath}', '$ {result.vchkcode}')"&gt;$ {result.rname} ($ {result.size_kb}kb)&lt;/a&gt;</p>
						<p>			&lt;/span&gt;</p>
						<p>			&lt;span class="data"&gt;&lt;/span&gt;</p>
						<p>		&lt;/div&gt;</p>
						<p>	&lt;/div&gt;</p>
						<p>&lt;/c:forEach&gt;</p>
						<p>&nbsp;</p>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">6. 파일 다운로드</label></th>
					<td>
						<p>&nbsp;</p>
						<p><span class="txt_red">1. 파일을 다운로드할 부분(&lt;a&gt; tag)에서 아래 함수를 링크한다. </span></p>
						<p><span class="txt_blue">KEY_3는 같이 첨부된 파일 내에서의 일련번호이다. </span></p>
						<p>&nbsp;</p>
						<p>cmmfn_download_atchfile(#CONTEXT#, #KEY_1#, #KEY_2#, #KEY_3#, #CHKCODE3)</p>
						
					</td>
				</tr>
			</table>	
			
		</div>
		<div id="divTabSub07">
			<div class="info">
				본 페이지는 개발자가 개발시에만 사용하는 페이지로, 보안상 매우 취약하므로 최종배포시에 반드시 삭제하시기 바랍니다.<br/><br/>
				엑셀다운로드에 필요한 가이드코드를 제공합니다.<br/>
				액션추가(파일)를 통해 생성된 소스코드에 엑셀 저장하는 부분이 자동으로 생성되도록 수정되었습니다.
			</div>
			<table class="tstyle_view">
				<colgroup>
					<col width="18%" />
					<col />
				</colgroup>
				<caption>항목</caption>
				<tr>
					<th scope="row"><label for="title">1. 버튼 추가</label></th>
					<td>
						<p>엑셀 저장 버튼을 화면에 추가합니다.</p>
						<p>이 버튼은 javascript:cmmfn_download_xlsfile('contextpath', 'action_url') 함수를 링크합니다.</p>
					</td>
				</tr>
			</table>
		</div>
		<div id="divTabSub08">
			<div class="info">
				본 페이지는 개발자가 개발시에만 사용하는 페이지로, 보안상 매우 취약하므로 최종배포시에 반드시 삭제하시기 바랍니다.<br/><br/>
				통계처리를 위한 가이드코드를 제공합니다.
			</div>
		</div>
		
	</div>
</div>
<!-- //content -->

<form:hidden path="srch_mu_site"/>
<form:hidden path="srch_mu_lang"/>

</form:form>    