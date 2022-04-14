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
	<li class="active"><a href="sub1_3.jsp">태동기 (2005~2008)</a></li>
	<li><a href="sub1_3_2.jsp">창립기 (2009~2010)</a></li>
	<li><a href="sub1_3_3.jsp">인프라 구축기 (2010~2015)</a></li>
	<li><a href="sub1_3_4.jsp">성장기 (2016~)</a></li>
</ul>

<article class="history history1">
	<p class="img"><img src="../../../images/kor/sub/history1.jpg" alt="" /></p>
	<div class="title">
		<h2>태동기</h2>
		<strong>2005~2008</strong>
		<span>여성폭력으로서  성매매를  문제화하다!</span>
	</div>
	<ul class="list">
		<li>
			<strong>2005</strong>
			<span class="point1">11</span>
			여성인권중앙지원센터 종이학 설립 
		</li>
		<li>
			<strong>2008</strong>
			<span class="point1">06</span>
			성매매방지중앙지원센터 법적 근거 마련
		</li>
	</ul>
</article>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>