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
	<li><a href="sub1_3_3.jsp">인프라 구축기 (2010~2015)</a></li>
	<li class="active"><a href="sub1_3_4.jsp">성장기 (2016~)</a></li>
</ul>

<article class="history history4">
	<p class="img"><img src="../../../images/kor/sub/history4.jpg" alt="" /></p>
	<div class="title">
		<h2>성장기</h2>
		<strong>2016~</strong>
		<span>여성폭력  근절  및  인권의  허브기관으로  성장하다!</span>
	</div>
	<ul class="list">
		<li>
			<strong>2016</strong>
			<span class="point1">03</span>
			인턴십 지원센터 ‘카페자몽’ 개소 및 운영 (~2017.10) <br />
			<span class="point1">12</span>
			가족친화인증기관 선정
		</li>
		<li>
			<strong>2017</strong>
			<span class="point1">11</span>
			제4대 변혜정원장 취임
		</li>
		<li>
			<strong>2018</strong>
			<span class="point1">03</span>
			직장내 성희롱·성폭력 특별신고센터 운영 <br />
			<span class="point1">04</span>
			디지털 성범성 대응 및 지원사업 운영
		</li>
	</ul>
</article>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>