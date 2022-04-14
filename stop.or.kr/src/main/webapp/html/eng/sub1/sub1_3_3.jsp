<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb1.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="About Us" />
	<jsp:param name="path" value="History" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<ul class="tabmenu">
	<li><a href="sub1_3.jsp">Beginning</a></li>
	<li><a href="sub1_3_2.jsp">Establishment</a></li>
	<li class="active"><a href="sub1_3_3.jsp">Establishment of infrastructure</a></li>
	<li><a href="sub1_3_4.jsp">Growth</a></li>
</ul>

<article class="history history3">
	<p class="img"><img src="../../../images/kor/sub/history3.jpg" alt="" /></p>
	<div class="title">
		<h2>Establishment <br />of infrastructure</h2>
		<strong>2010~2015</strong>
		<span>Establishing infrastructure for the prevention of gender violence</span>
	</div>
	<ul class="list">
		<li>
			<strong>2010</strong>
			<span class="point1">March </span>
			Supported the establishment of the Korea Support Center for Women and Children Victims of Violence and entrusted with its operation (to present)
		</li>
		<li>
			<strong>2011</strong>
			<span class="point1">March </span>
			Entrusted with the management of Treatment and Rehabilitation Support for Prostituted Adolescents program (to present)<br />
			<span class="point1">May </span>
			Kim Ho Soon inaugurated as the second President<br />
			<span class="point1">December  </span>
			Consolodated three subsidiary organizations and relocated them to a central office on Seosomun-ro in the Jung-gu district of Seoul
		</li>
		<li>
			<strong>2012</strong>
			<span class="point1">April </span>
			Supported the establishment of the Korea Support Center for Women’s Hotline 1366 and entrusted with its operation (to present)
		</li>
		<li>
			<strong>2013</strong>
			<span class="point1">May </span>
			Kang Wol Goo inaugurated as the third President
		</li>
		<li>
			<strong>2014</strong>
			<span class="point1">February </span>
			Designated “Other Public Organization” by the Ministry of Planning and Finance
		</li>
		<li>
			<strong>2015</strong>
			<span class="point1">January </span>
			Entrusted with the operation of the Treatment and Customized Support for Sex Slaves of the Imperial Japanese Army program (to present)
		</li>
	</ul>
</article>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>