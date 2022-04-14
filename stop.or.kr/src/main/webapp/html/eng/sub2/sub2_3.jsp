<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb2.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="News Monitoring&Prevention Actions in Korea" />
	<jsp:param name="path" value="Policies and Prevention Actions in Korea" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<ul class="tabmenu">
	<li class="active"><a href="sub4_1.jsp">진흥원소식<span class="point2">(10)</span></a></li>
	<li><a href="sub4_1_2.jsp">현장기관소식<span class="point2">(21)</span></a></li>
</ul>

<ul class="board-blog">
	<li>
		<a href="">
			<span class="img"><img src="../../../images/kor/sub/blog1.jpg" alt="" /></span>
			<strong>[채비포커스 1호] #metoo에도 ‘자격’이 필요하다?</strong>
			<span>&lt;기획의도&gt; “대화, 소통의 시작은 궁금함” 채비(채움과 비움)포커스는 우리사회 차별과 폭력 근절을 위한 대화의 시작을 위해서 기획되었습니다. 이를 위해 대중의 궁금함을 함께 고민하고 논할 수 있는 장으로서, 성평등 문화 형성을 위하여 우리가 어떤 것을 함께 채우고, 어떤 것을 비워야 할지 소통해보았...</span>
		</a>
	</li>
	<li>
		<a href="">
			<span class="img"><img src="../../../images/kor/sub/blog2.jpg" alt="" /></span>
			<strong>디지털 성범죄 피해자 지원센터 개소, 불법촬영물 무료삭제·상담·법률 등 지원해드려요</strong>
			<span>여성가족부 정현백 장관(사진 좌측)과 한국여성인권진흥원 변혜정 원장이 디지털 성범죄 피해자 지원센터 현판식에 참여하고 있다. 여성가족부는 불법촬영과 유포 등 디지털 성범죄로 고통 받는 피해자들을 위해 종합 지원서비스를 제공하는 ‘디지털 성범죄 피해자 지원센터’를 4월 30일(월)부터 운영한다.</span>
		</a>
	</li>
	<li>
		<a href="">
			<span class="img"><img src="../../../images/kor/sub/blog3.jpg" alt="" /></span>
			<strong>뫼비우스의 띠로 얽힌 '성접대', 성폭력, 성매매</strong>
			<span>'성접대’를 한 여성은 미투(me too)를 할 수 있을까? 성매매를 둘러싼‘침묵의 카르텔’, 한국여성인권진흥원, 4.24. 성매매방지 정책토론회 개최 최근, 9년 전 죽음으로 ‘미투’를 해야 했던 여성연예인 J씨에 대한 성접대 강요 사건이 검찰 과거사위원회의 사전조사 대상에 포함됨에 따라, ‘성접대’ 문제에 대한 여론의 관심...</span>
		</a>
	</li>
	<li>
		<a href="">
			<strong>미투 운동 이후, 1366 성폭력 상담 51% 올랐다	</strong>
			<span class="date">2018-04-18</span>
			<span class="hit">462</span>
		</a>
	</li>
	<li>
		<a href="">
			<strong>불법촬영물 삭제요청 누가 할 수 있는지, 혹 아시나요</strong>
			<span class="date">2018-04-18</span>
			<span class="hit">462</span>
		</a>
	</li>
	<li>
		<a href="">
			<strong>배우 정려원 씨와 with you 하실 여러분을 찾습니다</strong>
			<span class="date">2018-04-18</span>
			<span class="hit">462</span>
		</a>
	</li>
	<li>
		<a href="">
			<strong>해바라기센터로 미투하는 여성들…이용자 89%가 여성</strong>
			<span class="date">2018-04-18</span>
			<span class="hit">462</span>
		</a>
	</li>
	<li>
		<a href="">
			<strong>한국여성인권진흥원, 투명하게 알리고 고객만족 높였다</strong>
			<span class="date">2018-04-18</span>
			<span class="hit">462</span>
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