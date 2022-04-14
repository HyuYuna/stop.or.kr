<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header_contest.jsp">
	<jsp:param name="snb" value="contest.jsp" />
	<jsp:param name="path" value="성매매방지 국민생각 공모전" />
	<jsp:param name="path" value="접수하기" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<h2 class="title1">접수확인</h2>
<div class="table-wrap">
	<table>
		<caption>접수확인 - 접수번호, 분류, 접수일, 첨부파일 확인, 상태</caption>
		<thead>
			<tr>
				<th scope="col">접수번호</th>
				<th scope="col">분류</th>
				<th scope="col">접수일</th>
				<th scope="col">첨부파일 확인</th>
				<th scope="col"><span class="sr-only">상태</span></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>1807090001</td>
				<td>수기</td>
				<td>18. 07. 10</td>
				<td><a href="" class="btn-s btn2">다운로드</a></td>
				<td><span class="icon1 type1">접수완료</span></td>
			</tr>
			<tr>
				<td>1807090001</td>
				<td>포스터</td>
				<td>18. 07. 10</td>
				<td><a href="" class="btn-s btn2">다운로드</a></td>
				<td><span class="icon1 type6">접수대기</span></td>
			</tr>
			<tr>
				<td>1807090001</td>
				<td>캘리그라피</td>
				<td>18. 07. 10</td>
				<td><a href="" class="btn-s btn2">다운로드</a></td>
				<td><span class="icon1 type7">접수반려</span></td>
			</tr>
		</tbody>
	</table>
</div>
<ul class="box1">
	<li>
		<span class="icon1 type1">접수완료</span>
		담당자 확인완료 상태입니다.
	</li>
	<li>
		<span class="icon1 type6">접수대기</span>
		담당자 확인 전 상태입니다.
	</li>
	<li>
		<span class="icon1 type7">접수반려</span>
		해당 사유로 인해 접수가 되지 않은 상태입니다.
	</li>
</ul>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>