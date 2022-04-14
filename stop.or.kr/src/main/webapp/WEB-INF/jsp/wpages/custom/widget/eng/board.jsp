<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>

<ul>
<c:choose>
	<c:when test="${!empty resultList}">
		<c:forEach var="result" items="${resultList}" varStatus="status">
			
			<li>
				<a href="${pageContext.request.contextPath}/brdartcl/boardarticleView.do?brd_id=${result.brd_id}&srch_menu_nix=${menu_nix}&cont_idx=${result.cont_idx}&srch_mu_lang=CDIDX00023"><c:out value="${elfunc:cutString(result.subject,100, '...')}"/></a>
				<span> <c:out value="${result.wdt}"/> </span>
			</li>
				
		</c:forEach>
	</c:when>
	<c:otherwise>
		<li>
			<strong>No Data.</strong>
		</li>
	</c:otherwise>
</c:choose>
</ul>
