<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb1.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="진흥원소개" />
	<jsp:param name="path" value="연혁" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<ul class="tabmenu">
	<li><a href="sub1_3.jsp">태동기 (2005~2008)</a></li>
	<li class="active"><a href="sub1_3_2.jsp">창립기 (2009~2010)</a></li>
	<li><a href="sub1_3_3.jsp">인프라 구축기 (2010~2015)</a></li>
	<li><a href="sub1_3_4.jsp">성장기 (2016~)</a></li>
</ul>

<article class="history history2">
	<p class="img"><img src="../../../images/kor/sub/history2.jpg" alt="" /></p>
	<div class="title">
		<h2>창립기</h2>
		<strong>2009~2010</strong>
		<span>폭력방지 여성인권,  공공영역에서  그  서막을  열다!</span>
	</div>
	<ul class="list">
		<li>
			<strong>2009</strong>
			<span class="point1">11</span>
			재)한국여성인권진흥원 설립<br />
			<span class="point1">05</span>
			제1대 이화영원장 취임<br />
			<span class="point1">05</span>
			성매매방지중앙지원센터 사업 위탁 (~ 현재)<br />
			<span class="point1">12</span>
			이주여성긴급지원센터 1577-1366 위탁 (~2014.3.)
		</li>
	</ul>
</article>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>