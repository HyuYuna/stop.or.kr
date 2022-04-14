<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div id="divMainArticle">
	<form:form name="reqForm" commandName="sysauthVO">
		<h3> 권한 / 권한별 사용메뉴 관리 </h3>
		<br/>
		<table class="tstyle_view">
			<colgroup>
				<col width="10%" />
				<col width="40%" />
				<col width="10%"/>
				<col width="40%" />
			</colgroup>
			<caption>권한 등록 페이지</caption>
			<tr style="height:200px">
				<th scope="row"><label for="title">권한 그룹</label></th>
				<td class="txt_center_top">
					<ol id="selectable_lv1">
					</ol>
				</td>
				<th scope="row"><label for="title">권한 하위항목</label></th>
				<td class="txt_center_top">
					<ol id="selectable_lv2">
					</ol>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="title">설명</label></th>
				<td colspan="3">
					<span id="spanAuthInfomation"></span>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="title">구분</label></th>
				<td>
					<!--<form:radiobutton path="child_gb" value="0" label="권한 그룹" checked="checked"/>-->
					<form:radiobutton path="child_gb" value="1" label="권한 하위항목" checked="checked"/>
				</td>
				<th scope="row"><label for="title">등록 / 수정</label></th>
				<td>
					<form:radiobutton path="job_gb" value="0" label="등록"/>
					<form:radiobutton path="job_gb" value="1" label="수정"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="title">항목 명</label></th>
				<td>
					<form:input path="auth_nm" class="input_width_200"/>
				</td>
				<th scope="row"><label for="title">순서</label></th>
				<td>
					<form:input path="auth_ord" class="input_width_50" value="1"/> 
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
		<form:hidden path="auth_cd"/>
		<form:hidden path="up_auth_cd"/>
				
		<form:hidden path="srch_mu_site"/>
		<form:hidden path="srch_mu_lang"/>
		
	</form:form>
	<div class="btn_area_right">
		<a href="javascript:fn_egov_sysauth_menushow()" class="btn_line">메뉴권한설정</a>
		<a href="javascript:fn_egov_sysauth_save()" class="btn_line">저장</a>
		<c:if test="${SESS_USR_LV eq '0'}">
			<!-- 삭제권한은 개발자에게만.. 개발시점 이후에는 추가/변경은 가능해도 삭제되어서는 안된다. -->
			<a href="javascript:fn_egov_sysauth_del()" class="btn_line">삭제</a>
		</c:if>
	</div>
	
	<div id="divDlgAuthmenu">
		<span class="txt_red">메뉴에 체크하고 저장버튼을 누르면 그 메뉴는 사용 가능하게 됩니다.</span>
		<div>
			<div class="float_left">
				<table id="tblDlgAuthmenuMan"></table>
			</div>
			<div class="float_right">
				<table id="tblDlgAuthmenuUsr"></table>
			</div>
		</div>
	</div>
</div>