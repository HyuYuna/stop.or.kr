<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>

<!-- 상세콘텐츠 영역 -->
<form:form name="news_reject_form" class="news-ajax-form-submit" action="${pageContext.request.contextPath}/newsletter/newsletterFormMdf.do">
	<article class="form-spam">
		<div class="desc">
			<div class="item">
				<h2>
					<span class="point3">이메일 수신거부</span> 신청 페이지 입니다.
				</h2>
				<p>한국여성인권진흥원의 뉴스레터 및 기관소식 메일을 수신거부 하시겠습니까?</p>
			</div>
		</div>
		
		<div class="form">
			<input type="hidden" name="email" id="email"/>
			<input type="hidden" name="type" id="type"/>
			<label for="mailid" class="hidden-text">이메일주소 아이디</label>
			<input type="text" id="mailid" name="mailid" title="이메일주소 중 아이디" placeholder="이메일 주소"> @
			<label for="mailhost" class="hidden-text">이메일주소 도메인</label>
			<input type="text" id="mailhost" name="mailhost" title="이메일주소 중 도메인">
			<label for="user_email_3" class="hidden-text">이메일 도메인 선택</label>
			<select name="user_email_3" id="user_email_3" title="이메일 도메인 선택">
				<option value="" selected="selected">직접입력</option>
				<option value="nate.com">nate.com</option>
				<option value="gmail.com">gmail.com</option>
				<option value="empal.com">empal.com</option>
				<option value="naver.com">naver.com</option>
				<option value="dreamwiz.com">dreamwiz.com</option>
				<option value="hanmail.net">hanmail.net</option>
				<option value="freechal.com">freechal.com</option>
				<option value="paran.com">paran.com</option>
				<option value="hitel.net">hitel.net</option>
				<option value="hanmir.com">hanmir.com</option>
				<option value="netian.com">netian.com</option>
				<option value="lycos.co.kr">lycos.co.kr</option>
				<option value="yahoo.co.kr">yahoo.co.kr</option>
				<option value="chillian.net">chillian.net</option>
				<option value="korea.com">korea.com</option>
				<option value="hotmail.com">hotmail.com</option>
				<option value="unitel.co.kr">unitel.co.kr</option>
				<option value="nownuri.net">nownuri.net</option>
				<option value="hanafos.com">hanafos.com</option>
				<option value="kornet.net">kornet.net</option>
			</select>
		</div>
	</article>
	
	<p class="btns txt-center">
<!-- 		<a href="" class="btn-l btn1">예</a> -->
		<input type="submit" class="btn-l btn1" value="예"/>
		<a href="${pageContext.request.contextPath}/" class="btn-l btn2">아니오</a>
	</p>
</form:form>
<!-- // -->
<script>
$("#user_email_3").change(function() {
	
	if($(this).val() != "") 
		$("#mailhost").val($(this).val())
	else
		$("#mailhost").val("");
});
;jQuery(document).ready(function($)
{
	$('form.news-ajax-form-submit').AjaxFormSubmit("","수신거부 하시겠습니까?",before_action);
	
	function before_action() {
	
		$("input#email").val($("#mailid").val()+"@"+$("#mailhost").val());
		$('#type').val("mdf");
		/*ajax 태워서  이메일이 존재하는지 여부 체크하기*/
		
		
	}
	
	
});
</script>