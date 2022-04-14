<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<form:form name="reqForm" method="post" commandName="memberVO">


<div id="contentWrap">	

	<!-- 컨텐츠영역 -->
	<h1 class="margin_bottom10"><img src="${pageContext.request.contextPath}/images/custom/kor/member/ptitle_pw_search.gif" alt="비밀번호 찾기" /></h2>
	<p class="margin_bottom20">회원가입시 입력한 아이디, 이름, 핸드폰번호를 입력해 주세요.<br>
문자메시지로 임시 비밀번호가 발송됩니다.</p>
	<fieldset>
		<legend>비밀번호 찾기</legend>
		<table class="tstyle_member" summary="비밀번호 찾기시 아이디, 이름, 핸드폰번호, 인증번호 입력">
			<caption>
				비밀번호 찾기
			</caption>
			<colgroup>
				<col width="170" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="uid">아이디</label></th>
					<td class="txt_left">
						<input id="user_id" name="user_id" title="아이디" size="40" type="text" value=""/>
						<input id="user_recover_type" name="user_recover_type" type="hidden" value=""/>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="name">이름</label></th>
					<td class="txt_left"><input id="user_nm" name="user_nm" title="이름" size="40" type="text" value=""/></td>
				</tr>
				<tr>
					<th scope="row"><label for="hp1">핸드폰 번호</label></th>
					<td class="txt_left">
						<select id="user_cp_1" name="user_cp_1" title="핸드폰번호 앞 자리 선택">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="017">017</option>
						<option value="016">016</option>
						<option value="018">018</option>
						<option value="019">019</option>
					</select>
					-
					<input id="user_cp_2" name="user_cp_2" title="핸드폰번호 가운데 3~4자리 입력" type="text" value="" size="4" maxlength="4"/>
					-
					<input id="user_cp_3" name="user_cp_3" title="핸드폰번호 마지막 4자리 입력" type="text" value="" size="4" maxlength="4"/> <span class="btn_smallBrown"><button type="button" id="btnSendPinCode"><img src="${pageContext.request.contextPath}/images/custom/kor/member/btn_auth_number.png" alt="인증번호" /></button></span>
					<p class="point_red">회원가입 시 입력한 핸드폰번호를 입력해 주세요. 발송된 인증번호를 정확히 입력해야 임시비밀번호를 받을 수 있습니다.</p>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="pinCode">인증번호입력</label></th>
					<td class="txt_left"><input type="text" name="pinCode" id="pinCode" size="40" title="인증번호"/></td>
				</tr>
			</tbody>
		</table>	
		<div class="btn_area_center">
			<button type="button" id="btnRecoverScrt" title="확인" class="btn_green">확인</button> <button type="button" id="btnRecoverScrtCancel" title="취소" class="btn_black" onclick="window.close()">취소</button>
		</div>
	</fieldset>
	<!-- //컨텐츠영역-->
	
</div>



</form:form>