<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>


<ul>
	<c:if test="${!empty multiCmsList}">
		<li>
			<c:if test="${!empty multiCmsList.get(0).file_code}">
				<c:url value="${pageContext.request.contextPath}/widgets/download_popup.do" var="url">
				  <c:param name="d_vchkcode" value="${multiCmsList.get(0).file_code}" />
				  <c:param name="div" value="multicms_${multiCmsList.get(0).mc_category}" />
				  <c:param name="seq" value="${multiCmsList.get(0).mc_seq}" />
				  <c:param name="subject" value="${multiCmsList.get(0).mc_title}" />
				</c:url>
			</c:if>
			<a href="#download" data-url="${url}" class="btn-layerpopup ajajx-down">
				<span class="img"><img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${multiCmsList.get(0).img_code}" alt="${multiCmsList.get(0).mc_alt}" /></span>
				<span class="text"><c:out value="${multiCmsList.get(0).mc_title}"/></span>
			</a>
		</li>
		<li>
			<c:if test="${!empty multiCmsList.get(1).file_code}">
				<c:url value="${pageContext.request.contextPath}/widgets/download_popup.do" var="url">
				  <c:param name="d_vchkcode" value="${multiCmsList.get(1).file_code}" />
				  <c:param name="div" value="multicms_${multiCmsList.get(1).mc_category}" />
				  <c:param name="seq" value="${multiCmsList.get(1).mc_seq}" />
				  <c:param name="subject" value="${multiCmsList.get(1).mc_title}" />
				</c:url>
			</c:if>
			<a href="#download" data-url="${url}" class="btn-layerpopup ajajx-down">
				<span class="img"><img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${multiCmsList.get(1).img_code}" alt="${multiCmsList.get(1).mc_alt}"/></span>
				<span class="text"><c:out value="${multiCmsList.get(1).mc_title}"/></span>
			</a>
		</li>
	</c:if>
</ul>



