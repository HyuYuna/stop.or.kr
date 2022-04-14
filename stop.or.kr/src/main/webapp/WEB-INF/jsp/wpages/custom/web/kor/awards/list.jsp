<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="/SiteMenuWidget/tabmenu3awards.do" >
	<c:param name="use" value="Y" />
</c:import>

<ul class="board-thumb">
<c:forEach var="result" items="${resultList}" varStatus="status">
	<li>
		<c:set var="viewParams" value="id=${result.data_id}" />
		<a href="${cutil:getUrl('/awards/view.do', viewParams, true)}">
			<span class="img">
				<c:set var="imageParam" value="vchkcode=${result.atchfileVO.vchkcode}"/>
				<img src="${cutil:getUrl('/atchfile/imageAtchfile.do', imageParam, true)}" height="100" width="100" />
			</span>
			<span class="icon1 type8"><c:out value="${cutil:awardsText(result.awards)}"/></span>
			<strong><c:out value="${result.subject}" /></strong>
		</a>
	</li>
</c:forEach>
</ul>

<br>
<div class="box1 gongnr">
	<div class="item">
		<span class="icon"><img src="/images/kor/sub/ggnr_type4.png" alt="OPEN 공공누리 공공저작물 자유이용허락 출처표시 / 상업용금지 / 변경금지" style="width:200px;"></span>
		<p class="txt">본 저작물은 &quot;공공누리 제4유형 : 출처표시+상업적이용금지+변경금지&quot; 조건에 따라 이용할 수 있습니다. 개인 외 기관 등에서 활용 목적으로 다운로드 시 활용 전 담당자에게 문의 바랍니다. 홍보 담당자</p>
	</div>
</div>
