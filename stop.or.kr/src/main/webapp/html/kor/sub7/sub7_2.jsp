<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb7.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="자료실" />
	<jsp:param name="path" value="영상자료" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<div class="box1">
	<div class="item">
		<span class="icon"><img src="../../../images/kor/sub/icon1.gif" alt="" /></span>
		<p class="txt">다운로드를 원하실 경우 사용계획 및 연락처를 기재하여 메일(기획홍보팀 center@stop.or.kr)로 문의하시기 바랍니다.</p>
	</div>
</div>

<ul class="board-thumb">
	<li>
		<a href="sub7_2_2.jsp">
			<span class="img"><img src="../../../images/kor/sub/thumb1.jpg" alt="" /></span>
			<span class="icon1 type1">홍보영상</span>
			<strong>2015년 성매매방지 홍보영상 (건강한 가치편)</strong>
			<p class="info">
				<span class="point3">2015</span>    
				한국여성인권진흥원 
			</p>
		</a>
	</li>
	<li>
		<a href="sub7_2_2.jsp">
			<span class="img"><img src="../../../images/kor/sub/thumb2.jpg" alt="" /></span>
			<span class="icon1 type1">홍보영상</span>
			<strong>공감</strong>
			<p class="info">
				<span class="point3">2014</span>    
				한국여성인권진흥원 
			</p>
		</a>
	</li>
	<li>
		<a href="sub7_2_2.jsp">
			<span class="img"><img src="../../../images/kor/sub/thumb3.jpg" alt="" /></span>
			<span class="icon1 type1">홍보영상</span>
			<strong>멋진 당신을 응원합니다.</strong>
			<p class="info">
				<span class="point3">2014</span>    
				영화제작소 눈 
			</p>
		</a>
	</li>
	<li>
		<a href="sub7_2_2.jsp">
			<span class="img"><img src="../../../images/kor/sub/thumb4.jpg" alt="" /></span>
			<span class="icon1 type1">홍보영상</span>
			<strong>성매매, 그들의 일상이 무엇을 만드는가?</strong>
			<p class="info">
				<span class="point3">2013</span>    
				성매매방지 홍보영상
			</p>
		</a>
	</li>
	<li>
		<a href="sub7_2_2.jsp">
			<span class="img"><img src="../../../images/kor/sub/thumb5.jpg" alt="" /></span>
			<span class="icon1 type2">2009 선정작</span>
			<strong>빛(Light)</strong>
			<p class="info">
				<span class="point3">2009</span>    
				양현아, 신자희 <span class="point1">(우수상)</span>
			</p>
		</a>
	</li>
	<li>
		<a href="sub7_2_2.jsp">
			<span class="img"><img src="../../../images/kor/sub/thumb6.jpg" alt="" /></span>
			<span class="icon1 type3">2012 선정작</span>
			<strong>살롱 드 보아</strong>
			<p class="info">
				<span class="point3">2012</span>    
				손해숙
			</p>
		</a>
	</li>
</ul>
<br /><br />

<!-- 다운로드 팝업 -->
<article class="layerpopup type1" id="downlode">
	<div class="group">
		<h2>[사용자]-[자료실] 하위 게시판들은 다운로드 시 <br />개인/기관 확인 후 다운로드 진행 <br />기관명 필수 개인은 별도 정보 수집 없음</h2>
		<div class="item">
			<div class="table-wrap">
				<table>
					<caption>다운로드 받으시는 분의 정보를 입력해 주세요.</caption>
					<thead>
						<tr>
							<th scope="col" class="txt-left">다운로드 받으시는 분의 정보를 입력해 주세요.</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="txt-left">
								<span class="form-set form-radio">
									<input type="radio" id="type1" />
									<label for="type1">기관</label>
								</span>
								<span class="form-set form-radio">
									<input type="radio" id="type2" />
									<label for="type2">개인</label>
								</span>
							</td>
						</tr>
						<tr>
							<td class="txt-left">
								<input type="text" title="기관명" placeholder="기관명">
							</td>
						</tr>
					</tbody>
				</table>
			</div>
						
			<p class="btns txt-center">
				<a href="" class="btn-l btn1">다운로드</a>
				<a href="#downlode" class="btn-l btn2 close">닫기</a>
			</p>
		</div>
	</div>
</article>
<!-- //다운로드 팝업 -->

<ul class="board-thumb type1">
	<li>
		<a href="#downlode" class="btn-layerpopup">
			<span class="img"><img src="../../../images/kor/sub/thumb1.jpg" alt="" /></span>
			<strong>2015년 성매매방지 홍보영상 (건강한 가치편)</strong>
			<p class="info">2018-01-01</p>
		</a>
	</li>
	<li>
		<a href="#downlode" class="btn-layerpopup">
			<span class="img"><img src="../../../images/kor/sub/thumb2.jpg" alt="" /></span>
			<strong>공감</strong>
			<p class="info">2018-01-01</p>
		</a>
	</li>
	<li>
		<a href="#downlode" class="btn-layerpopup">
			<span class="img"><img src="../../../images/kor/sub/thumb3.jpg" alt="" /></span>
			<strong>멋진 당신을 응원합니다.</strong>
			<p class="info">2018-01-01</p>
		</a>
	</li>
	<li>
		<a href="#downlode" class="btn-layerpopup">
			<span class="img"><img src="../../../images/kor/sub/thumb4.jpg" alt="" /></span>
			<strong>성매매, 그들의 일상이 무엇을 만드는가?</strong>
			<p class="info">2018-01-01</p>
		</a>
	</li>
	<li>
		<a href="#downlode" class="btn-layerpopup">
			<span class="img"><img src="../../../images/kor/sub/thumb5.jpg" alt="" /></span>
			<strong>빛(Light)</strong>
			<p class="info">2018-01-01</p>
		</a>
	</li>
	<li>
		<a href="#downlode" class="btn-layerpopup">
			<span class="img"><img src="../../../images/kor/sub/thumb6.jpg" alt="" /></span>
			<strong>살롱 드 보아</strong>
			<p class="info">2018-01-01</p>
		</a>
	</li>
</ul>

<div class="pager">
	<a href="#" class="arr first">처음으로</a>
	<a href="#" class="arr prev">이전</a>
	<strong class="active">1</strong>
	<a href="#">2</a>
	<a href="#">3</a>
	<a href="#">4</a>
	<a href="#">5</a>
	<a href="#" class="arr next">다음</a>
	<a href="#" class="arr last">마지막으로</a>
</div>

<div class="board-search">
	<select name="" id="" title="검색 구분">
		<option value="">제목</option>
	</select>
	<input type="text" title="검색어" />
	<a href="" class="btn">검색</a>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>