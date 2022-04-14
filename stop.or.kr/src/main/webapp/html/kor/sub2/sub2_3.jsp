<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb2.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="주요사업" />
	<jsp:param name="path" value="교육사업" />
	<jsp:param name="path" value="직무 관련 교육" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<ul class="bookmark">
	<li><a href="#group1">국방부 협력사업</a></li>
	<li><a href="#group2">가정폭력 사건대응 역량강화 사업</a></li>
	<li><a href="#group3">기술매개 젠더기반폭력 방지 전문상담원 교육</a></li>
</ul>

<article id="group1">
	<h2 class="title1">국방부 협력사업</h2>
	<div class="table-wrap board-write">
		<table>
			<caption>국방부 협력사업 - 사업목적, 주요내용</caption>
			<colgroup>
				<col width="20%" />
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">사업목적</th>
					<td class="txt-left">군 상담원의 군대 내 성폭력 피해지원 전문성 강화와 장병의 인식개선 및 성폭력 피해지원 체계 안내</td>
				</tr>
				<tr>
					<th scope="row">주요내용</th>
					<td class="txt-left">
						<ul class="bul1">
							<li>
								군대내 성폭력 피해지원 담당자 교육 2회
								<ul class="bul2">
									<li>대상 : 성고충전문상담관(기존 인력 1회, 신규 인력 1회)</li>
								</ul>
							</li>
							<li>장병용 성폭력 피해지원 책자 제작 1종</li>
						</ul>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</article>

<article id="group2">
	<h2 class="title1">가정폭력 사건대응 역량강화 사업</h2>
	<div class="table-wrap board-write">
		<table>
			<caption>가정폭력 사건대응 역량강화 사업 - 사업목적, 주요내용</caption>
			<colgroup>
				<col width="20%" />
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">사업목적</th>
					<td class="txt-left">가정폭력 사건 초기대응과정에서 경찰과 피해자 지원기관 간 협업 체계 강화 </td>
				</tr>
				<tr>
					<th scope="row">주요내용</th>
					<td class="txt-left">
						<ul class="bul1">
							<li>가정폭력방지 네트워크 회의 (연중)</li>
							<li>권역별 경찰·가정폭력 피해자 지원기관 협업 워크숍 등 (연중)</li>
						</ul>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</article>

<article id="group3">
	<h2 class="title1">기술매개 젠더기반폭력 방지 전문상담원 교육</h2>
	<div class="table-wrap board-write">
		<table>
			<caption>기술매개 젠더기반폭력 방지 전문상담원 교육 - 사업목적, 주요내용</caption>
			<colgroup>
				<col width="20%" />
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">사업목적</th>
					<td class="txt-left">기술 발전에 따른 젠더기반폭력의 변화 양상 이해 및 피해자 지원 실무 역량 강화를 통한 폭력 피해 지원의 사각지대 해소</td>
				</tr>
				<tr>
					<th scope="row">주요내용</th>
					<td class="txt-left">
						<ul class="bul1">
							<li>교육 기간 : &lt;1기&gt; 2018. 2. 23.(금)~2018. 3. 31.(토), 총 18차</li>
							<li>교육 대상 : 여성폭력피해자지원기관 종사자 등</li>
							<li>
								교육 내용 : 기초&middot;전문이론&middot;전문실무과정 100시간 교육
								<ul class="bul2">
									<li>기초과정 : ‘4차 산업혁명의 이해와 미래’, ‘사이버 공간에서의 십대와 젠더’, ‘디지털 시민성과 윤리성 개념’ 등</li>
									<li>전문이론과정 : ‘기술매개 젠더기반폭력: 성폭력, 온라인 그루밍, 성매매 등’, ‘기술매개 혐오 및 차별 발언’, 관련 법제 동향 등</li>
									<li>전문실무과정 : ‘기술매개 젠더기반폭력 대응방안’, ‘피해자 지원 실무 및 실습’ 등</li>
								</ul>
							</li>
						</ul>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</article>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>