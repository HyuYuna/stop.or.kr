<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb1.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="About Us" />
	<jsp:param name="path" value="Establishment" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<ul class="tabmenu">
	<li><a href="sub1_3.jsp">Beginning</a></li>
	<li class="active"><a href="sub1_3_2.jsp">Establishment</a></li>
	<li><a href="sub1_3_3.jsp">Establishment of infrastructure</a></li>
	<li><a href="sub1_3_4.jsp">Growth</a></li>
</ul>

<article class="history history2">
	<p class="img"><img src="../../../images/kor/sub/history2.jpg" alt="" /></p>
	<div class="title">
		<h2>Establishment</h2>
		<strong>2009~2010</strong>
		<span>Opening an era of women’s human rights in the public sector</span>
	</div>
	<ul class="list">
		<li>
			<strong>2009</strong>
			<span class="point1">April </span>
			Launched the Women’s Human Rights Commission of Korea<br />
			<span class="point1">May </span>
			Lee Hwayoung inaugurated as the first President<br />
			<span class="point1">May </span>
			Entrusted with the operation of the Central Support Center for Prevention of Sex Trafficking (to present)<br />
			<span class="point1">December </span>
			Entrusted with the operation of the Migrant Women’s Hotline 1577-1366 (to March 2014)
		</li>
	</ul>
</article>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>