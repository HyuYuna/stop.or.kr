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
				<li>
					<a class="label" href="sub1_4.jsp">경영기획본부</a>
					<ul class="depth4">
						<li><p class="label">직장 내 성희롱 성폭력 신고센터</p></li>
						<li><p class="label">디지털 성범죄 피해자 지원센터</p></li>
					</ul>
				</li>
				<li><a class="label" href="sub1_4_2.jsp">성매매방지중앙지원센터 </a></li>
				<li>
					<a class="label" href="sub1_4_3.jsp">성폭력방지본부</a>
					<ul class="depth4">
						<li><p class="label">일본군 ‘위안부’ 문제 연구소</p></li>
					</ul>
				</li>
				<li>
					<a class="label" href="sub1_4_4.jsp">가정폭력방지본부</a>
					<ul class="depth4">
						<li><p class="label">여성긴급전화1366 중앙센터</p></li>
					</ul>
				</li>
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

<!-- 20180822 추가 -->
<h2 class="title1">직원검색</h2>
<div class="board-search org-search">
	<select name="" id="" title="검색 구분">
		<option value="">제목</option>
	</select>
	<input title="검색어" type="text">
	<a href="" class="btn">검색</a>
</div>
<!-- //20180822 추가 -->

<ul class="tabmenu">
	<li class="active"><a href="#tab1">경영기획본부</a></li>
	<li><a href="#tab2">성매매방지중앙지원센터 </a></li>
	<li><a href="#tab3">성폭력방지본부</a></li>
	<li><a href="#tab4">가정폭력방지본부</a></li>
</ul>
<div id="tab1" class="tab-con">
	<h2 class="title1">경영기획본부</h2>
	<h3 class="title2">상임이사</h3>
	<div class="table-wrap">
		<table>
			<caption>상임이사 - 성명, 담당업무, 연락처</caption>
			<thead>
				<tr>
					<th scope="col">성명</th>
					<th scope="col">담당업무</th>
					<th scope="col">연락처</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>원장 변혜정</td>
					<td>한국여성인권진흥원 총괄</td>
					<td>02-735-0160</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<h3 class="title2">경영기획본부</h3>
	<div class="table-wrap">
		<table>
			<caption>경영기획본부 - 구분/팀명, 성명, 담당업무, 연락처</caption>
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
					<td>김지혜</td>
					<td>본부 총괄</td>
					<td>02-735-0161</td>
				</tr>
				<tr>
					<td rowspan="5">전략기획팀</td>
					<td>팀장 최선화</td>
					<td>전략기획팀 총괄</td>
					<td>02-735-5165</td>
				</tr>
				<tr>
					<td>김자영</td>
					<td>사업 기획 및 조정, 중장기계획, 경영평가, 성과관리, 열린혁신 추진, 자문위원단운영</td>
					<td>02-735-5166</td>
				</tr>
				<tr>
					<td>윤형석</td>
					<td>국회, 윤리경영 및 감사반 운영, 제규정 관리</td>
					<td>02-735-5167</td>
				</tr>
				<tr>
					<td>고은정</td>
					<td>이후 포럼, 직원교육, 기록물 관리, 폭력예방조치 이행</td>
					<td>02-735-5168</td>
				</tr>
				<tr>
					<td>박주현</td>
					<td>직원 동아리 운영, 경력 증명서 발급, 전략기획팀 업무지원</td>
					<td>02-735-8991</td>
				</tr>
				<tr>
					<td rowspan="10">경영지원팀</td>
					<td>팀장 변주연</td>
					<td>경영지원팀 총괄</td>
					<td>02-735-5180</td>
				</tr>
				<tr>
					<td>김희주</td>
					<td>인사관리 실무 총괄, 노사협의회 운영지원, 경영공시</td>
					<td>02-735-5181</td>
				</tr>
				<tr>
					<td>최유진</td>
					<td>채용 및 퇴직, 노무 및 복무, 가족친화제도, 시설자원관리 등 자산관리</td>
					<td>02-735-5186</td>
				</tr>
				<tr>
					<td>이소민</td>
					<td>시설자원관리 지원, 경영지원팀 업무지원</td>
					<td>02-735-5183</td>
				</tr>
				<tr>
					<td>주미란</td>
					<td>계약, 구매, 지정기부금 관리</td>
					<td>02-735-5184</td>
				</tr>
				<tr>
					<td>이기연</td>
					<td>기관 및 경영기획본부 세무/회계/결산</td>
					<td>02-735-5185</td>
				</tr>
				<tr>
					<td>김재아</td>
					<td>성매매방지중앙지원센터 세무/회계/결산</td>
					<td>02-735-5187</td>
				</tr>
				<tr>
					<td>김연정</td>
					<td>성폭력방지본부 세무/회계/결산</td>
					<td>02-735-5188</td>
				</tr>
				<tr>
					<td>송슬기</td>
					<td>가정폭력방지본부 세무/회계/결산</td>
					<td>02-735-5189</td>
				</tr>
				<tr>
					<td>박지선</td>
					<td>가정폭력방지본부 세무/회계/결산</td>
					<td>02-735-5193</td>
				</tr>
				<tr>
					<td rowspan="8">대외홍보팀</td>
					<td>팀장 류혜진</td>
					<td>대외홍보팀 총괄</td>
					<td>02-735-7360</td>
				</tr>
				<tr>
					<td>강명숙</td>
					<td>여성폭력 관련 콘텐츠 개발</td>
					<td>02-735-7361</td>
				</tr>
				<tr>
					<td>김정은</td>
					<td>대외홍보, 기관 홍보 브랜드 개발, 홍보 매체 운영</td>
					<td>02-735-7363</td>
				</tr>
				<tr>
					<td>현이슬</td>
					<td>홍보 매체 운영, 여성폭력 관련 콘텐츠 개발</td>
					<td>02-735-7367</td>
				</tr>
				<tr>
					<td>곽혜경</td>
					<td>정보보안 및 개인정보 관리, 정보시스템 관리, 일반보안</td>
					<td>02-735-8990</td>
				</tr>
				<tr>
					<td>김다빈</td>
					<td>정보시스템 관리, 개인정보 관리, 공공기관 창구 운영</td>
					<td>02-735-8992</td>
				</tr>
				<tr>
					<td>정지은</td>
					<td>정보시스템 관리, 개인정보 관리, 정보자원관리</td>
					<td>02-735-7386</td>
				</tr>
				<tr>
					<td>김유진</td>
					<td>여성폭력 관련 콘텐츠 개발, 대외홍보팀 업무지원</td>
					<td>02-735-7376</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<div id="tab2" class="tab-con">
콘텐츠2
</div>
<div id="tab3" class="tab-con">
콘텐츠3
</div>
<div id="tab4" class="tab-con">
콘텐츠4
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>