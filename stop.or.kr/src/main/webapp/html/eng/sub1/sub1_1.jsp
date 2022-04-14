<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb1.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="About Us" />
	<jsp:param name="path" value="Greeting" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<div class="greeting">
	<p class="txt">
		Thank you for visiting the Women’s Human Rights Institute of Korea. We value your interest in gender violence and human rights.
		<br />
		With the expansion of awareness of the gravity of violence and discrimination, South Korean society is continuing its efforts to eradicate these ills. Despite these efforts, however, the forms of gender violence, such as misogynistic behaviors, dating abuse, and digital violence, are diversifying.
		<br />
		In order to respond to this ever-evolving spectrum of violence, the Women’s Human Rights Institute of Korea is spearheading the national efforts to support victims through cooperation with criminal justice professionals, women’s organizations, and victim support facilities. 
		<br />
		Along with our goal of preventing and eradicating violence against women, we are also striving to promote women’s human rights through a variety of activities including public awareness campaigns, the creation of a gender violence archive, and publishing policy research. 
		<br />
		Violence and discrimination are not simply personal or family matters. They are serious national issues that affect all aspects of our society. As such, appropriate institutions and public participation are essential.
		<br />
		The Women’s Human Rights Institute of Korea is striving to apply our expertise and experience to addressing the issue of violence against women. We encourage your interest and participation in these efforts as we shift the paradigms of violence and discrimination. 
		<br />
		Thank you.
	</p>

	<div class="title">
		<p class="desc">
			<strong>The Women’s Human Rights Institute of Korea is <br />striving to apply our expertise and experience to addressing <br />the issue of violence against women.</strong>
			<span>President, Women’s Human Rights Institute of Korea <img src="../../../images/kor/sub/greeting.png" alt="변혜정" /></span>
		</p>
		<p class="img">
			<span>Women’s Human<br /> Rights Institute of Korea</span>
			<img src="../../../images/kor/sub/greeting.jpg" alt="" />
		</p>
	</div>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>