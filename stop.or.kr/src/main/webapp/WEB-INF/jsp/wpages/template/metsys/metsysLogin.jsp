<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>관리자 로그인 - ${SESS_PROP_PRJTNM}</title>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="keywords" content="관리자 페이지" />
<meta name="description" content="PLANI_FRM" />
<meta name="copyright" content="Copyright 2013 PLANI, all rights reserved." /> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/template/metsys/login.css"  />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/_cmmn/plani_common.js"></script>

<!-- ▼아래는 IE9 보다 버전이 낮은 브라우저에서만 이 스크립트를 해석하도록 한 것 -->
<!--[if lt IE 9]><script src="${pageContext.request.contextPath}/js/plani/html5.js"></script><![endif]-->

<script type="text/javascript">
	jQuery(document).ready(function(){
		/*
		var errmsg = jQuery("#metsys_errmsg").val();		
		if(! (errmsg == null || errmsg == undefined || errmsg == "") )
			alert(errmsg);		
		var id = document.metsysLoginForm.user_id; 
		if(id.value != null && id.value != "")
			id.focus();		
		*/
		jQuery("#user_scrt").unbind("keypress");
		jQuery("#user_scrt").keydown(function(event){
			if(event.keyCode == 13)
			{
				formLogin();
			}
		});
		
	});

	function formLogin()
	{
		var form = document.metsysLoginForm;		
		var id = form.user_id;
		var pwd = form.user_scrt;
		
		if(id.value == null || id.value == "")
		{
			alert("아이디를 입력해주십시오.");
			id.focus();
			return;
		}

		if(pwd.value == null || pwd.value == "")
		{
			alert("비밀번호를 입력해주십시오.");
			pwd.focus();
			return;
		}		
		form.action = "${pageContext.request.contextPath}/metsys/metsysLoginProc.do";
	   	form.submit();
	}	
	
</script>
</head>
<body>
<form:form name="metsysLoginForm" commandName="loginVO">
<div id="wrap">
	<h1 class="logo">Administrator Login</h1>	
	<!-- login_content -->
	<section id="loginForm">
		<div class="idpw_area">
			<p><input type="text" id="user_id" name="user_id" title="아이디 입력" value=""/></p>
			<p><input type="password" id="user_scrt" name="user_scrt" title="비밀번호 입력" value=""/></p>
			<p class="point01">
				<form:errors path="user_id"></form:errors>
				<form:errors path="user_scrt"></form:errors>
			</p>
		</div>
		<p class="btn_login bgColor"><a href="javascript:formLogin()">Login</a></p>
	</section>	
	<!-- //login_content -->
</div>
</form:form>
</body>
</html>