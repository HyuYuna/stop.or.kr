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
	<li><a href="sub5_1_3.jsp">성폭력피해상담소</a></li>
	<li class="active"><a href="sub5_1_4.jsp">성매매피해상담소</a></li>
	<li><a href="sub5_1_5.jsp">해바라기센터</a></li>
</ul>

<h2 class="title1">성매매피해상담소</h2>

<div class="table-wrap">
	<table>
		<caption>성매매피해상담소 - 지역, 기관명, 주소, 연락처</caption>
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
			    <td>춘천길잡이의 집</td>
			    <td class="txt-left">강원도 춘천시 중앙로 131 춘천시민복지회관 3층</td>
			    <td>033-243-8297</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>동두천    새움터 부설 자활지원센터</td>
			    <td class="txt-left">경기    동두천시 중앙로 320 2층</td>
			    <td>031-867-4655</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>성매매피해상담소    with us</td>
			    <td class="txt-left">경기도    성남시 수정구 수정북로 92<br />(태평동락커뮤니티) 302호</td>
			    <td>031-747-0117</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>수원자활지원센터    모모이</td>
			    <td class="txt-left">경기도    수원시 팔달구 중부대로20 7층</td>
			    <td>031-243-7780</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>어깨동무</td>
			    <td class="txt-left">경기도    수원시 팔달구 중부대로20 7층</td>
			    <td>031-222-0122</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>두레방</td>
			    <td class="txt-left">경기    의정부시 송산로 999번길 15</td>
			    <td>031-841-2609</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>여성인권센터    쉬고</td>
			    <td class="txt-left">경기도    파주시 황골로 77, 2층</td>
			    <td>031-957-6117</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>평택    새움터 부설 자활지원센터</td>
			    <td class="txt-left">경기도    평택시 탄현로 250 2층</td>
			    <td>031-663-4655</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>경남여성인권지원센터</td>
			    <td class="txt-left">경남    창원시 마산합포구 중앙북5길 20</td>
			    <td>055-246-8297~8</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>여성인권상담소</td>
			    <td class="txt-left">경남    창원시 의창구 도계로 102 대남상가 304호</td>
			    <td>055-273-2241</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>범숙학교</td>
			    <td class="txt-left">경남    창원시 의창구 북면 동전로 179-18</td>
			    <td>055-298-1127</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>경북성매매피해상담센터    새날</td>
			    <td class="txt-left">경북    포항시 북구 용당로 109번길 9</td>
			    <td>054-231-8297</td>
			  </tr>
			  <tr>
			    <td>광주시</td>
			    <td>광주여성자활지원센터    다힘</td>
			    <td class="txt-left">광주광역시    동구 백서로125번길 5(금동 2,3층)</td>
			    <td>062-226-8297</td>
			  </tr>
			  <tr>
			    <td>광주시</td>
			    <td>성매매피해상담소    언니네</td>
			    <td class="txt-left">광주광역시    동구 중앙로 196번길 29, 2층</td>
			    <td>062-431-8297</td>
			  </tr>
			  <tr>
			    <td>대구시</td>
			    <td>민들레</td>
			    <td class="txt-left">대구 중구    태평로 53-13 2층</td>
			    <td>053-430-6020</td>
			  </tr>
			  <tr>
			    <td>대구시</td>
			    <td>생생이랑</td>
			    <td class="txt-left">대구    중구 국채보상로 683(유성빌딩) 4층</td>
			    <td>053-426-4898</td>
			  </tr>
			  <tr>
			    <td>대구시</td>
			    <td>힘내</td>
			    <td class="txt-left">대구 중구    국채보상로 683 2층</td>
			    <td>053-422-8297</td>
			  </tr>
			  <tr>
			    <td>대전시</td>
			    <td>여성인권지원상담소    느티나무</td>
			    <td class="txt-left">대전    중구 목중로 54번길 17 2층</td>
			    <td>042-256-8297</td>
			  </tr>
			  <tr>
			    <td>부산시</td>
			    <td>여성인권지원센터    살림</td>
			    <td class="txt-left">부산시    서구 구덕로 147, 3층</td>
			    <td>051-257-8297</td>
			  </tr>
			  <tr>
			    <td>부산시</td>
			    <td>자활지원센터    숲</td>
			    <td class="txt-left">부산광역시    서구 구덕로147, 4층</td>
			    <td>051-256-8297</td>
			  </tr>
			  <tr>
			    <td>부산시</td>
			    <td>부산여성지원센터    꿈아리</td>
			    <td class="txt-left">부산시    해운대구 마린시티 3로 1, 408호</td>
			    <td>051-816-1366</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>여성인권상담소    소냐의 집</td>
			    <td class="txt-left">서울특별시    강동구 구천면로 285 3층</td>
			    <td>02-474-0746</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>늘푸른    자립학교</td>
			    <td class="txt-left">서울시    관악구 관천로 113</td>
			    <td>02-326-1318</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>성매매피해상담소    이룸</td>
			    <td class="txt-left">서울시    동대문구 무학로 37길 30, 5층 이룸</td>
			    <td>02-953-6279</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>여성인권지원상담소    에이레네</td>
			    <td class="txt-left">서울    동대문구 왕산로45길 32(청량리동44-4)</td>
			    <td>02-3394-7946</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>서울특별시    다시함께상담센터</td>
			    <td class="txt-left">서울    동작구 여의대방로54길 18 4층</td>
			    <td>02-814-3660</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>여성인권센터 보다</td>
			    <td class="txt-left">서울시 성북구 삼양로 42-1 B동 202호</td>
			    <td>02-982-0923</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>십대여성인권센터</td>
			    <td class="txt-left">서울시 영등포구 당산동 4가 32-40    은혜빌딩 6층</td>
			    <td>010-7705-1318</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>여성성공센터    W-ing</td>
			    <td class="txt-left">서울시    영등포구 영등포로 420-6</td>
			    <td>02-843-3872</td>
			  </tr>
			  <tr>
			    <td>울산시</td>
			    <td>울산성매매피해상담소</td>
			    <td class="txt-left">울산시    남구 삼호로 81, 4층</td>
			    <td>052-249-8297</td>
			  </tr>
			  <tr>
			    <td>인천시</td>
			    <td>달빛공방    자활지원센터</td>
			    <td class="txt-left">인천광역시    미추홀구 경인로321 수림빌딩 10층</td>
			    <td>032-519-8297<br>
			      032-518-8297</td>
			  </tr>
			  <tr>
			    <td>인천시</td>
			    <td>희희낙낙상담소</td>
			    <td class="txt-left">인천광역시    미추홀구 경인로321 수림빌딩 10층</td>
			    <td>032-507-0182</td>
			  </tr>
			  <tr>
			    <td>전남</td>
			    <td>목포여성인권지원센터    디딤</td>
			    <td class="txt-left">전남    목포시 용당로 151(2층)</td>
			    <td>061-276-8297</td>
			  </tr>
			  <tr>
			    <td>전남</td>
			    <td>순천여성인권지원센터</td>
			    <td class="txt-left">전남    순천시 강남로 144-1 , 2층</td>
			    <td>061-753-3644</td>
			  </tr>
			  <tr>
			    <td>전남</td>
			    <td>여수여성인권지원센터</td>
			    <td class="txt-left">전라남도    여수시 시청동3길 35</td>
			    <td>061-662-8297</td>
			  </tr>
			  <tr>
			    <td>전남</td>
			    <td>여수여성자활지원센터    징검다리</td>
			    <td class="txt-left">전남    여수시 흥국상가길 33 2층</td>
			    <td>061-685-7296</td>
			  </tr>
			  <tr>
			    <td>전북</td>
			    <td>여성자활지원센터</td>
			    <td class="txt-left">전북    전주시 완산구 권삼득로 76 1층</td>
			    <td>063-232-4248</td>
			  </tr>
			  <tr>
			    <td>전북</td>
			    <td>현장상담센터</td>
			    <td class="txt-left">전북    전주시 완산구 권삼득로 76 3층</td>
			    <td>063-282-8297</td>
			  </tr>
			  <tr>
			    <td>제주</td>
			    <td>제주자활지원센터</td>
			    <td class="txt-left">제주시    관덕로 8길 34 1층</td>
			    <td>064-722-7304</td>
			  </tr>
			  <tr>
			    <td>제주</td>
			    <td>제주현장상담센터    해냄</td>
			    <td class="txt-left">제주시    관덕로 8길 32 2층</td>
			    <td>064-702-8297</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>충남여성인권상담센터</td>
			    <td class="txt-left">충남    천안시 서북구 성정로 91 영진빌딩 3층</td>
			    <td>041-575-1366</td>
			  </tr>
			  <tr>
			    <td>충북</td>
			    <td>충북여성인권상담소    늘봄</td>
			    <td class="txt-left">충북    청주시 상당구 상당로 158번길 5호 </td>
			    <td>043-257-8297</td>
			  </tr>
		</tbody>
	</table>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>