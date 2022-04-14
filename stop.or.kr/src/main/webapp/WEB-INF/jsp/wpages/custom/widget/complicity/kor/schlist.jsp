<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>

<ul class="item">		
<c:if test="${!empty schlist}">
	<li>
		<p class="date">
			<strong>23</strong>
			수요일<br />
			05, 2018
		</p>
		<ul class="bul1">
		<c:forEach var="result" items="${schlist}" varStatus="status">
			<li>

				
				<c:out value="${elfunc:cutString(elfunc:removeTag(result.subject),40, '...')}"/>
				
			</li>
		</c:forEach>
		</ul>
	</li>
</c:if>
<c:if test="${empty schlist}">
	<li><spring:message code="COMMON.NODATA" /></li>
</c:if>
</ul>