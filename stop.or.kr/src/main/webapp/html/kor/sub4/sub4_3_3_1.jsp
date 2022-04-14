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

<div class="table-wrap board">
	<table>
		<caption>설문조사 목록 - 번호, 제목, 설문기간, 상태</caption>
		<colgroup>
			<col class="date">
			<col class="subject">
			<col class="part">
			<col class="date">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">제목</th>
				<th scope="col">설문기간</th>
				<th scope="col">상태</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>3</td>
				<td class="subject"><a href="sub4_3_3.jsp">배우 정려원 씨와 with you 하실 여러분을 찾습니다</a></td>
				<td>2018.05.18 ~ 2018.05.30</td>
				<td><span class="icon3 type1">진행중</span></td>
			</tr>
			<tr>
				<td>3</td>
				<td class="subject"><a href="sub4_3_3.jsp">배우 정려원 씨와 with you 하실 여러분을 찾습니다</a></td>
				<td>2018.05.18 ~ 2018.05.30</td>
				<td><span class="icon3 type2">마감</span></td>
			</tr>
		</tbody>
	</table>
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