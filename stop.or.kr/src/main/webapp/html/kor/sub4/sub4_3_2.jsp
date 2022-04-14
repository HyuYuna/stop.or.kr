<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb4.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="알림마당" />
	<jsp:param name="path" value="참여마당" />
	<jsp:param name="path" value="이벤트" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<ul class="tabmenu">
	<li><a href="sub4_3.jsp">공모전</a></li>
	<li class="active"><a href="sub4_3_2.jsp">이벤트</a></li>
	<li><a href="sub4_3_3.jsp">설문조사</a></li>
</ul>

<ul class="board-event">
	<li class="ing">
		<a href="sub4_3_2_2.jsp">
			<em>진행</em>
			<p><img src="../../../images/kor/sub/event1.jpg" alt="" /></p>
			<span>2018. 02. 07 ~ 2018. 02. 28</span>
			<strong>공모전 소문내기 이벤트 </strong>
		</a>
	</li>
	<li>
		<a href="sub4_3_2_2.jsp">
			<em>마감</em>
			<p><img src="../../../images/kor/sub/event2.jpg" alt="" /></p>
			<span>2018. 02. 07 ~ 2018. 02. 28</span>
			<strong>「여성과 인권」 통권 18호 퀴즈 이벤트 </strong>
		</a>
	</li>
	<li>
		<a href="sub4_3_2_2.jsp">
			<em>마감</em>
			<p><img src="../../../images/kor/sub/event3.jpg" alt="" /></p>
			<span>2018. 02. 07 ~ 2018. 02. 28</span>
			<strong>「여성과 인권」 통권 18호 구독자 만족도 조사 이벤트  </strong>
		</a>
	</li>
	<li>
		<a href="sub4_3_2_2.jsp">
			<em>마감</em>
			<p><img src="../../../images/kor/sub/event3.jpg" alt="" /></p>
			<span>2018. 02. 07 ~ 2018. 02. 28</span>
			<strong>2017 성매매추방주간 맞이 이벤트 '퀴즈풀고 소문내고' 이벤트 '퀴즈풀고 </strong>
		</a>
	</li>
	<li>
		<a href="sub4_3_2_2.jsp">
			<em>마감</em>
			<p><img src="../../../images/kor/sub/event3.jpg" alt="" /></p>
			<span>2018. 02. 07 ~ 2018. 02. 28</span>
			<strong>「여성과 인권」 통권 18호 구독자 만족도 조사 이벤트  </strong>
		</a>
	</li>
</ul>

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