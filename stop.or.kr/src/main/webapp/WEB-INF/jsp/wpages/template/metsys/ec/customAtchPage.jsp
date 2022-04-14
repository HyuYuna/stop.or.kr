<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div id="divMainArticle">
	
	<form:form name="reqForm" method="post" commandName="atchfileVO">
	
		<h3>컨텐츠상에 필요한 파일을 등록하고 링크를 걸어 사용</h3>
		웹 접근성 준수를 위해 파일명을 상세히 적어주세요.
		<br/>
		<div class="articles_search">		
			<p class="articles">전체 <span class="txt_bold">${totCnt}건</span>, 현재 페이지 <span class="total">${curPage}</span> / ${totPage } pages</p>		
		</div>
		<table id="tableSysmenuList" class="tstyle_list">
			<thead>
				<tr>
					<th scope="col" width="5%">순번</th>
					<th scope="col" width="10%">미리보기</th>
					<th scope="col" width="5%">종류</th>
					<th scope="col" width="30%">파일명</th>
					<th scope="col" width="45%">링크</th>
					<th scope="col" width="5%">삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td>${result.rn}</td>
					<td class="txt_center">
						<a href="javascript:cmmfn_download_atchfile('${pageContext.request.contextPath}','${result.vchkcode}')">
							<c:choose>
								<c:when test="${result.fext eq 'jpg' or result.fext eq 'gif' or result.fext eq 'png' or result.fext eq 'bmp'}">
									<img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${result.vchkcode}"
								 		width="70px" height="70px" alt="${result.rname}"/>
								</c:when>
								<c:when test="${result.fext eq 'ppt' or result.fext eq 'pptx'}">
									<img src="${pageContext.request.contextPath}/images/template/exticos/ppt.gif"/>
								</c:when> 
								<c:when test="${result.fext eq 'xls' or result.fext eq 'xlsx'}">
									<img src="${pageContext.request.contextPath}/images/template/exticos/xls.gif"/>
								</c:when> 
								<c:when test="${result.fext eq 'doc' or result.fext eq 'docx'}">
									<img src="${pageContext.request.contextPath}/images/template/exticos/docx.gif"/>
								</c:when>
								<c:when test="${result.fext eq 'hwp'}">
									<img src="${pageContext.request.contextPath}/images/template/exticos/hwp.gif"/>
								</c:when>
								<c:otherwise>
									<img src="${pageContext.request.contextPath}/images/template/exticos/dft.gif"/>
								</c:otherwise> 
							</c:choose>
						</a>
					</td>
					<td>${result.fext}</td>
					<td class="txt_left">${result.rname}</td>
					<td class="txt_left">
						<c:choose>
							<c:when test="${result.fext eq 'jpg' or result.fext eq 'gif' or result.fext eq 'png' or result.fext eq 'bmp'}">
								/atchfile/imageAtchfile.do?vchkcode=<c:out value="${result.vchkcode}"/>
							</c:when>
							<c:otherwise>
								/atchfile/binaryAtchfile.do?vchkcode=<c:out value="${result.vchkcode}"/>
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<a href="javascript:cmmfn_delete_onefile('${pageContext.request.contextPath}', '${result.vchkcode}', fn_egov_atch_list)">
							<img src="${pageContext.request.contextPath}/images/template/sub/btn_delete2.gif"/>
						</a>
					</td>
				</tr>
				</c:forEach>
				<c:if test = "${totCnt eq 0}">
					<tr id="trSysmenuEmpty">
						<td colspan="9">조회 결과가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
		
		<c:if test="${totPage gt 1}">
			<div class="board_pager">
				<ui:pagination paginationInfo = "${paginationInfo}" type="image"
					jsFunction="fn_egov_link_page" />
			</div>
		</c:if>
		
		<div class="fileUpload_area">
			<h2>첨부파일</h2><input type="file" name="file_upload" id="file_upload"/>
			<ul class="fileUpload_progress">
				<li><div id="divSelectFileArea"></div></li>
			</ul>
		</div>

		<div class="btn_area_right">
			<a href="javascript:fn_egov_custatch_save()" class="btn_line">등록</a>
			<!-- <a href="javascript:fn_egov_sysmenu_script()">스크립트</a> -->
		</div>
		
		<form:hidden path="pageIndex"/>
		<input type="hidden" id="maxcustkey" value="${maxcustkey}"/>
		
		<form:hidden path="srch_mu_site"/>
		<form:hidden path="srch_mu_lang"/>
		
		
	</form:form>
</div>
