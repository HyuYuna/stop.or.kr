<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
	
	<header id="header">
		<h1 class="logo"><a href=""><img src="${contextPath}/images/eng/layout/logo.png" alt="Women's Human Rights Institute of Korea" /></a></h1>
		<nav>
			<ul id="gnb">
				<li>
					<a href="${contextPath}/html/eng/sub1/sub1_1.jsp">About Us</a>
					<div class="depth2">
						<p class="desc">
							<strong>About Us</strong>
						</p>
						<ul>
							<li><a href="${contextPath}/html/eng/sub1/sub1_1.jsp">Greeting</a></li>
							<li><a href="${contextPath}/html/eng/sub1/sub1_2.jsp">Goals and Vision</a></li>
							<li><a href="${contextPath}/html/eng/sub1/sub1_3.jsp">History</a></li>
							<li><a href="${contextPath}/html/eng/sub1/sub1_4.jsp">Organization chart</a></li>
							<li><a href="${contextPath}/html/eng/sub1/sub1_5.jsp">Symbol</a></li>
							<li><a href="${contextPath}/html/eng/sub1/sub1_6.jsp">Directions</a></li>
						</ul>
					</div>
				</li>
				<li>
					<a href="${contextPath}/html/eng/sub2/sub2_1.jsp">News Monitoring&Prevention Actions in Korea</a>
					<div class="depth2">
						<p class="desc">
							<strong>News Monitoring&Prevention Actions in Korea</strong>
						</p>
						<ul>
							<li><a href="${contextPath}/html/eng/sub2/sub2_1.jsp">Global News Monitoring</a></li>
							<li><a href="${contextPath}/html/eng/sub2/sub2_2.jsp">Best Practices of Anti-Prostitution Organizations</a></li>
							<li><a href="${contextPath}/html/eng/sub2/sub2_3.jsp">Policies and Prevention Actions in Korea</a></li>
						</ul>
					</div>
				</li>
				<li>
					<a href="${contextPath}/html/eng/sub3/sub3_1.jsp">WHRIK Publication</a>
					<div class="depth2">
						<p class="desc">
							<strong>WHRIK Publication</strong>
						</p>
						<ul>
							<li><a href="${contextPath}/html/eng/sub3/sub3_1.jsp">WHRIK Publication</a></li>
						</ul>
					</div>
				</li>
			</ul>
		</nav>
		<div class="util">
			<div class="search">
				<p class="form">
					<input type="text" placeholder="keyword" title="keyword" />
					<input class="btn" value="search" type="submit">
				</p>
				<a href="" class="control open">open</a>
			</div>

			<p class="language">
				<a href="">KOR</a>
				<a href="" class="active">ENG</a>
			</p>
			<a href="#allmenu" class="all-menu">all menu</a>
		</div>
		<%@ include file="allmenu.jsp" %>
	</header>