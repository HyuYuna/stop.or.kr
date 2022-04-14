<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>

<script>
	$(function(){
		$(".board-thumb li").eq(7).hide();
		$(".board-thumb li").eq(8).hide();
	})
</script>
	        
<!-- 상세콘텐츠 영역 -->
<ul class="board-thumb type1">
<c:choose>
	<c:when test="${!empty resultList}">
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<li>
				<c:if test="${result.max_seq gt 0 }">
					<c:set var="viewParams" value="seq=${result.max_seq}&pageIndex=${pageIndex}&nownm=${result.rn}&cate=${result.cn_seq}" />
					<a href="${cutil:getUrl('/webtoon/webtoonUsrView.do', viewParams, true)}" >
				</c:if>
					<span class="img"><img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${result.vchkcode}" width="225" height="158" alt="${result.cn_title}" /></span>
					<strong><c:out value="${result.cn_title}"/></strong>
					<p class="info"><c:out value="${result.wdt}"/></p>
				<c:if test="${result.max_seq gt 0 }">
					</a>
				</c:if>
			</li>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<li>등록된 데이터가 없습니다.</li>
	</c:otherwise>
</c:choose>	
</ul>


<c:if test="${paginationInfo.totalPageCount gt 1}">
     	<div class="pager">
		<ui:pagination paginationInfo = "${paginationInfo}" type = "user"
			jsFunction = "fn_egov_link_page" />
	</div>
</c:if>


<div class="board-search">
	<form:form name="reqForm" class="search" commandName="webtooncategoryVO">
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
		<span class="icon"><img src="/images/kor/sub/ggnr_type4.png" alt="OPEN 공공누리 공공저작물 자유이용허락 출처표시 / 상업용금지 / 변경금지" style="width:200px;"></span>
		<p class="txt">본 저작물은 "공공누리 제4유형 : 출처표시+상업적이용금지+변경금지" 조건에 따라 이용할 수 있습니다. 개인 외 기관 등에서 활용 목적으로 다운로드 시 활용 전 담당자에게 문의 바랍니다. 홍보 담당자</p>
	</div>
</div>


<%-- <c:set var="viewParams1" value="seq=${result.cn_seq}&pageIndex=1&nownm=${result.rn}&cate=${result.category}" />	

<c:set var="viewParams2" value="seq=${result2.cn_seq}&pageIndex=1&nownm=${result2.rn}&cate=${result2.category}" />	

<ul class="board-thumb type1">

	<c:set var="viewParams" value="seq=1&pageIndex=1&nownm=1" />	
	<li><a href="<c:if test="${not empty result.cn_seq}">${cutil:getUrl('/webtoon/webtoonUsrView.do',viewParams1, true)}</c:if>" ><span class="img"><img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${result.vchkcode}" width="225" height="158" alt="${result.cn_title}" /></span>
				<strong><c:out value="불어라비바람"/></strong></a></li>
	<li><a href="<c:if test="${not empty result2.cn_seq}">${cutil:getUrl('/webtoon/webtoonUsrView.do',viewParams2, true)}</c:if>" ><span class="img"><img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${result.vchkcode}" width="225" height="158" alt="${result.cn_title}" /></span>
				<strong><c:out value="여행"/></strong></a></li>
	
</ul>
 --%>











<%
if(true)
{
  return;
}
%>
<div class="table-wrap board" style="display:none">
	<table>
		<caption>공지사항 목록 - 번호, 분류, 제목, 담당부서, 등록일, 조회수</caption>
		<colgroup>
			<col class="date">
			<col class="subject">
			<col class="date">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">제목</th>
				<th scope="col">등록일</th>
			</tr>
		</thead>
		<tbody>
				

				<c:forEach var="result" items="${resultList}" varStatus="status">
					<c:set var="viewParams" value="seq=${result.cn_seq}&pageIndex=${pageIndex}&nownm=${result.rn}" />	
					<tr>
						<td><c:out value="${totCnt - (result.rn - 1)}"/></td>
						<td class="subject">
							<a href="${cutil:getUrl('/webtoon/webtoonUsrView.do', viewParams, true)}"><c:out value="${result.cn_title}"/></a>	
						</td>
						<td><c:out value="${result.wdt}"/></td>
					</tr>
				</c:forEach>
				
				<c:if test="${paginationInfo.totalRecordCount eq 0}">
					<tr>
						<td colspan="3"> 조회 결과가 없습니다 </td>
					</tr>
				</c:if>	
		</tbody>
	</table>	
</div>

<ul class="board-thumb type1">
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<c:set var="viewParams" value="seq=${result.cn_seq}&pageIndex=${pageIndex}&nownm=${result.rn}" />	
		<li>
			<a href="${cutil:getUrl('/webtoon/webtoonUsrView.do', viewParams, true)}" >
				<span class="img"><img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${result.vchkcode}" width="225" height="158" alt="${result.cn_title}" /></span>
				<strong><c:out value="${result.cn_title}"/></strong>
				<p class="info"><c:out value="${result.wdt}"/></p>
			</a>
		</li>
	</c:forEach>
	
</ul>



<c:if test="${paginationInfo.totalPageCount gt 1}">
     	<div class="pager">
		<ui:pagination paginationInfo = "${paginationInfo}" type = "user"
			jsFunction = "fn_egov_link_page" />
	</div>
</c:if>


<div class="board-search">
	<form:form name="reqForm" class="search" commandName="webtoonVO">
	<form:hidden path="pageIndex"/>
	<form:select path="searchCondition">
		<form:option value="SUBJECT">제목</form:option>
	</form:select>
	<form:input path="searchKeyword" class="keyword" />
	<a href="#" class="btn" onclick="$('form.search').submit();">검색</a>
	</form:form>
</div>
	
	
	
	
	
	
	
	
	