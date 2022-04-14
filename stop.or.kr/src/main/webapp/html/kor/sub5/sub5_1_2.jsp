<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb5.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="현장네트워크" />
	<jsp:param name="path" value="기관정보" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<ul class="tabmenu">
	<li><a href="sub5_1.jsp">여성긴급전화 1336</a></li>
	<li class="active"><a href="sub5_1_2.jsp">가정폭력상담소</a></li>
	<li><a href="sub5_1_3.jsp">성폭력피해상담소</a></li>
	<li><a href="sub5_1_4.jsp">성매매피해상담소</a></li>
	<li><a href="sub5_1_5.jsp">해바라기센터</a></li>
</ul>

<h2 class="title1">가정폭력상담소</h2>

<div class="table-wrap">
	<table>
		<caption>가정폭력상담소 - 지역, 기관명, 주소, 연락처</caption>
		<colgroup>
			<col class="hit">
			<col class="part">
			<col />
			<col class="tel">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">지역</th>
				<th scope="col">기관명</th>
				<th scope="col">주소</th>
				<th scope="col">연락처</th>
			</tr>
		</thead>
		<tbody>
			<tr>
			    <td>강원도</td>
			    <td>강릉가정폭력·성폭력상담소(통합)</td>
			    <td class="txt-left">강원도 강릉시 강릉대로    454, 2층</td>
			    <td>033-652-9556</td>
			  </tr>
			  <tr>
			    <td>강원도</td>
			    <td>강릉여성의전화 부설 해솔상담소</td>
			    <td class="txt-left">강원도 강릉시 토성로 162 벽산빌딩 3층</td>
			    <td>033-643-1982</td>
			  </tr>
			  <tr>
			    <td>강원도</td>
			    <td>동해가정폭력성폭력상담소(통합)</td>
			    <td class="txt-left">강원도 동해시 중앙로 188 2층</td>
			    <td>033-535-4943</td>
			  </tr>
			  <tr>
			    <td>강원도</td>
			    <td>삼척종합사회복지관부설<br />삼척가정폭력·성폭력통합상담소(통합)</td>
			    <td class="txt-left">강원 삼척시 원당로2길 72-6</td>
			    <td>033-573-9168</td>
			  </tr>
			  <tr>
			    <td>강원도</td>
			    <td>속초YWCA가정폭력상담소</td>
			    <td class="txt-left">강원도 속초시 번영로 184(영랑동)</td>
			    <td>033-635-3520</td>
			  </tr>
			  <tr>
			    <td>강원도</td>
			    <td>원주가정폭력성폭력통합상담소(통합)</td>
			    <td class="txt-left">강원도 원주시 갈머리2길 31,    307호<br />(학성동,원주시사회복지센터)</td>
			    <td>033-765-1366</td>
			  </tr>
			  <tr>
			    <td>강원도</td>
			    <td>철원가정폭력상담소</td>
			    <td class="txt-left">강원도 철원군 갈말읍 텃골3길 17</td>
			    <td>033-452-1566</td>
			  </tr>
			  <tr>
			    <td>강원도</td>
			    <td>춘천가정폭력성폭력상담소(통합)</td>
			    <td class="txt-left">강원도 춘천시 효자로 135</td>
			    <td>033-257-4687</td>
			  </tr>
			  <tr>
			    <td>강원도</td>
			    <td>태백가정폭력상담소</td>
			    <td class="txt-left">강원도 태백시 보드미길 40</td>
			    <td>031-554-4005</td>
			  </tr>
			  <tr>
			    <td>강원도</td>
			    <td>홍천가족상담소</td>
			    <td class="txt-left">강원도 홍천군 홍천읍 남산마을길1길 8</td>
			    <td>033-433-1367</td>
			  </tr>
			  <tr>
			    <td>강원도</td>
			    <td>행복만들기상담소</td>
			    <td class="txt-left">강원도 횡성군 횡성읍 북천리    115-62번지</td>
			    <td>033-344-1366</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>덕양가정상담센터</td>
			    <td class="txt-left">경기도 고양시 일산동구 장항동 893-1 위너스21빌딩    803호</td>
			    <td>031-965-9119</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>행복한사람들가족상담센터</td>
			    <td class="txt-left">경기도 고양시 일산동구 백석동    1222-5</td>
			    <td>031-903-0691</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>고양YWCA가족사랑상담소</td>
			    <td class="txt-left">경기도 고양시 일산서구 주엽로 134 시대프라자 5층</td>
			    <td>031-921-1366</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>광명여성의전화 부설 가정폭력상담소</td>
			    <td class="txt-left">경기도 광명시 도덕공원로 64-1</td>
			    <td>02-2060-0245</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>광주열린상담소</td>
			    <td class="txt-left">경기도 광주시 광주대로 97번길 18</td>
			    <td>031-766-3395</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>(사)가화부설 가족상담센터</td>
			    <td class="txt-left">경기도 구리시 벌말로129번길 50,    3층</td>
			    <td>031-551-9976</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>구리가정폭력상담소</td>
			    <td class="txt-left">경기도 구리시 딸기원로8번길45(교문동)</td>
			    <td>031-569-0101</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>두레가정폭력상담소</td>
			    <td class="txt-left">경기도 구리시    검배로29번길44(수택동)</td>
			    <td>031-552-8448</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>21가정사랑 훈련학교</td>
			    <td class="txt-left">경기도 군포시 곡란로 8번길 35-10</td>
			    <td>031-391-4862</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>(사)김포여성의전화    <br />부설 가정폭력상담소</td>
			    <td class="txt-left">경기도 김포시 북변중로 68번길 20    종합복지회관 2층</td>
			    <td>031-986-0136</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>남양주가족상담센터</td>
			    <td class="txt-left">경기도 남양주시 평내로161번길 7-7(101호)</td>
			    <td>031-595-1238</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>남양주한마음가족상담소</td>
			    <td class="txt-left">경기도 남양주시 오남읍    진건오남로671번길 24</td>
			    <td>031-574-7189</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>가톨릭가족상담센타</td>
			    <td class="txt-left">경기도 부천시 소사로 656번길21</td>
			    <td>032-683-8241</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>부천가정폭력상담소</td>
			    <td class="txt-left">경기도 부천시 성주로 272 4층</td>
			    <td>032-667-2314</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>행복가정폭력상담소</td>
			    <td class="txt-left">경기도 부천시 원미구 상동 432-3, 4층</td>
			    <td>032-612-1366</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>성남가정폭력상담소</td>
			    <td class="txt-left">경기도 성남시 분당구 판교로546,    1층(야탑동)</td>
			    <td>031-707-6661</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>성남가정폭력상담센터 </td>
			    <td class="txt-left">경기도 성남시 수정구 수정북로 100 (태평동, 동호빌딩    6층)</td>
			    <td>031-751-6677</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>굿패밀리상담센터</td>
			    <td class="txt-left">경기도 성남시 중원구 희망로 356,    5층</td>
			    <td>031-733-0675</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>(사)수원여성의전화 <br />부설 통합상담소(통합)</td>
			    <td class="txt-left">경기도 수원시 팔달구 향교로 161 우림빌딩 704호</td>
			    <td>031-232-7795</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>수원시가정법률상담소<br />부설가정폭력상담소</td>
			    <td class="txt-left">경기도 수원시 팔달구 향교로161,    501호(중동,우림빌딩)</td>
			    <td>031-243-4556</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>시흥여성의전화부설    가정폭력상담소</td>
			    <td class="txt-left">경기도    시흥시 정왕동 마유로 330 대하빌딩 501-502호</td>
			    <td>031-496-9391</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>안산가정폭력상담소</td>
			    <td class="txt-left">경기도 안산시 단원구 광덕동로    71(고잔동)</td>
			    <td>031-486-4366</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>안산상담심리연구소</td>
			    <td class="txt-left">경기도 안산시 단원구 신길로1길 62, 102호(신길동)</td>
			    <td>031-493-8007</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>가톨릭여성상담소</td>
			    <td class="txt-left">경기도 안산시 상록구 한양대학1길 60    대학동성당 내</td>
			    <td>031-415-0117</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>다리꿈상담센터</td>
			    <td class="txt-left">경기도 안산시 상록구 광덕1로 370, 406호<br />(이동,    코로스프라자)</td>
			    <td>031 415 5006</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>안산가정.성폭력통합상담소</td>
			    <td class="txt-left">경기도 안산시 상록구 용신로 164    (사동)</td>
			    <td>031-419-1366</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>안성가정행복상담센터</td>
			    <td class="txt-left">경기도 안성시 현수길 26-14</td>
			    <td>031-671-9191</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>YWCA가정폭력상담소</td>
			    <td class="txt-left">경기도 안양시 동안구 경수대로 604,    2층</td>
			    <td>031-427-1366</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>(사)안양여성의전화부설가정폭력상담소</td>
			    <td class="txt-left">경기도 안양시 만안구 안양로 149, 5층(안양동, 샤인빌딩)</td>
			    <td>031-442-5385</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>가정폭력상담소</td>
			    <td class="txt-left">경기도 양주시 독바위로5. 남양상가    306호.</td>
			    <td>031-864-7545~6</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>양평가정상담소</td>
			    <td class="txt-left">경기도 양평군 양평읍 시민로47</td>
			    <td>031-775-4983</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>여주가정폭력·성폭력상담소</td>
			    <td class="txt-left">경기도 여주시 세종로 45번길 8</td>
			    <td>031-885-7652</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>오산가정폭력상담소</td>
			    <td class="txt-left">경기도 오산시 궐리사로 38 하나빌딩 301호</td>
			    <td>031-372-6043~4</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>사단법인 행복터 부설 용인가정상담센터</td>
			    <td class="txt-left">경기도 용인시 기흥구 구갈로60번길    3, 골드프라자801호</td>
			    <td>031-286-1758</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>의왕가정.성상담소</td>
			    <td class="txt-left">경기도 의왕시 전주남이길 23-4</td>
			    <td>031-459-1311</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>경기북부가정문제상담소</td>
			    <td class="txt-left">경기도 의정부시 장곡로 596번길 19    골드타워 402</td>
			    <td>031-876-7544~5</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>하나가정폭력상담소</td>
			    <td class="txt-left">경기도 의정부시 부용로 95, 701호(금오동,현대프라자)</td>
			    <td>031-852-0142</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>이천가정성상담소</td>
			    <td class="txt-left">경기 이천시 영창로 213 서영빌딩    4층</td>
			    <td>031-638-7200</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>한국가정법률상담소 평택안성지부 <br />부설 가정폭력상담소</td>
			    <td class="txt-left">경기도 평택시 이충로 84-6 여성회관 중1층</td>
			    <td>031-611-4251</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>사)해피패밀리 포천지부 희망가족상담소</td>
			    <td class="txt-left">경기도 포천시 중앙로 119번길 20</td>
			    <td>031-531-2821</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>(사)정해복지부설 <br />하남행복한가정상담소</td>
			    <td class="txt-left">경기도 하남시 신장로 130-5</td>
			    <td>031-794-4111</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>화성가정상담소</td>
			    <td class="txt-left">경기도 화성시 매송면 화성로 2393</td>
			    <td>031-296-1055</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>(사)거제가정상담센터</td>
			    <td class="txt-left">경상남도    거제시 거제중앙로 13길 22</td>
			    <td>055-633-7638</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>고성가족상담소</td>
			    <td class="txt-left">경상남도    고성군 고성읍 중앙로 87-1 <br />정림무지개APT상가2층</td>
			    <td>055-673-2911</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>사)김해여성회부설가정폭력상담소</td>
			    <td class="txt-left">경상남도    김해시 가야의길 92-25</td>
			    <td>055-326-6253</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>장유하늘가족상담센터</td>
			    <td class="txt-left">경상남도    김해시 장유면 계동로 233 마루애 빌딩 503호</td>
			    <td>055-326-8291</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>남해보물섬가정행복상담소</td>
			    <td class="txt-left">경상남도    남해군 남해읍 망운로32</td>
			    <td>055-864-1366</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>사천YWCA건강가정상담소</td>
			    <td class="txt-left">경상남도    사천시 동금로 12, 농협 2층</td>
			    <td>055-834-1253</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>양산가정폭력상담소</td>
			    <td class="txt-left">경상남도    양산시 명동 6길 19</td>
			    <td>055-366-6661</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>양산가족상담센터</td>
			    <td class="txt-left">경상남도    양산시 서일동2길 17</td>
			    <td>055-362-1366</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>진주가정폭력상담소</td>
			    <td class="txt-left">경상남도    진주시 진양호로 360(신안동주민센터 3층)</td>
			    <td>055-746-7988</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>경남가정상담지원센터</td>
			    <td class="txt-left">경상남도    창원시 마산합포구 밤밭고개로 442-2 성대빌딩4층</td>
			    <td>055-221-3308</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>마산가정상담센터</td>
			    <td class="txt-left">경상남도    창원시 마산회원구 양덕옛3길 5(석전동)</td>
			    <td>055-296-9126</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>창원가정상담센터</td>
			    <td class="txt-left">경상남도    창원시 성산구 창이대로 663번길 7, <br />대한빌딩 401호(사파동)</td>
			    <td>055-261-0280</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>진해가정상담센터</td>
			    <td class="txt-left">경상남도    창원시 진해구 태평로 50(태평동)</td>
			    <td>055-551-2332</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>통영가정폭력상담소</td>
			    <td class="txt-left">경상남도    통영시 안개4길 94</td>
			    <td>055-640-7795</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>합천가정행복상담센터</td>
			    <td class="txt-left">경상남도    합천군 합천읍 동서로 39</td>
			    <td>055-934-1366</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>경산가정폭력상담소</td>
			    <td class="txt-left">경상북도 경산시 중앙초등길3</td>
			    <td>053-814-9191</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>경주가정폭력상담소</td>
			    <td class="txt-left">경상북도 경주시 원화로 341번길5</td>
			    <td>054-749-1366</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>구미여성종합상담소(통합)</td>
			    <td class="txt-left">경상북도 구미시 광평길 41(3층)</td>
			    <td>054-463-1386,1388</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>한사랑가정폭력상담소</td>
			    <td class="txt-left">경상북도 김천시 봉산면 태화1길 101-132</td>
			    <td>054-430-4330</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>문경열린종합상담소(통합)</td>
			    <td class="txt-left">경상북도 문경시 남부3길 19</td>
			    <td>054-555-8207</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>상주가정문제상담소</td>
			    <td class="txt-left">경상북도 상주시 함창읍 함창중앙로 156</td>
			    <td>054-541-6116</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>필그림가정복지상담소(통합)</td>
			    <td class="txt-left">경상북도 상주시 영남제일로 1368</td>
			    <td>054-534-5999</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>안동가정법률상담소<br />부설가정폭력상담소</td>
			    <td class="txt-left">경상북도 안동시 영가로 12-1</td>
			    <td>054-856-4200</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>샘물가족상담센터</td>
			    <td class="txt-left">경상북도 영주시 풍기읍 기주로 85-1</td>
			    <td>054-635-9191</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>소백가정문제상담소</td>
			    <td class="txt-left">경상북도 영주시 구성로 418-4</td>
			    <td>054-638-1366</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>영천가정문제상담소</td>
			    <td class="txt-left">경상북도 영천시 완산중앙3길 30</td>
			    <td>054-336-1366</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>울진가정폭력상담소</td>
			    <td class="txt-left">경상북도 울진군 읍내8길 26</td>
			    <td>054-782-1153</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>쉼터한알가정폭력상담소</td>
			    <td class="txt-left">경상북도 의성군 안계면 안신로    181-21</td>
			    <td>054-862-9256</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>의성가정폭력상담소</td>
			    <td class="txt-left">경상북도 의성군 의성읍 군청길41</td>
			    <td>054-832-2666</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>(사)칠곡종합상담센터(통합)</td>
			    <td class="txt-left">경상북도 칠곡군 왜관읍 석전로    69-35</td>
			    <td>054-973-8290</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>(사)포항여성회부설<br />경북여성통합상담소(통합)</td>
			    <td class="txt-left">경상북도 포항시 남구 송림로 10번길 6-2</td>
			    <td>054-284-0404</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>포항YWCA가정폭력상담소</td>
			    <td class="txt-left">경상북도 포항시 남구 포스코대로    358(일선빌딩6층)</td>
			    <td>054-277-5418</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>무지개가정문제상담소</td>
			    <td class="txt-left">경상북도 포항시 북구 기계면 협동길 17-1</td>
			    <td>054-246-1383</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>포항로뎀나무가정문제상담소</td>
			    <td class="txt-left">경상북도 포항시 북구 흥해읍    동해대로1574번길 5 <br />한미장관맨션상가2층</td>
			    <td>054-262-3554</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>포항미래상담소</td>
			    <td class="txt-left">경상북도 포항시 북구 탑산길 10번길 7,2층 </td>
			    <td>054-255-1191</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>포항생명의전화부설가정폭력상담소</td>
			    <td class="txt-left">경상북도 포항시 북구 중앙로419번길    21 <br />대동우방타운 상가2층</td>
			    <td>054-242-0015</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>한국가정법률상담소부설 <br />포항가정폭력상담소</td>
			    <td class="txt-left">경상북도 포항시 북구 신덕로 277, 201호(장성동,    율정빌딩)</td>
			    <td>054-283-7555</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>희망상담소</td>
			    <td class="txt-left">경상북도 포항시 북구    선착로12(대신동)</td>
			    <td>054-256-5670</td>
			  </tr>
			  <tr>
			    <td>광주시</td>
			    <td>송광한가족상담센터</td>
			    <td class="txt-left">광주광역시 광산구 우산로96번길 66, 3층 (우산동)</td>
			    <td>062-452-1366</td>
			  </tr>
			  <tr>
			    <td>광주시</td>
			    <td>한마음가정폭력상담소</td>
			    <td class="txt-left">광주광역시 광산구 어등대로665번길 3    (소촌동)</td>
			    <td>062-945-1360</td>
			  </tr>
			  <tr>
			    <td>광주시</td>
			    <td>광주YWCA가정상담센터</td>
			    <td class="txt-left">광주광역시 남구 제중로46번길 1 (양림동)</td>
			    <td>062-672-1355</td>
			  </tr>
			  <tr>
			    <td>광주시</td>
			    <td>광주장애인가정상담소</td>
			    <td class="txt-left">광주광역시 남구 봉선로79번길 4-1    (주월동)</td>
			    <td>062-654-0420</td>
			  </tr>
			  <tr>
			    <td>광주시</td>
			    <td>광주생명의전화한마음상담소</td>
			    <td class="txt-left">광주광역시 동구 동명로 60</td>
			    <td>062-233-9192</td>
			  </tr>
			  <tr>
			    <td>광주시</td>
			    <td>총신가정폭력상담소</td>
			    <td class="txt-left">광주광역시 북구 군왕로 85번지 3층</td>
			    <td>062-672-8282</td>
			  </tr>
			  <tr>
			    <td>광주시</td>
			    <td>가족사랑상담소</td>
			    <td class="txt-left">광주광역시 서구 풍암2로 14</td>
			    <td>062-655-9559</td>
			  </tr>
			  <tr>
			    <td>광주시</td>
			    <td>광주여성인권상담소</td>
			    <td class="txt-left">광주광역시 서구 내방로404번길    15(농성동)</td>
			    <td>062-363-0485</td>
			  </tr>
			  <tr>
			    <td>광주시</td>
			    <td>한가정상담센터</td>
			    <td class="txt-left">광주광역시    서구 화정로 87-1</td>
			    <td>062-373-1367</td>
			  </tr>
			  <tr>
			    <td>대구시</td>
			    <td>사)대구여성의전화    부설 <br />대구가정폭력상담소</td>
			    <td class="txt-left">대구광역시 남구 이천로 31</td>
			    <td>053-471-6484</td>
			  </tr>
			  <tr>
			    <td>대구시</td>
			    <td>대구여성장애인통합상담소(통합)</td>
			    <td class="txt-left">대구광역시 달서구 와룡로 5길 11</td>
			    <td>053-637-6057</td>
			  </tr>
			  <tr>
			    <td>대구시</td>
			    <td>대구이주여성상담소</td>
			    <td class="txt-left">대구시 동구 아양로 9</td>
			    <td>053-944-2977</td>
			  </tr>
			  <tr>
			    <td>대구시</td>
			    <td>영남가정폭력상담소</td>
			    <td class="txt-left">대구광역시 동구 아양로49길 6</td>
			    <td>053-953-2866</td>
			  </tr>
			  <tr>
			    <td>대구시</td>
			    <td>대구여성폭력통합상담소(통합)</td>
			    <td class="txt-left">대구광역시 수성구 동대구로385</td>
			    <td>053745-4501</td>
			  </tr>
			  <tr>
			    <td>대전시</td>
			    <td>대전가톨릭가정폭력상담소</td>
			    <td class="txt-left">대전광역시 대덕구 한남로 150번길 16(오정동)</td>
			    <td>042-636-2036</td>
			  </tr>
			  <tr>
			    <td>대전시</td>
			    <td>대전열린가정폭력상담소</td>
			    <td class="txt-left">대전광역시 동구 계족로368번길 81</td>
			    <td>042-625-5441</td>
			  </tr>
			  <tr>
			    <td>대전시</td>
			    <td>대전가정행복상담소</td>
			    <td class="txt-left">대전광역시 서구 도산로 393번길 26, 2층</td>
			    <td>042-365-1925</td>
			  </tr>
			  <tr>
			    <td>대전시</td>
			    <td>들꽃가정폭력상담소</td>
			    <td class="txt-left">대전광역시 서구 신갈마로211번안길    57</td>
			    <td>042-534-0477</td>
			  </tr>
			  <tr>
			    <td>대전시</td>
			    <td>물구나무다사람 가정폭력상담소</td>
			    <td class="txt-left">대전광역시 유성구 은구비로 18, 311호</td>
			    <td>042-826-8821</td>
			  </tr>
			  <tr>
			    <td>대전시</td>
			    <td>대전YWCA가정폭력상담소</td>
			    <td class="txt-left">대전광역시 중구 대흥로 128</td>
			    <td>042-254-3038</td>
			  </tr>
			  <tr>
			    <td>부산시</td>
			    <td>한사랑가정폭력상담소</td>
			    <td class="txt-left">부산광역시 금정구 팔송로39번길 13-4</td>
			    <td>051-581-0401</td>
			  </tr>
			  <tr>
			    <td>부산시</td>
			    <td>기장열린상담소(통합)</td>
			    <td class="txt-left">부산광역시 기장군 기장읍 차성로290</td>
			    <td>051-531-1366</td>
			  </tr>
			  <tr>
			    <td>부산시</td>
			    <td> 희망의전화 가정폭력상담소</td>
			    <td class="txt-left">부산광역시 남구 황령대로 488 </td>
			    <td>051-623-1488 </td>
			  </tr>
			  <tr>
			    <td>부산시</td>
			    <td>(사)부산가정법률상담소부설    <br />가정폭력관련상담소</td>
			    <td class="txt-left">부산광역시    동구 조방로49번길 29, 호림빌딩705호</td>
			    <td>051-469-2987</td>
			  </tr>
			  <tr>
			    <td>부산시</td>
			    <td>부산성폭력.가정폭력상담소(통합)</td>
			    <td class="txt-left">부산광역시    동래구 중앙대로 1523 <br />SK허브스카이 A3동 5,6호(온천동)</td>
			    <td>051-558-8833</td>
			  </tr>
			  <tr>
			    <td>부산시</td>
			    <td>사)부산여성의전화  <br />성·가정폭력상담센터(통합)</td>
			    <td class="txt-left">부산광역시    부산진구 전포대로255번길 15(전포동)</td>
			    <td>051-817-4344</td>
			  </tr>
			  <tr>
			    <td>부산시</td>
			    <td>여권문화인권센터 가정폭력상담소</td>
			    <td class="txt-left">부산광역시    북구 덕천1동 388-1 대방아파트 상가 305호</td>
			    <td>051-363-3838</td>
			  </tr>
			  <tr>
			    <td>부산시</td>
			    <td>울타리가정폭력상담소</td>
			    <td class="txt-left">부산 사상구 광장로 99</td>
			    <td>051-325-0064</td>
			  </tr>
			  <tr>
			    <td>부산시</td>
			    <td>사하가정폭력상담소</td>
			    <td class="txt-left">부산광역시 사하구 사하로 133-1(괴정동)</td>
			    <td>051-205-8296</td>
			  </tr>
			  <tr>
			    <td>부산시</td>
			    <td>사)다함께 성·가정상담센터(통합)</td>
			    <td class="txt-left">부산광역시 수영구 연수로 392    (광안동)</td>
			    <td>051-753-1377</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>해윰가족상담소</td>
			    <td class="txt-left">서울특별시    강북구 미아동 134-97(4층)</td>
			    <td>02-980-1366</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>강서양천가정폭력상담소</td>
			    <td class="txt-left">서울특별시    강서구 강서로 159 (화곡동)</td>
			    <td>02-2605-8455</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>휴샘통합운영상담센터(통합)</td>
			    <td class="txt-left">서울특별시    강서구 내발산동 709-5 경우빌딩 4021호 </td>
			    <td>02-2663-1366</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>푸른나무가정폭력상담소</td>
			    <td class="txt-left">서울특별시    관악구 남부순환로 1986</td>
			    <td>02-871-5086</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>음악치료    가정상담소</td>
			    <td class="txt-left">서울특별시    광진구 긴고랑로7길 54 (중곡동)</td>
			    <td>02-461-5548</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>희년여성상담소</td>
			    <td class="txt-left">서울특별시    광진구 자양로 71-7</td>
			    <td>02-453-1366</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>희망가정폭력    상담소</td>
			    <td class="txt-left">서울특별시    광진구 광장동 330-8, 3층</td>
			    <td>02-3437-0195</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>한영신학대학교    부설 가정폭력상담소</td>
			    <td class="txt-left">서울특별시    구로구 경인로 290-42</td>
			    <td>02-2067-4594</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>한울가족상담센터 </td>
			    <td class="txt-left">서울특별시    금천구 시흥대로 405 (독산동)</td>
			    <td>02-849-2255</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>월계우리가족상담소</td>
			    <td class="txt-left">서울특별시    노원구 초안산로 1길 18 <br />월계종합사회복지관 2층</td>
			    <td>02904-0179</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>동대문행복한심리상담센터</td>
			    <td class="txt-left">서울특별시    동대문구 한천로 244-7</td>
			    <td>02-2248-7702</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>희망가정폭력상담소</td>
			    <td class="txt-left">서울특별시    동대문구 이문로1길 11</td>
			    <td>02-959-0101</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>동작가정폭력상담소</td>
			    <td class="txt-left">서울특별시    동작구 상도로 398</td>
			    <td>02-826-0675</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>나우리    가족상담센터</td>
			    <td class="txt-left">서울특별시    마포구 월드컵로 190번 이안상암2차 706호</td>
			    <td>02-332-3776</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>서대문가정폭력관련상담소</td>
			    <td class="txt-left">서울특별시    서대문구 신촌로 215-2 전진빌딩 3층 </td>
			    <td>02-364-0413</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>동산가정폭력상담소</td>
			    <td class="txt-left">서울특별시    서초구 서초대로 27길 10-10</td>
			    <td>02-599-7646</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>서울성동가정상담센터</td>
			    <td class="txt-left">서울특별시    성동구 무학로2길, 7, 301호(도선동)</td>
			    <td>02-2297-2911</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>(사)한국여성상담센터(통합)</td>
			    <td class="txt-left">서울특별시    성북구 보문로22길 28<br />(안암동 3가, 신일빌딩 4층)</td>
			    <td>02-953-1704</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>잠실가정폭력상담소</td>
			    <td class="txt-left">서울특별시    송파구 올림픽로12길 12</td>
			    <td>02-2202-7806</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>가정행복상담센터 </td>
			    <td class="txt-left">서울특별시    양천구 목동남로2길 25(신정동)</td>
			    <td>02-6083-9191</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>나우미가정폭력상담센터</td>
			    <td class="txt-left">서울특별시    양천구 목동동로 293,  2715-1호<br />(목동, 현대41타워)</td>
			    <td>02-2062-1366</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>대한가정법률복지상담원    <br />부설 가정폭력상담소</td>
			    <td class="txt-left">서울특별시    양천구 오목로 176, 2,4층 (신정동, 산호빌딩)</td>
			    <td>02-2697-0155</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>서울가정폭력상담센터</td>
			    <td class="txt-left">서울특별시    양천구 목동동로 293, 현대41타워 1016-1</td>
			    <td>02-2653-1366</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>가톨릭여성의집    가정폭력상담소  </td>
			    <td class="txt-left">서울특별시    영등포구 도림로 289(신길동)</td>
			    <td>02-833-3465</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>꿈터가정폭력상담소</td>
			    <td class="txt-left">서울특별시    영등포구 여의대방로 13길 14</td>
			    <td>02-6083-4971~2</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>한국가정법률상담소    <br />부설&nbsp;가정폭력상담소</td>
			    <td class="txt-left">서울특별시    영등포구 국회대로76가길 14 (여의도동)</td>
			    <td>02-1644-7077</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>한국가정상담센터</td>
			    <td class="txt-left">서울특별시    영등포구 영신로 20가길 6(영등포동)</td>
			    <td>02-842-0004</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>(사)다문화종합복지센터    <br />부설 다사랑가정상담소</td>
			    <td class="txt-left">서울특별시    용산구 청파로 319 3층</td>
			    <td>02-713-0284</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>용산가정폭력관련상담소</td>
			    <td class="txt-left">서울특별시    용산구 백범로51길 3 (효창동)</td>
			    <td>02-707-1849</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>(사)한국여성의전화    가정폭력상담소</td>
			    <td class="txt-left">서울특별시    은평구 진흥로16길 8-4 (녹번동)</td>
			    <td>02-3156-5400</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>은평가정폭력상담소</td>
			    <td class="txt-left">서울특별시    은평구 은평터널로 48 (수색동)</td>
			    <td>02-326-1366</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>성결가정폭력상담소</td>
			    <td class="txt-left">서울특별시    종로구 행촌동 1-30 </td>
			    <td>02-725-7077</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>아하가족성장연구소</td>
			    <td class="txt-left">서울특별시    종로구 창의문로10길 11 (부암동)</td>
			    <td>02-379-8558</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>한국가정법률상담소    <br />중구지부 부설 가정폭력상담소</td>
			    <td class="txt-left">서울특별시    중구 청구로19길 9-15</td>
			    <td>02-2238-6551</td>
			  </tr>
			  <tr>
			    <td>세종시</td>
			    <td>종촌종합복지센터    <br />가정성폭력상담소(통합)</td>
			    <td class="txt-left">세종시 도움1로 116 종촌종합복지센터 3층</td>
			    <td>044-850-3095</td>
			  </tr>
			  <tr>
			    <td>울산시</td>
			    <td>생명의전화울산지부부설<br />가정·성폭력통합상담소(통합)</td>
			    <td class="txt-left">울산광역시 남구 문수로 313,    삼성빌딩505호</td>
			    <td>052-265-5570</td>
			  </tr>
			  <tr>
			    <td>울산시</td>
			    <td>동구가정성폭력통합상담소(통합)</td>
			    <td class="txt-left">울산광역시 동구 내진길 18</td>
			    <td>052-252-6778</td>
			  </tr>
			  <tr>
			    <td>울산시</td>
			    <td>북울산가정폭력상담소</td>
			    <td class="txt-left">울산광역시 북구 호계로 313    <br />성우현대아파트 상가 208호 209호</td>
			    <td>052-295-0310</td>
			  </tr>
			  <tr>
			    <td>울산시</td>
			    <td>사)울산여성회부설북구가정폭력상담소</td>
			    <td class="txt-left">울산광역시 북구 상방로 141, 2층</td>
			    <td>052-287-1364</td>
			  </tr>
			  <tr>
			    <td>인천시</td>
			    <td>내일을여는집 가족상담소</td>
			    <td class="txt-left">인천광역시 계양구 계양산로 102번길    5 <br />계양구사회복지회관 지하 1층</td>
			    <td>032-541-1366</td>
			  </tr>
			  <tr>
			    <td>인천시</td>
			    <td>가족사랑상담소</td>
			    <td class="txt-left">인천광역시 미추홀구 한나루로403번길120</td>
			    <td>032-874-6661</td>
			  </tr>
			  <tr>
			    <td>인천시</td>
			    <td>남구가정폭력상담소</td>
			    <td class="txt-left">인천광역시 미추홀구 인하로 314</td>
			    <td>032-437-1141</td>
			  </tr>
			  <tr>
			    <td>인천시</td>
			    <td>인천여성단체협의회부설<br />가정.성폭력상담소(통합)</td>
			    <td class="txt-left">인천 미추홀구 경인로 345</td>
			    <td>032-865-1365</td>
			  </tr>
			  <tr>
			    <td>인천시</td>
			    <td>한국가정법률상담소 인천지부 <br />부설    가정폭력상담소</td>
			    <td class="txt-left">인천광역시 미추홀구 학익소로29    석목빌딩508호</td>
			    <td>032 865 1120</td>
			  </tr>
			  <tr>
			    <td>인천시</td>
			    <td>서인천가족상담소</td>
			    <td class="txt-left">인천광역시 서구 승학로 247, 3층</td>
			    <td>032-564-1366</td>
			  </tr>
			  <tr>
			    <td>인천시</td>
			    <td>중구가정폭력상담소</td>
			    <td class="txt-left">인천광역시 중구 우현로 39번길 2</td>
			    <td>032-761-7070</td>
			  </tr>
			  <tr>
			    <td>전남</td>
			    <td>고흥나누리상담센터</td>
			    <td class="txt-left">전라남도 고흥군 고흥읍 고흥로 1762-1,2층</td>
			    <td>061-832-1360</td>
			  </tr>
			  <tr>
			    <td>전남</td>
			    <td>광양여성상담센터</td>
			    <td class="txt-left">전라남도 광양시 성북길39</td>
			    <td>061-761-1254</td>
			  </tr>
			  <tr>
			    <td>전남</td>
			    <td>목포여성상담센터(통합)</td>
			    <td class="txt-left">전라남도 목포시 신흥로83번길 5</td>
			    <td>061-285-1366</td>
			  </tr>
			  <tr>
			    <td>전남</td>
			    <td>무안 열린가정상담센터</td>
			    <td class="txt-left">전라남도 무안군 무안읍 무안로 507    월암빌딩 5층</td>
			    <td>061-454-1365</td>
			  </tr>
			  <tr>
			    <td>전남</td>
			    <td>순천여성상담센터</td>
			    <td class="txt-left">전라남도 순천시 호남길3</td>
			    <td>061-753-9900</td>
			  </tr>
			  <tr>
			    <td>전남</td>
			    <td>여수여성상담센터</td>
			    <td class="txt-left">전라남도 여수시 동문로 120</td>
			    <td>061-654-5211</td>
			  </tr>
			  <tr>
			    <td>전남</td>
			    <td>영광여성상담센터</td>
			    <td class="txt-left">전라남도 영광군 영광읍 중앙로2길 54-2</td>
			    <td>061-352-1322</td>
			  </tr>
			  <tr>
			    <td>전남</td>
			    <td>영암행복한가정상담센터</td>
			    <td class="txt-left">전라남도 영암군 삼호읍 녹색로 1113    <br />세한대학교 정보관 1층 8100호</td>
			    <td>061-461-1366</td>
			  </tr>
			  <tr>
			    <td>전남</td>
			    <td>함평열린가정 상담센터</td>
			    <td class="txt-left">전라남도 함평군 함평읍 남일길 52 </td>
			    <td>061-324-1366</td>
			  </tr>
			  <tr>
			    <td>전남</td>
			    <td>어울림가정상담센터</td>
			    <td class="txt-left">전라남도 화순군 화순읍 진각로    118-1/2층</td>
			    <td>061-371-1366</td>
			  </tr>
			  <tr>
			    <td>전북</td>
			    <td>군산여성의전화(부)가정폭력상담소</td>
			    <td class="txt-left">전라북도    군산시 구영7길 8. 2층</td>
			    <td>063-445-2285</td>
			  </tr>
			  <tr>
			    <td>전북</td>
			    <td>남원YWCA가정폭력상담소</td>
			    <td class="txt-left">전라북도    남원시 시청로65 2층</td>
			    <td>063-625-1316</td>
			  </tr>
			  <tr>
			    <td>전북</td>
			    <td>남원가정폭력상담소</td>
			    <td class="txt-left">전라북도    남원시 요천로 1415번지</td>
			    <td>063-635-0712</td>
			  </tr>
			  <tr>
			    <td>전북</td>
			    <td>익산가정폭력상담소</td>
			    <td class="txt-left">전라북도    익산시 인북로48길 19</td>
			    <td>063-853-9191</td>
			  </tr>
			  <tr>
			    <td>전북</td>
			    <td>익산여성의전화부설가정폭력상담소</td>
			    <td class="txt-left">전라북도    익산시 익산대로 172-1</td>
			    <td>063-858-9191</td>
			  </tr>
			  <tr>
			    <td>전북</td>
			    <td>한국가정법률상담소익산지부부설<br />가정폭력상담소부설    가정폭력상담소</td>
			    <td class="txt-left">전라북도    익산시 인북로 168.</td>
			    <td>063-851-5113</td>
			  </tr>
			  <tr>
			    <td>전북</td>
			    <td>가정폭력상담소</td>
			    <td class="txt-left">전라북도    전주시 완산구 효자로338. 3층</td>
			    <td>063-287-7324~5</td>
			  </tr>
			  <tr>
			    <td>전북</td>
			    <td>전주가정폭력상담소</td>
			    <td class="txt-left">전라북도    전주시 완산구 노송광장로7</td>
			    <td>063-244-0227</td>
			  </tr>
			  <tr>
			    <td>전북</td>
			    <td>정읍가정폭력상담소</td>
			    <td class="txt-left">전라북도    정읍시 연지동21-1</td>
			    <td>063-535-8223</td>
			  </tr>
			  <tr>
			    <td> 제주</td>
			    <td>서귀포가정행복상담소</td>
			    <td class="txt-left">제주특별자치도    서귀포시 중앙로42번길 46, 5층</td>
			    <td>064-732-3279</td>
			  </tr>
			  <tr>
			    <td> 제주</td>
			    <td> 제주YWCA통합상담소 </td>
			    <td class="txt-left">제주특별자치도    제주시 삼무로 11길 3</td>
			    <td> 064-748-3040 </td>
			  </tr>
			  <tr>
			    <td> 제주</td>
			    <td> 제주가족사랑상담소 </td>
			    <td class="txt-left">제주특별자치도    제주시 중앙로195(2층)</td>
			    <td> 064-726-3277 </td>
			  </tr>
			  <tr>
			    <td> 제주</td>
			    <td>제주여성장애인상담소</td>
			    <td class="txt-left">제주특별자치도    제주시 복지로3길 1-4, 4층</td>
			    <td>064-756-4983</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>공주시가족상담센터</td>
			    <td class="txt-left">충청남도 공주시 제민천3길 22    (중학동)</td>
			    <td>041-854-1366</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>논산YWCA가정폭력상담소</td>
			    <td class="txt-left">충청남도 논산시 중앙로 398번길 29-9</td>
			    <td>041-736-8297</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>당진가족상담센터</td>
			    <td class="txt-left">충청남도 당진시 무수동로36 용원빌딩    2층 </td>
			    <td>041-354-2366</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>대천가족상담센터</td>
			    <td class="txt-left">충청남도 보령시 대천로 35</td>
			    <td>041-936-7941</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>서산가족상담지원센터</td>
			    <td class="txt-left">충청남도 서산시 율지8로60</td>
			    <td>041-668-8566</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>아산가정성상담지원센터(통합)</td>
			    <td class="txt-left">충청남도 아산시 배방읍 공수리1037</td>
			    <td>041-546-9191</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>해뜰가족상담소</td>
			    <td class="txt-left">충청남도 아산시 번영로113-19</td>
			    <td>041-547-5004</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>예산가정상담소</td>
			    <td class="txt-left">충청남도 예산군 예산읍 아리랑로 73</td>
			    <td>041-334-1366</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>가족성장상담소남성의소리</td>
			    <td class="txt-left">충청남도 천안시 동남구 통정8로    5-24 2층</td>
			    <td>041-572-0115</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>충남가족과성상담소</td>
			    <td class="txt-left">충청남도 천안시 서북구 쌍용대로289-4 삼정빌딩 601호</td>
			    <td>041-578-1145</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>새샘가족상담센터</td>
			    <td class="txt-left">충청남도 청양군 청양읍 칠갑산로 4길    25</td>
			    <td>041-943-1366</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>홍성가정폭력상담소</td>
			    <td class="txt-left">충청남도 홍성군 홍성읍 충서로1121-32</td>
			    <td>041-631-3939</td>
			  </tr>
			  <tr>
			    <td>충북</td>
			    <td>영동가정폭력성폭력통합상담소(통합)</td>
			    <td class="txt-left">충청북도 영동군 영동읍 회동로    212-1,(2층)</td>
			    <td>043-743-1366</td>
			  </tr>
			  <tr>
			    <td>충북</td>
			    <td>음성가정(성)폭력상담소</td>
			    <td class="txt-left">충청북도 음성군 음성읍 시장로54. 중앙빌딩4층</td>
			    <td>043-873-1330</td>
			  </tr>
			  <tr>
			    <td>충북</td>
			    <td>제천가정법률상담소<br />부설가정폭력상담소</td>
			    <td class="txt-left">충청북도 제천시 의림대로6길32</td>
			    <td>043-645-5690</td>
			  </tr>
			  <tr>
			    <td>충북</td>
			    <td>청주가정법률상담소<br />부설가정폭력상담소</td>
			    <td class="txt-left">충청북도 청주시 상당구 상당로158번길5</td>
			    <td>043-257-0088</td>
			  </tr>
			  <tr>
			    <td>충북</td>
			    <td>청주YWCA여성종합상담소(통합)</td>
			    <td class="txt-left">충청북도 청주시 흥덕구 1순환로    536번길 4</td>
			    <td>043-268-3007</td>
			  </tr>
			  <tr>
			    <td>충북</td>
			    <td>충주YWCA 가정폭력상담소</td>
			    <td class="txt-left">충청북도 충주시 중앙로 113, 경인빌딩304호</td>
			    <td>043-842-9889</td>
			  </tr>
		</tbody>
	</table>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>