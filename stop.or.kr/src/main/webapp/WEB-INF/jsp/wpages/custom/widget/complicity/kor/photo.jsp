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
					<div class="title">
					
						<p>
							<em>진흥원소식</em>
							<strong><c:out value="${elfunc:cutString(result.subject,30, '...')}"/></strong>
							<span><img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${result.vchkcode}" alt="${result.subject}" width="386px" height="236px"/></span>
						</p>
					</div>
					<p class="txt">
						<c:out value="${elfunc:cutString(elfunc:removeTag(result.brd_cont),40, '...')}"/>
					</p>	
					<a href="${pageContext.request.contextPath}/brdartcl/boardarticleView.do?brd_id=${result.brd_id}&srch_menu_nix=${menu_nix}&cont_idx=${result.cont_idx}" class="btn">자세히 보기</a>	
					
				</li>
			</c:forEach>
			</ul>
		</c:when>
		<c:otherwise>
			<li>등록된 데이터가 없습니다.</li>
		</c:otherwise>
	</c:choose>
</ul>



