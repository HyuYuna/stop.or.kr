<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb3.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="정보공개" />
	<jsp:param name="path" value="경영공시" />
	<jsp:param name="path" value="사전공표목록" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<div class="box1">
	<span class="bg"><img src="../../../images/kor/sub/bg1.gif" alt=""></span>
	<p class="txt">
		한국여성인권진흥원은 보유ㆍ관리하는 중요 정책ㆍ사업, 예산집행 등에 관한 정보를
		「공공기관의 정보공개에 관한법률」제7조에 의거 사전에 공개범위·주기·시기·방법을 미리 공표하고
		정기적으로 한국여성인권진흥원 홈페이지 등에 공개하고 있습니다. 
	</p>
</div>

<div class="table-wrap">
<table>
<caption>사전공표목록 - No.공표목록,공표항목,공표시기,공표주기,공표방법,담당부서</caption>
<colgroup>
<col style="width:5%">
<col style="width:15%">
<col style="width:30%">
<col span="4">
</colgroup>
	<tbody><tr>
        <th scope="col">No.</th>
        <th scope="col">공표목록</th>
        <th scope="col">공표항목</th>
        <th scope="col">공표시기</th>
        <th scope="col">공표주기</th>
        <th scope="col">공표방법</th>
        <th scope="col">담당부서</th>
      </tr>
      <tr>
        <td>1</td>
        <td>기관업무보고자료</td>
        <td class="txt-left">일반현황, 주요 업무계획(사업계획 등)</td>
        <td>4월</td>
        <td>매년</td>
        <td>홈페이지</td>
        <td>경영지원본부</td>
      </tr>
      <tr>
        <td>2</td>
        <td>정부경영실적평가</td>
        <td class="txt-left">기관평가</td>
        <td>6월</td>
        <td>매년</td>
        <td>홈페이지</td>
        <td>경영지원본부</td>
      </tr>
      <tr>
        <td>3</td>
        <td>기관관련 주요법령</td>
        <td class="txt-left">법, 시행령, 시행규칙, 사내규정 등</td>
        <td>사유발생 시</td>
        <td>수시</td>
        <td>홈페이지</td>
        <td>경영지원본부</td>
      </tr>
      <tr>
        <td>4</td>
        <td>노사협의회현황</td>
        <td class="txt-left">협의회구성 및 기능, 협의회 운영방법,<br>노사협의회 의결사항</td>
        <td>익월</td>
        <td>분기</td>
        <td>홈페이지</td>
        <td>경영지원본부</td>
      </tr>
      <tr>
        <td>5</td>
        <td>기관장 업무추진비<br>집행현황 </td>
        <td class="txt-left">사용일자, 사용내역, 금액 등 집행사항</td>
        <td>익월</td>
        <td>매월</td>
        <td>홈페이지</td>
        <td>경영지원본부</td>
      </tr>
      <tr>
        <td>6</td>
        <td>채용통계</td>
        <td class="txt-left">채용개요, 채용인원, 지원인원, 경쟁률</td>
        <td>4월</td>
        <td>매년</td>
        <td>홈페이지</td>
        <td>경영지원본부</td>
      </tr>
      <tr>
        <td>7</td>
        <td>MOU체결현황 </td>
        <td class="txt-left">유관기관 등과 MOU 체결현황</td>
        <td>4월</td>
        <td>매년</td>
        <td>홈페이지</td>
        <td>경영지원본부</td>
      </tr>
      <tr>
        <td>8</td>
        <td>사회공헌활동현황</td>
        <td class="txt-left">계기, 지원일자, 지원대상, 지원내역,<br>지원금액, 재원조달(모금, 예산)</td>
        <td>사유발생 시</td>
        <td>수시</td>
        <td>홈페이지</td>
        <td>경영지원본부</td>
      </tr>
      <tr>
        <td>9</td>
        <td>중소기업제품<br>구매실적</td>
        <td class="txt-left">품목, 구매금액, 전체 구매액 대비 비율</td>
        <td>4월</td>
        <td>매년</td>
        <td>홈페이지</td>
        <td>경영지원본부</td>
      </tr>
      <tr>
        <td>10</td>
        <td>장애인생산품<br>구매실적</td>
        <td class="txt-left">품목, 구매금액, 전체 구매액 대비 비율</td>
        <td>4월</td>
        <td>매년</td>
        <td>홈페이지</td>
        <td>경영지원본부</td>
      </tr>
      <tr>
        <td>11</td>
        <td>대외포상<br>수상내역</td>
        <td class="txt-left">포상일자, 포상훈격, 포상대상자,<br>포상기관, 포상제목</td>
        <td>4월</td>
        <td>매년</td>
        <td>홈페이지</td>
        <td>경영지원본부</td>
      </tr>
      <tr>
        <td>12</td>
        <td>상품권<br>구매내역</td>
        <td class="txt-left">상품권 구매 및 사용현황</td>
        <td>4월</td>
        <td>매년</td>
        <td>홈페이지</td>
        <td>경영지원본부</td>
      </tr>
    </tbody></table>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>