<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>
<c:if test="${param.agree eq 'Y'}">
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
							<img src="http://stop.or.kr/html/kor/email/images/email-process05-img01.gif" alt="한국여성인권진흥원의 뉴스레터 구독 재동의해주셔서 감사합니다. 재동의 처리를 완료하였습니다." style="display:block;margin:0;padding:0;border:none;font-size:0;line-height:0;">
						</td>
					</tr>
					<tr>
						<td align="center" style="display:block;margin:0;padding:0;height:121px;">&nbsp;</td>
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
</c:if>
<c:if test="${param.agree eq 'N'}">
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
							<img src="http://stop.or.kr/html/kor/email/images/email-process04-img01.gif" alt="지금까지 한국여성인권진흥원의 뉴스레터를 구독해주셔서 감사합니다." style="display:block;margin:0;padding:0;border:none;font-size:0;line-height:0;">
							<img src="http://stop.or.kr/html/kor/email/images/email-process04-img02.gif" alt="재동의 거부를 완료하였습니다. 뉴스레터 구독을 위해 등록한 귀하의 이메일주소는 삭제완료 되었습니다. 뉴스레터 재구독을 원하시는 분은 한국여성인권진흥원 홈페이지(www.stop.or.kr) 메인 페이지 하단 부분의 뉴스레터 신청에서 이메일 주소를 입력하여 구독신청 하시기 바랍니다. 감사합니다." style="display:block;margin:0;padding:0;border:none;font-size:0;line-height:0;">
						</td>
					</tr>
					<tr>
						<td align="center" style="display:block;margin:0;padding:0;height:25px;">&nbsp;</td>
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
</c:if>
