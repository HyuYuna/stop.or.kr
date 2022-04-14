<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<c:if test="${!empty visualList}">
	<div class="paging">
		<strong>1</strong>
		<span>${visual_size}</span>
	</div>
	<ul>
		<c:forEach var="result" items="${visualList}" varStatus="status">
	
			<li><a href="${result.pop_link }" target="${result.pop_target}" title="새창열림"><img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${result.vchkcode}" alt="${result.pop_alt}"/></a></li>
	
		</c:forEach>
	</ul>
</c:if>