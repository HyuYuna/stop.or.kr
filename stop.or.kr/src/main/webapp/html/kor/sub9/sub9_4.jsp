<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header_contest.jsp">
	<jsp:param name="snb" value="contest4.jsp" />
	<jsp:param name="path" value="성매매방지 국민생각 공모전" />
	<jsp:param name="path" value="자료실" />
	<jsp:param name="path" value="2017" />
	<jsp:param name="path" value="만화" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<h1 class="title5">2017 성매매방지 콘텐츠 공모전</h1>
<div class="box1">
	<div class="item">
		<span class="icon"><img src="../../../images/kor/sub/icon1.gif" alt=""></span>
		<p class="txt">
			작품을 클릭하면 작품 전체 이미지를 볼 수 있습니다.<br />
			본 콘텐츠의 저작권은 수상자에게 있습니다. 자료 사용을 원하시는 경우, 한국여성인권진흥원으로 문의해 주시기 바랍니다<br />
			※ 사용문의 _ center@stop.or.kr 
		</p>
	</div>
</div>
<ul class="tabmenu">
	<li class="active"><a href="">만화 (Cartoon)</a></li>
	<li><a href="">캘리그라피 (Caligraphy)</a></li>
	<li><a href="">일러스트 (Illustration)</a></li>
	<li><a href="">카드뉴스 (Card News)</a></li>
</ul>

<ul class="board-thumb">
	<li>
		<a href="">
			<span class="img"><img src="../../../images/kor/contest/thumb1.jpg" alt=""></span>
			<span class="icon1 type8">대상 수상작</span>
			<strong>2015년 성매매방지 홍보영상 (건강한 가치편)</strong>
		</a>
	</li>
	<li>
		<a href="">
			<span class="img"><img src="../../../images/kor/contest/thumb2.jpg" alt=""></span>
			<span class="icon1 type9">금상 수상작</span>
			<strong>공감</strong>
		</a>
	</li>
	<li>
		<a href="">
			<span class="img"><img src="../../../images/kor/contest/thumb3.jpg" alt=""></span>
			<span class="icon1 type10">은상 수상작</span>
			<strong>멋진 당신을 응원합니다.</strong>
		</a>
	</li>
	<li>
		<a href="">
			<span class="img"><img src="../../../images/kor/contest/thumb4.jpg" alt=""></span>
			<span class="icon1 type11">동상 수상작</span>
			<strong>성매매, 그들의 일상이 무엇을 만드는가?</strong>
		</a>
	</li>
	<li>
		<a href="">
			<span class="img"><img src="../../../images/kor/contest/thumb1.jpg" alt=""></span>
			<span class="icon1 type10">은상 수상작</span>
			<strong>멋진 당신을 응원합니다.</strong>
		</a>
	</li>
	<li>
		<a href="">
			<span class="img"><img src="../../../images/kor/contest/thumb2.jpg" alt=""></span>
			<span class="icon1 type11">동상 수상작</span>
			<strong>성매매, 그들의 일상이 무엇을 만드는가?</strong>
		</a>
	</li>
</ul>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>