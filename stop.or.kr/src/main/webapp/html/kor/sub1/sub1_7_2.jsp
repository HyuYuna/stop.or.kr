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
	<li class="active"><a href="sub1_7_2.jsp">고객서비스 이행표준</a></li>
	<li><a href="sub1_7_3.jsp">고객소통게시판</a></li>
</ul>

<article class="box3">
	<div class="title txt-center">
		<h2>고객서비스 이행표준</h2>
	</div>
	<div class="item">
		<h3 class="title1">우리의 고객</h3>
		<h4 class="title2">내부고객</h4>
		<p>직원, 이사회</p>
		<h4 class="title2">외부고객</h4>
		<p>여성폭력피해자, 피해자 지원시설 및 종사자, 관련 부처 및 지방자치단체, 일반국민</p>
		
		<h3 class="title1">고객을 맞이하는 우리의 자세</h3>
		<h4 class="title2">제1장 직접 방문하시는 경우</h4>
		<ul class="bul1">
			<li>방문하시는 고객의 불편함이 없도록 정문 앞에는 건물 안내도를, 층별 입구에는 담당자 성명 및 전화번호를, 책상 앞에는 명패를 비치하겠습니다.</li>
			<li>고객을 맞이할 때는 밝은 얼굴로 “안녕하십니까? 무엇을 도와드릴까요?”라고 인사를 드린 후 업무를 처리해 드리겠습니다.</li>
			<li>방문고객을 해당부서의 담당자에게 친절히 안내해 드리겠습니다.</li>
			<li>방문고객이 불필요하게 기다리시지 않도록 다른 업무를 처리 중이라도 즉시 하던 일을 중단하고 고객의 말씀을 경청하겠습니다.</li>
			<li>용무를 마치고 돌아가시는 고객에 대하여 “감사합니다. 안녕히 가십시오.” 라고 정중하게 인사하겠습니다.</li>
		</ul>
		
		<h4 class="title2">제2장 전화로 서비스를 이용하시는 경우</h4>
		<ul class="bul1">
			<li>전화는 벨이 3회 이상 울리기 전에 받겠으며 항상 친절하고 정확하게 응대하겠습니다.</li>
			<li>전화를 주신 고객에게 “한국여성인권진흥원 ㅇㅇㅇ팀 ㅇㅇㅇ입니다.”라고 알아듣기 쉽도록 정확한 발음으로 소속과 이름을 밝히겠습니다.</li>
			<li>다른 부서 소관 업무에 대하여 문의를 받는 경우에는 “고객님의 전화를 ㅇㅇㅇ팀의 담당자에게 돌려드리겠습니다. 혹시 전화가 끊어지면 735-0000번으로 전화하셔서 담당직원을 찾아주시기 바랍니다.”라고 안내해 드리겠습니다.</li>
		</ul>
		
		<h4 class="title2">제3장 온라인을 이용하시는 경우</h4>
		<ul class="bul1">
			<li>홈페이지(www.stop.or.kr)를 통해 우리 원의 정보를 상세히 설명하여 별도의 전화나 방문이 없이도 고객이 원하는 정보를 편리하게 이용할 수 있도록 하겠습니다.</li>
			<li>
				홈페이지에 고객이 건의사항을 올릴 수 있는 메뉴를 만들어 7일 이내에 회신하고 부득이한 사유로 처리기간이 7일 이상 소요될 경우에는 중간진행 사항 및 예상 소요시간을 먼저 안내하겠습니다.<br />
				* 창의행정 : 행정능률성 제고 등 의견접수(goodidea@stop.or.kr)<br />
				* 클린신고센터 : 임직원 부패행위, 부조리 등 신고 접수(clean@stop.or.kr)
			</li>
		</ul>
		
		<h4 class="title2">제4장 정보제공 및 고객 비밀 보호</h4>
		<ul class="bul1">
			<li>우리 원이 업무수행 중 작성, 취득하여 관리하는 정보를 고객이 요청할 경우에는 관련 절차에 의거 열람, 사본, 복제 등의 형태로 공개하여 고객의 알권리를 존중하겠습니다.</li>
			<li>고객 상담 및 업무 중 지득한 고객의 인적사항 및 관련정보는 기밀사항으로 처리하여 유출되지 않도록 하겠으며, 특히 온라인을 통해 처리되는 개인정보 보호를 위하여 ‘개인정보 보호법’을 준수하겠습니다.</li>
		</ul>
		
		<h4 class="title2">제4장 정보제공 및 고객 비밀 보호</h4>
		<ul class="bul1">
			<li>우리 원이 업무수행 중 작성, 취득하여 관리하는 정보를 고객이 요청할 경우에는 관련 절차에 의거 열람, 사본, 복제 등의 형태로 공개하여 고객의 알권리를 존중하겠습니다.</li>
			<li>고객 상담 및 업무 중 지득한 고객의 인적사항 및 관련정보는 기밀사항으로 처리하여 유출되지 않도록 하겠으며, 특히 온라인을 통해 처리되는 개인정보 보호를 위하여 ‘개인정보 보호법’을 준수하겠습니다.</li>
		</ul>
		
		<h4 class="title2">문의</h4>
		<ul class="bul1">
			<li>(전화) 02-735-5166 (팩스) 02-735-2051</li>
			<li>(이메일) webmaster@stop.or.kr</li>
		</ul>
		<br />
		시행일 : 2016년 4월 14일 부터
	</div>
</article>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>