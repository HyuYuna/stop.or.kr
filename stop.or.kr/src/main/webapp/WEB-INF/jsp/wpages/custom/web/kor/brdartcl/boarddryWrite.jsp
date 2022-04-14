<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${boarddryVO.srch_menu_nix eq 'eZ5zT3co' }">

	<div class="title_area group">
		<h2>기타관리</h2>
		<p class="path">
			<img src="${pageContext.request.contextPath}/images/template/sub/ico_home.gif" alt="" /> Home &gt; 기타관리 &gt; <strong>전체일정관리</strong> 
		</p>
	</div>
	<h3>전체일정관리
	</h3><br/>

</c:if>		
<form:form name="reqForm" commandName="boarddryVO">
	<div id="divMainArticle">
		<section id="content"> 
	
			<article id="detail_content">
				<p><span class="point01">*</span> 항목은 필수입력 항목입니다.</p>
				
				<table class="tstyle_write" summary="작성자, 제목, 분류, 이메일, 공지설정, 비밀글 설정, 내용 입력, 첨부파일 등록">
					<caption>글 등록</caption>
					<colgroup>
						<col width="100" />
						<col width="*" />
					</colgroup> 
					<c:if test="${boarddryVO.edomweivgp eq 'R' }">
					<!-- 등록 / 수정 -->
					<tr>
						<th scope="row" class="left"><label for="startdt">등록일자</label></th>
						<td class="form">
							${fn:substring(boarddryVO.startdt, 0, 10) }~${fn:substring(boarddryVO.enddt, 0, 10) }
						</td>
					</tr>
					<tr>
						<th scope="row" class="left"><label for="ctgry_idx">구분</label></th>
						<td class="form">
							<form:select path="ctgry_idx" disabled="true">
								<form:option value="CTIDX00082">전시</form:option>
								<form:option value="CTIDX00083">행사</form:option>
								<form:option value="CTIDX00084">교육</form:option>
								<form:option value="CTIDX00085">기타</form:option>
							</form:select>
						</td>
					</tr>
					<tr>
						<th scope="row" class="left"><label for="subject">제목</label></th>
						<td class="form">
							${boarddryVO.subject }
						</td>
					</tr>
					<tr>
						<th scope="row" class="left"><label for="dry_place">장소</label></th>
						<td class="form">
							${boarddryVO.dry_place }
						</td>
					</tr>
					<tr>
						<th scope="row"><label for=ref_url>링크</label></th>
						<td>
							<c:if test="${boarddryVO.ref_url ne null }">
							<form:select path="ref_target" title="링크타겟" disabled="true">
								<form:option value="_blank">새창</form:option>
								<form:option value="">현재창</form:option>
							</form:select>
							</c:if>
							${boarddryVO.ref_url }
							
								
						</td>
					</tr>
					</c:if>
					<c:if test="${boarddryVO.edomweivgp eq 'A' or boarddryVO.edomweivgp eq 'M' }">
					<!-- 등록 / 수정 -->
					<tr>
						<th scope="row" class="left"><label for="startdt">등록일자</label></th>
						<td class="form">
							<form:input path="startdt" value="${fn:substring(boarddryVO.startdt, 0, 10) }"/>~<form:input path="enddt" value="${fn:substring(boarddryVO.enddt, 0, 10) }"/>
						</td>
					</tr>
					<tr>
						<th scope="row" class="left"><label for="ctgry_idx">구분</label></th>
						<td class="form">
							<form:select path="ctgry_idx">
								<form:option value="CTIDX00082">전시</form:option>
								<form:option value="CTIDX00083">행사</form:option>
								<form:option value="CTIDX00084">교육</form:option>
								<form:option value="CTIDX00085">기타</form:option>
							</form:select>
						</td>
					</tr>
					<tr>
						<th scope="row" class="left"><label for="subject">제목</label></th>
						<td class="form">
							<form:input path="subject"/>
						</td>
					</tr>
					<tr>
						<th scope="row" class="left"><label for="dry_place">장소</label></th>
						<td class="form">
							<form:input path="dry_place"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for=ref_url>링크</label></th>
						<td>
							<form:select path="ref_target" title="링크타겟">
								<form:option value="_blank">새창</form:option>
								<form:option value="">현재창</form:option>
							</form:select>
							<form:input path="ref_url" class="input_width_500" title="링크"/>
								
						</td>
					</tr>
					</c:if>
					
				</table>
						
				
				
			</article>
			<!-- container-right //-->
		
			<div class="btn_style03">
			<c:if test="${boarddryVO.edomweivgp eq 'A' or boarddryVO.edomweivgp eq 'M' }">
			<a href="javascript:fn_egov_save_dry();">저장하기</a>
			</c:if>
			<c:if test="${boarddryVO.edomweivgp eq 'R'}">
			<a href="javascript:fn_egov_mod_dry();">수정하기</a>
			</c:if>
			<a href="javascript:fn_egov_dry_list()">목록보기</a>
		</div>
		</section>
		
		<form:hidden path="edomweivgp"/>
		<form:hidden path="pageIndex"/>
		<form:hidden path="cont_idx"/>
		<form:hidden path="brd_id"/>
		<form:hidden path="modeV"/>
		<form:hidden path="srchcalMon"/>
		<form:hidden path="srchcalYr"/>
		
	</div>
	
	
</form:form>


