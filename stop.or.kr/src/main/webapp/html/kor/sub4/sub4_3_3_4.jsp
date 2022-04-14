<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb4.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="알림마당" />
	<jsp:param name="path" value="참여마당" />
	<jsp:param name="path" value="설문조사" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
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
		<input type="text" title="이메일주소 중 아이디" placeholder="이메일 주소"> @
		<input type="text" title="이메일주소 중 도메인">
		<select title="이메일 도메인 선택">
			<option>직접입력</option>
		</select>
	</div>
</article>

<p class="btns txt-center">
	<a href="" class="btn-l btn1">예</a>
	<a href="#newsletter" class="btn-l btn2">아니오</a>
</p>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>