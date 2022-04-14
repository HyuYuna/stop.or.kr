<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb1.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="진흥원소개" />
	<jsp:param name="path" value="오시는 길" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<div class="map">
	<div class="item">
		<!--
			* Daum 지도 - 약도서비스
			* 한 페이지 내에 약도를 2개 이상 넣을 경우에는
			* 약도의 수 만큼 소스를 새로 생성, 삽입해야 합니다.
		-->
		<!-- 1. 약도 노드 -->
		<div id="daumRoughmapContainer1530511617413" class="root_daum_roughmap root_daum_roughmap_landing"></div>
		
		<!-- 2. 설치 스크립트 -->
		<script charset="UTF-8" class="daum_roughmap_loader_script" src="http://dmaps.daum.net/map_js_init/roughmapLoader.js"></script>
		
		<!-- 3. 실행 스크립트 -->
		<script charset="UTF-8">
			new daum.roughmap.Lander({
				"timestamp" : "1530511617413",
				"key" : "ouby",
				"mapWidth" : "990",
				"mapHeight" : "520"
			}).render();
		</script>
	</div>
</div>
<p class="location">주소 : 2호선 충정로 4번 출구에서 약 100m 전방, 글로리아진스 커피전문점 건물 3층</p>

<h2 class="title1">지하철</h2>
<ul class="bul1">
	<li>2호선 <span class="icon2 bus1">초록색박스</span> 5호선 <span class="icon2 bus2">보라색박스</span> 충정로역 4번 출구, 약 200m 직진</li>
</ul>

<h2 class="title1">버스</h2>
<div class="table-wrap">
	<table>
		<caption>버스 - 정류장, 노선번호</caption>
		<colgroup>
			<col class="part" />
			<col width="200px" />
			<col />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">정류장</th>
				<th scope="col" colspan="2">노선번호</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="point1" rowspan="3">한국경제신문사</td>
				<td class="point1">
					간선
					<span class="icon2 bus3">파란색박스</span>
				</td>
				<td class="txt-left">370, 603</td>
			</tr>
			<tr>
				<td class="point1">
					지선
					<span class="icon2 bus4">초록색박스</span>
				</td>
				<td class="txt-left">7011, 7013A, 7013B, 7017</td>
			</tr>
			<tr>
				<td class="point1">
					공항
					<span class="icon2 bus5">하늘색박스</span>
				</td>
				<td class="txt-left">6015, 6021</td>
			</tr>
			<tr>
				<td class="point1" rowspan="3">종근당·충정로역</td>
				<td class="point1">
					간선
					<span class="icon2 bus3">파란색박스</span>
				</td>
				<td class="txt-left">172, 472, 603, N62</td>
			</tr>
			<tr>
				<td class="point1">
					지선
					<span class="icon2 bus4">초록색박스</span>
				</td>
				<td class="txt-left">7011, 7013A, 7013B, 7017</td>
			</tr>
			<tr>
				<td class="point1">
					광역
					<span class="icon2 bus6">빨간색박스</span>
				</td>
				<td class="txt-left">1000, 1100, 1101, 1200, 1300, 1301, 1302, 1400, 1500, 1601, 1800</td>
			</tr>
			<tr>
				<td class="point1" rowspan="3">경찰청</td>
				<td class="point1">
					간선
					<span class="icon2 bus3">파란색박스</span>
				</td>
				<td class="txt-left">471, 701, 704, 750A, 750B, 751, 752</td>
			</tr>
			<tr>
				<td class="point1">
					지선
					<span class="icon2 bus4">초록색박스</span>
				</td>
				<td class="txt-left">7021, 7024</td>
			</tr>
			<tr>
				<td class="point1">
					공항
					<span class="icon2 bus5">하늘색박스</span>
				</td>
				<td class="txt-left">6005</td>
			</tr>
		</tbody>
	</table>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>