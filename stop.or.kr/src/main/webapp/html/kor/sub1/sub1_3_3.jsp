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
	<li><a href="sub1_3_2.jsp">창립기 (2009~2010)</a></li>
	<li class="active"><a href="sub1_3_3.jsp">인프라 구축기 (2010~2015)</a></li>
	<li><a href="sub1_3_4.jsp">성장기 (2016~)</a></li>
</ul>

<article class="history history3">
	<p class="img"><img src="../../../images/kor/sub/history3.jpg" alt="" /></p>
	<div class="title">
		<h2>인프라<br />구축기</h2>
		<strong>2010~2015</strong>
		<span>여성폭력  방지  인프라를  구축하다!</span>
	</div>
	<ul class="list">
		<li>
			<strong>2010</strong>
			<span class="point1">03</span>
			여성·아동폭력피해중앙지원단 설치지원 및 사업 위탁 (~ 현재)
		</li>
		<li>
			<strong>2011</strong>
			<span class="point1">03</span>
			성매매피해청소년치료재활 사업 위탁 (~ 현재) <br />
			<span class="point1">05</span>
			제2대 김호순원장 취임<br />
			<span class="point1">12</span>
			보조사업 추진 3개 기관 통합 이전 ( 중구 서소문로)
		</li>
		<li>
			<strong>2012</strong>
			<span class="point1">04</span>
			여성긴급전화중앙지원단 설치지원 및 사업 위탁 (~ 현재)
		</li>
		<li>
			<strong>2013</strong>
			<span class="point1">05</span>
			제3대 강월구원장 취임
		</li>
		<li>
			<strong>2014</strong>
			<span class="point1">02</span>
			기타 공공기관 지정 ( 기획재정부)
		</li>
		<li>
			<strong>2015</strong>
			<span class="point1">01</span>
			일본군 ‘위안부’ 피해자 치료 및 맞춤형 지원사업 위탁 (~ 현재)
		</li>
	</ul>
</article>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>