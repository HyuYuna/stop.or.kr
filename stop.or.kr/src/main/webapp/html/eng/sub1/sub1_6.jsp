<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb1.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="About Us" />
	<jsp:param name="path" value="Directions" />
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
<p class="location">Address : 3F Central Place, 50 Seosomun-ro, Jung-gu, Seoul, 04505</p>

<h2 class="title1">Subway</h2>
<ul class="bul1">
	<li>Get off at Chungjeongro Station on the Number 2 <span class="icon2 bus1">green</span> and 5 <span class="icon2 bus2">purple</span> line, take Exit 4, and walk straight about 200 meters.</li>
</ul>

<h2 class="title1">Bus</h2>
<div class="table-wrap">
	<table>
		<caption>Bus - Bus stop, Bus numbers</caption>
		<colgroup>
			<col width="250px" />
			<col width="250px" />
			<col />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">Bus stop</th>
				<th scope="col" colspan="2">Bus numbers</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="point1" rowspan="3">The Korea <br />Economic Daily Station </td>
				<td class="txt-left point1">
					<span class="icon2 bus3">blue</span>
					Long-distance buses 
				</td>
				<td class="txt-left">370, 603</td>
			</tr>
			<tr>
				<td class="txt-left point1">
					<span class="icon2 bus4">green</span>
					Local buses 
				</td>
				<td class="txt-left">7011, 7013A, 7013B, 7017</td>
			</tr>
			<tr>
				<td class="txt-left point1">
					<span class="icon2 bus5">sky</span>
					Airport buses 
				</td>
				<td class="txt-left">6015, 6021</td>
			</tr>
			<tr>
				<td class="point1" rowspan="3">Chong Kun Dang <br />Chungjeongro Station</td>
				<td class="txt-left point1">
					<span class="icon2 bus3">blue</span>
					Long-distance buses 
				</td>
				<td class="txt-left">172, 472, 603, N62</td>
			</tr>
			<tr>
				<td class="txt-left point1">
					<span class="icon2 bus4">green</span>
					Local buses 
				</td>
				<td class="txt-left">7011, 7013A, 7013B, 7017</td>
			</tr>
			<tr>
				<td class="txt-left point1">
					<span class="icon2 bus6">red</span>
					Gwangyeok buses
				</td>
				<td class="txt-left">1000, 1100, 1101, 1200, 1300, 1301, 1302, 1400, 1500, 1601, 1800</td>
			</tr>
			<tr>
				<td class="point1" rowspan="3">The Korea National <br />Police Agency Station</td>
				<td class="txt-left point1">
					<span class="icon2 bus3">blue</span>
					Long-distance buses 
				</td>
				<td class="txt-left">471, 701, 704, 750A, 750B, 751, 752</td>
			</tr>
			<tr>
				<td class="txt-left point1">
					<span class="icon2 bus4">green</span>
					Local buses 
				</td>
				<td class="txt-left">7021, 7024</td>
			</tr>
			<tr>
				<td class="txt-left point1">
					<span class="icon2 bus5">sky</span>
					Airport buses 
				</td>
				<td class="txt-left">6005</td>
			</tr>
		</tbody>
	</table>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>