<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb4.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="알림마당" />
	<jsp:param name="path" value="참여마당" />
	<jsp:param name="path" value="이벤트" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<ul class="tabmenu">
	<li><a href="sub4_3.jsp">공모전</a></li>
	<li class="active"><a href="sub4_3_2.jsp">이벤트</a></li>
	<li><a href="sub4_3_3.jsp">설문조사</a></li>
</ul>

<div class="board-view">
	<div class="view-event">
		<h1 class="view-title">공모전 소문내기 이벤트 </h1>
		<p>「여성과 인권」 통권 18호를 읽고 퀴즈를 맞춰주세요.<br />총 3회의 퀴즈에 참여하시면 정답자 중 추첨을 통해 총 30분께 선물을 드립니다.</p>
		
		<ul class="info">
			<li>
				<strong>기간</strong> 2018.2.7.(수)~2.28.(수)
			</li>
			<li>
				<strong>발표</strong> 3월 초 예정
			</li>
			<li>
				<strong>상품</strong> 스타벅스 음료 모바일쿠폰
			</li>
		</ul>
		
		<a href="">참여하기</a>
	</div>
	
	<div class="view-content">
		<p class="txt-center"><img src="../../../images/kor/sub/event.jpg" alt=""></p>
	</div>
</div>

<div class="btns txt-right">
	<a href="sub4_3_2.jsp" class="btn-m btn1">목록으로</a>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>