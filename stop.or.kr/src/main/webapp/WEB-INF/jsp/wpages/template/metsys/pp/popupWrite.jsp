<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%> 

<form:form name="reqForm" commandName="popupVO">

<!-- content -->
<div id="divMainArticle">

		<h2>팝업 관리</h2><br/>

		<table class="tstyle_view">
			<colgroup>
				<col width="18%" />
				<col />
			</colgroup>
			<caption>등록 폼</caption>
			<tr>
				<th scope="row"><label for="pop_title">제목</label></th>
				<td><form:input path="pop_title" class="input_width_300" title="제목"/></td>
			</tr>
			<tr>
				<th scope="row">팝업구분</th>
				<td>
					<form:radiobutton path="pop_type" value="W" label="팝업창" title="팝업창"/>
					<form:radiobutton path="pop_type" value="Z" label="팝업존" title="팝업구분"/>
					<form:radiobutton path="pop_type" value="V" label="비주얼" title="비주얼"/>
					<form:radiobutton path="pop_type" value="E" label="영문비주얼" title="영문비주얼"/>
					<form:radiobutton path="pop_type" value="C" label="공모전비주얼" title="공모전비주얼"/>
					<form:radiobutton path="pop_type" value="R" label="배너(관련사이트)" title="배너(관련사이트)"/>
				</td>
			</tr>
			<tr id="tr_pop_due">
				<th scope="row"><label for="pop_from">게시 기간</label></th>
				<td>
					<form:input path="pop_from" class="input_width_100" title="팝업시작일자"/> ~
					<form:input path="pop_to" class="input_width_100" title="팝업종료일자"/>
				</td>
			</tr>
			<tr id="tr_pop_wh">
				<th scope="row"><label for="pop_w">크기</label></th>
				<td>
					Width : <form:input path="pop_w" class="input_width_50" title="팝업 너비"/> 
					Height : <form:input path="pop_h" class="input_width_50" title="팝업 높이"/>
				</td>
			</tr>
			<tr id="tr_pop_xy">
				<th scope="row"><label for="pop_x">위치</label></th>
				<td>
					Left : <form:input path="pop_x" class="input_width_50" title="팝업 위치 x"/>  
					Top : <form:input path="pop_y" class="input_width_50" title="팝업 위치 y"/> ※ 공백으로 두면 Left : 0, Top : 0 좌표로 설정
				</td>
			</tr>			
			<tr id="tr_pop_content">
				<th scope="row"><label for="title">내용</label></th>
				<td>
					<form:textarea path="pop_content" title="내용" cols="90" rows="5"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="title">ALT속성값</label></th>
				<td>
					<form:input path="pop_alt" class="input_width_500" title="ALT속성값"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="title">링크</label></th>
				<td>
					<form:select path="pop_target" title="팝업타겟">
						<form:option value="_blank">새창</form:option>
						<form:option value="">현재창</form:option>
					</form:select>
					<form:input path="pop_link" class="input_width_500" title="링크"/>			
						
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="title">팝업순서</label></th>
				<td>
					<form:input path="pop_sort" title="팝업순서"/>
				</td>
			</tr>

		</table>
		<br/>
		<div class="fileUpload_area">
			<h2>팝업 이미지</h2><input type="file" name="file_upload" id="file_upload"/>
			<ul class="fileUpload_progress">
				
				<c:forEach var="result" items="${atchfileList}" varStatus="status">
					<li>
						<div id="divAtcharea_${result.atckey_4th}" class="uploadify-queue-item">
							<div class="cancel">
								<a href="javascript:cmmfn_delete_onefile('${pageContext.request.contextPath}', '${result.vchkcode}', fn_egov_popup_list)">X</a>
							</div>
							<div class="file_area">
								<span class="fileName">
									<img src="${pageContext.request.contextPath}/images/template/exticos/${elfunc:getImgicoByExt(result.fext)}.gif" width="16" height="16" alt="htp"/>
									<a href="javascript:cmmfn_download_atchfile('${pageContext.request.contextPath}', '${result.vchkcode}')">${result.rname} (${result.size_kb}kb)</a>
								</span>
								<span class="data"></span>
							</div> 
						</div>
					</li>
				</c:forEach>
				<li><div id="divSelectFileArea"></div></li>
			</ul>
		</div>
		<br/>

		
		<div class="btn_area_right">
			<a href="javascript:fn_egov_popup_save();" class="btn_line">저장하기</a>
			<c:if test="${formMode eq 'modify'}">
				<a href="javascript:fn_egov_show_poppreview()" class="btn_line">미리보기</a>
			</c:if>
			<a href="javascript:fn_egov_popup_list()" class="btn_line">목록보기</a>
		</div>
		
		<form:hidden path="edomweivgp" />
		<form:hidden path="pageIndex"/>
		<form:hidden path="pop_seq"/>
		<form:hidden path="srch_mu_site"/>
		<form:hidden path="srch_mu_lang"/>
		
</div>

</form:form>
