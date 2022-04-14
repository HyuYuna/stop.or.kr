<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb3.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="정보공개" />
	<jsp:param name="path" value="경영공시" />
	<jsp:param name="path" value="정보공개목록" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<ul class="tabmenu">
	<li><a href="sub3_2.jsp">정보공개 제도</a></li>
	<li class="active"><a href="sub3_2_1_2.jsp">정보공개 제도 주요내용</a></li>
	<li><a href="sub3_2_1_3.jsp">정보공개 청구 절차</a></li>
	<li><a href="sub3_2_1_4.jsp">불복구제 절차 및 방법</a></li>
	<li><a href="sub3_2_1_5.jsp">비공개 대상 세부기준</a></li>
</ul>

<h2 class="title1">정보공개 제도 주요 내용</h2>

<div class="table-wrap board-write txt-left">
	<table>
		<caption>정보공개 제도 주요 내용 - 정보공개 청구, 사전 공표 정보, 원문정보 공개</caption>
		<colgroup>
			<col width="20%" />
			<col />
		</colgroup>
		<tbody>
		<tr>
			<th scope="row">01. 정보공개 청구</th>
			<td class="txt-left">
				<ul class="bul1">
					<li>정보공개 청구는 공공기관이 보유한 정보를 청구인의 청구에 의해 공개하는 제도입니다. 
						<div>
							<p><em class="point1">&lt;청구인&gt;</em></p>
							<ul>
								<li>모든 국민 : 모든 국민은 청구인 본인 또는 그 대리인을 통하여 공공기관에 정보공개를 <br>청구할 수 있습니다.</li>
								<li>법인 · 단체 : 법인과 단체의 경우 대표자의 명의로 공공기관에 정보공개를 청구할 수 있습니다.</li>
								<li>외국인 : 국내에 일정한 주소를 두고 거주하거나, 학술·연구를 위하여 일시적으로 체류하는자, 국내에 사무소를 두고 있는 법인 또는 단체에 한해 정보공개를 청구할 수 있습니다.</li>
							</ul>
						</div>
						<div>
							<p><em class="point1">&lt;대상기관&gt;</em></p>
							<ul>
								<li>국가기관
									<ul>
										<li>국회, 법원, 헌법재판소, 중앙선거관리위원회(해당기관에 직접청구)</li>
										<li>중앙행정기관(대통령 소속 기관과 국무총리 소속 기관을 포함) 및 그 소속 기관</li>
										<li>「행정기관 소속 위원회의 설치·운영에 관한 법률」에 따른 위원회</li>
									</ul>
								</li>
								<li>지방자치단체</li>
								<li>「공공기관의 운영에 관한 법률」 제2조에 따른 공공기관</li>
								<li>그 밖에 대통령령으로 정하는 기관</li>
							</ul>
						</div>
						<div>
							<p><em class="point1">&lt;청구 가능 정보&gt;</em></p>
							<ul>
								<li>공공기관이 직무상 작성 또는 취득하여 관리하고 있는 문서(전자문서 포함) · 도면 · 사진 · 필름 · 테이프 · 슬라이드 및 기타 이에 준하는 매체 등에 기록된 사항</li>
								<li>공공기관의 기록물관리에 관한 법률상 기록물과의 관계 : "공공기관이 업무와 관련하여 생산 또는 접수한 문서 · 도서 · 대장 · 카드 · 도면 · 시청각물 · 전자문서 등 모든 형태의 기록정보자료"인 기록물은 모두 정보공개청구의 대상이 되는 정보에 해당합니다. </li>

							</ul>
						</div>
					</li>
				</ul>	
			</td>
		</tr>
		<tr class="even">
			<th scope="row">02. 사전 공표 정보</th>
			<td class="txt-left">
				<ul class="bul1">
					<li>사전공표 정보는 국민들이 정보공개를 청구하기 전에 국민이 필요로 하는 정보를 선제적·능동적 공개하는 제도입니다. 
						<div>
							<p><em class="point1">&lt;사전공표정보 대상&gt;</em></p>
							<ul>
								<li>비공개 대상 정보 외에 국민이 알아야 할 필요가 있는 모든  정보<br>(공공기관의 정보공개에 관한 법률 제7조 제1항 및 제2항)
									<ul>
										<li>국민생활에 매우 큰 영향을 미치는 정책에 관한 정보</li>
										<li>국가의 시책으로 시행하는 공사(工事) 등 대규모 예산이 투입되는 사업에 관한 정보</li>
										<li>예산집행의 내용과 사업평가 결과 등 행정감시를 위하여 필요한 정보</li>
										<li>그 밖에 공공기관의 장이 정하는 정보</li>
									</ul>
								</li>
							</ul>
							<p><em class="point1">&lt;사전공표정보 공표 방법&gt;</em></p>
							<ul>
								<li>각 기관 홈페이지를 통해 최신정보를 공개합니다. 정보공개시스템에서는 각 기관의 사전공표정보의 목록을 제공합니다. </li>
							</ul>
						</div>
					</li>
				</ul>	
			</td>
		</tr>
		<tr>
			<th scope="row">03. 원문정보 공개</th>
			<td class="txt-left">
				<ul class="bul1">
					<li>원문정보 공개는 공무원이 업무 중 생산한 정보를 공개 문서에 대해 별도의 국민의 청구가 없더라도 정보공개시스템을 통해 공개하는 제도입니다. 
						<div>
							<p><em class="point1">&lt;연도별 원문공개 대상 기관&gt;</em></p>
							<div class="table-wrap">
								<table>
									<caption>원문공개 대상기관 - 년도별 원문정보공개 연계 대상기관 목록입니다.</caption>
									<colgroup>
										<col width="20%">
										<col width="80%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">연도</th>
											<th scope="col">원문공개 대상 기관</th>
								
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="txt-left"><b>2014년 3월</b></td>
											<td class="txt-left">
												<ul>
													<li>온-나라시스템 이용기관(중앙 부처, 광역시도, 시군구)</li>
												</ul>
											</td>
										</tr>
										<tr>
											<td class="txt-left"><b>2015년 3월</b></td>
											<td class="txt-left">
												<ul>
													<li>17개 시도 교육청</li>
													<li>전자결재시스템 이용 시군구</li>
													<li>표준 기록관리시스템 이용기관(중앙 부처, 광역시도, 시군구, 교육청)</li>
												</ul>
											</td>
										</tr>
										<tr>
											<td class="txt-left"><b>2016년 3월<br>이후</b></td>
											<td class="txt-left">
												<ul>
													<li>공사/공단 전자결재시스템 이용기관</li>
													<li>자료관, 문서함등 기록관리시스템 이용기관</li>
													<li>기타 이용 기관</li>
								
												</ul>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</li>
				</ul>
			</td>
		</tr>
	</tbody>
	</table>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>