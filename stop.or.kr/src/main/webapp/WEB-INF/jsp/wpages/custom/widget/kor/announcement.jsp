<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>


<c:choose>
	<c:when test="${!empty resultList}">
		<ul>
		<c:forEach var="result" items="${resultList}" varStatus="status">
					<li><a href="${pageContext.request.contextPath}/announcement/view.do?groupId=${result.group_id}&srch_menu_nix=${menu_nix}&id=${result.data_id}"><c:out value="${elfunc:cutString(result.subject,30, '...')}"/></a></li>
		</c:forEach>
		</ul>
	</c:when>
	<c:otherwise>
		<ul class="nodata"><li>등록된 데이터가 없습니다.</li></ul>
	</c:otherwise>
</c:choose>




