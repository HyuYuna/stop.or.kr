<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb3.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="정보공개" />
	<jsp:param name="path" value="경영공시" />
	<jsp:param name="path" value="사업실명제" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<div class="box1">
	<span class="bg"><img src="../../../images/kor/sub/bg3.gif" alt=""></span>
	<p class="txt">
		공공기관이 사업을 결정·집행하는 과정에서 담당자 및 참여자의 실명과 의견을 기록·관리함으로써 
		사업의 투명성을 확보하고 담당 직원의 책임성을 높이기 위해 한국여성인권진흥원에서 운영하는 제도입니다.
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