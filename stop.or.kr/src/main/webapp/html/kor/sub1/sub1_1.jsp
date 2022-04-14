<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb1.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="진흥원소개" />
	<jsp:param name="path" value="인사말" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<div class="greeting">
	<p class="txt">
		<strong>안녕하십니까.</strong><br />
		여성폭력과 인권에 대한 관심으로 한국여성인권진흥원을 방문하여 
		주신 여러분, 반갑습니다. <br />
		현재 우리사회는 폭력과 차별의 심각성에 대해서 인지하고, 근절을 위하여 지속적으로 노력을 기울이고 있습니다. 그러나 이와 동시에 여성혐오,데이트 폭력이나 디지털폭력 등 여성폭력의 범주가 다양해지고 있는 것 또한 사실 입니다. 한국여성인권진흥원은 다양해지는 여성폭력의 범주에 대응 하기 위하여 사법기관과의 연대와 여성단체 및 여성폭력 피해자 지원시설 등의 네트워크를 통하여 여성폭력 피해자 지원에 앞장서고 있습니다.<br />
		한국여성인권진흥원을 찾아주신 여러분,<br />
		폭력과 차별은 개인, 가정에서 일어나는 문제가 아닌 사회 전반에 걸쳐 있는 중대한 사회문제입니다. 그만큼 국가적 차원의 제도 정비와 더불어 전 국민 적인 관심과 참여가 절대적으로 필요합니다.<br />
		한국여성인권진흥원은 임직원들의 전문성과 경험을 바탕으로 여성폭력 예방과 근절을 위하여 최선을 다할 것입니다. 폭력과 차별 문제의 타개를 위한 패러다임의 변화에 여러분의 관심과 참여로 힘을 보태주시길 부탁드립니다.
		감사합니다.
	</p>

	<div class="title">
		<p class="desc">
			<strong>여성폭력 예방과 근절, 폭력 피해자에<br /> 대한 지원을 위해 전문성과 경험을 바탕으로 <br />최선을 다할 것입니다.</strong>
			<span>여성인권진흥원원장 <img src="../../../images/kor/sub/greeting.png" alt="변혜정" /></span>
		</p>
		<p class="img">
			<span>Women’s Human<br /> Rights Institute of Korea</span>
			<img src="../../../images/kor/sub/greeting.jpg" alt="" />
		</p>
	</div>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>