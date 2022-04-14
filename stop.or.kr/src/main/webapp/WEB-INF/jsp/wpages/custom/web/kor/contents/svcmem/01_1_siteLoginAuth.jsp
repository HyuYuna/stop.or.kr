<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" import="Kisinfo.Check.IPINClient" %>

<%
	/********************************************************************************************************************************************
		NICE평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED
		
		서비스명 : 가상주민번호서비스 (IPIN) 서비스
		페이지명 : 가상주민번호서비스 (IPIN) 호출 페이지
	*********************************************************************************************************************************************/
	
	String sSiteCode				= "G@@@";			// IPIN 서비스 사이트 코드		(NICE평가정보에서 발급한 사이트코드)
	String sSitePw					= "E@@@@@@";			// IPIN 서비스 사이트 패스워드	(NICE평가정보에서 발급한 사이트패스워드)
	
	
	/*
	┌ sReturnURL 변수에 대한 설명  ─────────────────────────────────────────────────────
		NICE평가정보 팝업에서 인증받은 사용자 정보를 암호화하여 귀사로 리턴합니다.
		따라서 암호화된 결과 데이타를 리턴받으실 URL 정의해 주세요.
		
		* URL 은 http 부터 입력해 주셔야하며, 외부에서도 접속이 유효한 정보여야 합니다.
		* 당사에서 배포해드린 샘플페이지 중, ipin_process.jsp 페이지가 사용자 정보를 리턴받는 예제 페이지입니다.
		
		아래는 URL 예제이며, 귀사의 서비스 도메인과 서버에 업로드 된 샘플페이지 위치에 따라 경로를 설정하시기 바랍니다.
		예 - http://www.test.co.kr/ipin_process.jsp, https://www.test.co.kr/ipin_process.jsp, https://test.co.kr/ipin_process.jsp
	└────────────────────────────────────────────────────────────────────
	*/
	String sReturnURL				= "http://domain/IPIN/ipin_process.jsp";
	/* String sReturnURL				= "http://localhost:8080/IPIN/ipin_process.jsp"; */
	
	
	/*
	┌ sCPRequest 변수에 대한 설명  ─────────────────────────────────────────────────────
		[CP 요청번호]로 귀사에서 데이타를 임의로 정의하거나, 당사에서 배포된 모듈로 데이타를 생성할 수 있습니다.
		
		CP 요청번호는 인증 완료 후, 암호화된 결과 데이타에 함께 제공되며
		데이타 위변조 방지 및 특정 사용자가 요청한 것임을 확인하기 위한 목적으로 이용하실 수 있습니다.
		
		따라서 귀사의 프로세스에 응용하여 이용할 수 있는 데이타이기에, 필수값은 아닙니다.
	└────────────────────────────────────────────────────────────────────
	*/
	String sCPRequest				= "";
	
	
	
	// 객체 생성
	IPINClient pClient = new IPINClient();
	
	
	// 앞서 설명드린 바와같이, CP 요청번호는 배포된 모듈을 통해 아래와 같이 생성할 수 있습니다.
	sCPRequest = pClient.getRequestNO(sSiteCode);
	
	// CP 요청번호를 세션에 저장합니다.
	// 현재 예제로 저장한 세션은 ipin_result.jsp 페이지에서 데이타 위변조 방지를 위해 확인하기 위함입니다.
	// 필수사항은 아니며, 보안을 위한 권고사항입니다.
	session.setAttribute("CPREQUEST" , sCPRequest);
	
	
	// Method 결과값(iRtn)에 따라, 프로세스 진행여부를 파악합니다.
	int iRtn = pClient.fnRequest(sSiteCode, sSitePw, sCPRequest, sReturnURL);
	
	String sRtnMsg					= "";			// 처리결과 메세지
	String sEncData					= "";			// 암호화 된 데이타
	
	// Method 결과값에 따른 처리사항
	if (iRtn == 0)
	{
	
		// fnRequest 함수 처리시 업체정보를 암호화한 데이터를 추출합니다.
		// 추출된 암호화된 데이타는 당사 팝업 요청시, 함께 보내주셔야 합니다.
		sEncData = pClient.getCipherData();		//암호화 된 데이타
		
		sRtnMsg = "정상 처리되었습니다.";
	
	}
	else if (iRtn == -1 || iRtn == -2)
	{
		sRtnMsg =	"배포해 드린 서비스 모듈 중, 귀사 서버환경에 맞는 모듈을 이용해 주시기 바랍니다.<BR>" +
					"귀사 서버환경에 맞는 모듈이 없다면 ..<BR><B>iRtn 값, 서버 환경정보를 정확히 확인하여 메일로 요청해 주시기 바랍니다.</B>";
	}
	else if (iRtn == -9)
	{
		sRtnMsg = "입력값 오류 : fnRequest 함수 처리시, 필요한 4개의 파라미터값의 정보를 정확하게 입력해 주시기 바랍니다.";
	}
	else
	{
		sRtnMsg = "iRtn 값 확인 후, NICE평가정보 개발 담당자에게 문의해 주세요.";
	}

%>
<form:form name="reqForm" commandName="memberVO">

	<!-- 컨텐츠영역 -->
	<div id="member_content">
	<ul class="tab_menu">
	<li class="on" id="loginLi"><a href="javascript:;" id="loginButton">회원로그인</a></li>
	<li id="authLi"><a href="javascript:;" id="authButton">비회원 본인인증</a></li>
	</ul>
		<div class="member_login">
			<div class="img_title">
				<h2><img src="${pageContext.request.contextPath}/main/images/custom/kor/member/title_login.gif" alt="로그인" /></h2>
				<p>아이디, 비밀번호를 입력해 주세요</p>
			</div>
			<div class="login_form_box">
				
				<fieldset>
					<legend>로그인 폼</legend>
					<div class="input_area">
						<div class="id_pw">
							<p><label for="oldPasswd">아이디</label>
								<input id="user_id" name="user_id" title="아이디" maxLength="15" class="text w1" type="text" value=""/>
							</p>
							<p><label for="newPasswd">비밀번호</label>
								<input id="user_scrt" name="user_scrt" title="비밀번호" maxLength="15" class="type1 w1" type="password" value=""/>
							</p>
						</div>
						<div class="input_btn">
							<button type="button" id="btnSiteLogin">로그인</button>
						</div>
					</div>
					<p class="error_info" id="pLoginerrorArea">&nbsp;</p>
					<!--
					<p class="idpw_save">
						<input type="checkbox" name="chkLoginfieldSave" id="chkLoginfieldSave" title="아이디저장" /><label for="chkLoginfieldSave">아이디 저장</label>
						<input name="idpw_save" id="pwSave" type="checkbox" value="" /><label for="pwSave">비밀번호 저장</label>
					</p>
					--> 
					<div class="btn_area"> 
						<span><a href="javascript:fn_memsvc_pagemove('memJoin')" class="btn_black_arrow">회원가입</a></span>
						<span><a href="javascript:fn_memsvc_pagemove('recoverId')" class="btn_black_arrow">아이디찾기</a></span> 
						<span><a href="javascript:fn_memsvc_pagemove('recoverScrt')" class="btn_black_arrow">비밀번호 찾기</a></span> 
					</div>
				</fieldset>
			</div><!-- //login_form_box -->
		</div><!-- //login_content -->	
	
		<div class="auth" style="display: none">
			<div class="img_title">
				<h2><img src="${pageContext.request.contextPath}/main/images/custom/kor/member/txt_mem_auth.gif" alt="온라인 상에서 익명 사용자로 인한 피해를 방지 및 악의적인 명의도용방지를 위하여 본인확인 절차가 필요합니다. 아래 인증방식 중 선택하여 본인확인을 진행해 주시기 바랍니다." /></h2>
			</div>
			<p class="alert">14세미만의 어린이는 개인정보 수집시 법정대리인의 동의가 필요합니다.</p>
			<div class="dashed_box">
				<fieldset>
					<legend>비밀번호 수정 폼</legend>
					<ul class="report">
						<li> <img src="${pageContext.request.contextPath}/main/images/custom/kor/gov/corrupt_ipin.gif" alt="공공아이핀" /> <span class="title">
							<label for="ipin">
								<input type="radio" name="idType" id="ipin" checked="checked" value="ipin">
								공공아이핀</label>
							</span> </li>
						<li> <img src="${pageContext.request.contextPath}/main/images/custom/kor/gov/corrupt_phone.gif" alt="phone" /> <span class="title">
							<label for="phone">
								<input type="radio" name="idType" id="phone" value="phone">
								휴대전화</label>
							</span>
						</li>
					</ul>
				</fieldset>
			</div>
			<p class="btn_area_center">
				<button type="button" id="btnChkUsrcert" class="btn_black_arrow">본인인증</button>
			</p>
		</div>	
		<!-- //컨텐츠영역-->
	</div>
	<!-- 본인 인증 변수-->
	<input type="hidden" name="m" id="m" value="checkplusSerivce"><!-- 필수 데이타로, 누락하시면 안됩니다. -->
	<input type="hidden" name="enc_data" value="<%= sEncData %>">
	
	<input type="hidden" id="EncodeData" name="EncodeData" value=""><!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
	
	<!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
		 해당 파라미터는 추가하실 수 없습니다. -->
	<input type="hidden" name="param_r1" value="">
	<input type="hidden" name="param_r2" value="${param.pg_ret_type}">
	<input type="hidden" name="param_r3" value="">
	<!-- 본인 인증 변수 끝-->
</form:form>
<form name="vnoform" method="post">
	<input type="hidden" name="enc_data">								<!-- 인증받은 사용자 정보 암호화 데이타입니다. -->
	
	<!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
    	 해당 파라미터는 추가하실 수 없습니다. -->
    <input type="hidden" name="param_r1" value="">
    <input type="hidden" name="param_r2" value="${param.pg_ret_type}">
    <input type="hidden" name="param_r3" value="">
</form>