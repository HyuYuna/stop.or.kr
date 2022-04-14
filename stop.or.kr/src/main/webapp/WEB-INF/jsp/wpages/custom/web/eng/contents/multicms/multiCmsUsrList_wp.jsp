<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>



<ul class="board-ebook type1">
	
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<li>
			<span class="img"><img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${result.img_code}" width="140" height="190" alt="${result.mc_title}" /></span>
			<strong><c:out value="${result.mc_title}"/> </strong>
			<p class="txt">
				<c:out value="${elfunc:removeTag(result.mc_content)}"/>
			</p>
			
			<div class="info">
			<p>
				
			</p>
			<p>
			
			</p>
			</div>
			<c:if test="${!empty result.file_code}">
			<a href="javascript:cmmfn_download_atchfile('${pageContext.request.contextPath}', '${result.file_code}')"  class="btn-m btn2">PDF DOWNLOAD</a>
			</c:if>
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
	<form:form name="reqForm" class="search" commandName="multiCmsVO">
	<form:hidden path="pageIndex" value="${pageIndex}"/>
	<form:select path="searchCondition">
		<form:option value="SUBJECT">TITLE</form:option>
	</form:select>
	<form:input path="searchKeyword" class="keyword" />
	<a href="#" class="btn" onclick="$('form.search').submit();">Search</a>
	</form:form>
</div>
	
	
	
	
	
	
	
	
	