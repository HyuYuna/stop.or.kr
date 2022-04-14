<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header_zoomin.jsp">
	<jsp:param name="snb" value="zoomin.jsp" />
	<jsp:param name="cont_txt" value="전국 매장 정보와 제공 서비스를 확인하세요. " />
	<jsp:param name="path" value="여성폭력 Zoom-in" />
	<jsp:param name="path" value="지원기관" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<div class="area">
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
					"mapWidth" : "1250",
					"mapHeight" : "960"
				}).render();
			</script>
		</div>
	</div>
	
	<div class="search">
		<select title="지역">
			<option>지역을 선택하세요</option>
		</select>
		
		<select title="시/군/구">
			<option>시/군/구 선택</option>
		</select>
		
		<p class="form">
			<input type="text" placeholder="주소나 센터명을 입력하세요. 예)여성인권진흥원" />
			<a href="" class="btn">검색</a>
		</p>
		
		<p class="txt">지역을 선택 안 해도 검색어만으로 검색하실 수 있습니다.</p>
	</div>
	
	<ul class="tabmenu">
		<li class="active"><a href="">가정폭력상담소</a></li>
		<li><a href="">성매매피해지원기관</a></li>
		<li><a href="">성폭력상담소</a></li>
		<li><a href="">여성긴급전화</a></li>
		<li><a href="">해바라기 센터</a></li>
	</ul>
	
	<article class="result">
		<div class="title">
			<h2>
				<strong>"부산"</strong>
				총 <span>2,243</span>건이 검색되었습니다.
			</h2>
			
			<ul class="category">
				<li class="active"><a href="">지번 주소</a></li>
				<li><a href="">도로명 주소</a></li>
			</ul>
		</div>
		
		<div class="item">
			<ul class="list">
				<li>
					<div>
						<span class="icon1 type4">여성긴급전화</span>
						<h3>1366부산센터</h3>
						<a href="" class="go">홈페이지 바로가기</a>
					</div>
					<p>우) 46204 부산광역시 금정구 중앙대로 2238 (노포동)<br />051-1366 </p>
				</li>
				<li>
					<div>
						<span class="icon1 type5">성매매피해지원기관</span>
						<h3>1366부산센터</h3>
						<a href="" class="go">홈페이지 바로가기</a>
					</div>
					<p>우) 46204 부산광역시 금정구 중앙대로 2238 (노포동)<br />051-1366 </p>
				</li>
				<li>
					<div>
						<span class="icon1 type1">성폭력상담소</span>
						<h3>1366부산센터</h3>
						<a href="" class="go">홈페이지 바로가기</a>
					</div>
					<p>우) 46204 부산광역시 금정구 중앙대로 2238 (노포동)<br />051-1366 </p>
				</li>
				<li>
					<div>
						<span class="icon1 type2">가정폭력상담소</span>
						<h3>1366부산센터</h3>
						<a href="" class="go">홈페이지 바로가기</a>
					</div>
					<p>우) 46204 부산광역시 금정구 중앙대로 2238 (노포동)<br />051-1366 </p>
				</li>
				<li>
					<div>
						<span class="icon1 type3">해바라기센터</span>
						<h3>1366부산센터</h3>
						<a href="" class="go">홈페이지 바로가기</a>
					</div>
					<p>우) 46204 부산광역시 금정구 중앙대로 2238 (노포동)<br />051-1366 </p>
				</li>
			</ul>
		</div>
	</article>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>