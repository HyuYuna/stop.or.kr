<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb4.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="알림마당" />
	<jsp:param name="path" value="참여마당" />
	<jsp:param name="path" value="설문조사" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<ul class="tabmenu">
	<li><a href="sub4_3.jsp">공모전</a></li>
	<li><a href="sub4_3_2.jsp">이벤트</a></li>
	<li class="active"><a href="sub4_3_3.jsp">설문조사</a></li>
</ul>

<div class="board-view">
	<div class="view-event txt-center">
		<h1 class="view-title">설문조사 타이틀 </h1>
		<p>설문조사에 대한 설명문이 들어가는 부분 설문조사에 대한 설명문이 들어가는 부분 설문조사에 대한 설명문이 들어가는 부분 설문조사에 대한 설명문이 들어가는 부분 </p>
		
		<ul class="info">
			<li>
				<strong>기간</strong> 2018.2.7.(수)~2.28.(수)
			</li>
		</ul>
	</div>
	
	<div class="view-survey">
		<article class="group">
			<h2>여성인권진흥원 이용분야 관련</h2>
			
			<article class="item">
				<h3>선생님께서는 여성인권진흥원을 얼마나 자주 방문하십니까?</h3>
				<ul class="form-survey">
					<li class="form-set form-radio">
						<input type="radio" id="survey1-1">
						<label for="survey1-1">하루에 1회 이상</label>
					</li>
					<li class="form-set form-radio">
						<input type="radio" id="survey1-2">
						<label for="survey1-2">일주일에 3회 이상</label>
					</li>
					<li class="form-set form-radio">
						<input type="radio" id="survey1-3">
						<label for="survey1-3">일주일에 1회 이상</label>
					</li>
					<li class="form-set form-radio">
						<input type="radio" id="survey1-4">
						<label for="survey1-4">한달에 3회 이상</label>
					</li>
					<li class="form-set form-radio">
						<input type="radio" id="survey1-5">
						<label for="survey1-5">한달에 1회 이상</label>
					</li>
					<li class="form-set form-radio form-etc">
						<input type="radio" id="survey1-6">
						<label for="survey1-6">기타</label>
						<p><input type="text" title="기타 사유를 입력해주세요"></p>
					</li>
				</ul>
			</article>
			
			<article class="item">
				<h3>선생님께서 이용하시는 분야는 무엇입니까?</h3>
				<div class="table-wrap board">
					<table>
						<caption>공지사항 목록 - 번호, 분류, 제목, 담당부서, 등록일, 조회수</caption>
						<colgroup>
							<col class="date">
							<col class="date">
							<col class="subject">
							<col class="part">
							<col class="date">
							<col class="hit">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">분류</th>
								<th scope="col">제목</th>
								<th scope="col">담당부서</th>
								<th scope="col">등록일</th>
								<th scope="col">조회수</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><span class="notice">NOTICE</span></td>
								<td class="point1">공지사항</td>
								<td class="subject"><a href="sub4_2_1_2.jsp">미투 운동 이후, 1366 성폭력 상담 51% 올랐다</a><span class="new">새글</span></td>
								<td>경영지원팀</td>
								<td>2018.05.01</td>
								<td>112</td>
							</tr>
							<tr>
								<td><span class="notice">NOTICE</span></td>
								<td class="point1">채용소식</td>
								<td class="subject"><a href="sub4_2_1_2.jsp">불법촬영물 삭제요청 누가 할 수 있는지, 혹 아시나요</a></td>
								<td>경영지원본부</td>
								<td>2018.05.01</td>
								<td>112</td>
							</tr>
							<tr>
								<td>3</td>
								<td class="point1">공지사항</td>
								<td class="subject"><a href="sub4_2_1_2.jsp">배우 정려원 씨와 with you 하실 여러분을 찾습니다</a></td>
								<td>성매매방지중앙지원센터 현장지원팀</td>
								<td>2018.05.01</td>
								<td>112</td>
							</tr>
							<tr>
								<td>2</td>
								<td class="point1">채용소식</td>
								<td class="subject"><a href="sub4_2_1_2.jsp">제목이 들어갑니다.</a></td>
								<td>경영지원팀</td>
								<td>2018.05.01</td>
								<td>112</td>
							</tr>
							<tr>
								<td>1</td>
								<td class="point1">공지사항</td>
								<td class="subject"><a href="sub4_2_1_2.jsp">제목이 들어갑니다.</a></td>
								<td>경영지원본부</td>
								<td>2018.05.01</td>
								<td>112</td>
							</tr>
						</tbody>
					</table>
				</div>
			</article>
		</article>
		
		<article class="group">
			<h2>여성인권진흥원 이용분야 관련</h2>
			
			<article class="item">
				<h3>선생님께서는 여성인권진흥원을 얼마나 자주 방문하십니까?</h3>
				<textarea></textarea>
			</article>
			
			<article class="item">
				<h3>선생님께서 이용하시는 분야는 무엇입니까?</h3>
				<ul class="form-survey">
					<li class="form-set form-check">
						<input type="checkbox" id="survey2-1">
						<label for="survey2-1">하루에 1회 이상</label>
					</li>
					<li class="form-set form-check">
						<input type="checkbox" id="survey2-2">
						<label for="survey2-2">일주일에 3회 이상</label>
					</li>
					<li class="form-set form-check">
						<input type="checkbox" id="survey2-3">
						<label for="survey2-3">일주일에 1회 이상</label>
					</li>
					<li class="form-set form-check">
						<input type="checkbox" id="survey2-4">
						<label for="survey2-4">한달에 3회 이상</label>
					</li>
					<li class="form-set form-check">
						<input type="checkbox" id="survey2-5">
						<label for="survey2-5">한달에 1회 이상</label>
					</li>
					<li class="form-set form-check form-etc">
						<input type="checkbox" id="survey2-6">
						<label for="survey2-6">기타</label>
						<p><input type="text" title="기타 사유를 입력해주세요"></p>
					</li>
				</ul>
			</article>
		</article>
	</div>
	
	<p class="btns txt-center">
		<a href="sub4_3_3_3.jsp" class="btn-l btn1">제출하기</a>
		<a href="" class="btn-l btn2">뒤로가기</a>
	</p>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>