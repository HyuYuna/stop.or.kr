<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>

<ul class="board-thumb type1">
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<li><c:url value="${pageContext.request.contextPath}/widgets/download_popup.do" var="url">
			  <c:param name="d_vchkcode" value="${result.file_code}" />
			  <c:param name="div" value="multicms_${result.mc_category}" />
			  <c:param name="seq" value="${result.mc_seq}" />
			  <c:param name="subject" value="${result.mc_title}" />
			</c:url>
			<a href="#download" data-url="${url}" class="btn-layerpopup ajajx-down">
				<span class="img">
					<img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${result.img_code}" alt="${result.mc_title}" width="163" height="113"/>
				</span>
				<strong><c:out value="${elfunc:cutString(result.mc_title, 30, '...')}"/></strong>
				<p class="info">
					${result.wdt}
				</p>
				
			</a>
		</li>
	</c:forEach>

	<c:if test="${totCnt eq 0}">
		<li><spring:message code="BOARD.NO-DATA" /><%-- 조회 결과가 없습니다. --%></li>
	</c:if>
</ul>
	
	



<c:if test="${paginationInfo.totalPageCount gt 1}">
     	<div class="pager">
		<ui:pagination paginationInfo = "${paginationInfo}" type = "user"
			jsFunction = "fn_egov_link_page" />
	</div>
</c:if>


<div class="board-search">
	<form:form name="reqForm" class="search" commandName="multiCmsVO">
	<form:hidden path="pageIndex" />
	<label for="searchCondition" class="hidden-text">검색 구분</label>
	<form:select path="searchCondition">
		<form:option value="SUBJECT">제목</form:option>
	</form:select>
	
	<label for="searchKeyword" class="hidden-text">검색어 입력</label>
	<form:input path="searchKeyword" class="keyword" />
	<a href="#" class="btn" onclick="$('form.search').submit();">검색</a>
	</form:form>
</div>

<br>
<div class="box1 gongnr">
    <div class="item">
        <span class="icon">
            <img src="/images/kor/sub/ggnr_type4.png" alt="OPEN 공공누리 공공저작물 자유이용허락 출처표시 / 상업용금지 / 변경금지" style="width:200px;">
        </span>
        <p class="txt">본 저작물은 &quot;공공누리 제4유형 : 출처표시+상업적이용금지+변경금지&quot; 조건에 따라 이용할 수 있습니다. 개인 외 기관 등에서 활용 목적으로 다운로드 시 활용 전 담당자에게 문의 바랍니다. <br/>※담당자: 장예진/02-6363-8436/yejin0712@stop.or.kr</p>
    </div>
</div>