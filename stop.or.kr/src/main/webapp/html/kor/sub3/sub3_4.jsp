<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb3.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="정보공개" />
	<jsp:param name="path" value="경영공시" />
	<jsp:param name="path" value="공공데이터개방" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<article class="box2">
	<span class="bg"><img src="../../../images/kor/sub/data.png" alt=""></span>
	<div class="txt">
		<h2>공공데이터</h2>
		<p>“공공데이터”란 데이터베이스, 전자화된 파일 등 공공기관이 법령 등에서 정하는 목적을 위하여 생성 또는 취득하여 관리하고 있는 전자적 방식으로 처리된 자료 또는 정보를 말합니다.</p>
	</div>
</article>

<h3 class="title1">공공데이터 개방</h3>
<p>“공공데이터 개방”은 공공데이터를 민간에 제공함으로써 민간 활용을 통한 신규 비즈니스와 일자리 창출, 국민 편익을 향상하기 위한 제도입니다.</p>

<h3 class="title1">공공데이터의 제공 및 이용 활성화에 관한 법률</h3>
<p>“공공데이터의 제공 및 이용 활성화에 관한 법률”에 따라 공공데이터 제공책임관(제12조)을 아래와 같이 공표하며, 제공목록(제19조)은 공공데이터포털(https://www.data.go.kr/)을 통해 확인하실 수 있고, 동법 제27조에 따라 제공목록에 포함되지 않은 공공데이터를 신청하실 수 있습니다. </p>

<h3 class="title1">공공데이터제공 책임관 및 실무담당자</h3>
<div class="table-wrap board">
	<table>
		<caption>공공데이터제공 책임관 및 실무담당자 - 구분, 부서/직위, 성명, 연락처</caption>
		<thead>
			<tr>
				<th scope="col">구분</th>
				<th scope="col">부서/직위</th>
				<th scope="col">성명</th>
				<th scope="col">연락처</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="point1">공공데이터 책임관</td>
				<td class="point1">경영기획본부 본부장</td>
				<td>김지혜</td>
				<td>02-735-0161</td>
			</tr>
			<tr>
				<td class="point1">공공데이터 담당자</td>
				<td class="point1">경영기획본부 대외홍보팀 팀원</td>
				<td>김다빈</td>
				<td>02-735-8992</td>
			</tr>
		</tbody>
	</table>
</div>

<p class="btns">
	<a href="" class="btn-b btn3">공공데이터 제공목록 바로가기</a>
	<a href="" class="btn-b btn3">공공데이터 제공신청 바로가기</a>
</p>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>