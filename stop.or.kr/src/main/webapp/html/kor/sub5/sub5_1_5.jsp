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
	<li><a href="sub5_1_4.jsp">성매매피해상담소</a></li>
	<li class="active"><a href="sub5_1_5.jsp">해바라기센터</a></li>
</ul>

<h2 class="title1">해바라기센터</h2>
<p>
	법률상 명칭인 ‘성폭력 피해자 통합지원센터’는 ‘성폭력’이라는 부정적 의미보다 피해자가 시설 이용으로 해바라기 꽃처럼 활짝 웃을 수 있는 희망을 함께 가지길 
	바라는 의미에서 ‘해바라기’라는 표현을 처음 사용하게 되었습니다. 이후 전국 센터 및 관련부처 협의를 거쳐 2015년 1월부터 지금의 ‘해바라기센터’로 명칭을 
	일원화하였습니다.
</p>
<br/>
<p class="txt-center">
	<img src="../../../images/kor/sub/sunflower.gif" alt="[같이가요 해바라기센터] 전국 38개 센터 운영 - 통합형 14개, 위기지원형 16개, 아동형 8개" />
</p>

<div class="table-wrap">
	<table>
		<caption>해바라기센터 - 지역, 기관명, 주소, 연락처</caption>
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
			    <td>강원동부해바라기센터</td>
			    <td class="txt-left">강원도 강릉시    강릉대로419번길 42 강릉동인병원 별관</td>
			    <td>033-652-9840</td>
			  </tr>
			  <tr>
			    <td>강원도</td>
			    <td>강원서부해바라기센터</td>
			    <td class="txt-left">강원도    춘천시 백령로156 강원대학병원 어린이병원 지하2층</td>
			    <td>033-252-1375</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>경기북서부해바라기센터</td>
			    <td class="txt-left">경기도    고양시 덕양구 화정로 65-1 우리프라자 5층</td>
			    <td>통합    : 031-816-1375</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>경기해바라기센터(아동)</td>
			    <td class="txt-left">경기도    성남시 분당구 판교로 471 한화빌딩 5층</td>
			    <td>031-708-1375</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>경기남부해바라기센터(거점)</td>
			    <td class="txt-left">경기도    수원시 영통구 월드컵로 185 2층</td>
			    <td>거점    : 031-217-9117 <br /> 통합 : 031-215-1117 <br />응급 : 031-216-1117</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>경기서부해바라기센터</td>
			    <td class="txt-left">경기도    안산시 단원구 선부광장1로 182 <br />한도병원 별관 3층 305호</td>
			    <td>031-364-8117</td>
			  </tr>
			  <tr>
			    <td>경기도</td>
			    <td>경기북동부해바라기센터</td>
			    <td class="txt-left">경기도    의정부시 흥선로142 의정부의료원 본관 3층</td>
			    <td>031-874-3117</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>경남해바라기센터(아동)</td>
			    <td class="txt-left">경상남도    진주시 강남로79 경상대학교병원 본관 지하1층</td>
			    <td>055-754-1375</td>
			  </tr>
			  <tr>
			    <td>경남</td>
			    <td>경남해바라기센터</td>
			    <td class="txt-left">경상남도    창원시 마산합포구 3.15대로231 마산의료원</td>
			    <td>055-244-8117,    <br />055-245-8117</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>경북서부해바라기센터</td>
			    <td class="txt-left">경상북도    김천시 신음1길12</td>
			    <td>054-439-9600</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>경북북부해바라기센터</td>
			    <td class="txt-left">경상북도    안동시 태사2길55 안동의료원</td>
			    <td>054-843-1117</td>
			  </tr>
			  <tr>
			    <td>경북</td>
			    <td>경북동부해바라기센터</td>
			    <td class="txt-left">경상북도    포항시 남구 대잠동길 17 포항성모병원 성루가관 지하3층</td>
			    <td>054-278-1375</td>
			  </tr>
			  <tr>
			    <td>광주시</td>
			    <td>광주해바라기센터</td>
			    <td class="txt-left">광주광역시    동구 필문대로365 조선대학교병원 2층</td>
			    <td>062-225-3117</td>
			  </tr>
			  <tr>
			    <td>광주시</td>
			    <td>광주해바라기센터(아동)</td>
			    <td class="txt-left">광주광역시    동구 제봉로57 웰크리닉 4층</td>
			    <td>062-232-1375</td>
			  </tr>
			  <tr>
			    <td>대구시</td>
			    <td>대구해바라기센터</td>
			    <td class="txt-left">대구광역시    서구 평리로157 대구의료원 건강증진센터 2층</td>
			    <td>053-556-8117,    <br />053-556-9117</td>
			  </tr>
			  <tr>
			    <td>대구시</td>
			    <td>대구해바라기센터(아동)</td>
			    <td class="txt-left">대구광역시    중구 동덕로125 금화빌딩 5층</td>
			    <td>053-421-1375</td>
			  </tr>
			  <tr>
			    <td>대전시</td>
			    <td>대전해바라기센터</td>
			    <td class="txt-left">대전광역시    중구 문화로282 충남대학교병원</td>
			    <td>042-280-8436~7</td>
			  </tr>
			  <tr>
			    <td>부산시</td>
			    <td>부산해바라기센터</td>
			    <td class="txt-left">부산광역시    서구 구덕로 179 <br />부산대학교 병원 융합의학연구동 6층</td>
			    <td>051-244-1375</td>
			  </tr>
			  <tr>
			    <td>부산시</td>
			    <td>부산동부해바라기센터</td>
			    <td class="txt-left">부산    연제구 월드컵대로 359 부산의료원 1층</td>
			    <td>051-501-9117</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>서울북부해바라기센터</td>
			    <td class="txt-left">서울특별시    동대문구 망우로 82 서울북부해바라기센터</td>
			    <td>02-3390-4145</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>서울남부해바라기센터</td>
			    <td class="txt-left">서울    동작구 보라매로5길 20 보라매병원 희망관 2층</td>
			    <td>02-870-1700</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>서울해바라기센터(아동)</td>
			    <td class="txt-left">서울특별시    마포구 백범로23 구프라자 7층</td>
			    <td>02-3274-1375</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>서울동부해바라기센터</td>
			    <td class="txt-left">서울    송파구 송이로 123 경찰병원 1층</td>
			    <td>02-3400-1117</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>서울해바라기센터</td>
			    <td class="txt-left">서울    종로구 대학로8가길 56 동숭빌딩 2층</td>
			    <td>02-3672-0365<br />별관 02-745-0366~7</td>
			  </tr>
			  <tr>
			    <td>서울시</td>
			    <td>서울중부해바라기센터</td>
			    <td class="txt-left">서울    중구 을지로 245</td>
			    <td>02-2266-8276</td>
			  </tr>
			  <tr>
			    <td>울산시</td>
			    <td>울산해바라기센터</td>
			    <td class="txt-left">울산광역시    남구 월평로171번길 13 울산병원 8층</td>
			    <td>052-265-1375</td>
			  </tr>
			  <tr>
			    <td>인천시</td>
			    <td>인천해바라기센터(아동)</td>
			    <td class="txt-left">인천광역시    남동구 남동대로769 한성빌딩 2층</td>
			    <td>032-423-1375</td>
			  </tr>
			  <tr>
			    <td>인천시</td>
			    <td>인천동부해바라기센터</td>
			    <td class="txt-left">인천광역시    동구 방축로217 인천의료원</td>
			    <td>032-582-1170~1</td>
			  </tr>
			  <tr>
			    <td>인천시</td>
			    <td>인천북부해바라기센터</td>
			    <td class="txt-left">인천광역시    부평구 동수로56 가톨릭대학교 인천성모병원</td>
			    <td>032-280-5678</td>
			  </tr>
			  <tr>
			    <td>전남</td>
			    <td>전남서부해바라기센터</td>
			    <td class="txt-left">전라남도    목포시 영산로623 목포중앙병원별관5층</td>
			    <td>061-285-1375</td>
			  </tr>
			  <tr>
			    <td>전남</td>
			    <td>전남동부해바라기센터</td>
			    <td class="txt-left">전라남도    순천시 순광로221 순천성가롤로병원 별관</td>
			    <td>061-727-0117</td>
			  </tr>
			  <tr>
			    <td>전북</td>
			    <td>전북서부해바라기센터</td>
			    <td class="txt-left">전북    익산시 무왕로 895 원광대학교병원</td>
			    <td>063-859-1375</td>
			  </tr>
			  <tr>
			    <td>전북</td>
			    <td>전북해바라기센터</td>
			    <td class="txt-left">전라북도    전주시 덕진구 건지로20 <br />전북대학교병원 응급센터 지하1층</td>
			    <td>063-278-0117</td>
			  </tr>
			  <tr>
			    <td>전북</td>
			    <td>전북해바라기센터(아동)</td>
			    <td class="txt-left">전라북도    전주시 덕진구 백제대로751 뱅크빌딩 2층</td>
			    <td>063-246-1375</td>
			  </tr>
			  <tr>
			    <td>제주</td>
			    <td>제주해바라기센터</td>
			    <td class="txt-left">본관:제주    제주시 도령로 65, 2층(연동,한라병원)<br>
			      별관:제주 제주시 남녕로 5-3, 3층</td>
			    <td>064-749-5117 <br />별관 064-748-5117</td>
			  </tr>
			  <tr>
			    <td>충남</td>
			    <td>충남해바라기센터</td>
			    <td class="txt-left">충청남도    천안시 동남구 망향로201 단국대학교병원</td>
			    <td>041-567-7117</td>
			  </tr>
			  <tr>
			    <td>충북</td>
			    <td>충북해바라기센터</td>
			    <td class="txt-left">충청북도    청주시 서원구 흥덕로 48</td>
			    <td>043-272-7117</td>
			  </tr>
			  <tr>
			    <td>충북</td>
			    <td>충북해바라기센터(아동)</td>
			    <td class="txt-left">충청북도    충주시 봉현로222(교현동, 보성빌딩 4층)</td>
			    <td>043-857-1375</td>
			  </tr>
		</tbody>
	</table>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>