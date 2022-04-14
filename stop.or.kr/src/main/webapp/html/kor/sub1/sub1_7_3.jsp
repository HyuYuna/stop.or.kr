<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb1.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="진흥원소개" />
	<jsp:param name="path" value="고객만족경영" />
	<jsp:param name="path" value="고객서비스 이행표준" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<div class="box1">
	<strong class="title type1">
		CS
		<span>Vision</span>
	</strong>
	<span class="bg"><img src="../../../images/kor/sub/bg5.gif" alt=""></span>
	<p class="txt">고객만족을 최우선으로 하는 여성인권 허브기관</p>
</div>

<ul class="tabmenu">
	<li><a href="sub1_7.jsp">고객서비스 헌장</a></li>
	<li><a href="sub1_7_2.jsp">고객서비스 이행표준</a></li>
	<li class="active"><a href="sub1_7_3.jsp">고객소통게시판</a></li>
</ul>

<article class="box3">
	<div class="title txt-center">
		<h2>고객소통게시판</h2>
	</div>
	<div class="item">
		<ul class="bul1">
			<li>한국여성인권진흥원의 정책에서 겪는 애로 및 건의사항, 정책제안 등에 대한 소통창구를 안내드립니다.</li>
			<li>아래 홈페이지를 참고하셔서 적극적으로 제안주시면 감사하겠습니다.</li>
			<li></li>
			<li>여러분들의 귀중한 의견에 귀기울이는 한국여성인권진흥원이 되겠습니다.</li>
		</ul>
		<br /><br /><br />
		<ul class="bul1">
			<li>1. 국민권익위원회 국민신문고 :  https://www.epeople.go.kr</li>
			<li>2. 국가인권위원회 :  https://case.humanrights.go.kr</li>
		</ul>
	</div>
</article>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>