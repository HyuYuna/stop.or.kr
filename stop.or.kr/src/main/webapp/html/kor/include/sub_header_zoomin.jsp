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
	<title><%=lastpath%> | 한국여성인권진흥원</title>
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
			<%@ include file="allmenu.jsp" %>
		</header>
	
		<main id="main">
			<% String snb = request.getParameter("snb"); %>
			<jsp:include page="<%= snb %>" />
				<div id="contents">
					<div class="cont-top">
						<h1 class="cont-title"><%=lastpath%></h1>
						<p class="cont-txt"><%=cont_txt%></p>
					</div>
					<div class="cont-mid">