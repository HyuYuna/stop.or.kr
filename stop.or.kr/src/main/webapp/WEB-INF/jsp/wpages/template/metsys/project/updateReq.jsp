<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">

$( document ).ready(function() {
	
	//jsp 파일 내 선언방법
	var _fileOption = [
	              		{
	              			objFileMode : "target",
	              			objFileInput : "#inputFile",
	              			objFileContainer : "#fileContainer",
	              			objFileHtml : "<p style='padding-top:5px;'><a href='javascript:;' onclick='downFileSingle(\"#jqXHR.atchFileId\")'><input type='hidden' name='atchFileId' value='#jqXHR.atchFileId'>#jqXHR.orignlFileNm</a><a href='javascript:;' class='imgDelete'>[삭제]</a></p>",
	              			objFileLimit : 20,
	              			objFileCallback : false
	              		}
	              	];
	
  	//#jqXHR.logicFileStreCours : 저장경로, #jqXHR.orignlFileNm : 원본 파일명, 	#jqXHR.streFileNm : 저장된 파일명
  	initFileUpload(_fileOption);
	
  	$(".imgDelete").on("click",function(){	
  		deleteFileFake(this);
	});
	
  	fnToList = function(){
		$("#listFrm").find("input[name=pbdSeq]").remove();
		$("#listFrm").attr("action","/project/list.do");
		$("#listFrm").submit();
	};		
	
	fnToRequest = function(){
		$("#listFrm").attr("action","/project/write.do");
		$("#listFrm").submit();
	};
	
	fnToRegist = function(){
		
		var inputCheckArray = new Array("pbdCategory","pbdReqTitle","pbdDueDt");
		var inputNameArray = new Array("점검항목을 선택해 주세요.","제목을 입력해 주세요.","완료요청일을 입력해 주세요.");

		for ( var i = 0; i < inputCheckArray.length; i++ ) {
			if($("#"+inputCheckArray[i]).val() == ""){
				alert(inputNameArray[i]);
				$("#"+inputCheckArray[i]).focus();
				return false;
			}
	    }
		
		var pidCd = "${vo.pidCd}";
		if(pidCd == "news"){
			if($("#targetUrl").val() == ""){
				alert("외부링크를 입력해 주세요.");
				$("#targetUrl").focus();
				return false;
			}
		}else{
			//setForm(Editor);	//editor textarea setting
			//alert(Editor.getCanvas().getContent());
			var editorData = Editor.getCanvas().getContent();
			if(editorData == "" || editorData == "<p><br></p>"){
				alert("내용을 입력해 주세요.");
				return false;
			}
			$("#pbdReqContent").val(editorData);
		}
		  
		$.ajax({
			url: "/project/jsonUpdate.do",
			type: "post",
			data: $('#frm').serialize(),
			async:false,
			success:function (response) {
				var data = JSON.parse(response);
				alert(data.result.msg);
				if(data.result.status == "success"){
					fnToList();
				}
			}
		});
		 
		 
	};
	
	fnToCancel = function(){
		if(confirm("작성중인 내용이 저장되지 않습니다. 계속진행하시겠습니까?")){
			fnToList();
		}	
	};
	
	fnAddRow = function(obj,addSize){
		//기본 5개까지만 추가되도록 설정
		if(typeof addSize == "undefined") addSize = 5;
		console.log($(obj));
		var tagName = $(obj).prev().get(0).tagName;
		if($(obj).parent().children(tagName).size() < addSize){
			var delBtn = "<br /><a href=\"javascript:;\" onclick=\"fnDelRow(this)\" class=\"sbtn sMinus\">제거</a>";
			var addObj = $(obj).prev().clone(true);	//이벤트까지 복사함
			addObj.find("input").val("");
			
			//부모객체를 기준으로 append
			$(obj).parent().append(addObj);
			$(obj).parent().append(delBtn);	
		}else{
			alert("최대 5개까지만 등록이 가능합니다.");
		}
	};
	
	// 파일등록란 삭제
	fnDelRow = function(obj){
		//$(obj).prev().prev().prev().remove();
		$(obj).prev().prev().remove();	//ul
		$(obj).prev().remove();			//br
		$(obj).remove();					///delBtn
	};
	
	fnCallMemberPopup = function(){

	};
	
	$("#pbdDueDt").datepicker({
		dateFormat: 'yy-mm-dd',
		changeMonth: 'true',
		changeYear: 'true'
	});
	
});
</script>

<form name="listFrm" id="listFrm" method="get" action="">
<input type="hidden" name="pageIndex" value="<c:out value="${vo.pageIndex }" />">
<input type="hidden" name="pbdReqType" value="<c:out value="${vo.pbdReqType }" />">
<input type="hidden" name="pbdYear" value="<c:out value="${vo.pbdYear }" />">
<input type="hidden" name="pbdCategory" value="<c:out value="${vo.pbdCategory }" />">
<input type="hidden" name="searchType" value="<c:out value="${vo.searchType }" />">
<input type="hidden" name="searchWord" value="<c:out value="${vo.searchWord }" />">
<input type="hidden" name="pageUnit" value="<c:out value="${vo.pageUnit }" />">
<input type="hidden" name="pbdSeq" value="<c:out value="${vo.pbdSeq }" />">
<input type="hidden" name="srch_menu_nix" id="srch_menu_nix" value="${vo.srchMenuNix }">
</form>

<div id="divMainArticle">
		<form name="frm" id="frm" method="post">
		<input type="hidden" name="pbdSeq" id="pbdSeq" value="<c:out value="${result.pbdSeq }" />">
		<input type="hidden" name="pidCd" id="pidCd" value="<c:out value="${result.pidCd }" />">
		<input type="hidden" name="pbdReqType" id="pbdReqType" value="<c:out value="${empty result.pbdReqType ? '요청' : result.pbdReqType }" />">
		
		<table class="tstyle_view">
			<caption>테이블</caption>
			<colgroup>
				<col style="width:15%"/>
				<col style="width:35%"/>
				<col style="width:15%"/>
				<col />
			</colgroup>
			<tbody>
				<tr>	
					<th scope="row">요청번호</th>
					<td><c:out value="${result.pbdNo}" /></td>
					<th scope="row">등록일시</th>
					<td><c:out value="${result.pbdReqDt}" /></td>
				</tr>
				<tr>	
					<th scope="row">요청구분</th>
					<td><c:out value="${result.pbdReqType}" /></td>
					<th scope="row">요청자</th>
					<td><c:out value="${result.pbdReqMemNm}" /></td>
				</tr>
				<tr>	
					<th scope="row">점검항목</th>
					<td>
						<select name="pbdCategory" id="pbdCategory" style="width:112px">
							<option value="" >선택</option>
							<option value="그룹웨어" ${result.pbdCategory eq '그룹웨어' ? 'selected="selected"':''}>그룹웨어</option>
							<option value="홈페이지" ${result.pbdCategory eq '홈페이지' ? 'selected="selected"':''}>홈페이지</option>
							<option value="위기청소년" ${result.pbdCategory eq '위기청소년' ? 'selected="selected"':''}>위기청소년</option>
							<option value="사이버상담" ${result.pbdCategory eq '사이버상담' ? 'selected="selected"':''}>사이버상담</option>
							<option value="해바라기센터" ${result.pbdCategory eq '해바라기센터' ? 'selected="selected"':''}>해바라기센터</option>
							<option value="디성" ${result.pbdCategory eq '디성' ? 'selected="selected"':''}>디성</option>
							<option value="기타" ${result.pbdCategory eq '기타' ? 'selected="selected"':''}>기타</option>
							<option value="해바라기고도화" ${result.pbdCategory eq '해바라기고도화' ? 'selected="selected"':''}>해바라기고도화</option>
						</select>
					</td>
					<th scope="row">완료요청일</th>
					<td>
						<input type="text" name="pbdDueDt" id="pbdDueDt" style="width:120px;" value="<c:out value="${result.pbdDueDt }" />"  placeholder="2019-01-01" readonly/>
					</td>
				</tr>
				<tr>	
					<th scope="row">제목</th>
					<td colspan="3"><input type="text" name="pbdReqTitle" id="pbdReqTitle" style="width:90%;" value="<c:out value="${result.pbdReqTitle }" />"  placeholder="제목을 입력해 주세요." /></td>
				</tr>
				<tr>	
					<th scope="row">내용</th>
					<td colspan="3">
						<div class="textarea">
							<%-- <!--DaumEditor 시작 -->
					    	<jsp:include page="/daumEditor/editor.jsp" flush="false" >
					    	<jsp:param name="editor_type" value="image"/>
					    	<jsp:param name="return_form_name" value="frm"/>
					    	<jsp:param name="return_textarea_name" value="pbdReqContent"/>
					    	</jsp:include>		
							<!--DaumEditor 끝 -->
							<textarea id="editorHtml" style="display:none;"><c:out value="${result.pbdReqContent}" escapeXml="false" /></textarea> --%>
							<div id="editor_frame"></div>
							<textarea name="pbdReqContent" id="pbdReqContent" rows="" cols="" class="display_none"><c:out value="${result.pbdReqContent}" escapeXml="false" /></textarea>		
						</div>
					</td>
				</tr>
				<tr>	
					<th scope="row">첨부파일</th>
					<td colspan="3">
						<div class="filebox preview-image">
							<!-- 첨부파일 호출 요소 -->
							<label>
								파일선택
								<input type="file" name="inputFile" id="inputFile" class="upload-hidden" multiple="multiple"/>
								<!-- DB에 등록될 atchFileId가 저장될 input 개발시 input type hidden으로 변경-->
								<input type="hidden" name="atchFileId" style="width:100px;" readonly="readonly" value="<c:out value="${result.atchFileId }" />"/>
							</label>
							<!-- 등록파일명이 표출되는 input  -->
							<c:if test="${!empty result.atchFileId }"><a href="javascript:;" class="imgDelete">[삭제]</a></c:if>
						</div>
						<div id="fileContainer">
						<c:forEach var="list" items="${fileList}" varStatus="status">
						<c:if test="${list.pbfType eq 'req' }">
						<p style="padding-top:5px;"><a href="javascript:;" onclick="downFileSingle('${list.atchFileId }')"><input type="hidden" name="atchFileId" value="${list.atchFileId }">${list.orignlFileNm }</a><a href="javascript:;" class="imgDelete">[삭제]</a></p>
						</c:if>
						</c:forEach>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		
		
		<table style="margin-top:20px;" class="tstyle_view">
			<caption>테이블</caption>
			<colgroup>
				<col style="width:15%"/>
				<col style="width:35%"/>
				<col style="width:15%"/>
				<col />
			</colgroup>
			<tbody>
				<tr>	
					<th scope="row">처리구분</th>
					<td>
						<c:out value="${result.pbdResType}" />
					</td>
					<th scope="row">조치자</th>
					<td>
						<c:out value="${result.pbdResMemNm}" />
					</td>
				</tr>
				<tr>	
					<th scope="row">조치일시</th>
					<td colspan="3"><c:out value="${result.pbdResDt}" /></td>
				</tr>
				<%-- <tr>	
					<th scope="row">제목</th>
					<td colspan="3"><input type="text" name="pbdResTitle" id="pbdResTitle" style="width:90%;" value="<c:out value="${result.pbdReqTitle }" />"  placeholder="제목을 입력해 주세요." /></td>
				</tr> --%>
				<tr>	
					<th scope="row">내용</th>
					<td colspan="3">
						<div class="textarea" style="min-height:200px;">
							<c:out value="${result.pbdResContent}" escapeXml="false" />
						</div>
					</td>
				</tr>
				<tr>	
					<th scope="row">첨부파일</th>
					<td colspan="3">
						<div id="fileContainerRes">
						<c:forEach var="list" items="${fileList}" varStatus="status">
						<c:if test="${list.pbfType eq 'res' }">
						<p style="padding-top:5px;"><a href="javascript:;" onclick="downFileSingle('${list.atchFileId }')">${list.orignlFileNm }</a></p>
						</c:if>
						</c:forEach>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		</form>


		<div class="btn_area_right">
			<button class="btn_line" onclick="fnToCancel(); return false;">취소</button>
			<button class="btn_line" onclick="fnToRequest(); return false;">재요청</button>
			<button class="btn_line" onclick="fnToRegist(); return false;">수정</button>
		</div>

</div>


<script type="text/javascript">
//각 값들을 선언 -> 추후 개편 예정 (좀 더 깔끔한 소스로)
/* 
var file_array = ["atch_file_id"];
var file_array_value = ["${result.atch_file_id}"];
var file_array_value_ori = ["${result.atch_file_id_ori}"];

for(i=0; i < file_array.length;i++){
	if(file_array_value[i] == ""){
		//값이 없을경우 건너뜀!
		continue;
	}else{
		//데이터를 로드할 elememt 를 선언 		
		click_element = $("#"+file_array[i]);
		//데이터 값 입력
		var _loaddata = {
				'filename': file_array_value_ori[i],
				'atchFileId': file_array_value[i],
				'fileSn': '0'
		};
		//첨부파일 호출
		uploadComplete(_loaddata);
	}
}
 */
 
var  pidCd = "${vo.pidCd}";
if(pidCd != "news"){
	/* Editor Contents, File Load */
	var attachments = {};
	attachments['image'] = [];
	var ediotor_contents = $("#editorHtml").val();
	var ediotor_el = $.parseHTML( ediotor_contents );
	$(ediotor_el).find(".txc-image").each(function(){
		attachments['image'].push({
			'attacher': 'image',
			'data': {
				'imageurl': $(this).attr("src"),
				'filename': $(this).attr("data-filename"),
				'filesize': $(this).attr("data-filesize"),
				'originalurl': $(this).attr("src"),
				'thumburl': $(this).attr("src")
			}
		});
	}); 
	 
	/* 저장된 컨텐츠를 불러오기 위한 함수 호출 */
	Editor.modify({
		"attachments": function () { /* 저장된 첨부가 있을 경우 배열로 넘김, 위의 부분을 수정하고 아래 부분은 수정없이 사용 */
			var allattachments = [];
			for (var i in attachments) {
				allattachments = allattachments.concat(attachments[i]);
			}
			return allattachments;
		}(),
		"content": ediotor_contents /* 내용 문자열, 주어진 필드(textarea) 엘리먼트 */
	});

}
</script>


	
