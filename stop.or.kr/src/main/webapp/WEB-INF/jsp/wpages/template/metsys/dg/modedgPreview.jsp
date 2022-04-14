<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>

<style>
	<c:out value="${contentsmanVO.ucont_css}"/>
</style>


<div id="content">

	<!-- contents area -->
	<article id="detail_content">
	
		<div id="divUcont_cont" style="margin:50px;">
			${elfunc:removeScrtag(contentsmanVO.ucont_cont)}
		</div>
		
	</article>
</div>
