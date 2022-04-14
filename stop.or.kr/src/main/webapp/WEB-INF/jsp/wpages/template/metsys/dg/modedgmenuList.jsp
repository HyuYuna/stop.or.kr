<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>

<script type="text/javascript">
jQuery(document).ready(function(){
	
	jQuery("#srch_mu_site, #srch_mu_lang").change(function(){
		jQuery("#pageIndex").val(1);
		fn_egov_cont_menulist();
	});
	
});

</script> 
<div id="divMainArticle">

	<div id="container">
			
		<form:form name="reqForm" commandName="contentsmanVO">
			<h3>메뉴연결 보기 <span class="txt_blue">(메뉴관리에서 메뉴와 연결된 컨텐츠를 메뉴구조로 보여줍니다)</span> </h3>
			
			<div class="articles_search">	
				<div class="basic_searchForm"> 
					<form:hidden path="srch_mu_gub" value="USR"/>
					사이트 : 
					<form:select path="srch_mu_site" title="사이트구분 선택">
						<form:options items="${sitecode}" itemLabel="code_nm" itemValue="code_idx"/>
					</form:select>
					&nbsp;
					언어 : 
					<form:select path="srch_mu_lang" title="언어구분 선택">
						<form:options items="${langcode}" itemLabel="code_nm" itemValue="code_idx"/>
					</form:select>
				</div>
			</div>
			<table id="tableModedgList" class="tstyle_list">
				<thead>
					<tr>
						<th scope="col" width="4%">No.</th>
						<th scope="col" width="*">컨텐츠 명</th>
						<th scope="col" width="10%">등록인</th>
						<th scope="col" width="15%">등록일시</th>
						<th scope="col" width="7%">미리보기</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<c:choose>
						<c:when test="${result.use_yn eq 'Y'}">
							<c:set var="use_yn_kr" value="사용"/>
							
							<c:choose>
								<c:when test="${empty result.ucont_subject}">
									<c:set var="linebg" value="#f2ffff"/>
								</c:when>
								<c:otherwise>
									<c:set var="linebg" value="#ffffff"/>
								</c:otherwise>
							</c:choose>
							
						</c:when>
						<c:when test="${result.use_yn eq 'N'}">
							<c:set var="use_yn_kr" value="사용안함"/>
							<c:set var="linebg" value="#f0f0f0"/>
						</c:when>
					</c:choose>
					<tr bgcolor="${linebg}" 
						 	data-tt-id="tr_${result.menu_idx}" 
					 		<c:if test="${result.menu_lv gt 1}">data-tt-parent-id="tr_${result.up_menu_idx}"</c:if> 
							<c:if test="${SESS_USR_LV > 0 and result.menu_idx eq 'MNIDX00001'}">style="display:none"</c:if>>
						<td>${result.rn}</td>
						<td class="txt_left">
							<c:choose>
								<c:when test="${not empty result.ucont_subject}">
									<a href="javascript:fn_egov_cont_view('<c:out value="${result.ucont_id}"/>')">
										<c:choose>
											<c:when test="${result.is_leaf eq 0}">
												<img src="${pageContext.request.contextPath}/images/template/metsys/common/folder-open-add2.png" width="16px"/>
											</c:when>							
											<c:otherwise>
												<img src="${pageContext.request.contextPath}/images/template/metsys/common/folder-document.png" width="16px"/>
											</c:otherwise>
										</c:choose>
										<span title="<c:out value="${result.menu_nm}"/>"><c:out value="${elfunc:cutString(result.menu_nm, 18,'..')}"/></span>
									</a>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${result.is_leaf eq 0}">
											<img src="${pageContext.request.contextPath}/images/template/metsys/common/folder-open-add2.png" width="16px"/>
										</c:when>							
										<c:otherwise>
											<img src="${pageContext.request.contextPath}/images/template/metsys/common/folder-document.png" width="16px"/>
										</c:otherwise>
									</c:choose>
									<span title="<c:out value="${result.menu_nm}"/>"><c:out value="${elfunc:cutString(result.menu_nm, 18,'..')}"/></span>
								</c:otherwise>
							</c:choose>
						</td>
						<td><c:out value="${result.writer_nm}"/></td>
						<td><c:out value="${result.wdt}"/></td>
						<td>
							<c:if test="${not empty result.ucont_subject}">
								<a href="javascript:fn_egov_cont_mainprev('${result.ucont_id}', '${result.ucont_version}')">
									<img src="${pageContext.request.contextPath}/images/template/cmm/preview_file.png" width="24" height="24" alt="미리보기">
								</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
				<c:if test = "${empty resultList}">
					<tr id="trSysmenuEmpty">
						<td colspan="5">조회 결과가 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
			</table>
			
			<form:hidden path="edomweivgp"/>
			<form:hidden path="use_yn"/>
			<form:hidden path="mu_gub"/>
			
			<input type="hidden" id="ucont_id" name="ucont_id" value=""/>
			<input type="hidden" id="ucont_version" name="ucont_version" value="0"/>
			
		</form:form>
		<form name="prevForm" method="post">
		</form>  
	 </div>
</div>