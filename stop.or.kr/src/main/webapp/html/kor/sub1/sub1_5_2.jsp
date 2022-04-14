<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb1.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="진흥원소개" />
	<jsp:param name="path" value="CI" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<h2 class="title1">대표 캐릭터</h2>
<p>한국여성인권진흥원과 함께 #with you 메시지를 전하는 대표 캐릭터를 소개합니다.</p>

<h3 class="title2">컨셉</h3>
<p>성평등 사회의 비전을 담고 있는 창의적이고 주체적인 캐릭터로 10대, 성인 등 다양한 여성상을 나타냄</p>

<h3 class="title2">역할</h3>
<p>젠더기반폭력(여성폭력) 피해자와 조력자, 활동가에게 연대’,  ‘공감’, ‘응원’, ‘희망’의 메시지를 전함</p>

<h3 class="title2">캐릭터별 메시지</h3>
<ul class="character">
	<li>
		<span><img src="../../../images/kor/sub/character1.gif" alt="" /></span>
		<strong>보라</strong>
		<p>“남몰래 힘들어 하진 않을까, 주변을 보라!”</p>
	</li>
	<li>
		<span><img src="../../../images/kor/sub/character2.gif" alt="" /></span>
		<strong>아라</strong>
		<p>“토닥토닥, <br />네 마음 다 아라”</p>
	</li>
	<li>
		<span><img src="../../../images/kor/sub/character3.gif" alt="" /></span>
		<strong>내라</strong>
		<p>“우리가 있으니 <br />힘을 내라”</p>
	</li>
	<li>
		<span><img src="../../../images/kor/sub/character4.gif" alt="" /></span>
		<strong>바라</strong>
		<p>“우리 함께, <br />성평등을 바라”</p>
	</li>
</ul>

<p class="txt-center">
	<img src="../../../images/kor/sub/character5.gif" alt="" />
</p>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>