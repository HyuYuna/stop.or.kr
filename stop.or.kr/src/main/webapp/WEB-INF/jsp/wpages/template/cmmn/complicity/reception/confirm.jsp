<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 상세콘텐츠 영역 -->
<form:form id="confirm-form" commandName="complicityConfirmVO" class="ajax-form-submit">
<article class="box5 form-contest">
	<h2>접수확인</h2>
	<div class="item">
		<div class="form">
			<form:input path="email" title="이메일 주소" placeholder="이메일 주소"/>
			<form:input path="name" title="이름" placeholder="이름"/>
			<a href="#" onclick="$('#confirm-form').submit(); return false;" class="btn">접수확인</a>
		</div>
	</div>
</article>
</form:form>
<!-- // -->