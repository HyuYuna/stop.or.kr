<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header_contest.jsp">
	<jsp:param name="snb" value="contest.jsp" />
	<jsp:param name="path" value="성매매방지 국민생각 공모전" />
	<jsp:param name="path" value="접수하기" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<h2 class="title1">기본 정보 입력</h2>
<div class="table-wrap board-write form">
	<table>
		<caption>기본 정보 입력 - 성명, 연락처, 이메일, 나이, 소속</caption>
		<colgroup>
			<col width="150px" />
			<col width="" />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><label for="name">성명</label></th>
				<td>
					<input type="text" class="w340" id="name">
				</td>
			</tr>
			<tr>
				<th scope="row">연락처</th>
				<td>
					<input type="text" class="w100" title="연락처 중 첫번째자리"> -
					<input type="text" class="w100" title="연락처 중 가운데자리"> -
					<input type="text" class="w100" title="연락처 중 마지막자리">
				</td>
			</tr>
			<tr>
				<th scope="row">이메일</th>
				<td>
					<input type="text" class="w170" title="이메일 중 아이디"> @
					<input type="text" class="w170" title="이메일 중 도메인">
					<select class="w170" title="이메일 중 도메인 선택">
						<option></option>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="age">나이</label></th>
				<td>
					<input type="text" class="w340" id="age">
					<a href="" class="btn-s btn5">14세 미만 동의서 다운로드</a>
					<p class="point1">
						만 14세 미만의 미성년자의 경우 법정 대리인의 동의를 반드시 받아야 합니다. 동의서 양식을 다운받아 작성한 후 <span class="point3">center@stop.or.kr</span>로 메일 보내주세요
					</p>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="position">소속</label></th>
				<td>
					<input type="text" class="w340" id="position">
				</td>
			</tr>
		</tbody>
	</table>
</div>

<h2 class="title1">기본 정보 입력</h2>
<div class="table-wrap board-write form">
	<table>
		<caption>출품작1 정보 - 개인/팀 구분, 공모대상, 작품명, 작품 설명, 파일 첨부</caption>
		<colgroup>
			<col width="70px" />
			<col width="150px" />
			<col width="" />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row" rowspan="5" class="title">1</th>
				<th scope="row">개인/팀 구분</th>
				<td>
					<span class="form-set form-radio">
						<input id="type1-1" name="agree3" type="radio">
						<label for="type1-1">개인</label>
					</span>
					<span class="form-set form-radio">
						<input id="type1-2" name="agree3" type="radio">
						<label for="type1-2">팀</label>
					</span>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="part1">공모대상</label></th>
				<td>
					<input type="text" class="w250" id="part1">
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="subject1">작품명</label></th>
				<td>
					<input type="text" class="w520" id="subject1">
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="desc1">작품 설명</label></th>
				<td>
					<textarea id="desc1">
					</textarea>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="file1">파일 첨부</label></th>
				<td>
					<input type="file" id="file1">
				</td>
			</tr>
		</tbody>
	</table>
</div>
<p class="btns txt-right">
	<a href="" class="btn-m btn5">작품추가</a>
	<a href="" class="btn-m btn2">작품삭제</a>
</p>

<div class="table-wrap board-write form">
	<table>
		<caption>출품작2 정보 - 개인/팀 구분, 공모대상, 작품명, 작품 설명, 파일 첨부</caption>
		<colgroup>
			<col width="70px" />
			<col width="150px" />
			<col width="" />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row" rowspan="5" class="title">1</th>
				<th scope="row">개인/팀 구분</th>
				<td>
					<span class="form-set form-radio">
						<input id="type2-1" name="agree3" type="radio">
						<label for="type2-1">개인</label>
					</span>
					<span class="form-set form-radio">
						<input id="type2-2" name="agree3" type="radio">
						<label for="type2-2">팀</label>
					</span>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="part2">공모대상</label></th>
				<td>
					<input type="text" class="w250" id="part2">
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="subject2">작품명</label></th>
				<td>
					<input type="text" class="w520" id="subject2">
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="desc2">작품 설명</label></th>
				<td>
					<textarea id="desc2">
					</textarea>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="file2">파일 첨부</label></th>
				<td>
					<input type="file" id="file2">
				</td>
			</tr>
		</tbody>
	</table>
</div>
<p class="btns txt-right">
	<a href="" class="btn-m btn5">작품추가</a>
	<a href="" class="btn-m btn2">작품삭제</a>
</p>

<h3 class="title2">공모 분야별 최대 5점까지 접수 가능</h3>
<div class="box1">
	<ul class="bul1 float-left">
		<li>제출형태 : 이미지 파일(작품당 최대 5MB)</li>		
		<li>파일이름 : 작품명과 동일하게</li>
		<li>Gif, Png, Jpg, Bmp만 업로드 가능(HWP, PPT, AVI, PSD, AI 파일은 불가능)</li>
		<li>동영상의 경우 이메일 또는 유투브 등록 후 웹 경로 첨부</li>
	</ul>
	<ul class="bul1 float-left">
		<li>표어(슬로건)은 파일첨부 없이 작품 제목으로 대체가 가능합니다. </li>		
		<li>본선 진출작에 한하여 원본 요청 예정</li>
		<li>공모전 주제에 맞지 않을 경우, 심사에서 제외될 수 있습니다. </li>
		<li>중복 수상은 불가하며, 상위작을 우선하여 수상합니다. </li>
	</ul>
</div>

<h2 class="title1">설문조사</h2>
<div class="view-survey">
	<div class="box3 txt-center">
		매년 발전하는 공모전 운영을 위해 참가자 분들을 대상으로 설문을 실시하고 있습니다.<br /> 
		본 설문은 수상작 선정에 전혀 영향을 미치지 않으며, 통계를 위해서만 활용됩니다.
		<p class="point3">설문조사를 완료하셔야 정상적으로 접수가 완료됩니다.</p> 
	</div>
	
		<article class="group">			
			<article class="item">
				<h3>귀하의 성별은 무엇입니까?</h3>
				<ul class="form-survey">
					<li class="form-set form-radio">
						<input type="radio" id="male">
						<label for="male">남성</label>
					</li>
					<li class="form-set form-radio">
						<input type="radio" id="female">
						<label for="female">여성</label>
					</li>
				</ul>
			</article>
			
			<article class="item">
				<h3>귀하의 연령대는 무엇입니까?</h3>
				<ul class="form-survey">
					<li class="form-set form-radio">
						<input type="radio" id="age1">
						<label for="age1">10대</label>
					</li>
					<li class="form-set form-radio">
						<input type="radio" id="age2">
						<label for="age2">20대</label>
					</li>
					<li class="form-set form-radio">
						<input type="radio" id="age3">
						<label for="age3">30대</label>
					</li>
					<li class="form-set form-radio">
						<input type="radio" id="age4">
						<label for="age4">40대</label>
					</li>
					<li class="form-set form-radio">
						<input type="radio" id="age5">
						<label for="age5">50대</label>
					</li>
					<li class="form-set form-radio">
						<input type="radio" id="age6">
						<label for="age6">60대 이상</label>
					</li>
				</ul>
			</article>
			
			<article class="item">
				<h3>귀하의 현재 거주지는 어디입니까?</h3>
				<select title="거주지">
					<option>서울</option>
				</select>
			</article>
			
			<article class="item">
				<h3>귀하가 공모전을 알게 된 경로는 무엇입니까?(중복체크 가능)</h3>
				<strong>(오프라인)</strong>
				<ul class="form-survey">
					<li class="form-set form-check">
						<input type="checkbox" id="off1">
						<label for="off1">교내 광고/게시판, 포스터</label>
					</li>
					<li class="form-set form-check">
						<input type="checkbox" id="off2">
						<label for="off2">씽굿 공모전 잡지 및 광고</label>
					</li>
					<li class="form-set form-check">
						<input type="checkbox" id="off3">
						<label for="off3">친구, 교수 등 지인소개</label>
					</li>
					<li class="form-set form-check">
						<input type="checkbox" id="off4">
						<label for="off4">기타</label>
					</li>
				</ul>
				<strong>(온라인)</strong>
				<ul class="form-survey">
					<li class="form-set form-check">
						<input type="checkbox" id="on1">
						<label for="on1">온라인 카페, 블로그, 게시판</label>
					</li>
					<li class="form-set form-check">
						<input type="checkbox" id="on2">
						<label for="on2">인터넷 뉴스 기사</label>
					</li>
					<li class="form-set form-check">
						<input type="checkbox" id="on3">
						<label for="on3">씽굿 공모전 홈페이지</label>
					</li>
					<li class="form-set form-check">
						<input type="checkbox" id="on4">
						<label for="on4">페이스북</label>
					</li>
					<li class="form-set form-check">
						<input type="checkbox" id="on5">
						<label for="on5">이메일</label>
					</li>
					<li class="form-set form-check">
						<input type="checkbox" id="on6">
						<label for="on6">기타</label>
					</li>
				</ul>
			</article>
			
			<article class="item">
				<h3>기타 의견(선택)</h3>
				<textarea></textarea>
			</article>
		</article>
</div>

<p class="btns txt-center">
	<a href="sub9_3_1_3.jsp" class="btn-l btn1">제출하기</a>
</p>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>