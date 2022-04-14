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
	<li class="active"><a href="sub1_4_2.jsp">성매매방지중앙지원센터 </a></li>
	<li><a href="sub1_4_3.jsp">성폭력방지본부</a></li>
	<li><a href="sub1_4_4.jsp">가정폭력방지본부</a></li>
</ul>

<h2 class="title1">경영기획본부</h2>
<h3 class="title2">성매매방지중앙지원센터</h3>
<div class="table-wrap">
	<table>
		<caption>성매매방지중앙지원센터 - 구분/팀명, 성명, 담당업무, 연락처</caption>
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
				<td>센터장</td>
				<td>변혜정</td>
				<td>센터장 겸직</td>
				<td>02-735-0160</td>
			</tr>
			<tr>
				<td rowspan="4">정책사업팀</td>
				<td>팀장 정양희</td>
				<td>정책사업팀 총괄</td>
				<td>02-735-1902</td>
			</tr>
			<tr>
				<td>김수진</td>
				<td>여성과 인권 발간, 성과척도 개발 및 운영</td>
				<td>02-735-1904</td>
			</tr>
			<tr>
				<td>김민경</td>
				<td>국제네트워크, ODA사업</td>
				<td>02-735-1905</td>
			</tr>
			<tr>
				<td>정수아</td>
				<td>ODA사업, 정책토론회</td>
				<td>02-735-1906</td>
			</tr>
			<tr>
				<td rowspan="4">현장지원팀</td>
				<td>팀장 강현숙</td>
				<td>현장지원팀 총괄</td>
				<td>02-735-1451</td>
			</tr>
			<tr>
				<td>조순애</td>
				<td>성매매방지 콘텐츠 공모전, 성매매추방주간 홍보사업</td>
				<td>02-735-1452</td>
			</tr>
			<tr>
				<td>김정미</td>
				<td>시설역량강화, 지원실적 및 이용자 만족도 조사, 평가지표 개발</td>
				<td>02-735-1453</td>
			</tr>
			<tr>
				<td>주해은</td>
				<td>유관기관 네트워크 사업, 성매매피해자 자활매장 지원사업</td>
				<td>02-735-1454</td>
			</tr>
			<tr>
				<td rowspan="4">교육팀</td>
				<td>팀장 변정애</td>
				<td>교육팀 총괄</td>
				<td>02-735-1505</td>
			</tr>
			<tr>
				<td>김지윤</td>
				<td>성매매방지기관 종사자 양성교육, 성매매방지기관 대표자 워크숍</td>
				<td>02-735-1507</td>
			</tr>
			<tr>
				<td>박신영</td>
				<td>중앙위기청소년교육센터 운영</td>
				<td>02-735-1508</td>
			</tr>
			<tr>
				<td>이경숙</td>
				<td>중앙위기청소년교육센터 회계</td>
				<td>02-735-1509</td>
			</tr>
		</tbody>
	</table>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>