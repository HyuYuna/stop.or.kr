<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<form:form name="reqForm" commandName="loginVO" class="ajax-form-submit">
<section id="content">
	<!-- path -->
	<p class="path">
		<span class="path_home"><img src="${pageContext.request.contextPath}/images/custom/web/kor/common/path_home.gif" alt="홈" /></span> 
		<span>멤버십</span><span class="path_current">로그인</span>
	</p>
	<!-- //path -->
	<!-- stitle -->
	<h1 class="stitle">
		로그인
	</h1>
	<!-- //stitle -->
	<!-- detail_content -->
	<div id="detail_content">
		<div class="login">
			<div class="form">
				<ul class="input">
					<li>
						<form:input path="user_id" />
						<form:errors path="user_id" />
					</li>
					<li>
						<form:password path="user_scrt" />
						<form:errors path="user_scrt" />
					</li>
				</ul>
				<a href="javascript:fn_site_login()">
					<img class="btn_login" src="${pageContext.request.contextPath}/images/custom/web/kor/content/login_btn.gif" alt="로그인" />
				</a>
				<input type="submit" value="로그인" />
				<p class="btn">
					<a href="${pageContext.request.contextPath}/svcmem/memJoinStep01.do?tgtact=02" class="btn_orange_b">회원가입</a>
					<a href="${pageContext.request.contextPath}/html/web/kor/sub05/sub05_03.jsp" class="btn_light_b">아이디 찾기</a>
					<a href="${pageContext.request.contextPath}/html/web/kor/sub05/sub05_03.jsp" class="btn_light_b">비밀번호 찾기</a>
				</p>
			</div>
		</div>
		<!-- //페이지 작성 -->
	</div>
</section>
</form:form>