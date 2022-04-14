<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb1.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="About Us" />
	<jsp:param name="path" value="Organization chart" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<div class="org">
	<ul>
		<li class="depth1">
			<p class="label">Board of directors</p>
			<p class="label">Auditors</p>
		</li>
		<li class="depth2">
			<p class="label">President <br />(Inside Director)</p>
		</li>
		<li class="depth3">
			<ul>
				<li><span class="label">Administration and Planning Headquarters</span></li>
				<li><span class="label">Central Support Center for Prevention of Sex Trafficking (headed by the President) </span></li>
				<li><span class="label">Sexual Violence Prevention Headquarters</span></li>
				<li><span class="label">Domestic Violence Prevention Headquarters </span></li>
			</ul>
		</li>
	</ul>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>