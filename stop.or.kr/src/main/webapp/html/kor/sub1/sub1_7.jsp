<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb1.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="진흥원소개" />
	<jsp:param name="path" value="고객만족경영" />
	<jsp:param name="path" value="고객서비스 헌장" />
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
	<li class="active"><a href="sub1_7.jsp">고객서비스 헌장</a></li>
	<li><a href="sub1_7_2.jsp">고객서비스 이행표준</a></li>
	<li><a href="sub1_7_3.jsp">고객소통게시판</a></li>
</ul>

<article class="box3">
	<div class="title txt-center">
		<h2>고객서비스 헌장</h2>
	</div>
	<div class="item">
		한국여성인권진흥원은 우리 사회에 존재하는 다양한 형태의 여성폭력을 근절하여 성평등 사회를 실현하고, 여성폭력 예방 및 피해자 지원 사업을 통해 여성인권 향상에 기여하는 공공기관으로, 임직원 모두는 고객님께 최상의 서비스를 제공할 것을 약속드리며 다음의 사항을 성실히 실천하겠습니다.
		<br /><br />
		<ul class="bul1 point1">
			<li>우리는 항상 고객을 만족시킬 수 있도록 최선을 다하겠습니다.</li>
			<li>우리는 고객의 경쟁력 강화를 위해 지원서비스의 전문성을 강화하겠습니다.</li>
			<li>우리는 투명하고 공정한 업무처리로 믿을 수 있는 서비스를 제공하겠습니다.</li>
			<li>우리는 고객의 편의를 위해 업무 절차 및 제도를 개선하고 현장 중심의 서비스를 제공하겠습니다.</li>
			<li>우리는 고객에게 잘못 제공된 서비스가 있다면 적극적으로 대응하여 바로 개선하도록 하겠습니다.</li>
		</ul>
		<br />
		우리는 위의 고객 서비스 약속을 반드시 지키기 위하여 구체적인 서비스 이행표준을 정하여 성실히 이행하겠습니다.
		<br /><br />
		2016년 4월 14일 <br />
		한국여성인권진흥원 임직원 일동
	</div>
</article>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>