<!-- 공통 상단 영역에서 #spot 삭제함 -->
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%
	String lastpath="";

	if (request.getParameterValues("path")!=null)
	{
		String lpath[]	= request.getParameterValues("path");
		
		for (int i=0; i<lpath.length; i++)
		{
			if (i==(lpath.length-1))
			{
				lastpath=lpath[i];
			}
		}
	}
%>

<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	<title>성매매방지 국민생각 공모전</title>
	<link rel="stylesheet" type="text/css" href="../../../css/common.css" />
	<!-- 공모전 css 추가 -->
	<link rel="stylesheet" type="text/css" href="../../../css/kor/contest.css" />
	<link rel="stylesheet" type="text/css" href="../../../css/kor/respond/contest.css" />
	<!-- //공모전 추가 -->
</head>

<body>
	<!-- Accessibility -->
	<a id="uppermost" href="#contents" class="skip-to">본문 바로가기</a>
	<div id="wrap">
		<header id="header">
			<h1 class="logo"><a href=""><img src="${contextPath}/images/kor/contest/logo.png" alt="성매매방지 국민생각 공모전" /></a></h1>
			<nav>
				<ul id="gnb">
					<li><a href="${contextPath}/html/kor/sub9/sub9_1.jsp">소개</a></li>
					<li><a href="${contextPath}/html/kor/sub9/sub9_2.jsp">공모요강</a></li>
					<li><a href="${contextPath}/html/kor/sub9/sub9_3.jsp">접수하기</a></li>
					<li><a href="${contextPath}/html/kor/sub9/sub9_4.jsp">자료실</a></li>
					<li><a href="${contextPath}/html/kor/sub9/sub9_5.jsp">커뮤니티</a></li>
				</ul>
			</nav>
			<div class="util">
				<span class="sns">
					<a href="" class="facebook">페이스북</a>
					<a href="" class="twitter">트위터</a>
				</span>
				
				<!-- 20180822 추가 -->
				<a href="" class="go-link"><i class="xi-home"></i><span>진흥원 바로가기</span></a>
				<!-- //20180822 추가 -->
			
				<a href="#allmenu" class="all-menu">전체메뉴</a>
			</div>
			<%@ include file="../include/allmenu.jsp" %>
		</header>
	
		<main id="main">
			<div class="cont-wrap">
				<div id="contents">
					<div class="cont-mid">
<!-- //공통 상단 영역에서 #spot 삭제함 -->
	        
<!-- 상세콘텐츠 영역 -->
<div id="visual">
	<p class="img">
		<img src="${contextPath}/images/kor/contest/visual.gif" alt="성매매는 필요하다는 생각, 청소년 성매매는 청소년만의 문제라는 생각, 성매매는 내 문제가 아니라는 생각. 이런! 생각을 바꿀 생각을 찾습니다" />
	</p>
	<div class="desc">
		<strong>5.28 <br />~6.24</strong>
		<p>생각을 바꿀<br />생각을 찾습니다!!</p>
		<span>2018년 성매매방지 국민생각 공모전</span>
		<a href="">공모전 바로가기</a>
	</div>
</div>

<article class="go">
	<div class="title">
		<h2>세상에는 거래할 수 없는 것이 있습니다</h2>
		<span>보다 나은 사회를 만들어가는 첫 걸음 입니다.</span>
	</div>
	
	<ul>
		<li>
			<a href="">
				<img src="${contextPath}/images/kor/contest/go1.gif" alt="" />
				<span>소개</span>
			</a>
		</li>
		<li>
			<a href="">
				<img src="${contextPath}/images/kor/contest/go2.gif" alt="" />
				<span>공모요강</span>
			</a>
		</li>
		<li>
			<a href="">
				<img src="${contextPath}/images/kor/contest/go3.gif" alt="" />
				<span>접수하기</span>
			</a>
		</li>
		<li>
			<a href="">
				<img src="${contextPath}/images/kor/contest/go4.gif" alt="" />
				<span>자료실</span>
			</a>
		</li>
		<li>
			<a href="">
				<img src="${contextPath}/images/kor/contest/go5.gif" alt="" />
				<span>이벤트</span>
			</a>
		</li>
	</ul>
</article>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>