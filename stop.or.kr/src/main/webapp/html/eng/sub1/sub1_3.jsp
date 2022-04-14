<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb1.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="About Us" />
	<jsp:param name="path" value="History" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<ul class="tabmenu">
	<li class="active"><a href="sub1_3.jsp">Beginning</a></li>
	<li><a href="sub1_3_2.jsp">Establishment</a></li>
	<li><a href="sub1_3_3.jsp">Establishment of infrastructure</a></li>
	<li><a href="sub1_3_4.jsp">Growth</a></li>
</ul>

<article class="history history1">
	<p class="img"><img src="../../../images/kor/sub/history1.jpg" alt="" /></p>
	<div class="title">
		<h2>Beginning </h2>
		<strong>2005~2008</strong>
		<span>Taking on prostitution as a form of violence against women</span>
	</div>
	<ul class="list">
		<li>
			<strong>2005</strong>
			<span class="point1">November </span>
			Established Jongyhak, the Korea Support Center for Women’s Human Rights
		</li>
		<li>
			<strong>2008</strong>
			<span class="point1">June </span>
			Laid a legal basis for the Korea Support Center for Women’s Human Rights
		</li>
	</ul>
</article>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>