<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>

<c:import url="/SiteMenuWidget/tabmenu3awards.do" >
	<c:param name="use" value="Y" />
</c:import>

<div class="board-view">
	<h1 class="view-title">
		<c:out value="${awardsDataVO.subject}" />
	</h1>
	<ul class="info">
		<li>
			${awardsDataVO.author}
		</li>
	</ul>
	<div class="view-content">
		<c:if test="${!empty awardsDataVO.youtube}">
		<div>
			<iframe width="560" height="315" src="${awardsDataVO.youtube}" title="${awardsDataVO.subject}" allowfullscreen></iframe>
		</div>
		</c:if>
		${awardsDataVO.content}
	</div>
	<c:if test="${!empty atchfileList}">
	<div class="download-list">
		<strong class="title">첨부파일</strong>
		<ul>
		<c:forEach var="result" items="${atchfileList}" varStatus="status">
			<li>
				<c:set var="downloadParams" value="d_vchkcode=${result.vchkcode}&div=complicity&seq=${awardsDataVO.data_id}" />
				<a href="#download" data-url="${cutil:getUrl('/widgets/download_popup.do', downloadParams, true)}" class="btn-layerpopup ajajx-down">${result.rname} (${result.size_kb}kb)</a>
			</li>
		</c:forEach>
		</ul>
	</div>
	</c:if>
</div>


<div class="btns txt-right">
	<a href="${cutil:getUrl('/awards/list.do', 'id=', true)}" class="btn-m btn1">목록으로</a>
</div>
