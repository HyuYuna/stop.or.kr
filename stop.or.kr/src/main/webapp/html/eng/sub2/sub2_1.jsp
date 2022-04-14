<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb2.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="알림마당" />
	<jsp:param name="path" value="공지/공고" />
	<jsp:param name="path" value="공지사항" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<ul class="category">
	<li class="active"><a href="">category1</a></li>
	<li><a href="">category2</a></li>
	<li><a href="">category3</a></li>
	<li><a href="">category4</a></li>
</ul>

<div class="table-wrap board">
	<table>
		<caption>공지사항 목록 - 번호, 분류, 제목, 담당부서, 등록일, 조회수</caption>
		<colgroup>
			<col class="date">
			<col class="date">
			<col class="subject">
			<col class="part">
			<col class="date">
			<col class="hit">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">분류</th>
				<th scope="col">제목</th>
				<th scope="col">담당부서</th>
				<th scope="col">등록일</th>
				<th scope="col">조회수</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><span class="notice">NOTICE</span></td>
				<td class="point1">공지사항</td>
				<td class="subject"><a href="sub4_2_1_2.jsp">미투 운동 이후, 1366 성폭력 상담 51% 올랐다</a><span class="new">새글</span></td>
				<td>경영지원팀</td>
				<td>2018.05.01</td>
				<td>112</td>
			</tr>
			<tr>
				<td><span class="notice">NOTICE</span></td>
				<td class="point1">채용소식</td>
				<td class="subject"><a href="sub4_2_1_2.jsp">불법촬영물 삭제요청 누가 할 수 있는지, 혹 아시나요</a></td>
				<td>경영지원본부</td>
				<td>2018.05.01</td>
				<td>112</td>
			</tr>
			<tr>
				<td>3</td>
				<td class="point1">공지사항</td>
				<td class="subject"><a href="sub4_2_1_2.jsp">배우 정려원 씨와 with you 하실 여러분을 찾습니다</a></td>
				<td>성매매방지중앙지원센터 현장지원팀</td>
				<td>2018.05.01</td>
				<td>112</td>
			</tr>
			<tr>
				<td>2</td>
				<td class="point1">채용소식</td>
				<td class="subject"><a href="sub4_2_1_2.jsp">제목이 들어갑니다.</a></td>
				<td>경영지원팀</td>
				<td>2018.05.01</td>
				<td>112</td>
			</tr>
			<tr>
				<td>1</td>
				<td class="point1">공지사항</td>
				<td class="subject"><a href="sub4_2_1_2.jsp">제목이 들어갑니다.</a></td>
				<td>경영지원본부</td>
				<td>2018.05.01</td>
				<td>112</td>
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