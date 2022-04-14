<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>


<div class="item">
	
	<c:if test="${!empty multiCmsList}">
		<a href="${pageContext.request.contextPath}/multicms/multiCmsUsrList.do?category=wp&srch_menu_nix=cQdZfk88&srch_mu_lang=CDIDX00023">
			<span class="img"><img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${multiCmsList.get(0).img_code}" width="110" height="140" alt="${multiCmsList.get(0).mc_title}}" /></span>
			<strong><c:out value="${multiCmsList.get(0).mc_title}"/></strong>
			<p><c:out value="${elfunc:cutString(elfunc:removeTag(multiCmsList.get(0).mc_content),40, '...')}"/></p>
		</a>
	</c:if>
</div>



