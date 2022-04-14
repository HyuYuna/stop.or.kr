<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>


<!-- 상세콘텐츠 영역 -->
<div class="board-news">
	<div class="group">
		<div class="title">
			<strong>${cardNewsVO.cn_title}</strong>
			<p class="info">
				<span class="point3">조회수</span>
				${cardNewsVO.hits+1}
			</p>
		</div>
		<div class="card">
			<ul>
				<c:forEach var="result" items="${atchfileList}" varStatus="status">
					<c:if test="${status.index ne '0' }">
						<li><img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${result.vchkcode}" width="700" alt="${result.alt}" /></li>		
					</c:if>
				</c:forEach>
			</ul>
			<textarea id="cn_content" name="cn_content" title="내용" cols="90" rows="5" class="hidden-text">${cardNewsVO.cn_content}</textarea>
			<p class="count">
				<strong>1</strong>
				/
				<span>4</span>
			</p>
		</div>
	</div>
</div>



<div class="board-card">
	<ul>
		<c:forEach var="resultUnder" items="${underList}" varStatus="status">
			<c:set var="viewParams" value="seq=${resultUnder.cn_seq}&pageIndex=${pageIndex}&nownm=${resultUnder.rn}" />
			<li <c:if test="${resultUnder.cn_seq eq cardNewsVO.cn_seq}">class="active"</c:if> >
				<a href="${cutil:getUrl('/cardnews/cardNewsUsrView.do', viewParams, true)}">
<%-- 					<span class="title">${resultUnder.cn_title}</span> --%>
					<span class="img"><img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${resultUnder.vchkcode}" alt="${resultUnder.cn_alt}" width="137" height="138" /></span>
				</a>
			</li>
		</c:forEach>
	</ul>
</div>