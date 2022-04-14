<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>

<style>
.a11y-hidden {
  position: absolute;
  width: 1px;
  height: 1px;
  margin: -1px;
  overflow: hidden;
  clip-path: polygon(0 0, 0 0, 0 0);
}
</style>

<div class="board-card">
	<ul>
		<c:forEach var="resultUnder" items="${underList}" varStatus="status">
			<c:set var="viewParams" value="seq=${resultUnder.cn_seq}&pageIndex=${pageIndex}&nownm=${resultUnder.rn}" />
			<li <c:if test="${resultUnder.cn_seq eq webtoonVO.cn_seq}">class="active"</c:if> >
				<a href="${cutil:getUrl('/webtoon/webtoonUsrView.do', viewParams, true)}">
					<span class="title">${resultUnder.cn_title}</span>
					<span class="img"><img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${resultUnder.vchkcode}" width="137" height="138" alt="${resultUnder.cn_title}" /></span>
				</a>
			</li>
		</c:forEach>
	</ul>
</div>


<!-- 상세콘텐츠 영역 -->
<div class="board-news">
	<div class="group">
		<div class="title">
			<strong>${webtoonVO.cn_title}</strong>
			<p class="info">
				<span class="point3">조회수</span>
				${webtoonVO.hits+1}
			</p>
		</div>
		<div class="card webtoon">
			<ul>
				<c:forEach var="result" items="${atchfileList}" varStatus="status">
					<c:if test="${status.index ne '0' }">
						<li><img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${result.vchkcode}" alt="${result.alt}" />${result.add_tag}</li>		
					</c:if>
				</c:forEach>
			</ul>
			<textarea id="cn_content" name="cn_content" title="내용" cols="90" rows="5" class="hidden-text">${webtoonVO.cn_content}</textarea>
			<!-- 
			<p class="count">
				<strong>1</strong>
				/
				<span>4</span>
			</p> -->
		</div>
	</div>
</div>



<div class="board-card">
	<ul>
		<c:forEach var="resultUnder" items="${underList}" varStatus="status">
			<c:set var="viewParams" value="seq=${resultUnder.cn_seq}&pageIndex=${pageIndex}&nownm=${resultUnder.rn}" />
			<li <c:if test="${resultUnder.cn_seq eq webtoonVO.cn_seq}">class="active"</c:if> >
				<a href="${cutil:getUrl('/webtoon/webtoonUsrView.do', viewParams, true)}">
					<span class="title">${resultUnder.cn_title}</span>
					<span class="img"><img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${resultUnder.vchkcode}" width="137" height="138" alt="${resultUnder.cn_title}" /></span>
				</a>
			</li>
		</c:forEach>
	</ul>
</div>