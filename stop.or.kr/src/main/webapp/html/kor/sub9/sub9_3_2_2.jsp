<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header_contest.jsp">
	<jsp:param name="snb" value="contest.jsp" />
	<jsp:param name="path" value="성매매방지 국민생각 공모전" />
	<jsp:param name="path" value="접수하기" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<article class="box5 form-contest">
	<h2>접수확인</h2>
	
	<div class="item">
		<div class="form">
			<input type="text" title="이메일 주소" placeholder="이메일 주소">
			<input type="text" title="이름" placeholder="이름">
			<a href="sub9_3_2_2.jsp" class="btn">접수확인</a>
		</div>
	</div>
</article>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>