<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb1.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="진흥원소개" />
	<jsp:param name="path" value="조직도" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<div class="org">
	<ul>
		<li class="depth1">
			<p class="label">이사회</p>
			<p class="label">감사</p>
		</li>
		<li class="depth2">
			<p class="label">원장(상임이사)</p>
		</li>
		<li class="depth3">
			<ul>
				<li><a class="label" href="sub1_4.jsp">경영기획본부</a></li>
				<li><a class="label" href="sub1_4_2.jsp">성매매방지중앙지원센터 </a></li>
				<li><a class="label" href="sub1_4_3.jsp">성폭력방지본부</a></li>
				<li><a class="label" href="sub1_4_4.jsp">가정폭력방지본부</a></li>
			</ul>
		</li>
	</ul>
</div>

<h2 class="title1">대표연락처</h2>
<ul class="bul1">
	<li>대표전화 : 02) 735-1050</li>
	<li>팩스 : 02) 735-2051</li>
	<li>이메일 : webmaster@stop.or.kr</li>
</ul>

<ul class="tabmenu">
	<li><a href="sub1_4.jsp">경영기획본부</a></li>
	<li><a href="sub1_4_2.jsp">성매매방지중앙지원센터 </a></li>
	<li><a href="sub1_4_3.jsp">성폭력방지본부</a></li>
	<li class="active"><a href="sub1_4_4.jsp">가정폭력방지본부</a></li>
</ul>

<h2 class="title1">경영기획본부</h2>
<h3 class="title2">가정폭력방지본부</h3>
<div class="table-wrap">
	<table>
		<caption>가정폭력방지본부 - 구분/팀명, 성명, 담당업무, 연락처</caption>
		<colgroup>
			<col width="170px" />
			<col width="150px" />
			<col />
			<col width="180px" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">구분/팀명</th>
				<th scope="col">성명</th>
				<th scope="col">담당업무</th>
				<th scope="col">연락처</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>본부장</td>
				<td>변현주</td>
				<td>본부 총괄</td>
				<td>02-735-7302</td>
			</tr>
			<tr>
				<td rowspan="5">교육팀</td>
				<td>팀장 윤정오</td>
				<td>교육팀 총괄</td>
				<td>02-735-7311</td>
			</tr>
			<tr>
				<td>오연희</td>
				<td>국회, 토론회, 포럼, 가정폭력방지 사건대응 역량강화 폭력피해이주여성 보호시설 종사자 교육</td>
				<td>02-735-7331</td>
			</tr>
			<tr>
				<td>김현정</td>
				<td>여성폭력관련기관 종사자보수교육</td>
				<td>02-735-7353</td>
			</tr>
			<tr>
				<td>이지은</td>
				<td>여성폭력관련기관 종사자보수교육</td>
				<td>02-735-7356</td>
			</tr>
			<tr>
				<td>홍수진</td>
				<td>여성폭력관련기관 종사자보수교육</td>
				<td>02-735-7359</td>
			</tr>
			<tr>
				<td rowspan="3">현장지원팀</td>
				<td>팀장 엄현정</td>
				<td>현장지원팀 총괄</td>
				<td>02-735-7378</td>
			</tr>
			<tr>
				<td>최지연</td>
				<td>상담 매뉴얼 제작</td>
				<td>02-735-7387</td>
			</tr>
			<tr>
				<td>배소리</td>
				<td>신입상담원교육, 운영매뉴얼</td>
				<td>02-735-7398</td>
			</tr>
			<tr>
				<td rowspan="3">여성긴급전화1366 <br />중앙센터 상담팀</td>
				<td>팀장 이인숙</td>
				<td>상담팀 총괄</td>
				<td>02-735-7394</td>
			</tr>
			<tr>
				<td>차현경</td>
				<td>1366 중앙센터 행정</td>
				<td>02-735-7395</td>
			</tr>
			<tr>
				<td>차경숙</td>
				<td>1366 중앙센터 행정</td>
				<td>02-735-7397</td>
			</tr>
		</tbody>
	</table>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>