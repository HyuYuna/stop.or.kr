<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
window.onload = function(){
	
	var errorCode = "<%=request.getParameter("errorCode") %>";
	var sMessage = "";
	
	switch(errorCode) {
		case "null" : window.opener.fn_chk_usrcert_parent_complete('etc'); break;
		case "0000" : window.opener.fn_chk_usrcert_parent_complete('etc'); break;
		case "0001" : sMessage = "인증불일치(사용자인증, 인증번호 불일치)"; break;
		case "0011" : sMessage = "유효하지 않은 응답 SEQ"; break;
		case "0012" : sMessage = "유효하지 않은 인증정보(주민번호, 휴대폰번호, 이통사)"; break;
		case "0013" : sMessage = "암호화 데이터 처리오류"; break;
		case "0014" : sMessage = "암호화 프로세스 오류"; break;
		case "0015" : sMessage = "암호화 데이터 오류"; break;
		case "0016" : sMessage = "복호화 프로세스 오류"; break;
		case "0017" : sMessage = "복호화 데이터 오류"; break;
		case "0018" : sMessage = "이통사 통신오류"; break;
		case "0020" : sMessage = "유효하지 않은 제휴사 코드"; break;
		case "0021" : sMessage = "중단된 제휴사 코드"; break;
		case "0022" : sMessage = "휴대폰인증 사용이 불가한 제휴사 코드"; break;
		case "0031" : sMessage = "인증번호 확인 실패(해당 데이터 없음)"; break;
		case "0032" : sMessage = "인증번호 확인 실패(주민번호 불일치)"; break;
		case "0033" : sMessage = "인증번호 확인 실패(요청SEQ 불일치)"; break;
		case "0034" : sMessage = "인증번호 확인 실패(기 처리건)"; break;
		case "0050" : sMessage = "명의도용 차단서비스 가입자"; break;
		case "9998" : sMessage = "본인인증 결과값 전달 실패"; break;
		case "9999" : sMessage = "정의되지 않은 오류"; break;
		default : sMessage = "알 수 없는 오류"; break;
	}
	
	if(sMessage != "") {
		alert(sMessage);
	}
	window.open("about:blank","_self").close();
}
</script>