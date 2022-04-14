<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyyMMdd" var="today" />
<c:choose>
	<c:when test="${today > '20200812' }">
<table align="center" width="720" border="0" cellspacing="0" cellpadding="0"  style="background:url('http://stop.or.kr/html/kor/email/images/email-bg.gif') no-repeat 0 0;">
	<tbody>
		<tr>
			<td width="720">
				<table align="center" width="720" border="0" cellspacing="0" cellpadding="0">
					<tbody>
					<tr>
						<td>
							<img src="http://stop.or.kr/html/kor/email/images/email-top-bg.gif" alt="" width="720" height="68" border="0" style="margin:0px;display:block;">
						</td>
					</tr>
					<tr>
						<td align="center">          
							<img src="http://stop.or.kr/html/kor/email/images/email-process03-img01.gif" alt="한국여성인권진흥원 뉴스레터 구독을 재동의 기간이 종료되었습니다." style="display:block;margin:0;padding:0;border:none;font-size:0;line-height:0;">
							<img src="http://stop.or.kr/html/kor/email/images/email-process03-img02.gif" alt="구독 재동의를 하지 않았을 경우 자동 구독 해지 처리되어 뉴스레터를 수신할 수 없으며, 이메일 정보는 2020년 8월 11일 삭제되었습니다. 뉴스레터 구독을 원하시는 분은 한국여성인권진흥원 홈페이지(www.stop.or.kr) 메인 페이지 하단 부분의 뉴스레터 신청에서 이메일 주소를 입력하여 구독신청 하시기 바랍니다.  감사합니다." style="display:block;margin:0;padding:0;border:none;font-size:0;line-height:0;">
						</td>
					</tr>
					<tr>
						<td align="center">          
							<a href="javascript:window.close();"><img src="http://stop.or.kr/html/kor/email/images/email-process01-btn04.png" alt="닫기"></a>
						</td>
					</tr>
					<tr>
						<td align="center" style="display:block;margin:0;padding:0;height:108px;">&nbsp;</td>
					</tr>
					<tr>
						<td>
							<table>
								<tbody>
								<tr>
									<td width="50"></td>
									<td>
										<span style="width:406px;display:inline-block;font-size:12px;color:#4b4948;letter-spacing:-1px;">(04505) 서울특별시 중고 서소문로 50 센트럴플레이스 3층 한국여성인권진흥원<br><a href="https://www.stop.or.kr/" title="새창열림" target="_blank"  style="font-size:14px;color:#4b4948;text-decoration:none;">www.stop.or.kr</a></span>

										<a href="https://www.stop.or.kr/" title="새창열림" target="_blank"  style="font-size:14px;color:#4b4948;text-decoration:none;"><img src="http://stop.or.kr/html/kor/email/images/email-logo.gif" width="190" alt="한국여성인권진흥원" style="vertical-align:top;"></a>
									</td>
									<td width="50"></td>
								</tr>
								</tbody>
							</table>
						</td>
					</tr>
					</tbody>
				</table>
			</td>
		</tr>
	</tbody>
	</table>
	</c:when>
	<c:otherwise>

<form name="news_form" action="${pageContext.request.contextPath}/newsletter/newsletterReFormAdd.do" method="post">
<input type="hidden" name="agree" value="${param.agree}">
	<table align="center" width="720" border="0" cellspacing="0" cellpadding="0"  style="background:url('http://stop.or.kr/html/kor/email/images/email-bg.gif') no-repeat 0 0;">
	<tbody>
		<tr>
			<td width="720">
				<table align="center" width="720" border="0" cellspacing="0" cellpadding="0">
					<tbody>
					<tr>
						<td>
							<img src="http://stop.or.kr/html/kor/email/images/email-top-bg.gif" alt="" width="720" height="68" border="0" style="margin:0px;display:block;">
						</td>
					</tr>
					<tr>
						<td align="center">          
							<img src="http://stop.or.kr/html/kor/email/images/email-process02-img01.gif" alt="한국여성인권진흥원 뉴스레터 구독을 재동의 해주시기 바랍니다." style="display:block;margin:0;padding:0;border:none;font-size:0;line-height:0;">
							<img src="http://stop.or.kr/html/kor/email/images/email-process02-img02.gif" alt="뉴스레터 발송을 위한 최소한의 개인정보를 수집하고 이용합니다. 수집된 정보는 발송 외 다른 목적으로 이용되지 않으며, 서비스가 종료되거나 구독을 해지할 경우 즉시 파기됩니다." style="display:block;margin:0;padding:0;border:none;font-size:0;line-height:0;">

							<p style="font-size:13px;color:#666;text-align:left;padding-left:100px;"><c:if test="${param.agree eq 'Y'}"><label><input type="checkbox" id="check1" name="check1" style="vertical-align:middle;"/>개인정보 수집 및 이용에 동의합니다. 개인정보 수집 및 이용에 동의해주세요.</label></c:if>&nbsp;</p>

						</td>
					</tr>
					<tr>
						<td align="center">
							<div style="border:1px solid #fff;width:500px;height:83px;margin-right:10px;margin-bottom:45px;">
									
								<p style="font-size:14px;color:#083388;text-align:center;letter-spacing:-1px;word-spacing:-1px;margin-bottom:5px;"><c:if test="${param.agree eq 'Y'}">뉴스레터 소식을 앞으로도 받고 싶으신 분은 이메일 주소를 다시 기입해주세요.</c:if>&nbsp;</p>
								
								<table>
									<tbody>
									<tr>
										<td width="100"><span style="font-size:14px;color:#4b4948;text-align:left;padding-left:6px;">이메일주소</span></td>
										<td>
											<label><input type="text" name="email" id="email"  style="width:328px;height:28px;border:1px solid #c1b15d;line-height:28px;padding-left:10px;padding-right:10px;"/></label>
										</td>
									</tr>

									<!--tr>
										<td width="100"  style="margin:0;padding:0;font-size:0;"><span style="font-size:14px;color:#4b4948;text-align:left;padding-left:6px;"></span></td>
										<td style="margin:0;padding:0;font-size:0;">
											<p style="font-size:13px;color:#ff0000;margin:0;">잘못된 이메일 주소입니다.</p>	
										</td>
									</tr-->
									</tbody>
								</table>
							</div> 
						</td>
					</tr>
					<tr>
						<td align="center">    
<c:if test="${param.agree eq 'Y'}">						      
							<a href="javascript:agreeCheck()"><img src="http://stop.or.kr/html/kor/email/images/email-process01-btn01.png" alt="구독 재동의"></a>
</c:if>
<c:if test="${param.agree eq 'N'}">							
							<a href="javascript:agreeCheck()"><img src="http://stop.or.kr/html/kor/email/images/email-process01-btn03.png" alt="재동의 거부"></a>
</c:if>
						</td>
					</tr>
					<tr>
						<td align="center" style="display:block;margin:0;padding:0;height:45px;">&nbsp;</td>
					</tr>
					<tr>
						<td>
							<table>
								<tbody>
								<tr>
									<td width="50"></td>
									<td>
										<span style="width:406px;display:inline-block;font-size:12px;color:#4b4948;letter-spacing:-1px;">(04505) 서울특별시 중고 서소문로 50 센트럴플레이스 3층 한국여성인권진흥원<br><a href="https://www.stop.or.kr/" title="새창열림" target="_blank"  style="font-size:14px;color:#4b4948;text-decoration:none;">www.stop.or.kr</a></span>

										<a href="https://www.stop.or.kr/" title="새창열림" target="_blank"  style="font-size:14px;color:#4b4948;text-decoration:none;"><img src="http://stop.or.kr/html/kor/email/images/email-logo.gif" width="190" alt="한국여성인권진흥원" style="vertical-align:top;"></a>
									</td>
									<td width="50"></td>
								</tr>
								</tbody>
							</table>
						</td>
					</tr>
					</tbody>
				</table>
			</td>
		</tr>
	</tbody>
	</table>
</form>
<script>
function agreeCheck(){
	var f=document.news_form;
	<c:if test="${param.agree eq 'Y'}">
	if(f.check1.checked==false){
		alert('개인정보 수집 및 이용에 동의해주세요.');
		return;
	}
	</c:if>
	if(f.email.value==''){
		alert('이메일주소를 입력하세요.');
		return;
	}else{
		f.submit();
	}
}
</script>
	</c:otherwise>
</c:choose>