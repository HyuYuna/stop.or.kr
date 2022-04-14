<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header_contest.jsp">
	<jsp:param name="snb" value="contest.jsp" />
	<jsp:param name="path" value="성매매방지 국민생각 공모전" />
	<jsp:param name="path" value="접수하기" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<article class="box5">
	<h2>접수가 <span class="point3">정상적으로 완료되었습니다.</span></h2>
	<p>공모전에 많은 관심을 가지고 응모해 주신 여러분들께 깊은 감사드립니다.<br />당첨자 발표 일정은 홈페이지의 커뮤니티 게시판을 참고 부탁드리며 당선자에게는 개별 연락 드릴 예정입니다. 감사합니다. </p>
</article>

<p class="btns txt-center">
	<a href="sub9_3_1_3.jsp" class="btn-l btn1">홈페이지</a>
</p>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>