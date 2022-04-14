<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div id="divMainArticle">
	<form:form name="reqForm" commandName="syscodeVO">
		<h3> 코드 관리 </h3>
		<br/>
		<table class="tstyle_view">
			<colgroup>
				<col width="10%" />
				<col width="40%" />
				<col width="10%"/>
				<col width="40%" />
			</colgroup>
			<caption>코드 등록 페이지</caption>
			<tr style="height:200px">
				<th scope="row"><label for="title">코드 그룹</label></th>
				<td class="txt_center_top">
					<ol id="selectable_lv1">
						<li>등록된 코드그룹이 없습니다.</li>
					</ol>
				</td>
				<th scope="row"><label for="title">코드 하위항목</label></th>
				<td class="txt_center_top">
					<ol id="selectable_lv2">
					</ol>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="title">구분</label></th>
				<td>
					<form:radiobutton path="child_gb" value="0" label="코드 그룹" checked="checked"/>
					<form:radiobutton path="child_gb" value="1" label="코드 하위항목"/>
				</td>
				<th scope="row"><label for="title">등록 / 수정</label></th>
				<td>
					<form:radiobutton path="job_gb" value="0" label="등록"/>
					<form:radiobutton path="job_gb" value="1" label="수정"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="title">코드 ID</label></th>
				<td>
					<form:input path="code_idx" class="input_width_100" readonly="true"/> <span class="txt_blue"> ( 자동으로 입력되는 값입니다 )</span>
				</td>
				<th scope="row"><label for="title">상위 코드 ID</label></th>
				<td>
					<form:input path="up_code_idx" class="input_width_100" readonly="true"/> <span class="txt_blue"> ( 자동으로 입력되는 값입니다 )</span>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="title">항목 명</label></th>
				<td>
					<form:input path="code_nm" class="input_width_200"/>
				</td>
				<th scope="row"><label for="title">순서</label></th>
				<td>
					<form:input path="code_ord" class="input_width_50" value="1"/> <span class="txt_blue"> ( 자동으로 입력되지만 수정할 수 있습니다. )</span>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="title">사용여부</label></th>
				<td colspan="3">
					<form:radiobutton path="use_yn" value="Y" label="사용함"/>
					<form:radiobutton path="use_yn" value="N" label="사용안함"/>
				</td>
			</tr>
		</table>
	
		<form:hidden path="srch_mu_site"/>
		<form:hidden path="srch_mu_lang"/>
		
	
	</form:form>
	<div class="btn_area_right">
		<a href="javascript:fn_egov_syscode_save()" class="btn_line">저장</a>
		<c:if test="${SESS_USR_LV eq '0'}">
		<!-- 삭제권한은 개발자에게만.. 개발시점 이후에는 추가/변경은 가능해도 삭제되어서는 안된다. -->
			<a href="javascript:fn_egov_syscode_del()" class="btn_line">삭제</a>
		</c:if>
	</div>
	

</div>