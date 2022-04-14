<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb6.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="브리핑룸" />
	<jsp:param name="path" value="뉴스레터" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<div class="board-news">
	<div class="group">
		<div class="title">
			<strong>[뉴스레터-2018년 3호] 디지털 성범죄 피해자 지원센터 운영</strong>
			<p class="info">
				<span class="point3">조회수</span>
				481
			</p>
		</div>
		<a href="" class="txt-center">
			<img src="../../../images/kor/sub/newsletter1.jpg" alt="" />
		</a>
	</div>
	<div class="group">
		<div class="title">
			<strong>[인권스타-2017년 11호] 한국여성인권진흥원 제4대 변혜정 원장 취임</strong>
			<p class="info">
				<span class="point3">조회수</span>
				2680
			</p>
		</div>
		<a href="" class="txt-center">
			<img src="../../../images/kor/sub/newsletter2.jpg" alt="" />
		</a>
	</div>
</div>

<div class="pager">
	<a href="#" class="arr first">처음으로</a>
	<a href="#" class="arr prev">이전</a>
	<strong class="active">1</strong>
	<a href="#">2</a>
	<a href="#">3</a>
	<a href="#">4</a>
	<a href="#">5</a>
	<a href="#" class="arr next">다음</a>
	<a href="#" class="arr last">마지막으로</a>
</div>

<div class="board-search">
	<select name="" id="" title="검색 구분">
		<option value="">제목</option>
	</select>
	<input type="text" title="검색어" />
	<a href="" class="btn">검색</a>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>