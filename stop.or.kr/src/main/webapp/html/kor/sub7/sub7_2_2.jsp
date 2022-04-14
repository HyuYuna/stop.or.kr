<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb7.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="자료실" />
	<jsp:param name="path" value="영상자료" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<div class="box1">
	<div class="item">
		<span class="icon"><img src="../../../images/kor/sub/icon1.gif" alt="" /></span>
		<p class="txt">다운로드를 원하실 경우 사용계획 및 연락처를 기재하여 메일(기획홍보팀 center@stop.or.kr)로 문의하시기 바랍니다.</p>
	</div>
</div>

<div class="board-view">
	<h1 class="view-title">
		<span class="icon1 type1">홍보영상</span><br />
		2015년 성매매방지 홍보영상 (건강한 가치편)
	</h1>
	<ul class="info">
		<li>
			<strong>제작(감독)</strong> 한국여성인권진흥원
		</li>
		<li>
			<strong>등록일</strong> 2018-04-01
		</li>
		<li>
			<strong>제작연도</strong> 2015
		</li>
		<li>
			<strong>재생시간</strong> 0:46
		</li>
	</ul>
	<div class="view-content">
		<div class="txt-center"><img src="../../../images/kor/sub/video.jpg" alt="" /></div>
	</div>
	<div class="download-list">
		<strong class="title">첨부파일</strong>
		<ul>
			<li>
				<a href="#">홍보용 사진.JPG</a>
			</li>
		</ul>
	</div>
</div>

<div class="btns txt-right">
	<a href="sub7_2.jsp" class="btn-m btn1">목록으로</a>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>