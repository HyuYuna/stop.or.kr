<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<form:form name="reqForm" method="post" commandName="memberVO">

<div id="contentWrap">	

	<!-- 컨텐츠영역 -->
	<h1 class="margin_bottom10"><img src="${pageContext.request.contextPath}/images/custom/kor/member/ptitle_pw_confirm.gif" alt="비밀번호 재확인" /></h2>
	<p class="margin_bottom20">회원가입시 입력한 이름과 이메일을 입력해 주세요.</p>
	<fieldset>
		<legend>비밀번호 재확인</legend>
		<table class="tstyle_member" summary="비밀번호 재확인시 아이디, 비밀번호 입력">
			<caption>
				비밀번호 재확인
			</caption>
			<colgroup>
				<col width="170" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="uid">아이디</label></th>
					<td class="txt_left">
						<c:out value="${userId}"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="name">새로운 비밀번호</label></th>
					<td class="txt_left"><input id="user_scrt" name="user_scrt" title="비밀번호" size="40" type="password" value=""/></td>
				</tr>
				<tr>
					<th scope="row"><label for="name">새로운 비밀번호 확인</label></th>
					<td class="txt_left"><input id="user_scrt_confirm" name="user_scrt_confirm" title="비밀번호확인" size="40" type="password" value=""/></td>
				</tr>
			</tbody>
		</table>
		<p class="point_red">회원님의 정보를 안전하게 보관하기 위해 비밀번호를 다시 확인하고 있습니다</p>	
		<div class="btn_area_center">
			<button type="button" id="btnChangePw" title="확인" class="btn_green">확인</button> <button type="button" id="" title="취소" class="btn_black">취소</button>
		</div>
	</fieldset>
	<!-- //컨텐츠영역-->
	
</div>


</form:form>