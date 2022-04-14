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
	<li><a href="sub1_3.jsp">Beginning</a></li>
	<li><a href="sub1_3_2.jsp">Establishment</a></li>
	<li><a href="sub1_3_3.jsp">Establishment of infrastructure</a></li>
	<li class="active"><a href="sub1_3_4.jsp">Growth</a></li>
</ul>

<article class="history history4">
	<p class="img"><img src="../../../images/kor/sub/history4.jpg" alt="" /></p>
	<div class="title">
		<h2>Growth</h2>
		<strong>2016~</strong>
		<span>Becoming an anchor for human rights and combatting gender violence</span>
	</div>
	<ul class="list">
		<li>
			<strong>2016</strong>
			<span class="point1">March </span>
			Opened Café Jamong, an internship support center (to October 2017)<br />
			<span class="point1">December </span>
			Designated a family-friendly organization by the Ministry of Gender Equality and Family
		</li>
		<li>
			<strong>2017</strong>
			<span class="point1">November </span>
			Byun Heajoung inaugurated as the fourth President
		</li>
		<li>
			<strong>2018</strong>
			<span class="point1">March </span>
			Launched the Hotline for Workplace Sexual Harassment and Abuse <br />
			<span class="point1">April </span>
			Launched the Support Center for Digital Sexual Abuse
		</li>
	</ul>
</article>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>