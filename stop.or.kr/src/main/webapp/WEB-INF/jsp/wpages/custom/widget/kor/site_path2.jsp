<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>




<h1 class="cont-title">${path.get(path.size()-1).menu_nm}</h1>
<script>
$(function(){
	$(".path .group p a").click(function(){
		$(this).children().text("접기");
		if ($(".path .group").hasClass("active")) {
		  $(this).children().text("펼치기");
		}
	});
});
</script>































<!-- 
<ul class="path">
home >
<c:set var="i" value="1"/>
<c:set var="last" value="${path.size()}"/>
<c:forEach var="path" items="${path}">
${path.menu_nm } 
<c:if test="${last ne i }">
>
</c:if>
<c:set var="i" value="${i+1}"/>
</c:forEach>
</ul>
 -->