<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb4.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="알림마당" />
	<jsp:param name="path" value="공지/공고" />
	<jsp:param name="path" value="공지사항" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<div class="schedule">
	<article class="calender">
		<div class="title">
			<h2>
				<strong>8</strong>
				<span> August 2018</span>
			</h2>
			<p class="control">
				<a href="" class="prev">이전</a>
				<a href="" class="next">다음</a>
			</p>
		</div>
		
		<div class="table">
			<table>
				<caption>2018년 8월 달력</caption>
				<thead>
					<tr>
						<th scope="col" class="point4">Sun</th>
						<th scope="col">Mon</th>
						<th scope="col">Tue</th>
						<th scope="col">Wed</th>
						<th scope="col">Thu</th>
						<th scope="col">Fri</th>
						<th scope="col" class="point5">Sat</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="point4 disable"><span class="label">29</span></td>
						<td class="disable"><span class="label">30</span></td>
						<td class="disable"><span class="label">31</span></td>
						<td><a href="" class="label">1</a></td>
						<td><a href="" class="label">2</a></td>
						<td><a href="" class="label">3</a></td>
						<td class="point5"><a href="" class="label">4</a></td>
					</tr>
					<tr>
						<td class="point4"><a href="" class="label">5</a></td>
						<td><a href="" class="label">6</a></td>
						<td><a href="" class="label">7</a></td>
						<td><a href="" class="label">8</a></td>
						<td class="today active"><a href="" class="label">9</a></td>
						<td><a href="" class="label">10</a></td>
						<td class="point5"><a href="" class="label">11</a></td>
					</tr>
					<tr>
						<td class="point4"><a href="" class="label">12</a></td>
						<td><a href="" class="label">13</a></td>
						<td class="active"><a href="" class="label">14</a></td>
						<td class="event today active"><a href="" class="label">15</a></td>
						<td><a href="" class="label">16</a></td>
						<td class="event today"><a href="" class="label">17</a></td>
						<td class="point5"><a href="" class="label">18</a></td>
					</tr>
					<tr>
						<td class="point4"><a href="" class="label">19</a></td>
						<td class="event active"><a href="" class="label">20</a></td>
						<td><a href="" class="label">21</a></td>
						<td class="event"><a href="" class="label">22</a></td>
						<td><a href="" class="label">23</a></td>
						<td><a href="" class="label">24</a></td>
						<td class="point5"><a href="" class="label">25</a></td>
					</tr>
					<tr>
						<td class="point4"><a href="" class="label">26</a></td>
						<td><a href="" class="label">27</a></td>
						<td><a href="" class="label">28</a></td>
						<td><a href="" class="label">29</a></td>
						<td><a href="" class="label">30</a></td>
						<td><a href="" class="label">31</a></td>
						<td class="point5"><span class="label">25</span></td>
					</tr>
				</tbody>
			</table>
		</div>
	</article>
	
	<article class="item">
		<h3 class="title3">8월 14일 행사</h3>
		<div class="list">
			<ul>
				<li>여성인권진흥원 정보 보안 교육</li>
				<li>여성인권진흥원 정보 보안 교육</li>
			</ul>
		</div>
	</article>
</div>

<h3 class="title3">8월의 행사</h3>
<div class="table-wrap">
	<table>
		<colgroup>
			<col class="date">
			<col>
		</colgroup>
		<tr>
			<td class="txt-left">14일</td>
			<td class="txt-left point1">여성인권진흥원 정보 보안 교육</td>
		</tr>
		<tr>
			<td class="txt-left">15일</td>
			<td class="txt-left point1">여성인권진흥원 정보 보안 교육</td>
		</tr>
		<tr>
			<td class="txt-left">171일</td>
			<td class="txt-left point1">여성인권진흥원 정보 보안 교육</td>
		</tr>
		<tr>
			<td class="txt-left">14일</td>
			<td class="txt-left point1">여성인권진흥원 정보 보안 교육</td>
		</tr>
		<tr>
			<td class="txt-left">14일</td>
			<td class="txt-left point1">여성인권진흥원 정보 보안 교육</td>
		</tr>
	</table>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>