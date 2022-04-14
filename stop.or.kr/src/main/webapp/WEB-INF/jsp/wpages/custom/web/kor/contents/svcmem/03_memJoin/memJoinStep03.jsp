<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>

<form:form name="reqForm" method="post" commandName="memberVO">

	<div id="contentWrap">	
	
		<!-- 컨텐츠영역 -->
		<div class="complete">
			<div class="img_title">
				<h1><img src="${pageContext.request.contextPath}/main/images/custom/kor/member/ptitle_complete.gif" alt="회원가입완료" /></h2>
				<p>국립생태원 회원가입을 축하드립니다.<br/>국립생태원에 로그인하시면 웹사이트를 자유롭게 이용하실 수 있습니다.</p>
			</div>
		</div>
		
		<fieldset>
			<legend>회원가입완료</legend>
			<div class="noborder_box txt_center font_14">${SESS_JOIN_INFO.user_nm}님의 회원가입이 완료되었습니다. 아이디는 <strong>${SESS_JOIN_INFO.user_id}</strong>입니다</div>
				
			<div class="btn_area_center">
				<a href="/main" class="btn_green">국립생태원 홈</a> <a href="http://www.nie.re.kr/reservation/index" class="btn_black">예약시스템 홈</a>
			</div>
		</fieldset>
		<!-- //컨텐츠영역-->
		
	</div>


				
</form:form>