<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb2.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="주요사업" />
	<jsp:param name="path" value="현장지원사업" />
	<jsp:param name="path" value="피해자지원 실적 및 성과관리" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<ul class="bookmark">
	<li><a href="#group1">해바라기센터 실적관리</a></li>
	<li><a href="#group2">여성긴급전화1366 실적관리</a></li>
</ul>

<article id="group1">
	<h2 class="title1">해바라기센터 실적관리</h2>
	<div class="table-wrap board-write">
		<table>
			<caption>해바라기센터 실적관리 - 사업목적, 주요내용</caption>
			<colgroup>
				<col width="20%" />
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">사업목적</th>
					<td class="txt-left">해바라기센터 실적 통계 관리를 통한 피해자 지원 동향보고 및 실적홍보</td>
				</tr>
				<tr>
					<th scope="row">주요내용</th>
					<td class="txt-left">
						<ul class="bul1">
							<li>
								해바라기센터 실적관리
								<ul class="bul2">
									<li>해바라기센터, 지자체, 여성가족부 요청에 따른 실적 자료 작성․제공</li>
								</ul>
							</li>
							<li>해바라기센터 운영실적 보고자료 작성(상/하반기)</li>
						</ul>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</article>

<article id="group2">
	<h2 class="title1">여성긴급전화1366 실적관리</h2>
	<div class="table-wrap board-write">
		<table>
			<caption>여성긴급전화1366 실적관리 - 사업목적, 주요내용</caption>
			<colgroup>
				<col width="20%" />
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">사업목적</th>
					<td class="txt-left">여성폭력방지 및 피해자 초기지원 실적 분석을 통해 여성폭력방지 정책 개발을 위한 기초현황자료 마련</td>
				</tr>
				<tr>
					<th scope="row" rowspan="2">주요내용</th>
					<td class="txt-left">
						<h3 class="title2">여성긴급전화1366 실적관리</h3>
						<ul class="bul1">
							<li>여성긴급전화1366 전국센터 상담실적 관리(연중) 및 보고(주간·월간·분기·연간 보고)</li>
							<li>국회 및 부처 등 외부 요구자료 대응 </li>
						</ul>
					</td>
				</tr>
				<tr>
					<td class="txt-left">
						<h3 class="title2">여성폭력 피해자 초기지원현황보고서 발행(1종) </h3>
						<ul class="bul1">
							<li>여성긴급전화 1366 운영 현황, 전국 상담통계 및 분석, 지역센터별 상담실적 및 특화사업 운영실적 등</li>
						</ul>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</article>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>