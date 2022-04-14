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
		fn_egov_brd_list();
	});
	
});

</script> 
<form:form name="reqForm" commandName="boardinfoVO">
<!-- content -->
<div class="float_wrap">
	<div class="articles_search">		
		
		<div class="basic_searchForm">
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
</div>
<table class="tstyle_list">
	<caption>
	</caption>
	<colgroup>
		<col width="5%" />
		<col width="30%" />
		<col width="*" />
		<col width="10%" />
	</colgroup>
	<thead>
		<tr>
	    	<!--  <th scope="col" width="4%"><input type="checkbox" name="chk" title="선택하기" /></th> -->
	        <th scope="col">No.</th>
	        <th scope="col">게시판명</th>
	        <th scope="col">게시판링크</th>
	        <th scope="col">등록일</th>
	    </tr>
	</thead>
	<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
	       	<tr>
				<td><c:out value="${result.rn}"/></td>
				<td class="txt_left"><a href="javascript:fn_egov_brd_mod('<c:out value="${result.brd_id}"/>')" title="<c:out value="${result.brd_dft}"/>"><c:out value="${elfunc:cutString(result.brd_dft, 50, '..')}"/></a></td>
				<td class="txt_left">
					<c:choose>
						<c:when test="${result.brd_gb eq 'CDIDX00043'}">
							<a href="${pageContext.request.contextPath}/brdfaq/boardfaqList.do?srch_menu_nix=${param.srch_menu_nix}&brd_id=<c:out value="${result.brd_id}"/>">
								${pageContext.request.contextPath}/brdfaq/boardfaqList.do?brd_id=<c:out value="${result.brd_id}"/>
							</a>
						</c:when>
						<c:when test="${result.brd_gb eq 'CDIDX00044'}">
							<a href="${pageContext.request.contextPath}/brdthm/boardthmList.do?srch_menu_nix=${param.srch_menu_nix}&brd_id=<c:out value="${result.brd_id}"/>">
								${pageContext.request.contextPath}/brdthm/boardthmList.do?brd_id=<c:out value="${result.brd_id}"/>
							</a>
						</c:when>
						<c:when test="${result.brd_gb eq 'CDIDX00045'}">
							<a href="${pageContext.request.contextPath}/brddry/boarddryList.do?srch_menu_nix=${param.srch_menu_nix}&brd_id=<c:out value="${result.brd_id}"/>">
								${pageContext.request.contextPath}/brddry/boarddryList.do?brd_id=<c:out value="${result.brd_id}"/>
							</a>
						</c:when>
						<c:when test="${result.brd_gb eq 'CDIDX00046'}">
							<a href="${pageContext.request.contextPath}/brdanm/boardanonimList.do?srch_menu_nix=${param.srch_menu_nix}&brd_id=<c:out value="${result.brd_id}"/>">
								${pageContext.request.contextPath}/brdanm/boardanonimList.do?brd_id=<c:out value="${result.brd_id}"/>
							</a>
						</c:when>
						<c:otherwise>
							<a href="${pageContext.request.contextPath}/brdartcl/boardarticleList.do?srch_menu_nix=${param.srch_menu_nix}&brd_id=<c:out value="${result.brd_id}"/>">
								${pageContext.request.contextPath}/brdartcl/boardarticleList.do?brd_id=<c:out value="${result.brd_id}"/>
							</a>
						</c:otherwise>
					</c:choose>
				</td>
				<td><c:out value="${result.wdt}"/></td>
			</tr>
		</c:forEach>
		<c:if test = "${totCnt eq 0}">
			<tr>
				<td colspan="4">조회 결과가 없습니다.</td>
			</tr>
		</c:if>
    </tbody>
</table>		
<div class="btn_area_right">
	<a href="javascript:fn_egov_brd_add()" class="btn_line">추가</a>
</div>
<form:hidden path="edomweivgp"/>

</form:form>    