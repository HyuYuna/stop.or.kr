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
	<li class="active"><a href="sub1_4_3.jsp">성폭력방지본부</a></li>
	<li><a href="sub1_4_4.jsp">가정폭력방지본부</a></li>
</ul>

<h2 class="title1">경영기획본부</h2>
<h3 class="title2">성폭력방지본부</h3>
<div class="table-wrap">
	<table>
		<caption>성폭력방지본부 - 구분/팀명, 성명, 담당업무, 연락처</caption>
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
				<td>윤선영</td>
				<td>본부 총괄</td>
				<td>02-735-7505</td>
			</tr>
			<tr>
				<td rowspan="5">현장지원팀</td>
				<td>팀장 장미정</td>
				<td>현장지원팀 총괄</td>
				<td>02-735-7506</td>
			</tr>
			<tr>
				<td>신소라</td>
				<td>국회, 해바라기센터 평가 및 컨설팅</td>
				<td>02-735-7507</td>
			</tr>
			<tr>
				<td>윤재은</td>
				<td>해바라기센터 운영지원사업,해바라기센터 상담통계 실적 관리</td>
				<td>02-735-7513</td>
			</tr>
			<tr>
				<td>황진주</td>
				<td>해바라기센터 운영지원사업,해바라기센터 질의응답</td>
				<td>02-735-7515</td>
			</tr>
			<tr>
				<td>민금양</td>
				<td>현장지원팀 업무지원</td>
				<td>02-735-7516</td>
			</tr>
			<tr>
				<td rowspan="7">교육팀</td>
				<td>팀장 정유진</td>
				<td>교육팀 총괄</td>
				<td>02-735-7517</td>
			</tr>
			<tr>
				<td>김보경</td>
				<td>지역네트워크 구축협력사업, 종사자연구 및 매뉴얼 개발</td>
				<td>02-735-7529</td>
			</tr>
			<tr>
				<td>박지영</td>
				<td>종사자 보수교육</td>
				<td>02-735-7532</td>
			</tr>
			<tr>
				<td>황미희</td>
				<td>일본군 위안부 치료사업</td>
				<td>02-735-8995</td>
			</tr>
			<tr>
				<td>하진주</td>
				<td>일본군 위안부 치료사업</td>
				<td>02-735-8996</td>
			</tr>
			<tr>
				<td>주민경</td>
				<td>일본군 위안부 공모사업</td>
				<td>02-735-7537</td>
			</tr>
			<tr>
				<td>박혜연</td>
				<td>일본군 위안부 치료사업 업무지원</td>
				<td>02-735-7519</td>
			</tr>
		</tbody>
	</table>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>