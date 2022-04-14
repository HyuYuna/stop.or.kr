<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb3.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="정보공개" />
	<jsp:param name="path" value="경영공시" />
	<jsp:param name="path" value="정기/수시공시" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<div class="gov">
	<article class="group">
		<h2 class="title1">I. 일반현황</h2>
		<ul class="depth1">
			<li><a href="http://www.alio.go.kr/popReportTerm.do?apbaId=C0902&reportFormRootNo=10101" target="_blank" class="icon-link">일반현황</a></li>
		</ul>
	</article>

	<article class="group">
		<h2 class="title1">II. 기관운영</h2>
		<ul class="depth1">
			<li><a href="http://www.alio.go.kr/popReportTerm.do?apbaId=C0902&reportFormRootNo=2020" target="_blank" class="icon-link">임직원수 현황</a></li>
			<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0902&reportFormRootNo=20305" target="_blank" class="icon-link">임원 현황</a></li>
			<li><a href="http://www.alio.go.kr/popReportTerm.do?apbaId=C0902&reportFormRootNo=2040" target="_blank" class="icon-link">신규채용,유연근무,청년인턴    채용 현황</a></li>
			<li><a href="http://www.alio.go.kr/popReportTerm.do?apbaId=C0902&reportFormRootNo=2050" target="_blank" class="icon-link">임원 연봉 현황</a></li>
			<li><a href="http://www.alio.go.kr/popReportTerm.do?apbaId=C0902&reportFormRootNo=2060" target="_blank" class="icon-link">직원 평균보수 및 신입사원 초임 현황</a></li>
			<li><a href="http://www.alio.go.kr/popReportTerm.do?apbaId=C0902&reportFormRootNo=20701" target="_blank" class="icon-link">기관장 업무추진비</a></li>
			<li><a href="http://www.alio.go.kr/popReportTerm.do?apbaId=C0902&reportFormRootNo=20801" target="_blank" class="icon-link">복리후생비</a></li>
			<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0902&reportFormRootNo=20905" target="_blank" class="icon-link">임원 국외출장정보</a></li>
			<li>
				노동조합 가입 정보
				<ul class="depth2 bul1">
					<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0902&reportFormRootNo=21025#p_content" target="_blank" class="icon-link">복수노조 교섭창구 단일화 정보</a></li>
					<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0902&reportFormRootNo=21026" target="_blank" class="icon-link">단체협약</a></li>
					<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0902&reportFormRootNo=21027" target="_blank" class="icon-link">임금협약</a></li>
					<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0902&reportFormRootNo=21028" target="_blank" class="icon-link">노사협의회 의결사항</a></li>
				</ul>
			</li>
			<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0902&reportFormRootNo=21110" target="_blank" class="icon-link">내부규정</a></li>
			<li>
				징계제도 운영현황
				<ul class="depth2 bul1">
					<li><a href="http://www.alio.go.kr/popReportTerm.do?apbaId=C0902&reportFormRootNo=2120" target="_blank" class="icon-link">징계처분 결과</a></li>
				</ul>
			</li>
			<li>
				소송 및 소송대리인 현황
				<ul class="depth2 bul1">
					<li><a href="http://www.alio.go.kr/popReportTerm.do?apbaId=C0902&reportFormRootNo=2131" target="_blank" class="icon-link">고문변호사 및 법률자문현황</a></li>
				</ul>
			</li>
		</ul>
	</article>

	<article class="group">
		<h2 class="title1">III. 주요사업 및 경영성과</h2>
		<ul class="depth1">
			<li><a href="http://www.alio.go.kr/popReportTerm.do?apbaId=C0902&reportFormRootNo=3120" target="_blank" class="icon-link">대차대조표 (또는 요약 재무상태표)</a></li>
			<li><a href="http://www.alio.go.kr/popReportTerm.do?apbaId=C0902&reportFormRootNo=3130" target="_blank" class="icon-link">요약 손익계산서 (또는 요약 포괄손익계산서)</a></li>
			<li><a href="http://www.alio.go.kr/popReportTerm.do?apbaId=C0902&reportFormRootNo=31401" target="_blank" class="icon-link">수입 및 지출 현황</a></li>
			<li><a href="http://www.alio.go.kr/popReportTerm.do?apbaId=C0902&reportFormRootNo=31501" target="_blank" class="icon-link">주요사업 현황</a></li>
			<li><a href="http://www.alio.go.kr/popReportTerm.do?apbaId=C0902&reportFormRootNo=3160" target="_blank" class="icon-link">투자집행 현황</a></li>
			<li><a href="http://www.alio.go.kr/popReportTerm.do?apbaId=C0902&reportFormRootNo=31701" target="_blank" class="icon-link">자본금 및 주주현황</a></li>
			<li><a href="http://www.alio.go.kr/popReportTerm.do?apbaId=C0902&reportFormRootNo=3180" target="_blank" class="icon-link">장단기 차입금 현황</a></li>
			<li>
				투자 및 출자 현황 
				<ul class="depth2 bul1">
					<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0902&reportFormRootNo=31925" target="_blank" class="icon-link">퇴직임원 채용현황</a></li>
					<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0902&reportFormRootNo=31935" target="_blank" class="icon-link">대규모 거래내역</a></li>
					<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0902&reportFormRootNo=31965" target="_blank" class="icon-link">신규시설 투자</a></li>
				</ul>
			</li>
			<li><a href="http://www.alio.go.kr/popReportTerm.do?apbaId=C0902&reportFormRootNo=32001" target="_blank" class="icon-link">연간출연 및 증여</a></li>
			<li>
				경영부담비용 추계 
				<ul class="depth2 bul1">
					<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0902&reportFormRootNo=32135" target="_blank" class="icon-link">기타 경영상 부담이 될 사항</a></li>
				</ul>
			</li>
			<li>
				납세정보현황 
				<ul class="depth2 bul1">
					<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0902&reportFormRootNo=32225" target="_blank" class="icon-link">세무확정내역</a></li>
				</ul>
			</li>
			<li><a href="http://www.alio.go.kr/popReportTerm.do?apbaId=C0902&reportFormRootNo=32301" target="_blank" class="icon-link">감사보고서</a></li>
		</ul>
	</article>

	<article class="group">
		<h2 class="title1">IV. 대내외 평가</h2>
		<ul class="depth1">
			<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0902&reportFormRootNo=B1210" target="_blank" class="icon-link">국회지적사항</a></li>
			<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0902&reportFormRootNo=B1220" target="_blank" class="icon-link">감사원/주무부처 지적사항</a></li>
			<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0000&reportFormRootNo=B1230" target="_blank" class="icon-link">경영실적 평가결과</a></li>
			<li><a href="http://www.alio.go.kr/popReportTerm.do?apbaId=C0902&reportFormRootNo=4270" target="_blank" class="icon-link">경영평가 지적사항</a></li>
			<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0000&reportFormRootNo=B1240" target="_blank" class="icon-link">고객만족도 조사결과</a></li>
			<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0000&reportFormRootNo=B1250" target="_blank" class="icon-link">감사직무실적 평가결과</a></li>
			<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0902&reportFormRootNo=43005,43006,43007,43008" target="_blank" class="icon-link">정관, 이사회 회의록, 내부 감사결과</a></li>
		</ul>
	</article>

	<article class="group">
		<h2 class="title1">V. 공지사항</h2>
		<ul class="depth1">
			<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0902&reportFormRootNo=B1050" target="_blank" class="icon-link">경영혁신사례</a></li>
			<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0902&reportFormRootNo=B1020" target="_blank" class="icon-link">임직원 채용공고</a></li>
			<li>
				계약정보(수의계약) 
				<ul class="depth2 bul1">
					<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0902&reportFormRootNo=B1030" target="_blank" class="icon-link">입찰공고</a></li>
				</ul>
			</li>
			<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0902&reportFormRootNo=B1040" target="_blank" class="icon-link">연구보고서</a></li>
			<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0902&reportFormRootNo=B1060" target="_blank" class="icon-link">기타정보공개</a></li>
		</ul>
	</article>

	<article class="group">
		<h2 class="title1">VI. 공공기관 정상화 추진</h2>
		<ul class="depth1">
			<li>주요 12개 기관의 상세부채 정보</li>
			<li>
				<a href="http://www.alio.go.kr/popReportTerm.do?apbaId=C0902&reportFormRootNo=63701" target="_blank" class="icon-link">복리후생 관련 8대항목</a>
				<ul class="depth2 bul1">
					<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0902&reportFormRootNo=63785,63786,63787" target="_blank" class="icon-link">제도운영 상황</a></li>
					<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0902&reportFormRootNo=63788" target="_blank" class="icon-link">노조운영 지원비</a></li>
					<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0902&reportFormRootNo=63789" target="_blank" class="icon-link">영리시설,장비운영권 노조위탁</a></li>
					<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0902&reportFormRootNo=63795" target="_blank" class="icon-link">단체협약상 별도 합의사항</a></li>
					<li><a href="http://www.alio.go.kr/popSusi.do?apbaId=C0902&reportFormRootNo=63796" target="_blank" class="icon-link">단체협약외의 별도 합의사항</a></li>
				</ul>
			</li>
		</ul>
	</article>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>