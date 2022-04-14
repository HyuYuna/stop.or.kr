<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>


<!-- 상세콘텐츠 영역 -->
<article class="box5">
	<h2>접수가 <span class="point3">정상적으로 완료되었습니다.</span></h2>
	<p>공모전에 많은 관심을 가지고 응모해 주신 여러분들께 깊은 감사드립니다.<br />당첨자 발표 일정은 홈페이지의 커뮤니티 게시판을 참고 부탁드리며 당선자에게는 개별 연락 드릴 예정입니다. 감사합니다. </p>
</article>

<p class="btns txt-center">
	<a href="${cutil:getUrl('/complicity/', '', true)}" class="btn-l btn1">홈페이지</a>
</p>
<!-- // -->
	          