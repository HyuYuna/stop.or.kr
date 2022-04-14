<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
$( document ).ready(function() {
	fnToList = function(pageIndex){
		
		if(typeof pageIndex == "undefined"){
			$("#pageIndex").val("1");
		}else{
			$("#pageIndex").val(pageIndex);
		}
		
		$("#listFrm").attr("action","/project/list.do");
		$("#listFrm").submit();
	};	
	
	fnToView = function(pbdSeq){
		var input = document.createElement("input");
		input.setAttribute("type","hidden");
		input.setAttribute("name","pbdSeq");
		input.setAttribute("value", pbdSeq);
		$("#listFrm").append(input);
		$("#listFrm").attr("action","/project/update.do");
		$("#listFrm").submit();
		$("#listFrm").find("input[name=pbdSeq]").remove();	//뒤로가기 디버그 수정
	};
	
	fnToWrite = function(){
		$("#listFrm").attr("action","/project/write.do");
		$("#listFrm").submit();
	};
	
	fnArrayDelete = function(){
		var checkedValue = "";
		$("#listTbody").find("input[type=checkbox]:checked").each(function(){
      		if(checkedValue == ""){
      			checkedValue += $(this).val();
      		}else{
      			checkedValue += ","+$(this).val();
      		}
      	});
		$("#checkedValue").val(checkedValue);
		
		if(checkedValue == ""){
			alert("삭제할 게시글을 체크해 주세요.");
		}else{
			if(confirm("선택한 게시글이 삭제됩니다. 계속진행하시겠습니까?")){
				$.ajax({
					url: "/project/jsonArrayDelete.do",
					type: "post",
					data: $('#frm').serialize(),
					async:false,
					success:function (response) {
						var data = JSON.parse(response);
						alert(data.result.msg);
						if(data.result.status == "success")	fnToList();
					}
				});	
			}
		}
	};
	
	$("#checkAll").change(function() {
	    if(this.checked) {
	        $("#listTbody").find("input[type=checkbox]").each(function(){
	        	this.checked = true;
	        });
	    }else{
	    	$("#listTbody").find("input[type=checkbox]").each(function(){
	        	this.checked = false;
	        });
	    }
	});
	
	fnExcelDown = function(){
		$("#listFrm").attr("action","/project/listExcel.do");
		$("#listFrm").submit();
	};
	
 	
});
</script>
<!-- content -->
<div id="divMainArticle">
	<form name="frm" id="frm" method="post" action="">
	<input type="hidden" name="checkedValue" id="checkedValue">
	</form>
	
	<form name="listFrm" id="listFrm" method="get" action="">
	<input type="hidden" name="pageIndex" id="pageIndex" value="1">
	<input type="hidden" name="srch_menu_nix" id="srch_menu_nix" value="${param.srch_menu_nix }">
				<table class="tstyle_view">
					<caption>목록 테이블</caption>
					<colgroup>
						<col style="width:15%">
						<col style="width:15%">
						<col style="width:15%">
						<col style="width:15%">
						<col style="width:15%">
						<col>
					</colgroup>
					<thead>
						<tr>
							<th scope="col">전체</th>
							<th scope="col">요청</th>
							<th scope="col">재요청</th>
							<th scope="col">미처리</th>
							<th scope="col">완료</th>
							<th scope="col">진도율</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
						<c:when test="${empty stats }">
						<tr>
							<td colspan="6" height="50" align="center">등록된 내용이 없습니다.</td>
						</tr>
						</c:when>
						<c:otherwise>
						<tr>
							<td align="center">${stats.totCnt }</td>
							<td align="center">${stats.reqCnt }</td>
							<td align="center">${stats.reCnt }</td>
							<td align="center">${stats.totCnt-stats.completeCnt }</td>
							<td align="center">${stats.completeCnt }</td>
							<td align="center"><fmt:formatNumber value="${empty stats.percent ? '0' : stats.percent * 100 }" pattern="###.##"/>%</td>
						</tr>
						</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<br />
				<table class="tstyle_view">
				<caption>검색</caption>
				<colgroup>
					<col style="width:20%">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">검색</th>
						<td>
							<label><q class="display_none">요청구분</q>
								<select name="pbd_req_type" id="pbd_req_type" style="width:112px">
									<option value="">요청구분</option>
									<option value="요청" ${projectVO.pbd_req_type eq '요청' ? 'selected="selected"':''}>요청</option>
									<option value="재요청" ${projectVO.pbd_req_type eq '재요청' ? 'selected="selected"':''}>재요청</option>
								</select>
							</label>
							
							<label><q class="display_none">연도</q>
								<c:set var="now" value="<%=new java.util.Date() %>" />
								<fmt:formatDate var="year" pattern="yyyy" value="${now}" />
								<select name="pbd_year" id="pbd_year" style="width:112px">
									<option value="">연도</option>
									<c:forEach var="i" begin="2019" end="${year}">
										<option value="${i}" ${projectVO.pbd_year eq i ? 'selected="selected"':''}>${i}</option>
									</c:forEach>
								</select>
							</label>
							
							<label><q class="display_none">점검항목</q>
								<select name="pbd_category" id="pbd_category" style="width:112px">
									<option value="">점검항목</option>
									<option value="그룹웨어" ${projectVO.pbd_category eq '그룹웨어' ? 'selected="selected"':''}>그룹웨어</option>
									<option value="홈페이지" ${projectVO.pbd_category eq '홈페이지' ? 'selected="selected"':''}>홈페이지</option>
									<option value="위기청소년" ${projectVO.pbd_category eq '위기청소년' ? 'selected="selected"':''}>위기청소년</option>
									<option value="사이버상담" ${projectVO.pbd_category eq '사이버상담' ? 'selected="selected"':''}>사이버상담</option>
									<option value="해바라기센터" ${projectVO.pbd_category eq '해바라기센터' ? 'selected="selected"':''}>해바라기센터</option>
									<option value="디성" ${projectVO.pbd_category eq '디성' ? 'selected="selected"':''}>디성</option>
									<option value="기타" ${projectVO.pbd_category eq '기타' ? 'selected="selected"':''}>기타</option>
									<option value="해바라기고도화" ${projectVO.pbd_category eq '해바라기고도화' ? 'selected="selected"':''}>해바라기고도화</option>
								</select>
							</label>
							
							<label><q class="display_none">처리구분</q>
								<select name="pbd_res_type" id="pbd_res_type" style="width:112px">
									<option value="">처리구분</option>
									<option value="미접수"${projectVO.pbd_res_type eq '미접수' ? 'selected="selected"':''}>미접수</option>
									<option value="접수" ${projectVO.pbd_res_type eq '접수' ? 'selected="selected"':''}>접수</option>
									<option value="처리중" ${projectVO.pbd_res_type eq '처리중' ? 'selected="selected"':''}>처리중</option>
									<option value="보류" ${projectVO.pbd_res_type eq '보류' ? 'selected="selected"':''}>보류</option>
									<option value="완료" ${projectVO.pbd_res_type eq '완료' ? 'selected="selected"':''}>완료</option>
									<option value="반려" ${projectVO.pbd_res_type eq '반려' ? 'selected="selected"':''}>반려</option>
								</select>
							</label>
							
							<label><q class="display_none">검색구분</q>
								<select name="searchType" id="searchType" style="width:112px">
									<option value="1" ${projectVO.searchType eq '1' ? 'selected="selected"':''}>제목</option>
									<option value="2" ${projectVO.searchType eq '2' ? 'selected="selected"':''}>내용</option>
									<option value="3" ${projectVO.searchType eq '3' ? 'selected="selected"':''}>제목+내용</option>
								</select>
							</label>
							<label><q class="display_none">검색</q>
								<input type="text" name="searchKeyword" id="searchKeyword" title="검색 입력" style="width:300px" value="${vo.searchKeyword}" onkeydown="javascript:if(event.keyCode==13){fnToList();return false;}">
							</label>
							<input type="button" class="input_smallBlack" value="검색" onclick="fnToList();">
						</td>
					</tr>
				</tbody>
				</table>
				<br />

					<div class="articles_search">		
						<div class="articles">
							<!-- <button class="input_smallBlack" onclick="fnArrayDelete(); return false;">선택삭제</button> 
							목록수 : --> 
							<select name="pageUnit" id="pageUnit"  onchange="fnToList();">
								<option value="15" ${vo.pageUnit eq '15' ? 'selected="selected"':''}>15개</option>
								<option value="30" ${vo.pageUnit eq '30' ? 'selected="selected"':''}>30개</option>
								<option value="50" ${vo.pageUnit eq '50' ? 'selected="selected"':''}>50개</option>
								<option value="999999" ${vo.pageUnit eq '999999' ? 'selected="selected"':''}>전체</option>
							</select>
						</div>		
						<div class="basic_searchForm">
							<a href="javascript:fnToWrite();" class="btn_line">등록</a> 
							<a href="javascript:cmmfn_download_xlsfile('', '/project/xlsProjectList.do?srch_menu_nix=pj021I9B')"  class="btn_line">액셀저장</a> 

						</div>
					</div>
				<br />
				<table class="tstyle_list">
					<caption>목록 테이블</caption>
					<colgroup>
						<col style="width:3%">
						<col style="width:6%">
						<col style="width:6%">
						<col style="width:8%">
						<col style="width:10%">
						<col style="width:10%">
						<col>
						<col style="width:6%">
						<col style="width:10%">
						<col style="width:8%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col"><input type="checkbox" id="checkAll"></th>
							<th scope="col">요청번호</th>
							<th scope="col">요청구분</th>
							<th scope="col">요청일</th>
							<th scope="col">요청자</th>
							<th scope="col">점검항목</th>
							<th scope="col">제목</th>
							<th scope="col">처리구분</th>
							<th scope="col">조치자</th>
							<th scope="col">${vo.memGroupCd eq 'sjtech' ? '<span style="color:red;">완료요청일</span>' : '조치일' }</th>
						</tr>
					</thead>
					<tbody id="listTbody">
						<c:if test="${empty resultList }">
						<tr>
							<td colspan="10" height="100">등록된 내용이 없습니다.</td>
						</tr>
						</c:if>
						<c:forEach var="list" items="${resultList}" varStatus="status">
						<tr>
							<td><input type="checkbox" value="${list.pbd_seq }" /></td>
							<%-- <td class="priority">${listCnt - (status.index + (vo.pageIndex-1) * vo.pageUnit)}</td> --%>
							<td><c:out value="${list.pbd_no }" /><c:if test="${list.pbd_no_sub ne '0' }">-<c:out value="${list.pbd_no_sub }" /></c:if></td>
							<td><c:out value="${list.pbd_req_type }" /></td>
							<td><c:out value="${list.pbd_req_dt}"/></td>
							<td><c:out value="${list.pbd_req_mem_nm }" /></td>
							<td><c:out value="${list.pbd_category }" /></td>
							<td class="text_left"><a href="javascript:;" onclick="fnToView('${list.pbd_seq}')"><c:out value="${list.pbd_req_title }" /></a></td>
							<td><c:out value="${list.pbd_res_type }" /></td>
							<td><c:out value="${list.pbd_res_mem_nm }" /></td>
							<td>
								<c:choose>
								<c:when test="${vo.memGroupCd eq 'sjtech' }"><c:out value="${list.pbd_due_dt }" /></c:when>
								<c:otherwise>${list.pbd_res_dt}</c:otherwise>
								</c:choose>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>

				<c:if test="${paginationInfo.totalPageCount gt 1}">
		       		<div class="board_pager">
						<ui:pagination paginationInfo = "${paginationInfo}" type = "image"
							jsFunction = "fn_egov_link_page" />
					</div>
				</c:if>

		</form>
		<!-- //content --> 
	</div>
