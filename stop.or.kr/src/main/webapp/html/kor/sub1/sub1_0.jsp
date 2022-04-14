<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb1.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="검색결과" />
	<jsp:param name="path" value="검색결과" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<ul class="tabmenu">
	<li class="active"><a href="">컨텐츠</a></li>
	<li><a href="">게시판</a></li>
	<li><a href="">cms</a></li>
</ul>

<div class="search-result">
	<p class="box1">
		<strong class="point1">"검색결과 test" </strong>에 대한 통합검색 결과 총 <span class="point3">1269</span>건 검색되었습니다.
	</p>

	<h2 class="title1">페이지명 <span class="txt1">(총 <strong class="point3">12</strong>건)</span></h2>
	<ul class="bul1">
		<li>소재정보은행 : 고부가 소재 물성 정보 및 기술 정보 구축 및 활용</li>
		<li>시뮬레이션 : 소재정보은행과 테스트베드 연계 가능한 시뮬레이션 프로그램 구축 및 기업 기술 지원</li>
	</ul>
	<p class="btns txt-right">
		<a href="" class="btn-m btn1">더보기</a>
	</p>
	
	<h2 class="title1">페이지명 <span class="txt1">(총 <strong class="point3">12</strong>건)</span></h2>
	<ul class="bul1">
		<li>소재정보은행 : 고부가 소재 물성 정보 및 기술 정보 구축 및 활용</li>
		<li>시뮬레이션 : 소재정보은행과 테스트베드 연계 가능한 시뮬레이션 프로그램 구축 및 기업 기술 지원</li>
		<li>소재정보은행 : 고부가 소재 물성 정보 및 기술 정보 구축 및 활용</li>
		<li>시뮬레이션 : 소재정보은행과 테스트베드 연계 가능한 시뮬레이션 프로그램 구축 및 기업 기술 지원</li>
		<li>소재정보은행 : 고부가 소재 물성 정보 및 기술 정보 구축 및 활용</li>
		<li>시뮬레이션 : 소재정보은행과 테스트베드 연계 가능한 시뮬레이션 프로그램 구축 및 기업 기술 지원</li>
		<li>소재정보은행 : 고부가 소재 물성 정보 및 기술 정보 구축 및 활용</li>
		<li>시뮬레이션 : 소재정보은행과 테스트베드 연계 가능한 시뮬레이션 프로그램 구축 및 기업 기술 지원</li>
	</ul>
	<p class="btns txt-right">
		<a href="" class="btn-m btn1">더보기</a>
	</p>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>