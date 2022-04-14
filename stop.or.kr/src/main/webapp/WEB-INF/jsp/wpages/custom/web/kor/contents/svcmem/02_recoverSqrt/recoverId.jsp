<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<form:form name="reqForm" method="post" commandName="memberVO">

<div id="contentWrap">	

	<!-- 컨텐츠영역 -->
	<h1 class="margin_bottom10"><img src="${pageContext.request.contextPath}/images/custom/kor/member/ptitle_id_search.gif" alt="아이디 찾기" /></h2>
	<p class="margin_bottom20">회원가입시 입력한 이름과 이메일을 입력해 주세요.</p>
	<fieldset>
		<legend>아이디 찾기</legend>
		<table class="tstyle_member" summary="아이디 찾기시 이름, 이메일 입력">
			<caption>
				아이디 찾기
			</caption>
			<colgroup>
				<col width="170" />
				<col width="*" />
			</colgroup>
			<tbody>			
				<tr>
					<th scope="row"><label for="name">이름</label></th>
					<td class="txt_left">
						<input id="user_nm" name="user_nm" title="이름" type="text" value="" size="40" />
						<input id="user_recover_type" name="user_recover_type" type="hidden" value=""/>
					</td>
				</tr>			
				<tr>
					<th scope="row"><label for="user_email">이메일</label></th>
					<td class="txt_left"><input id="user_email" name="user_email" title="이메일" type="text" value="" size="40"/></td>
				</tr>
			</tbody>
		</table>
		<div class="btn_area_center">
			<button type="button" id="btnRecoverId" title="확인" class="btn_green">확인</button> <button type="button" id="btnRecoverIdCancel" title="취소" class="btn_black" onclick="window.close()">취소</button>
		</div>
		<p class="point_red txt_center">입력한 정보와 일치하는 아이디가 존재하지 않습니다. 다시 확인해주세요</p>
	</fieldset>
	<!-- //컨텐츠영역-->
	
</div>


</form:form>	