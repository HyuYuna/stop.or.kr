<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>



<c:if test="${!empty twitterList}">
	<c:forEach var="result" items="${twitterList}" varStatus="status">
		
		<li>
			<strong>${user.getName()} <a href="<c:out value="${user.getURL()}"/>" target="_blank">@<c:out value="${result.getUser().getScreenName()}"/></a></strong>
			<p><c:out value="${result.getText()}"/></p>
		</li>

	</c:forEach>
</c:if>
