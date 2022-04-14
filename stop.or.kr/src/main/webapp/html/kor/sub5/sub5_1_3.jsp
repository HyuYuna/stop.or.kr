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
	<li><a href="sub5_1_2.jsp">가정폭력상담소</a></li>
	<li class="active"><a href="sub5_1_3.jsp">성폭력피해상담소</a></li>
	<li><a href="sub5_1_4.jsp">성매매피해상담소</a></li>
	<li><a href="sub5_1_5.jsp">해바라기센터</a></li>
</ul>

<h2 class="title1">성폭력피해상담소</h2>

<div class="table-wrap">
	<table>
		<caption>성폭력피해상담소 - 지역, 기관명, 주소, 연락처</caption>
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
			    <td>강릉가정폭력·성폭력상담소</td>
			    <td class="txt-left">강원도 강릉시 강릉대로454, <br />(포남동, 강릉여성문화센터    2층)</td>
			    <td>033-652-9555</td>
			  </tr>
			  <tr>
			    <td>강원도</td>
			    <td>동해가정폭력성폭력상담소</td>
			    <td class="txt-left">강원도    동해시 중앙로 188</td>
			    <td>033-535-4943</td>
			  </tr>
			  <tr>
			    <td>강원도</td>
			    <td>삼척종합사회복지관부설    <br />삼척가정폭력·성폭력통합상담소</td>
			    <td class="txt-left">강원도    삼척시 원당로2길 72-6</td>
			    <td>033-573-9168</td>
			  </tr>
			  <tr>
			    <td>강원도</td>
			    <td>사)속초여성인권센터    부설 <br />속초성폭력상담소</td>
			    <td class="txt-left">강원도    속초시 동해대로 4307</td>
			    <td>033-637-1988</td>
			  </tr>
			  <tr>
			    <td>강원도</td>
			    <td>영월성폭력상담소 </td>
			    <td class="txt-left">강원도    영월군 영월읍 단종로 34</td>
			    <td>033-375-1366</td>
			  </tr>
			  <tr>
			    <td>강원도</td>
			    <td>원주가정폭력성폭력통합상담소</td>
			    <td class="txt-left">강원도    원주시 갈머리2길 31 사회복지센터 307호</td>
			    <td>033-765-1366</td>
			  </tr>
			  <tr>
			    <td>강원도</td>
			    <td>아라리가족성상담소</td>
			    <td class="txt-left">강원도 정선군 정선읍 녹송1길 38</td>
			    <td>033-563-8666</td>
			  </tr>
			  <tr>
			    <td>강원도</td>
			    <td>춘천가정폭력성폭력상담소</td>
			    <td class="txt-left">강원도 춘천시 효자로 135, 3층</td>
			    <td>033-257-4687</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>한마음가족상담센터</td>
			    <td class="txt-left">경기도    고양시 덕양구 용현로 9, 해동빌딩 510호</td>
			    <td>031-979-1367</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>고양성폭력상담소</td>
			    <td class="txt-left">경기도    고양시 일산동구 무궁화로 32-21, <br />로데오메탈릭타워 602-2</td>
			    <td>031-907-1368</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>광명YWCA성폭력상담소</td>
			    <td class="txt-left">경기도    광명시 오리로 953</td>
			    <td>02-2619-8928</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>로뎀여성폭력피해상담소</td>
			    <td class="txt-left">경기도    광주시 용샘길 147(목현동)</td>
			    <td>031-764-0577</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>씨알여성회    부설 성폭력상담소</td>
			    <td class="txt-left">경기도    광주시 광주대로 129번길 13(송정동,3층)</td>
			    <td>031-797-7031</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>군포여성민우회    성폭력상담소</td>
			    <td class="txt-left">경기도    군포시 산본로 323번길 20-33, 802호</td>
			    <td>031-396-0236</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>김포여성상담센터</td>
			    <td class="txt-left">경기도    김포시 양촌읍 양곡1로56번길 3</td>
			    <td>031-984-1367</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>공감심리상담소</td>
			    <td class="txt-left">경기도    남양주시 오남읍 진건오남로 575, 302호(창노빌딩)</td>
			    <td>031-514-5150</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>남양주가정과성상담소</td>
			    <td class="txt-left">경기도    남양주시 금곡로 46, 301호(금곡동, 양지빌딩)</td>
			    <td>031-558-1366</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>동두천성폭력상담소</td>
			    <td class="txt-left">경기도    동두천시 상패로 5</td>
			    <td>031-867-3100</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>한국성건강센터</td>
			    <td class="txt-left">경기도    동두천시 행선로 102</td>
			    <td>031-858-1366</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>부천청소년성폭력상담소</td>
			    <td class="txt-left">경기도    부천시 성주로 149(송내동)</td>
			    <td>032-655-1366</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>한국여성의전화부천지부<br>
			      부설 성폭력상담소</td>
			    <td class="txt-left">경기도    부천시 중동로 248번길 86(중동)현해탑빌딩 302</td>
			    <td>032-328-9713</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>성남여성의전화부설 성폭력상담소</td>
			    <td class="txt-left">경기도    성남시 수정구 수정북로 100 (태평동, 동호빌딩 6층)</td>
			    <td>751-2050</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>여성장애인성폭력상담소</td>
			    <td class="txt-left">경기도    성남시 수정구 수정북로 92 <br />(태평동, 주민태평동락 303호)</td>
			    <td>755-2527</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>수원탁틴내일상담소</td>
			    <td class="txt-left">경기도    수원시 장안구 경수대로 862, 501호<br />(조원동,창경빌딩)</td>
			    <td>031-251-1516</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>수원여성의전화    부설 통합상담소</td>
			    <td class="txt-left">경기도    수원시 팔달구 향교로 161, 704호(중동,우림빌딩)</td>
			    <td>031-232-7795</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>안산YWCA여성과성상담소</td>
			    <td class="txt-left">경기도    안산시 단원구 고잔동 광덕서로66 . 412호</td>
			    <td>031-413-9414</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>정다운    가족 상담센터</td>
			    <td class="txt-left">경기도    안산시 단원구 광덕4로 246</td>
			    <td>031-439-1366</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>가톨릭여성상담소</td>
			    <td class="txt-left">경기도    안산시 상록구 한양대학1길 60</td>
			    <td>031415-0117</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>성교육성폭력 상담센터</td>
			    <td class="txt-left">경기도    안성시 서당길 39</td>
			    <td>031-676-1366</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>안양여성의전화부설성폭력상담소</td>
			    <td class="txt-left">경기도    안양시 동안구 관악대로 76(비산동)  정화빌딩6층</td>
			    <td>031-442-5385</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>한국새남심리상담연구원부설    <br />성폭력상담소</td>
			    <td class="txt-left">경기도    안양시 동안구 관악대로 275번길 65-1(비산동)</td>
			    <td>031-381-8530</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>양주성폭력상담소</td>
			    <td class="txt-left">경기도    양주시  독바위로 30-1</td>
			    <td>031-864-7546</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>연천행복뜰상담소</td>
			    <td class="txt-left">경기도    연천군 청산면 학담로 131</td>
			    <td>031-832-1315</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>용인성폭력상담소</td>
			    <td class="txt-left">경기도    용인시 기흥구 갈곡로8번길 11</td>
			    <td>031-281-1366</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>의왕장애인성폭력상담소</td>
			    <td class="txt-left">경기도    의왕시 부곡중앙남1길 34, 꿈머울푸러저 202호</td>
			    <td>031-462-1366</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>(사)사랑깊은뜰    부설 <br />경기북부가정문제성폭력상담소</td>
			    <td class="txt-left">경기도    의정부시 장곡로 596번길,19 골드타워402호(신곡동)</td>
			    <td>031-876-7544</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>의정부장애인성폭력상담소</td>
			    <td class="txt-left">경기도    의정부시 호국로 1426, 4층(금오동)</td>
			    <td>031-840-9203</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>하나성폭력상담소</td>
			    <td class="txt-left">경기도    의정부시 부용로95, 701호(금오동,현대프라자)</td>
			    <td>031-852-0142</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>성폭력    상담소'함께'</td>
			    <td class="txt-left">경기도    파주시 와석순환로 415 (운정행복센터2층)</td>
			    <td>031-946-2096</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>평택성폭력상담소</td>
			    <td class="txt-left">경기도    평택시 평택1로 23-1 2층</td>
			    <td>031-618-1366</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>포천가족성상담센터</td>
			    <td class="txt-left">경기도    포천시 소흘읍 호국로 571(정우빌딩 3층)</td>
			    <td>031-542-3171</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>하남YWCA부설    성폭력상담소</td>
			    <td class="txt-left">경기도    하남시 신장로205번길 27 (덕풍동,서해상가4층)</td>
			    <td>031.796-1274</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>맘 톡톡    상담센터</td>
			    <td class="txt-left">경기도    화성시 봉담읍 오래3길 11</td>
			    <td>031-298-2117</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>거창성가족상담소</td>
			    <td class="txt-left">경상남도    거창군 수남로 2193-40 거창문화원 3층</td>
			    <td>055-944-1828</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>김해여성의전화부설    성폭력상담소</td>
			    <td class="txt-left">경남    김해시 호계로 422번길 34-5(부원동)</td>
			    <td>055-329-6453</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>성폭력상담소</td>
			    <td class="txt-left">경남    창원시 마산합포구 오동동 10길 56 <br />가고파오피스텔 504호(오동동)</td>
			    <td>055-244-8400</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>밀양시성가족상담소</td>
			    <td class="txt-left">경남    밀양시 중앙로  268(삼문동, 여성회관)</td>
			    <td>055-359-5569</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>사천성가족상담센터</td>
			    <td class="txt-left">경남    사천시 사천읍 수양로 126(3층)</td>
			    <td>055-852-9040</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>양산성가족상담소</td>
			    <td class="txt-left">경남 양산시 중앙로 61, 204호</td>
			    <td>055-366-6663</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>진주성폭력상담소</td>
			    <td class="txt-left">경상남도    진주시 남강로477번길 11 (신안동, 2층)</td>
			    <td>055-746-7462</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>창녕성건강가정상담소</td>
			    <td class="txt-left">경남    창녕군 창녕읍 창녕대로 172</td>
			    <td>055-521-1366</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>마산여성장애인성폭력상담소</td>
			    <td class="txt-left">경남    창원시 마산합포구 오동동 10길 56 가고파오피스텔 804호(오동동)</td>
			    <td>055-241-5041</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>동산샘상담소</td>
			    <td class="txt-left">경남    창원시 성산구 연덕로 184번길 48 지층2호<br />(내동,공단상가)</td>
			    <td>055-277-6868</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>창원성폭력상담소</td>
			    <td class="txt-left">경남    창원시 의창구 신월로 42 토월복합상가 725호</td>
			    <td>055-283-8322</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>진해성폭력상담소</td>
			    <td class="txt-left">경남    창원시 진해구 충장로 511번길 16(풍호동)</td>
			    <td>055-546-8322</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>통영YWCA성폭력상담소</td>
			    <td class="txt-left">경남    통영시 동충1길4 (항남동)</td>
			    <td>055-648-2070</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>하동성가족상담소</td>
			    <td class="txt-left">경남    하동군 하동읍 섬진강대로 2222</td>
			    <td>055-884-1360</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>함안성˙가족상담소</td>
			    <td class="txt-left">경남 함안군 칠원읍 용산2길 70    (1층)</td>
			    <td>055-587-1367</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>로뎀성폭력상담소</td>
			    <td class="txt-left">경북    경산시 하양읍 대경로 766</td>
			    <td>053-853-5276</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>새경산성폭력상담소</td>
			    <td class="txt-left">경북    경산시 경안로 132-1</td>
			    <td>053-814-1318</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>경주다움    성폭력상담센터</td>
			    <td class="txt-left">경북    경주시 현곡면 금장 2길 25</td>
			    <td>054-777-1366<br>
			      054-777-1520</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>구미여성종합상담소</td>
			    <td class="txt-left">경북    구미시 광평길 41(3층)</td>
			    <td>054-463-1386<br>
			      054-463-1388</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>영남여성장애인성폭력상담소</td>
			    <td class="txt-left">경북    구미시 문장로 12길 18-1, 1층(도량동)</td>
			    <td>054-443-1366</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>문경열린종합상담소</td>
			    <td class="txt-left">경북    문경시 남부3길 19</td>
			    <td>054-555-8207</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>필그림가정복지상담소</td>
			    <td class="txt-left">경북    상주시 영남제일로 1368</td>
			    <td>054-534-5999</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>경북여성장애인성폭력상담소</td>
			    <td class="txt-left">경북    안동시 태화중앙로 60-1(태화동)</td>
			    <td>054-843-1366</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>칠곡종합상담센터</td>
			    <td class="txt-left">경북    칠곡군 왜관읍 석전로 69-35</td>
			    <td>054-973-8290</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>(사)포항여성회    부설 <br />경북여성통합상담소</td>
			    <td class="txt-left">경북    포항시 남구 송림로 10번길 6-2(송도동)</td>
			    <td>054-284-0404</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>(사)한마음부설    한마음상담소</td>
			    <td class="txt-left">경북    포항시 북구 죽도로 40번길 8-3(죽도동)</td>
			    <td>054-277-9540</td>
			  </tr>
			  <tr>
			    <td>광주시</td>
			    <td>어등    성폭력상담소</td>
			    <td class="txt-left">광주광역시    광산구 우산로95번길 80 (우산동)</td>
			    <td>062-946-8004</td>
			  </tr>
			  <tr>
			    <td>광주시</td>
			    <td>역따마래성폭력상담소</td>
			    <td class="txt-left">광주광역시    광산구 광산로20번길 28, 101동 201호</td>
			    <td>062-531-6707</td>
			  </tr>
			  <tr>
			    <td>광주시</td>
			    <td>참사랑    성폭력상담소</td>
			    <td class="txt-left">광주광역시    광산구 신창로86번길 7-17 (신창동)</td>
			    <td>062-954-4236</td>
			  </tr>
			  <tr>
			    <td>광주시</td>
			    <td>광주여성장애인    성폭력상담소</td>
			    <td class="txt-left">광주광역시    남구 천변좌로382번길 8 (사동)</td>
			    <td>062-654-1366</td>
			  </tr>
			  <tr>
			    <td>광주시</td>
			    <td>인구협회광주    성폭력상담소</td>
			    <td class="txt-left">광주광역시    남구 서문대로 816 (주월동)</td>
			    <td>062-673-1366</td>
			  </tr>
			  <tr>
			    <td>광주시</td>
			    <td>광주여성민우회    성폭력상담소</td>
			    <td class="txt-left">광주광역시    동구 중앙로196번길 3 삼호센터별관 102호</td>
			    <td>062-521-1366</td>
			  </tr>
			  <tr>
			    <td>광주시</td>
			    <td>지구촌가족    성폭력상담소</td>
			    <td class="txt-left">광주광역시    북구 군왕로 87 (두암동)</td>
			    <td>062-675-2277</td>
			  </tr>
			  <tr>
			    <td>광주시</td>
			    <td>광주여성인권상담소</td>
			    <td class="txt-left">광주광역시    서구 내방로 404번길 15</td>
			    <td>062-363-0487</td>
			  </tr>
			  <tr>
			    <td>대구시</td>
			    <td>대구여성의전화    부설 대구성폭력상담소</td>
			    <td class="txt-left">대구광역시    남구 이천로 31</td>
			    <td>053-471-6484</td>
			  </tr>
			  <tr>
			    <td>대구시</td>
			    <td>대구여성장애인통합상담소</td>
			    <td class="txt-left">대구    달서구 와룡로5길 11</td>
			    <td>053-637-6064</td>
			  </tr>
			  <tr>
			    <td>대구시</td>
			    <td>인구보건복지협회 대구경북지회    <br />성폭력상담소</td>
			    <td class="txt-left">대구시 서구 국채보상로 46길 16</td>
			    <td>053-566-1900</td>
			  </tr>
			  <tr>
			    <td>대구시</td>
			    <td>대구여성폭력통합상담소</td>
			    <td class="txt-left">대구광역시    수성구 동대구로 385</td>
			    <td>053-745-4501</td>
			  </tr>
			  <tr>
			    <td>대전시</td>
			    <td>동대전장애인성폭력상담소</td>
			    <td class="txt-left">대전광역시    동구 옥천로 176번길 15-4, 322호<br />(판암동, 동진프라자)</td>
			    <td>042-637-1366</td>
			  </tr>
			  <tr>
			    <td>대전시</td>
			    <td>대전여성장애인성폭력상담소</td>
			    <td class="txt-left">대전광역시 서구 월평서로9. 3층</td>
			    <td>042-223-8866</td>
			  </tr>
			  <tr>
			    <td>대전시</td>
			    <td>유성 건강한 성인권상담센터</td>
			    <td class="txt-left">대전광역시 유성구 대학로28, 306호</td>
			    <td>042-223-8866</td>
			  </tr>
			  <tr>
			    <td>대전시</td>
			    <td>대전YWCA성폭력상담소</td>
			    <td class="txt-left">대전광역시    중구 대흥로 128 (대흥동)</td>
			    <td>042-254-3038~9</td>
			  </tr>
			  <tr>
			    <td>대전시</td>
			    <td>대전성폭력상담소</td>
			    <td class="txt-left">대전광역시    중구 오류로 98 (오류동)</td>
			    <td>행정:    042-712-1368<br>
			      상담: 042-712-1367. 1369</td>
			  </tr>
			  <tr>
			    <td>부산시</td>
			    <td>기장열린상담소</td>
			    <td class="txt-left">부산광역시    기장군 기장읍 차성로 290, 303호 </td>
			    <td>051-531-1366</td>
			  </tr>
			  <tr>
			    <td>부산시</td>
			    <td>(사)부산여성장애인연대    <br />부설 성폭력상담소</td>
			    <td class="txt-left">부산광역시    동구 중앙대로196번길 12-3, <br />부산장애인회관 4층</td>
			    <td>051-583-7735</td>
			  </tr>
			  <tr>
			    <td>부산시</td>
			    <td>부산성폭력·가정폭력상담소</td>
			    <td class="txt-left">부산시    동래구 중앙대로 1523 SK허브스카이 A3동 5,6호</td>
			    <td>051-558-8832~4</td>
			  </tr>
			  <tr>
			    <td>부산시</td>
			    <td>성가정폭력상담소</td>
			    <td class="txt-left">부산광역시    부산진구 전포대로 255번길 15(전포동)</td>
			    <td>051-817-4344</td>
			  </tr>
			  <tr>
			    <td>부산시</td>
			    <td>다함께    성.가정상담센터</td>
			    <td class="txt-left">부산광역시    수영구 연수로 392(광안동)</td>
			    <td>051-753-1377</td>
			  </tr>
			  <tr>
			    <td>부산시</td>
			    <td>인구보건복지협회    부산지회 <br>
			      성폭력상담소</td>
			    <td class="txt-left">부산광역시    수영구 수영로 425 3층(남천동)</td>
			    <td>051-624-5584</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>한국성폭력위기센터</td>
			    <td class="txt-left">서울특별시    강남구 남부순환로 359길 31, 1층 102호</td>
			    <td>02-883-9285</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>장애여성공감    부설 <br />장애여성성폭력상담소</td>
			    <td class="txt-left">서울특별시    강동구 올림픽로 664 대우베네시티 410호 </td>
			    <td>02-3013-1399</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>한사회장애인성폭력상담센터</td>
			    <td class="txt-left">서울특별시    강서구 양천로 357 려산빌딩 지하1층</td>
			    <td>02-2658-1366</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>행복드림가정상담센터</td>
			    <td class="txt-left">서울특별시    강서구 공항대로 649, 제성빌딩 3층</td>
			    <td>070-8864-9365</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>휴샘통합운영상담센터</td>
			    <td class="txt-left">서울특별시    강서구 강서로 47나길 24 내발산동</td>
			    <td>02-2661-1366</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>이레성폭력상담소</td>
			    <td class="txt-left">서울특별시    관악구 관천로 25(서암빌딩, 4층)</td>
			    <td>02-3281-1366</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>가족과    성건강 아동청소년상담소</td>
			    <td class="txt-left">서울특별시    구로구 오리로 10길 20. 201호</td>
			    <td>02-2688-1366<br>
			      070-8128-1366</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>벧엘케어상담소</td>
			    <td class="txt-left">서울특별시    금천구 시흥대로 102, 401호</td>
			    <td>02-896-0401/0408</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>다미안성가족상담소</td>
			    <td class="txt-left">서울특별시    동대문구 한천로 46길 13, 2층</td>
			    <td>02-2242-1366</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>꿈과희망상담센터</td>
			    <td class="txt-left">서울특별시    동작구 대림로 6</td>
			    <td>070-7503-1366</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>천주교성폭력상담소</td>
			    <td class="txt-left">서울특별시    동작구 상도로 15마길 8-13</td>
			    <td> 02-825-1273</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>한국성폭력상담소</td>
			    <td class="txt-left">서울특별시    마포구 성지1길 32-42</td>
			    <td>02-338-2890</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>한국여성민우회성폭력상담소</td>
			    <td class="txt-left">서울특별시    마포구 월드컵로 26길 39</td>
			    <td>02-739-8858</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>탁틴내일청소년성폭력상담소</td>
			    <td class="txt-left">서울특별시    서대문구 신촌로7길 18(창천동)</td>
			    <td>02-338-2890</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>서초성폭력상담소</td>
			    <td class="txt-left">서울특별시    서초구 서초대로27길 10-10 4층(방배동)</td>
			    <td>02-599-7606</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>한국여성상담센터</td>
			    <td class="txt-left">서울특별시    성북구 보문로22길 28 신일빌딩 4층</td>
			    <td>02-953-1704</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>북한이탈여성 성폭력피해상담소</td>
			    <td class="txt-left">서울특별시    양천구 목동서로 131, 301호 <br />(목동, 양천사회단체봉사센터) </td>
			    <td>02-2655-1365</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>꿈터성폭력상담소</td>
			    <td class="txt-left">서울특별시    영등포구 여의대방로13길 14(신길동)</td>
			    <td>02-6083-4971</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>서울여성장애인성폭력상담소</td>
			    <td class="txt-left">서울특별시    영등포구 의사당대로 22, 402호<br />(여의도동, 이룸센터)</td>
			    <td>02-3675-4465~6</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>한국여성의전화    성폭력상담소</td>
			    <td class="txt-left">서울특별시    은평구 진흥로16길 8-4(녹번동)</td>
			    <td>02-3156-5463</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>꿈누리여성장애인상담소</td>
			    <td class="txt-left">서울특별시    중랑구 동일로 129길 35, 208 <br />(중화동, 태능시장 주상복합빌딩)</td>
			    <td>02-902-3356</td>
			  </tr>
			  <tr>
			    <td>세종시</td>
			    <td>세종YWCA성인권상담센터</td>
			    <td class="txt-left">세종특별자치시    조치원읍 조치원5길 75 여성회관1층</td>
			    <td>044-862-9191</td>
			  </tr>
			  <tr>
			    <td>세종시</td>
			    <td>종촌종합복지센터    <br />가정,성폭력 통합상담소</td>
			    <td class="txt-left">세종특별자치시    도움1로 116 종촌복지센터 3층</td>
			    <td>044-850-3095</td>
			  </tr>
			  <tr>
			    <td>울산시</td>
			    <td>생명의전화울산지부부설    <br />가정·성폭력통합상담소</td>
			    <td class="txt-left">울산시    남구 문수로 313, 삼성빌딩 505호</td>
			    <td>052-265-5570</td>
			  </tr>
			  <tr>
			    <td>울산시</td>
			    <td>동구가정성폭력통합상담소</td>
			    <td class="txt-left">울산 동구    내진길 18</td>
			    <td>052    252 6778</td>
			  </tr>
			  <tr>
			    <td>울산시</td>
			    <td>울산장애인성폭력상담소</td>
			    <td class="txt-left">울산광역시    울주군 범서읍 천상중앙길 104</td>
			    <td>052-246-1368</td>
			  </tr>
			  <tr>
			    <td>울산시</td>
			    <td>법률구조법인한국가정법률상담소    <br />울산지부부설 울산성폭력상담소</td>
			    <td class="txt-left">울산 중구    중앙길 127</td>
			    <td>052-245-1366</td>
			  </tr>
			  <tr>
			    <td>인천시</td>
			    <td>인구보건복지협회인천지회<br>
			      성폭력상담소</td>
			    <td class="txt-left">인천    남동구 용천로 142  (간석동 34-4)</td>
			    <td>032-451-4093~4</td>
			  </tr>
			  <tr>
			    <td>인천시</td>
			    <td>인천장애인성폭력상담소</td>
			    <td class="txt-left">인천    남동구 용천로208 사회복지회관 707호(간석3동 26-3)</td>
			    <td>032-424-1366</td>
			  </tr>
			  <tr>
			    <td>인천시</td>
			    <td>(사)인천광역시여성단체협의회부설<br />성,가정폭력상담소</td>
			    <td class="txt-left">인천광역시    미추홀구 경인로 345, 3층 (주안동, 인천명품관)</td>
			    <td>032-865-1365</td>
			  </tr>
			  <tr>
			    <td>인천시</td>
			    <td>오내친구장애인성폭력상담소</td>
			    <td class="txt-left">인천광역시    부평구 부평대로 137-10, 107동 101호 <br />(부평동, 스카이빌라트)</td>
			    <td>032-506-5479</td>
			  </tr>
			  <tr>
			    <td>전남</td>
			    <td>나주여성상담센터</td>
			    <td class="txt-left">전라남도 나주시 중앙로 50</td>
			    <td>061-337-1366</td>
			  </tr>
			  <tr>
			    <td>전남</td>
			    <td>담양인권지원상담소</td>
			    <td class="txt-left">전라남도    담양군 담양읍 중앙로 18 2층</td>
			    <td>061-381-1366</td>
			  </tr>
			  <tr>
			    <td>전남</td>
			    <td>목포여성상담센터</td>
			    <td class="txt-left">전라남도    목포시 신흥로83번길 5 </td>
			    <td>061-285-1366</td>
			  </tr>
			  <tr>
			    <td>전남</td>
			    <td>목포여성장애인성폭력상담소</td>
			    <td class="txt-left">전라남도    목포시 영산로 361</td>
			    <td>061-283-4767</td>
			  </tr>
			  <tr>
			    <td>전남</td>
			    <td>무안여성상담센터</td>
			    <td class="txt-left">전라남도 무안군 무안로 522-1</td>
			    <td>061-454-1360</td>
			  </tr>
			  <tr>
			    <td>전남</td>
			    <td>전남성폭력상담소</td>
			    <td class="txt-left">전라남도    순천시 서문성터길 104</td>
			    <td>061-753-1366</td>
			  </tr>
			  <tr>
			    <td>전남</td>
			    <td>여수성폭력상담소</td>
			    <td class="txt-left">전라남도    여수시 어항로 6</td>
			    <td>061-666-4001</td>
			  </tr>
			  <tr>
			    <td>전남</td>
			    <td>보두마상담센터</td>
			    <td class="txt-left">전라남도    함평군 함평읍 외대화길 27 하나캐슬 203동 101호</td>
			    <td>061-324-1388 </td>
			  </tr>
			  <tr>
			    <td>전남</td>
			    <td>해남성폭력상담소</td>
			    <td class="txt-left">전라남도 해남군 해남읍 북부순환로 30</td>
			    <td>061-533-9181</td>
			  </tr>
			  <tr>
			    <td>전북</td>
			    <td>군산성폭력상담소</td>
			    <td class="txt-left">전북    군산시 구영7길 8</td>
			    <td>063-442-1570</td>
			  </tr>
			  <tr>
			    <td>전북</td>
			    <td>성폭력예방치료센타김제지부 <br />성폭력상담소<br></td>
			    <td class="txt-left">전북    김제시 금성로 53-1</td>
			    <td>063-546-8366</td>
			  </tr>
			  <tr>
			    <td>전북</td>
			    <td>남원YWCA부설성폭력상담소</td>
			    <td class="txt-left">전북    남원시 시청로 65 2층</td>
			    <td>063-625-1316</td>
			  </tr>
			  <tr>
			    <td>전북</td>
			    <td>남원성폭력상담소</td>
			    <td class="txt-left">전북    남원시 요천로 1415</td>
			    <td>063-635-0712</td>
			  </tr>
			  <tr>
			    <td>전북</td>
			    <td>익산    성폭력상담소</td>
			    <td class="txt-left">전북    익산시 인북로  187(익산상공회의소5층)</td>
			    <td>063-834-1366</td>
			  </tr>
			  <tr>
			    <td>전북</td>
			    <td>새벽이슬장애인성폭력상담소</td>
			    <td class="txt-left">전북    전주시 완산구 신봉3길 6</td>
			    <td>063-223-3015</td>
			  </tr>
			  <tr>
			    <td>전북</td>
			    <td>성폭력예방치료센터    부설성폭력상담소</td>
			    <td class="txt-left">전북    전주시 완산구 인정2길12-4, 3층</td>
			    <td>063-236-0151</td>
			  </tr>
			  <tr>
			    <td>전북</td>
			    <td>성폭력예방치료센타정읍지부    <br />성폭력상담소</td>
			    <td class="txt-left">전북    정읍시 충정로 273(대율빌딩5층)</td>
			    <td>063-537-1366</td>
			  </tr>
			  <tr>
			    <td>제주</td>
			    <td>제주YWCA    통합상담소</td>
			    <td class="txt-left">제주시    삼무로11길</td>
			    <td>064-748-3040</td>
			  </tr>
			  <tr>
			    <td>제주</td>
			    <td>제주여성상담소</td>
			    <td class="txt-left">제주시    관덕로8길 32(삼도이동)</td>
			    <td>064-756-4008</td>
			  </tr>
			  <tr>
			    <td>제주</td>
			    <td>제주여성장애인상담소</td>
			    <td class="txt-left">제주시    복지로 3길 1-4(도남동)</td>
			    <td>064-753-4980</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>로뎀나무상담지원센터</td>
			    <td class="txt-left">충남    공주시 신금1길 44-11, 4층</td>
			    <td>041-852-1950</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>금산성인권상담소</td>
			    <td class="txt-left">충남 금산군 금산읍 비호산로57 <br />삼호아파트상가 105호,    106호, 201호, 202호</td>
			    <td>041-450-7366</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>금산성폭력상담센터</td>
			    <td class="txt-left">충남 금산군 금산읍 금산로 1444</td>
			    <td>041-752-9911</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>당진성상담센터</td>
			    <td class="txt-left">충남 당진시 무수동로 36 용연빌딩 2층.3층</td>
			    <td>041-354-2366</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>대천성폭력상담소</td>
			    <td class="txt-left">충남 보령시 대천로 35</td>
			    <td>041-931-1366</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>부여성폭력상담소</td>
			    <td class="txt-left">충남 부여군 부여읍 사비로 32  여성문화회관</td>
			    <td>041-830-2923</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>서천성폭력상담소</td>
			    <td class="txt-left">충청남도 서천군 장항읍 장마로 14</td>
			    <td>041-956-8255</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>아산가정성상담지원센터</td>
			    <td class="txt-left">충남 아산시 배방읍 순천향로 1060</td>
			    <td>041-546-9191</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>아산늘품상담지원센터</td>
			    <td class="txt-left">충남 아산시 번영로 69번길 10-3</td>
			    <td>041-541-0119</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>장애인성폭력아산상담소</td>
			    <td class="txt-left">충남 아산시 번영로 115번길 20-14</td>
			    <td>041-541-1514</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>예산 성폭력 상담소</td>
			    <td class="txt-left">충남 예산읍 주교로 50 2층</td>
			    <td>041-335-1311</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>천안여성의전화부설성폭력상담소</td>
			    <td class="txt-left">충남 천안시 동남구 고재20길 12(2층)(원성동)</td>
			    <td>041-561-0303, 20</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>충남성폭력상담소</td>
			    <td class="txt-left">충남 천안시 동남구 중앙로    66(영성동)</td>
			    <td>041-564-0026~7</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>천안장애인성폭력상담소</td>
			    <td class="txt-left">충남 천안시 서북구 두정역서5길 4, <br />두정프라자    301호(두정동)</td>
			    <td>041-592-6500</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>태안군성인권상담센터</td>
			    <td class="txt-left">충남 태안군 태안읍 서문4길 31-6</td>
			    <td>041-675-9536</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>홍성성가정폭력통합상담소</td>
			    <td class="txt-left">충남    홍성군 홍성읍 충서로 1121-32 (2층)</td>
			    <td>041-631-3939</td>
			  </tr>
			  <tr>
			    <td>충북</td>
			    <td>한스심리상담센터</td>
			    <td class="txt-left">충북    단양군 단양읍 삼봉로 274, 2층 </td>
			    <td>043-422-3004</td>
			  </tr>
			  <tr>
			    <td>충북</td>
			    <td>영동가정폭력성폭력통합상담소</td>
			    <td class="txt-left">충북 영동군 영동읍 회동로 212-1, (2층)</td>
			    <td>043-743-1366</td>
			  </tr>
			  <tr>
			    <td>충북</td>
			    <td>제천성폭력상담소</td>
			    <td class="txt-left">충북    제천시 내제로 5길 12(명동)</td>
			    <td>043-652-0049,    <br />653-1331</td>
			  </tr>
			  <tr>
			    <td>충북</td>
			    <td>사)청주여성의전화    부설 <br />청주성폭력상담소 </td>
			    <td class="txt-left">충북    청주시 상당구 대성로 57(서운동) 3층</td>
			    <td>043-252-0968</td>
			  </tr>
			  <tr>
			    <td>충북</td>
			    <td>충북여성장애인연대    부설 <br />청주여성장애인성폭력상담소</td>
			    <td class="txt-left">충북    청주시 상당구 상당로26번길 15-2 (서운동)</td>
			    <td>043-224-9414</td>
			  </tr>
			  <tr>
			    <td>충북</td>
			    <td>인구보건복지협회충북세종지회    <br />청주성폭력상담소</td>
			    <td class="txt-left">충북    청주시 흥덕구 내수동로 20(복대동)</td>
			    <td>043-263-2000</td>
			  </tr>
			  <tr>
			    <td>충북</td>
			    <td>청주YWCA여성종합상담소</td>
			    <td class="txt-left">충북    청주시 흥덕구 1순환로536번길 4, 1층(봉명동)</td>
			    <td>043-268-3007</td>
			  </tr>
			  <tr>
			    <td>충북</td>
			    <td>충주성폭력상담소</td>
			    <td class="txt-left">충북    충주시 예성로 135</td>
			    <td>043-845-1366</td>
			  </tr>
		</tbody>
	</table>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>