<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb2.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="알림마당" />
	<jsp:param name="path" value="공지/공고" />
	<jsp:param name="path" value="공지사항" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<ul class="tabmenu">
	<li class="active"><a href="sub4_2.jsp">공지사항</a></li>
	<li><a href="sub4_2_2.jsp">사업/입찰공고</a></li>
	<li><a href="sub4_2_3.jsp">채용공고</a></li>
	<li><a href="sub4_2_4.jsp">현장기관 채용공고</a></li>
</ul>

<div class="board-view">
	<h1 class="view-title">[공지사항] 한국여성인권진흥원 위드유 서포터즈 선발 및 발대식 초청</h1>
	<ul class="info">
		<li>
			<strong>작성자</strong> 한국여성인권진흥원
		</li>
		<li>
			<strong>작성일</strong> 2018-04-01
		</li>
		<li>
			<strong>조회수</strong> 201
		</li>
	</ul>
	<div class="view-content">
		한국여성인권진흥원 위드유 서포터즈 선발 및 발대식 초청
		<br /><br />
		한국여성인권진흥원 위드유 서포터즈에 지원해 주신 모든 분께 깊이 감사드립니다.<br />
		많은 분들이 지원해주셨지만 모두 함께 할 수 없음에 양해 부탁드리며, 앞으로도 지속적으로 여성폭력 피해자를 위한 위드유와 폭력 방지 활동에<br />
		 관심가져 주시길 부탁드립니다.
		 <br /><br />
		위드유 서포터즈는 공고 시 안내드린 기준에 따라 선발되었음을 알려드리며,<br />
		선발되신 분들께서는 하단의 발대식 초청내용을 확인하시어 참석(필수참여)해주시기 바랍니다.
		 <br /><br />
		감사합니다!
	</div>
	<div class="download-list">
		<strong class="title">첨부파일</strong>
		<ul>
			<li>
				<a href="#">20180507759-00_1526004197886_입찰공고서-1278(2018년 일본군 위안부 피해자 기림의 날 행사 용역)(국가+중기간+수요기관평가).hwp</a>
			</li>
			<li>
				<a href="#">2018년 일본군 위안부 피해자 기림의 날 행사 용역 제안요청서(최종).hwp(62.0KB/11)</a>
			</li>
		</ul>
	</div>
</div>

<div class="comment">
	<div class="write">
		<textarea title="댓글 내용">내용을 입력하세요</textarea>
		<a href="" class="btn">등록</a>
	</div>

	<ul class="list">
		<li class="group">
			<div class="txt">
				<strong>김주연 (yuan)</strong>
				<span>2017-01-19  12:00</span>
				<p>아주 대단히 환영합니다. 특강 때 뵈어요~</p>
			</div>
			<p class="btn">
				<a href="">답글</a>
				<a href="">수정</a>
				<a href="">삭제</a>
			</p>
		</li>
		<li class="reply" style="padding-left:20px">
			<div class="txt">
				<strong>설희 (seol)</strong>
				<span>2017-01-19  12:00</span>
				<p>네 알겠습니다.</p>
			</div>
			<p class="btn">
				<a href="">답글</a>
				<a href="">수정</a>
				<a href="">삭제</a>
			</p>
		</li>
		<li class="reply" style="padding-left:20px">
			<p class="write">
				<input placeholder="답글을 입력하세요" type="text">
				<a href="" class="btn">답글</a>
			</p>
		</li>
		<li class="group">
			<div class="txt">
				<strong>김주연 (yuan)</strong>
				<span>2017-01-19  12:00</span>
				<p>너무너무너무 대단히 환영합니다. 어서 빨리 특강 때 뵈어요~</p>
			</div>
			<p class="btn">
				<a href="">답글</a>
				<a href="">수정</a>
				<a href="">삭제</a>
			</p>
		</li>
		<li class="reply" style="padding-left:20px">
			<div class="txt">
				<strong>설희 (seol)</strong>
				<span>2017-01-19  12:00</span>
				<p>네 알겠습니다.</p>
			</div>
			<p class="btn">
				<a href="">답글</a>
				<a href="">수정</a>
				<a href="">삭제</a>
			</p>
		</li>
		<li class="reply" style="padding-left:40px">
			<div class="txt">
				<strong>김주연 (yuan)</strong>
				<span>2017-01-19  12:00</span>
				<p>특강 때 봐용</p>
			</div>
			<p class="btn">
				<a href="">답글</a>
				<a href="">수정</a>
				<a href="">삭제</a>
			</p>
		</li>
	</ul>
</div>

<ul class="prev-next">
	<li><strong>다음글</strong><a href="#" class="">첨부파일 1번입니다. (3MB)</a></li>
	<li><strong>이전글</strong><a href="#" class="">첨부파일 2번입니다. (3MB)</a></li>
</ul>

<div class="btns txt-right">
	<a href="sub4_2.jsp" class="btn-m btn1">목록으로</a>
	<a href="sub4_2_1_3.jsp" class="btn-m btn1">글쓰기</a>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>