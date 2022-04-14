<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>


<c:if test="${!empty visualList}">
	<c:forEach var="result" items="${visualList}" varStatus="status">
	<p class="img">
		<c:set var="imageParam" value="vchkcode=${result.vchkcode}" />
		<img src="${cutil:getUrl('/atchfile/imageAtchfile.do', imageParam, false)}" alt="${result.pop_title}" />
	<%--<img src="${cutil:url('/images/kor/contest/visual.gif')}" alt="성매매는 필요하다는 생각, 청소년 성매매는 청소년만의 문제라는 생각, 성매매는 내 문제가 아니라는 생각. 이런! 생각을 바꿀 생각을 찾습니다" /> --%>
	</p>
	<div class="desc">
		<%--<strong>5.28 <br />~6.24</strong> --%>
		<p><c:out value="${result.pop_title}" /></p>
		<span><c:out value="${result.pop_alt}" /></span>
		<c:if test="${!empty result.pop_link}">
			<c:choose> 
				<c:when test="${!empty result.pop_target}">
					<c:set var="target" value=" target=\"_blank\""/>
				</c:when>
				<c:otherwise>
					<c:set var="target" value=""/>
				</c:otherwise>
			</c:choose>
			<a href="${result.pop_link}"${target}>바로가기</a>
		</c:if>
	</div>
	</c:forEach>
</c:if>