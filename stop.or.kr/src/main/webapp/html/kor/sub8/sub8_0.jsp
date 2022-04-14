<!-- 공통 상단에서 .cont-top 삭제된 것임 -->
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%
	String lastpath="";

	String cont_txt = request.getParameter("cont_txt");
	
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
	<title>여성폭력 Zoomin</title>
	<link rel="stylesheet" type="text/css" href="../../../css/common.css" />
	<!-- 여성폭력 줌인 css 추가 -->
	<link rel="stylesheet" type="text/css" href="../../../css/kor/zoomin.css" />
	<link rel="stylesheet" type="text/css" href="../../../css/kor/respond/zoomin.css" />
	<!-- //여성폭력 줌인 css 추가 -->
</head>

<body>
	<!-- Accessibility -->
	<a id="uppermost" href="#contents" class="skip-to">본문 바로가기</a>
	<div id="wrap">
		<header id="header">
			<h1 class="logo"><a href=""><img src="${contextPath}/images/kor/zoomin/logo.png" alt="여성폭력 Zoom-in" /></a></h1>
			<nav>
				<ul id="gnb">
					<li><a href="${contextPath}/html/kor/sub8/sub8_1.jsp">여성폭력바로알기</a></li>
					<li><a href="${contextPath}/html/kor/sub8/sub8_2.jsp">지원기관</a></li>
					<li><a href="${contextPath}/html/kor/sub8/sub8_3.jsp">여성폭력동향</a></li>
					<li><a href="${contextPath}/html/kor/sub8/sub8_4.jsp">추천도서</a></li>
				</ul>
			</nav>
			<div class="util">
				<!-- 20180822 추가 -->
				<a href="" class="go-link"><i class="xi-home"></i><span>진흥원 바로가기</span></a>
				<!-- //20180822 추가 -->
				
				<div class="search">
					<p class="form">
						<input type="text" placeholder="검색어를 입력해주세요" title="검색어" />
						<input class="btn" value="검색" type="submit">
					</p>
					<a href="" class="control open">검색 열기</a>
				</div>
			
				<a href="#allmenu" class="all-menu">전체메뉴</a>
			</div>
			<%@ include file="../include/allmenu.jsp" %>
		</header>
	
		<main id="main">
			<div class="cont-wrap">
				<div id="contents">
					<div class="cont-mid">
<!-- //공통 상단에서 .cont-top 삭제된 것임 -->
	        
<!-- 상세콘텐츠 영역 -->
<article class="state">
	<div class="desc">
		<h2>
			<span class="point3">2018년 상반기,</span>
			여성폭력 피해지원 현황
		</h2>
	</div>
	
	<ul class="list">
		<li>
			<p><strong>888,888</strong>건</p>
			<span>여성긴급전화 <br />1366 상담</span>
		</li>
		<li>
			<p><strong>29,504</strong>건</p>
			<span>해바라기센터 지원</span>
		</li>
		<li>
			<p><strong>917</strong>건</p>
			<span>성희롱&middot;성폭력 <br />특별신고센터 신고</span>
		</li>
		<li>
			<p><strong>1,366</strong>건</p>
			<span>디지털성범죄 <br />피해자지원센터 지원</span>
		</li>
		<li>
			<p><strong>29,504</strong>건</p>
			<span>해바라기센터 지원</span>
		</li>
	</ul>
</article>

<article class="know">
	<div class="title">
		<h2>
			<span>Zoom-in</span>
			여성폭력이란?
		</h2>
		<a href="">자세히 알아보기</a>
	</div>
	<ul>
		<li>
			<a href="">
				<img src="../../../images/kor/zoomin/know1.png" alt="" /><br />
				<span>가정폭력</span>
			</a>
		</li>
		<li>
			<a href="">
				<img src="../../../images/kor/zoomin/know2.png" alt="" /><br />
				<span>스토킹·데이트폭력</span>
			</a>
		</li>
		<li>
			<a href="">
				<img src="../../../images/kor/zoomin/know3.png" alt="" /><br />
				<span>성폭력·성희롱</span>
			</a>
		</li>
		<li>
			<a href="">
				<img src="../../../images/kor/zoomin/know4.png" alt="" /><br />
				<span>성매매</span>
			</a>
		</li>
		<li>
			<a href="">
				<img src="../../../images/kor/zoomin/know5.png" alt="" /><br />
				<span>디지털성폭력</span>
			</a>
		</li>
	</ul>
</article>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>