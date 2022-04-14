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
	<title><%=lastpath%> | Women's Human Rights Institute of Korea</title>
	<link rel="stylesheet" type="text/css" href="../../../css/common.css" />
	<link rel="stylesheet" type="text/css" href="../../../css/eng/sub.css" />
	<link rel="stylesheet" type="text/css" href="../../../css/eng/respond/sub.css" />
</head>

<body>
	<!-- Accessibility -->
	<a id="uppermost" href="#contents" class="skip-to">Skip</a>
	<div id="wrap">
		<%@ include file="header.jsp" %>	
		<main id="main">
			<div id="spot">
				<strong><%=path1%></strong>
			</div>
			<div class="cont-wrap">
				<% String snb = request.getParameter("snb"); %>
				<jsp:include page="<%= snb %>" />
				<div id="contents">
					<div class="cont-top">
						<h1 class="cont-title"><%=lastpath%></h1>
						<div class="path">
							<span class="home"><i class="xi-home">Home</i></span>
							
							<div class="group depth1">
								<p class="label"><a href=""><%=path1%></a></p>
								<ul>
									<li><a href="../sub1/sub1_1.jsp">About Us</a></li>
									<li><a href="../sub2/sub2_1.jsp">News Monitoring&Prevention Actions in Korea</a></li>
									<li><a href="../sub3/sub3_1.jsp">WHRIK Publication</a></li>
								</ul>
							</div>

							<div class="group depth2">
								<p class="label"><a href=""><%=path2%></a></p>
								<ul>
									<li><a href="sub2_1.jsp">Global News Monitoring</a></li>
									<li><a href="sub2_2.jsp">Best Practices of Anti-Prostitution Organizations</a></li>
									<li><a href="sub2_3.jsp">Policies and Prevention Actions in Korea</a></li>
								</ul>
							</div>
						</div>
						<div class="cont-util">
							<p class="sns">
								<a href="" class="facebook"><i class="xi-facebook"></i><span class="sr-only">facebook</span></a>
								<a href="" class="twiiter"><i class="xi-twitter"></i><span class="sr-only">twitter</span></a>
								<a href="" class="story"><i class="xi-kakaostory"></i><span class="sr-only">kakao story</span></a>
								<a href="" class="talk"><i class="xi-kakaotalk"></i><span class="sr-only">kakao talk</span></a>
							</p>

							<a href="" class="print"><i class="xi-print"></i><span class="sr-only">print</span></a>
						</div>
					</div>
					<div class="cont-mid">