$(function() {
	/* jsp 파일 내 선언방법
	var _fileOption = [
	              		{
	              			objFileMode : "target",
	              			objFileInput : "#input-file-rep",
	              			objFileContainer : "#targetDivRep",
	              			objFileHtml : "<li class='ui-state-default'><img src='#jqXHR.logicFileStreCours#jqXHR.streFileNm' alt='#jqXHR.orignlFileNm' style='width:100px;height:70px'/><br /><span>#jqXHR.orignlFileNm</span><a href='javascript:;' class='imgDelete'><img src='/images/common/img_delete.png' alt='삭제'/></a><input type='hidden' name='repImageId' value='#jqXHR.streFileNm'></li>",
	              			objFileLimit : 1
	              		},
	              		{
	              			objFileMode : "target",
	              			objFileInput : "#input-file-spec",
	              			objFileContainer : "#targetDivSpec",
	              			objFileHtml : "<li class='ui-state-default'><input type='hidden' name='specSerialNbr'  id=''  value=''/><img src='#jqXHR.logicFileStreCours#jqXHR.streFileNm' alt='#jqXHR.orignlFileNm' style='width:100px;height:70px'/><br /><span>#jqXHR.orignlFileNm</span><a href='javascript:;' class='imgDelete'><img src='/images/common/img_delete.png' alt='삭제'/></a><input type='hidden' name='specImageId' value='#jqXHR.streFileNm'></li>",
	              			objFileLimit : 20
	              		},
	              		{
	              			objFileMode : "next",
	              			objFileInput : "input[name=clrIconIdFile]",
	              			objFileContainer : "input[name=clrIconId]",
	              			objFileHtml : "<a href='javascript:;' class='imgDelete'><img src='/images/common/img_delete.png' alt='삭제'/></a>",
	              			objFileLimit : 1
	              		},
	              		{
	              			objFileMode : "next",
	              			objFileInput : "input[name=carClassClrImageIdFile]",
	              			objFileContainer : "input[name=carClassClrImageId]",
	              			objFileHtml : "<a href='javascript:;' class='imgDelete'><img src='/images/common/img_delete.png' alt='삭제'/></a>",
	              			objFileLimit : 1
	              		}
	              	];
	
  	//#jqXHR.logicFileStreCours : 저장경로, #jqXHR.orignlFileNm : 원본 파일명, 	#jqXHR.streFileNm : 저장된 파일명
  	initFileUpload(_fileOption);
  	*/
	
	
	
	
	var _saveFileOption = [];
	
	/* 파일 컴포넌트 선언 핸들러 */
	initFileUpload = function(optionList){
		_saveFileOption = optionList;
		for(i = 0; i < optionList.length ; i++){
			if (typeof $(optionList[i].objFileInput) != "undefined"){
				
				$(optionList[i].objFileInput).on("change", function(e){  // 값이 변경되면
					var targetObject = findFileInputReturnOption(optionList,this);
					var files = this.files;	//file multiple
					for (var j = 0; j < files.length; j++){
						var fd = new FormData();
						fd.append("file", files[j]);
						var extension = files[j].name.substring(files[j].name.lastIndexOf('.')+1);		//ie debug
						//if(files[j].type == "application/pdf" || extension.toLowerCase() == "pdf" ){
							if(files[j].size > 104857600){	//관리가 필요할시 설정파일에 적용요망
								alert("100MB 이상 파일은 업로드 할 수 없습니다. 파일명: " + files[j].name);
							}else{
								sendFileToServer(fd,optionList[targetObject],this);
							}
						//}else{
							//alert("PDF 이외 파일은 업로드 할 수 없습니다.");
						///}
					}
					//change 이벤트를 위한 초기화 추후 확인 필요.
					$(this).val("");
				});//changeFunction
			}//if
		}//for
	};
	
	/*objFileInput 셀렉터를 활용하여 option index를 찾아 리턴해준다*/
	findFileInputReturnOption = function(optionList,obj){
		var targetOption = 0;	//혹 값이 없을때를 대비하여 기본값으로 0을 줌
		for(i = 0; i < optionList.length ; i++){
			if(optionList[i].objFileInput.substring(0,1) == "." && $(obj).attr("class") == optionList[i].objFileInput.replace(".","")){				//클래스의 경우
				targetOption = i;
			}else if(optionList[i].objFileInput.substring(0,1) == "#" && $(obj).attr("id") == optionList[i].objFileInput.replace("#","")){		//Id의 경우
				targetOption = i;
			}else{																																									//Name의 경우
				if(optionList[i].objFileInput.indexOf($(obj).attr("name")) > 0 ){
					targetOption = i;
				}
			}
		}
		return targetOption;
	};
	
	
	/*deleteBt 셀렉터를 활용하여 option index를 찾아 리턴해준다*/
	findDeleteBtnReturnOption = function(streFileNm,obj){
		console.log("streFileNm="+streFileNm);
		var targetOption = 99;	//혹 값이 없을때를 대비하여 기본값으로 99를 줌
		for(i = 0; i < _saveFileOption.length ; i++){
			var objFileMode = _saveFileOption[i].objFileMode;
			var objFileHtml = _saveFileOption[i].objFileHtml;
			console.log(objFileHtml);
			if(objFileMode == "next" || objFileMode == "prev" ){	//next or prev 의 경우
				$(obj).parent().find("input").each(function(){
					if($(this).val() == streFileNm){ 
						var findNm = $(this).attr("name");
						if(objFileHtml.indexOf(findNm) > 0){
							targetOption = i;	
						}	
					}
				});
			}else{
				$(objFileContainer).find("input").each(function(){
					if($(this).val() == streFileNm){ targetOption = i; }
				});
			}
		}
		return targetOption;
	};
	
	
	/* 파일정보 표출 및 객체 성성 핸들러 */
	handleFileUpload = function(jqXHR,option,obj){
		console.log(jqXHR);
		objFileContainer = $(option.objFileContainer);
		var entry = eval(jqXHR);	// data들을 객체로 변환
		for(i=0; i < entry.length; i++){
			/*
			아래의 문자열을 upload 된 정보로 replace 시켜 원하는 내역을 삽입함
			#jqXHR.logicFileStreCours : 저장경로
			#jqXHR.orignlFileNm : 원본 파일명
			#jqXHR.streFileNm : 저장된 파일명
			*/
			var replaceHtml = option.objFileHtml;
			replaceHtml = replaceHtml.replace(/#jqXHR.logicFileStreCours/gi, entry[i].logicFileStreCours);
			replaceHtml = replaceHtml.replace(/#jqXHR.orignlFileNm/gi, entry[i].orignlFileNm);
			replaceHtml = replaceHtml.replace(/#jqXHR.streFileNm/gi, entry[i].streFileNm);
			replaceHtml = replaceHtml.replace(/#jqXHR.atchFileId/gi, entry[i].atchFileId);
			
			//동적으로 생성한 imgDelete  클래스에 delete function 부여
			
			var replaceHtmlObj = $.parseHTML( replaceHtml );
			$(replaceHtmlObj).find(".imgDelete").click(function(){	
				//파일 삭제 로직 변경 :  기존 - 물리적 파일 삭제, 현재 - html 태그만 삭제
				///deleteFileFromServer(streFileNm,option,this);
				//alert(entry[i].streFileNm);
				if(option.objFileMode == "target"){
					deleteFileFake(this);	
				}else{
					deleteFileFakePrevNext(this);
				}
			});
			
			if($(replaceHtmlObj).attr("class")=="imgDelete"){	//삭제 이미지 태그만 있을경우 추가적으로 선언해 줌
				$(replaceHtmlObj).click(function(){
					if(option.objFileMode == "target"){
						deleteFileFake(this);	
					}else{
						deleteFileFakePrevNext(this);
					}
				});
			}
			
			if(option.objFileMode == "target"){
				$(option.objFileContainer).append(replaceHtmlObj);
			}else if(option.objFileMode == "prev"){
				$(obj).prev().val(entry[i].orignlFileNm);	//업로드된 파일명이 보여주기용도로 사용되고 DB에 들어갈 값은 objFileContainer 로 지정함
				$(obj).parent().find(option.objFileContainer).val(entry[i].streFileNm);	//objFileContainer에 지정한 selector 에 저장된 파일 값을 부여함
				if(option.objFileHtml){
					$(obj).prev().after(replaceHtmlObj);	
				}else{
					$(obj).parent().find(".btnGray").attr("href",entry[i].logicFileStreCours+entry[i].streFileNm);
				}
			}else if(option.objFileMode == "next"){
				$(obj).parent().next().val(entry[i].orignlFileNm);
				$(obj).parent().parent().find(option.objFileContainer).val(entry[i].streFileNm);
				if(option.objFileHtml){
					$(obj).parent().next().after(replaceHtmlObj);	
				}
			}
		}//for
		if(option.objFileCallback){	//콜백함수 호출
			fnFileCallback();
		}
	};
	
	/* 첨부파일 개수 체크 핸들러 */
	checkFileLimit = function(option,obj){
		if(option.objFileMode == "target"){
			if($(option.objFileContainer).children().size() < option.objFileLimit ){
				return true;	
			}else{
				alert(option.objFileLimit+"개의 첨부파일만 등록할 수 있습니다.");
				return false;
			}		
		}else{	//next,prev
			$(obj).parent().parent().find(".imgDelete").remove();
		}
	};
	
	//file 전송 function 
	sendFileToServer = function (formData,option,obj){
		
		var uploadURL = "/project/jsonFileUpload.do"; 		//Upload URL
		var extraData ={}; 						//추후 확장 옵션을 위해 선언
		var jqXHR=$.ajax({
			xhr: function() {
				var xhrobj = $.ajaxSettings.xhr();
				return xhrobj;
			},
			url: uploadURL,
			type: "POST",
			contentType:false,
			processData: false,
			cache: false,
			data: formData,
			beforeSend: function (){
				//보내기 전 callback 	
				//console.log("sendFileToServer="+option);
				$("#popLayer").show();
				$("#popLayer").center();
				
				var checkFileLimitStatus = checkFileLimit(option,obj);
				if(!checkFileLimitStatus)  $("#popLayer").hide();
				return checkFileLimitStatus;
			},
			success: function( jqXHR, textStatus, data ){
				//console.log(jqXHR);
				var entry = JSON.parse(jqXHR);
				//완료 후 callback		
				if(entry.result.status == "success"){
					handleFileUpload(entry.fileList,option,obj);
				}else{
					alert(entry.result.msg);
				}
				$("#popLayer").hide();
			},
			error: function( jqXHR, textStatus, errorThrown){
				//에러 시 callback
				alert(errorThrown);
			}
		}); 
		//status.setAbort(jqXHR);
	};
	
	/*파일정보 추출 핸들러 */
	getFileInfo = function(streFileNm){
		return $.ajax({ url : "/cmm/json/fileInfo.do", 	type : "post", data :  { streFileNm: streFileNm }
			
		});
	};
	
	
	deleteFileFromServer = function(streFileNm,option,obj){
		if(typeof option =="undefined" || option==null || option==""){		//option 부분이 없으면 option 값을 찾아옴 
			var optionIdx = findDeleteBtnReturnOption(streFileNm,obj);
			option = _saveFileOption[optionIdx];
		}
		
		$.ajax({ url : "/cmm/json/fileDelete_e.do",
			type : "post",
			data :  { streFileNm: streFileNm },
			async: true,
			success:
				function (data) {
					if(data == "true"){
						//web 삭제
						if(option.objFileMode == "target"){
							//해당 objFileHtml 을 가져와 객채로 parse 시킨 후 가장 상위 태그를 추출하여 제거함
							var objFileHtmlParse = $.parseHTML( option.objFileHtml );
							$(obj).closest($(objFileHtmlParse).get(0).tagName).remove();
						}else{ //next , prev
							$(obj).prev().val("");
							if(option.objFileHtml){
								var objFileHtmlParse = $.parseHTML( option.objFileHtml );
								$(obj).closest($(objFileHtmlParse).get(0).tagName).remove();
							}//if
						}//if
					}else{
						alert("이미 파일이 삭제되었습니다.");
					}
				},
				complete: function(data) {
					//통신 완료시 callback
				}
		}); 
	};
	
	//실제 삭제되면 안될경우 사용함 ex>불러온 내역 삭제
	deleteFileFake = function(obj){
		//alert("deleteFileFake");
		//$(obj).parent().parent().remove();
		$(obj).parent().remove();
	};
	
	deleteFileFakePrevNext = function(obj){
		//alert("deleteFileFakePrevNext");
		//$(obj).prev().val("");
		//$(obj).next().val("");
		//$(obj).parent().find("input").val("");
		$(obj).parent().find("input[name=docData]").val("");
		$(obj).parent().find("input[name=docFileNm]").val("");
		$(obj).remove();
	};
	
	downFileSingle = function(atchFileId){
		var url = "/project/jsonFileDown.do?atchFileId="+atchFileId;
		var dummyFrame = $("#dummyFrame");
	    if ($("#dummyFrame").length === 0) {
	        dummyFrame = $("<iframe>").attr({
	            id: "dummyFrame",
	            width: 0,
	            height: 0
	        }).css({
	            border: "0px none"
	        });
	        $("body").append(dummyFrame);
	    }
	    dummyFrame.attr("src", url);
	};
	
	makeDummyFrame = function(url){
		var dummyFrame = $("#dummyFrame");
	    if ($("#dummyFrame").length === 0) {
	        dummyFrame = $("<iframe>").attr({
	            id: "dummyFrame",
	            width: 0,
	            height: 0
	        }).css({
	            border: "0px none"
	        });
	        $("body").append(dummyFrame);
	    }
	    console.log(url);
	    dummyFrame.attr("src", url);
	};
	
});//function

jQuery.fn.center = function () {
    this.css("position","absolute");
    this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
    this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
    return this;
};