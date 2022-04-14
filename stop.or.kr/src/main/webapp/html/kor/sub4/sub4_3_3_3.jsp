<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb4.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="알림마당" />
	<jsp:param name="path" value="참여마당" />
	<jsp:param name="path" value="설문조사" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<ul class="tabmenu">
	<li><a href="sub4_3.jsp">공모전</a></li>
	<li><a href="sub4_3_2.jsp">이벤트</a></li>
	<li class="active"><a href="sub4_3_3.jsp">설문조사</a></li>
</ul>

<div class="board-view">
	<div class="view-result">
		<h1 class="view-title"><span class="point3">2,580</span> 명 응답</h1>
		<p>주관식 항목의 응답은 최근 50개까지만 표시됩니다.<br />나머지 응답결과를 확인하려면 상세보기를 이용해주세요.</p>
	</div>
	
	<div class="view-survey">
		<article class="group">
			<h2>여성인권진흥원 이용분야 관련</h2>
			
			<article class="item">
				<h3>선생님께서는 여성인권진흥원을 얼마나 자주 방문하십니까?</h3>
				<div>
					<!-- 차트 들어갈 곳 -->
					<p class="txt-center">
						<img src="../../../images/kor/sub/survey.gif" alt="하루에 1회 이상 10 19%, 일주일에 3회 이상 23 4%, 일주일에 1회 이상 39 19%, 한달에 3회 이상 38 18%, 한달에 1회 이상 37 18%, 기타 54 18%" />
					</p>
					<!-- //차트 들어갈 곳 -->
				</div>
			</article>
			
			<article class="item">
				<h3>선생님께서 이용하시는 분야는 무엇입니까?</h3>
				<ul class="list2">
					<li>공부를 하면서 논문 등의 최신지견 검색</li>
					<li>한방의 관심 증가</li>
					<li>정보특성상 기존 사용자층에 소폭 유입될 거 같다</li>
					<li>한방논문검색에 전통지식포탈과 함께 병용 사용</li>
					<li>한의계 종합 database이기 때문에</li>
					<li>향후 큰 차이가 없을 것 같아서</li>
					<li>현재 만족</li>
					<li>없음</li>
				</ul>
			</article>
		</article>
	</div>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>