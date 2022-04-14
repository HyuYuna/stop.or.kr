<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%
	String lastpath="";

	String path1="";
	String path2="";
	
	if (request.getParameterValues("path")!=null)
	{
		String lpath[]	= request.getParameterValues("path");
		
		for (int i=0; i<lpath.length; i++)
		{
			if (i==(lpath.length-1))
			{
				lastpath=lpath[i];
			}

			if (i==0)
			{
				path1=lpath[i];
			}

			if (i==1)
			{
				path2=lpath[i];
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
	<link rel="stylesheet" type="text/css" href="../../../css/kor/sub.css" />
	<link rel="stylesheet" type="text/css" href="../../../css/kor/respond/sub.css" />
</head>

<body>
	<!-- Accessibility -->
	<a id="uppermost" href="#contents" class="skip-to">본문 바로가기</a>
	<div id="wrap">
		<%@ include file="header.jsp" %>	
		<main id="main">
			<!-- 뎁스마다 spot4 넘버 변경해주세여 spot1, spot2 이로케 -->
			<div id="spot" class="spot4">
				<strong><%=path1%></strong>
				<p>여성폭력 예방과 근절, 폭력 피해자에 대한 지원을 위해 <br />전문성과 경험을 바탕으로 최선을 다할 것입니다.</p>
			</div>
			<div class="cont-wrap">
				<% String snb = request.getParameter("snb"); %>
				<jsp:include page="<%= snb %>" />
				<div id="contents">
					<div class="cont-top">
						<h1 class="cont-title"><%=lastpath%></h1>
						<div class="path">
							<span class="home"><i class="xi-home">홈</i></span>
							
							<div class="group depth1">
								<p class="label"><a href=""><%=path1%></a></p>
								<ul>
									<li><a href="../sub1/sub1_1.jsp">진흥원소개</a></li>
									<li><a href="../sub2/sub2_1.jsp">주요사업</a></li>
									<li><a href="../sub3/sub3_1.jsp">정보공개</a></li>
									<li><a href="../sub4/sub4_1.jsp">알림마당</a></li>
									<li><a href="../sub5/sub5_1.jsp">네트워크</a></li>
									<li><a href="../sub6/sub6_1.jsp">브리핑룸</a></li>
									<li><a href="../sub7/sub7_1.jsp">자료실</a></li>
									<li><a href="../sub8/sub8_1.jsp">여성폭력Zoomin</a></li>
								</ul>
							</div>

							<div class="group depth2">
								<p class="label"><a href=""><%=path2%></a></p>
								<!-- 2뎁스 메뉴 나오게 해주세여 -->
								<ul>
									<li><a href="sub4_1.jsp">소식</a></li>
									<li><a href="sub4_2.jsp">공지/공고</a></li>
									<li><a href="sub4_3.jsp">참여마당</a></li>
									<li><a href="sub4_4.jsp">여성인권달력</a></li>
								</ul>
							</div>
						</div>
						<div class="cont-util">
							<p class="sns">
								<a href="" class="facebook"><i class="xi-facebook"></i><span class="sr-only">페이스북</span></a>
								<a href="" class="twiiter"><i class="xi-twitter"></i><span class="sr-only">트위터</span></a>
								<a href="" class="story"><i class="xi-kakaostory"></i><span class="sr-only">카카오스토리</span></a>
								<a href="" class="talk"><i class="xi-kakaotalk"></i><span class="sr-only">카카오톡</span></a>
								<a href="" class="blog"><i class="xi-blogger"></i><span class="sr-only">블로그</span></a>
							</p>

							<a href="" class="print"><i class="xi-print"></i><span class="sr-only">프린트</span></a>
						</div>
					</div>
					<div class="cont-mid">