<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<form:form name="reqForm" commandName="cardNewsVO" action="${cutil:getUrl('/metsys/cardnews/cardNewsSave.do', '', true)}" class="ajax-form-submit_cn" method="post" enctype="multipart/form-data">

<!-- content -->
<div id="divMainArticle">

		<h2>카드뉴스 관리</h2><br/>

		<table class="tstyle_view">
			<colgroup>
				<col width="18%" />
				<col />
			</colgroup>
			<caption>등록 폼</caption>
			<tr style="display:none">
				<th scope="row"><label for="title">공지</label></th>
				<td>
					<input type="radio" name="is_notice" id="is_notice_y" value="Y" <c:if test="${ fn:trim(cardNewsVO.is_notice) eq 'Y'}">checked="checked"</c:if>><label for="is_notice_y">사용</label>
					<input type="radio" name="is_notice" id="is_notice_n" value="N" <c:if test="${ fn:trim(cardNewsVO.is_notice) eq 'N'}">checked="checked"</c:if>><label for="is_notice_n">미사용</label>
				</td>
			</tr>
			
			<tr>
				<th scope="row"><label for="cn_title">제목</label></th>
				<td><form:input path="cn_title" name="cn_title" class="input_width_700" title="제목"/>
				<form:errors path="cn_title"/></td>
			</tr>			
			<tr id="cn_content">
				<th scope="row"><label for="title">내용</label></th>
				<td>
					<form:textarea path="cn_content" title="내용" cols="90" rows="5"/>
				</td>
			</tr>
			
		</table>
		<br/>
		<div class="fileUpload_area">
			<h2>파일</h2><input type="file" name="file_upload" id="file_upload"/>
			<ul class="fileUpload_progress">
				
				<c:forEach var="result" items="${atchfileList}" varStatus="status">
					<li class="file_li">
						<div id="divAtcharea_${result.atckey_4th}" class="uploadify-queue-item">
							<div class="cancel">
								<a href="javascript:cmmfn_delete_onefile('${pageContext.request.contextPath}', '${result.vchkcode}', fn_cn_page_reload)">X</a>
							</div>
							<div class="file_area">
								<span class="fileName">
									<img src="${pageContext.request.contextPath}/images/template/exticos/${elfunc:getImgicoByExt(result.fext)}.gif" width="16" height="16" alt="htp"/>
									<a href="javascript:cmmfn_download_atchfile('${pageContext.request.contextPath}', '${result.vchkcode}')">${result.rname} (${result.size_kb}kb)</a>
								</span>
								<span class="data"></span>
							</div> 
						</div>
					</li>
				</c:forEach>
				<li><div id="divSelectFileArea"></div></li>
			</ul>
		</div>
		<br/>

		
		<div class="btn_area_right">
			<a href="#" onclick="file_attach_check();return false;" class="btn_line">저장하기</a>
			<a href="javascript:fn_egov_card_news_list();" class="btn_line">목록보기</a>
		</div>
		<form:hidden path="edomweivgp" />
		<form:hidden path="pageIndex" value="${pageIndex}"/>
		<form:hidden path="cn_seq"/>
		<form:hidden path="srch_mu_site"/>
		<form:hidden path="srch_mu_lang"/>
		
</div>

</form:form>