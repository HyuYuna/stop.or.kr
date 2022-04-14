<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb3.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="정보공개" />
	<jsp:param name="path" value="경영공시" />
	<jsp:param name="path" value="정보공개목록" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<div class="box1">
	<span class="bg"><img src="../../../images/kor/sub/bg2.gif" alt=""></span>
	<p class="txt">
		한국여성인권진흥원의 성매매 방지, 여성·아동폭력 방지, 가정폭력 방지 등 여성인권 관련 다양한 사업내용을 국민들이 알 수 있도록 진흥원의 보유·관리 정보를 공개합니다.
	</p>
</div>

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
				<td>5</td>
				<td class="point1">공지사항</td>
				<td class="subject"><a href="sub4_2_1_2.jsp">미투 운동 이후, 1366 성폭력 상담 51% 올랐다</a><span class="new">새글</span></td>
				<td>경영지원팀</td>
				<td>2018.05.01</td>
				<td>112</td>
			</tr>
			<tr>
				<td>4</td>
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
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>