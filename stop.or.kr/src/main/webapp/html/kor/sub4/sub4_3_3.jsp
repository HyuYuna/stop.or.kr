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
<ul class="tabmenu">
	<li><a href="sub4_3.jsp">공모전</a></li>
	<li><a href="sub4_3_2.jsp">이벤트</a></li>
	<li class="active"><a href="sub4_3_3.jsp">설문조사</a></li>
</ul>

<div class="board-view">
	<div class="view-event">
		<h1 class="view-title">설문조사 타이틀 </h1>
		<p>설문조사에 대한 설명문이 들어가는 부분 설문조사에 대한 설명문이 들어가는 부분 설문조사에 대한 설명문이 들어가는 부분 설문조사에 대한 설명문이 들어가는 부분 </p>
		
		<ul class="info">
			<li>
				<strong>기간</strong> 2018.2.7.(수)~2.28.(수)
			</li>
		</ul>
		
		<a href="sub4_3_3_2.jsp">설문참여</a>
	</div>
	
	<div class="view-content">
		<p class="txt-center"><img src="../../../images/kor/sub/survey.jpg" alt=""></p>
	</div>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>