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
	<title><%=lastpath%> | 한국여성인권진흥원</title>
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
			
				<a href="#allmenu" class="all-menu">전체메뉴</a>
			</div>
			<%@ include file="allmenu.jsp" %>
		</header>
	
		<main id="main">
			<div id="spot">
				<span>2018 성매매방지 국민생각 공모전</span>
				<strong>생각을 바꿀 생각을 찾습니다</strong>
				<em>5. 28<br />~6. 24</em>
				<p>
					<a href="" class="type1">공모전 접수하기</a>
					<a href="" class="type2">공모요강 바로가기</a>
				</p>
			</div>
			<div class="cont-wrap">
				<% String snb = request.getParameter("snb"); %>
				<jsp:include page="<%= snb %>" />
				<div id="contents">
					<div class="cont-mid">