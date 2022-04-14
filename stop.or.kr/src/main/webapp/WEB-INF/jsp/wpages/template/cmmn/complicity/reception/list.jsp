<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>

<!-- 상세콘텐츠 영역 -->
<h2 class="title1">접수확인</h2>
<div class="table-wrap">
	<table>
		<caption>접수확인 - 접수번호, 분류, 접수일, 첨부파일 확인, 상태</caption>
		<thead>
			<tr>
				<th scope="col">접수번호</th>
				<th scope="col">분류</th>
				<th scope="col">접수일</th>
				<th scope="col">첨부파일 확인</th>
				<th scope="col"><span class="sr-only">상태</span></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td><c:out value="${result.data_id}"/></td>
				<td><c:out value="${result.item_target}" /></td>
				<td>${cutil:dateFormat(result.complicityVO.wdt, 'yy. MM. dd')}</td>
				<td>
					<c:set var="downloadParam" value="vchkcode=${result.atchfileVO.vchkcode}"/>
					<a href="${cutil:getUrl('/atchfile/downloadAtchfile.do', downloadParam, false)}" class="btn-s btn2">다운로드</a>
				</td>
				<td>${cutil:complicityStateHtml(result.item_state)}</td>
			</tr>
			</c:forEach>
			<c:if test = "${fn:length(resultList) eq 0}">
			<tr>
				<td colspan="5">조회 결과가 없습니다.</td>
			</tr>
		</c:if>
			
		</tbody>
	</table>
</div>
<ul class="box1">
	<li>
		<span class="icon1 type1">접수완료</span>
		담당자 확인완료 상태입니다.
	</li>
	<li>
		<span class="icon1 type6">접수대기</span>
		담당자 확인 전 상태입니다.
	</li>
	<li>
		<span class="icon1 type7">접수반려</span>
		해당 사유로 인해 접수가 되지 않은 상태입니다.
	</li>
</ul>
<!-- // -->         