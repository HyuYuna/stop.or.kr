<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header_contest.jsp">
	<jsp:param name="snb" value="contest4.jsp" />
	<jsp:param name="path" value="성매매방지 국민생각 공모전" />
	<jsp:param name="path" value="소개" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<div class="intro">
	<div class="title"><p>세상에는 거래할 수 없는 것이 있습니다.</p></div>
	
	<div class="item">
		<strong class="label">돈으로는 <br />거래할 수 없는 <br />것이 있습니다.</strong>
		
		<p>
			<span>
				남녀사이의 사랑, 인간의 존엄성, 생명.<br />
				가족의 사랑, 자유, 소중한 자연, 개인의 꿈, 마음의 휴식...
			</span>
		</p>
		
		<p>
			아래에는 돈으로 만들어진 세상입니다.<br />
			돈으로 만들어진 아파트, 건물, 사람들의 옷, 자동차....<br />
			그리고 하늘에는, 그 돈으로는 거래할 수 없는 것들이 별처럼 떠 있습니다..
		</p>
		
		<p>
			&lt;성매매방지 온라인 홍보관&gt;에는 성매매방지 및 피해자 보호에 대한 정보가 담겨 있습니다. <br />
			성매매방지 공모전, 갤러리, 홍보영상 및 정책정보, 성매매 방지를 위한 우리의 활동을 모아 보실 수 있습니다.
		</p>
		
		<p>
			<img src="../../../images/kor/contest/intro.gif" alt="여성가족부, 한국여성인권진흥원" >
		</p>
	</div>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>