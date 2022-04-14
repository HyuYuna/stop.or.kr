<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>



	<c:if test="${!empty resultList}">
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<a href="/cardnews/cardNewsUsrView.do?srch_menu_nix=czt8k027&seq=${result.cn_seq}&pageIndex=1&nownm=${result.rn}">
				<p class="img"><img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${result.vchkcode}" alt="${result.cn_alt}" /></p>
				<div class="info">
					<p class="text"><c:out value="${result.cn_title}"/></p>
					<p class="date"><c:out value="${result.wdt}"/></p>
				</div>
			</a>
		</c:forEach>
	</c:if>




