<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>관리자 로그인</title>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="keywords" content="로그인" />
<meta name="description" content="관리자 페이지 로그인" />
<meta name="copyright" content="Copyright 2013 PLANI, all rights reserved." /> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/template/metsys/login.css"  />
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/core/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/plugins/form/4.2.2/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/plugins/jquery-plani.ajax_form_submit.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
</head>
<body onload="$('#user_id').focus();">
<form:form id="login-form" commandName="loginVO" class="ajax-form-submit">
<div id="wrap">
	<h1 class="logo">Administrator Login</h1>	
	<!-- login_content -->
	<section id="loginForm">
		<div class="idpw_area">
			<p><form:input path="user_id"  value=""/></p>
			<p class="point02"><form:errors path="user_id"></form:errors></p>
			<p><form:password path="user_scrt" value="" /></p>
			<p class="point02"><form:errors path="user_scrt"></form:errors></p>
		</div><input type="submit" name="loginButton" id="loginButton" value="Login" class="bgColor" style="cursor:pointer; width:100%; height:40px; border:solid 0px; font-size:11pt; color:#fff">
		<!-- <p class="btn_login bgColor">
		<a href="#" onclick="$('#login-form').submit(); return false;">Login</a></p> -->
	</section>	
	<!-- //login_content -->
</div>
</form:form>
</body>
</html>