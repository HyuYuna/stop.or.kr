<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>

<script type="text/javascript">
jQuery(document).ready(function(){

	<c:if test="${contentsmanVO.edomweivgp eq 'A' or contentsmanVO.edomweivgp eq 'M'}">
		cmmfn_init_uploadify("file_upload", "${pageContext.request.contextPath}", 0, 0/*parseInt("${atchfileListCount}")*/, 20, "IMG", fn_egov_complete_upload);
	</c:if>
	
	jQuery("#chkAddnew").click(function(){
		if($(this).prop("checked") == false && jQuery("#edomweivgp").val() == "A")
		{
			alert("버전이 등록된적이 없으므로 새 버전으로 등록해야 합니다.");
			$(this).prop("checked", true);
		}
	});
	
	jQuery("#divUcont_cont").hide();

	cmmfn_remove_scrtag(jQuery("#ucont_cont"));
	/*
	var cont = jQuery("#ucont_cont").val();
	cont = cont.replace(/http:\/\/localhost/gi, "");
	jQuery("#ucont_cont").val(cont);
	*/
	cmmfn_remove_scrtag(jQuery("#ucont_css"));
	cmmfn_init_editor("ucont_cont", lg_editor_gb, null);
	
	if(cmmfn_exist_object("ucont_css"))
	{
		var ucss = jQuery("#ucont_css").val();
		//alert(ucss);
		ucss = ucss.replace(/<br\/>/gi, "\n");
		jQuery("#ucont_css").val(ucss);
	}
	
	// 에디터에서 자동으로 붙이는 localhost를 삭제
	var org_cont = jQuery("#ucont_cont").val();
	org_cont = org_cont.replace(/https?:\/\/localhost/gi, "");
	jQuery("#ucont_cont").val(org_cont);


});

</script>
<div id= "divMainArticle">
<form:form name="reqForm" commandName="contentsmanVO">

	<c:choose>
		<c:when test="${contentsmanVO.edomweivgp eq 'A'}">
			<c:set var="pgname" value="컨텐츠 추가" />
		</c:when>
		<c:when test="${contentsmanVO.edomweivgp eq 'V'}">
			<c:set var="pgname" value="컨텐츠정보 조회" />
		</c:when>
		<c:when test="${contentsmanVO.edomweivgp eq 'U'}">
			<c:set var="pgname" value="컨텐츠정보 수정" />
		</c:when>
	</c:choose>

	<h2 class="depth2_bbsTitle">${pgname}</h2>
	
		
		<!-- content -->
			<div class="btn_style02"></div>
			<table class="tstyle_view">
				<colgroup>
					<col width="18%" />
					<col />
				</colgroup>
				<caption>갱신 페이지</caption>
				<tr>
					<th scope="row"><label for="title">사이트 구분</label>
					</th>
					<td>
						<select id = "sel_mu_site" name="sel_mu_site" title="사이트구분 선택">
							<c:forEach var="site" items="${sitecode}" varStatus="status">
								<option value="${site.code_idx}">${site.code_nm}</option>
							</c:forEach>
						</select>
						<form:hidden path="mu_site"/>
						<form:hidden path="srch_mu_site"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">언어 구분</label>
					<td>
						<select id="sel_mu_lang" name="sel_mu_lang" title="언어구분 선택">
							<c:forEach var="lang" items="${langcode}" varStatus="status">
								<option value="${lang.code_idx}">${lang.code_nm}</option>
							</c:forEach>
						</select>
						<form:hidden path="mu_lang"/>
						<form:hidden path="srch_mu_lang"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">컨텐츠 ID</label></th>
					<td>
						<c:out value="${contentsmanVO.ucont_id}"/><form:hidden path="ucont_id"/> <span class="txt_blue"> ( 자동으로 입력되는 값입니다 )</span>
						<form:hidden path="ucont_version"/>
					</td>
				</tr>
				<tr>
					<th scope="row">새버전 등록</th>
					<td>
						<c:choose>
							<c:when test="${contentsmanVO.edomweivgp eq 'A'}">
								<input type="checkbox" name="chkAddnew" id="chkAddnew" checked/><label for="chkAddnew">새 버전으로 등록합니다.</label>
							</c:when>
							<c:when test="${contentsmanVO.edomweivgp eq 'M'}">
								<input type="checkbox" name="chkAddnew" id="chkAddnew"/><label for="chkAddnew">새 버전으로 등록합니다.</label>
							</c:when>
						</c:choose>
						<span class="txt_blue"> ( 복원기능을 이용하시려면 새버전으로 등록하십시오 )</span>
					</td>
				</tr>
				<tr>
					<th scope="row">컨텐츠명</th>
					<td><form:input path="ucont_subject" class="input_mid" title="컨텐츠명"/>
					</td>
				</tr>
				<tr>
					<th scope="row">컨텐츠 설명</th>
					<td><form:input path="ucont_dft" class="input_mid" title="컨텐츠 설명"/></td>
				</tr>
				<c:if test="${SESS_USR_LV le 2 and not empty contentsmanVO.ref_menu_nix}">
					<tr>
						<th scope="row">연동 메뉴</th>
						<td>
							<c:out value="${contentsmanVO.ref_menu_nm}"/>
							<button  type="button" class="btn_graySmall" id="btnRefmenuDel" value="연동메뉴정보 삭제">연동메뉴정보 삭제</button>
						</td>
					</tr>
				</c:if>
				<!-- 
				<tr>
					<th scope="row">스타일 시트</th>
					<td>
						<form:textarea path="ucont_css" rows="15"></form:textarea>	
					</td>
				</tr>
				 -->
				<!-- 
				<tr>
					<th scope="row">첨부 이미지 사용</th>
					<td>
						<form:checkbox path="alter_img_atch" label="컨텐츠 내부의 이미지를 이름이 같은 첨부 파일로 대체합니다." value="N"/><br/>
						<span class="txt_blue">( 글 내용에 포함된 img 태그와 같은 이름의 파일을 첨부하면, 이미지가 자동으로 등록됩니다. )</span> 
					</td>
				</tr>
				-->
				<tr>
					<th scope="row">내용</th>
					<td>
						<!-- 
						# 첨부이미지를 사용하지 않으시는 경우에는 아래와 같이 이미지 경로에 #CONTEXTPATH#를 붙여주십시오.<br/>
						<span class="txt_red">ex) &lt;img src="#CONTEXTPATH#/layout/title/title.gif"/&gt;</span><br/>
						-->
						<span class="txt_red"># HTML 코드를 바로 붙여넣을때는 반드시 html보기 상태에서 입력하십시오.</span><br/>
						<span class="txt_blue"># css가 적용되지 않은 경우 실제 화면과 다르게 보일 수 있습니다. 실제화면은 미리보기를 클릭해 확인하시기 바랍니다.</span><br/>
						
						<!-- 
						<form:textarea path="ucont_cont"></form:textarea>
						<div id="divUcont_cont">
							<c:out value="${contentsmanVO.ucont_cont}"/>
						</div>
						-->
						<div id="editor_frame"></div>
						<form:textarea path="ucont_cont" class="display_none"></form:textarea>
					</td>
				</tr>
			</table>
			<!-- //content -->
						
			<!------------------------------- 첨부파일영역 Start ------------------------------->
			<c:choose>
				<c:when test="${contentsmanVO.edomweivgp eq 'R'}">
					<c:if test="${atchfileListCount > 0}">
						<div class="fileUpload_area">
							<h2>첨부파일</h2>
							<ul class="fileUpload_progress">
								<c:forEach var="result" items="${atchfileList}" varStatus="status">
									<li>
										<div id="divAtcharea_${result.atch_idx}" class="uploadify-queue-item">
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
					</c:if>
				</c:when>
				<c:when test="${contentsmanVO.edomweivgp eq 'A'}">
					<div class="fileUpload_area">
						<h2>첨부파일</h2><input type="file" name="file_upload", id="file_upload"/>
						<ul class="fileUpload_progress">
							<li><div id="divSelectFileArea"></div></li>
						</ul>
					</div>
				</c:when>
				<c:otherwise>
					<div class="fileUpload_area">
						<h2>첨부파일</h2><input type="file" name="file_upload", id="file_upload"/>
						<ul class="fileUpload_progress">
							
							<c:forEach var="result" items="${atchfileList}" varStatus="status">
								<li>
									<div id="divAtcharea_${result.atckey_4th}" class="uploadify-queue-item">
										<div class="cancel">
											<a href="javascript:cmmfn_delete_onefile('${pageContext.request.contextPath}', '${result.vchkcode}', fn_egov_cont_mod)">X</a>
										</div>
										<div class="file_area">
											<span class="fileName">
												<img src="${pageContext.request.contextPath}/images/template/exticos/${elfunc:getImgicoByExt(result.fext)}.gif" width="16" height="16" alt="htp"/>
												<a href="javascript:cmmfn_download_atchfile('${pageContext.request.contextPath}', '${result.vchkcode}')" title="${result.rname}">${elfunc:cutString(result.rname, 25, "... ")} (${result.size_kb}kb)</a>
											</span>
											<span class="data"></span>
										</div> 
									</div>
								</li>
							</c:forEach>
							<li><div id="divSelectFileArea"></div></li>
						</ul>
					</div>
				</c:otherwise>
			</c:choose>
			<!------------------------------- 첨부파일영역 End ------------------------------->
			
			
			<div class="btn_area_right">
				<a href="javascript:fn_egov_cont_save()" class="btn_line">저장</a>
				<c:if test="${contentsmanVO.edomweivgp ne 'A'}">
					<a href="javascript:fn_egov_cont_del()" class="btn_line">삭제</a>
					<a href="javascript:fn_egov_cont_prev('${contentsmanVO.ucont_version}')" class="btn_line">미리보기</a>
				</c:if>
				<a href="javascript:fn_egov_cont_list()" class="btn_line">목록</a>
			</div>
			<br/>
			<c:if test="${contentsmanVO.edomweivgp eq 'M'}">
				<!--  컨텐츠 버전 관리 영역 Start -->
				<h2>컨텐츠 버전</h2>
				<div class="srch_area">
				</div>
				<table class="tstyle_list">
					<thead>
						<tr>
							<th scope="col" width="110">컨텐츠 ID</th>
							<th scope="col" width="50">Version</th>
							<th scope="col">컨텐츠 제목</th>
							<th scope="col" width="10%">등록인</th>
							<th scope="col" width="150">등록일시</th>
							<th scope="col" width="80">Preview</th>
							<th scope="col" width="100">복원</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td><c:out value="${result.ucont_id}"/></td>
							<td><c:out value="${result.ucont_version}"/></td>
							<td class="txt_left"><c:out value="${result.ucont_subject}"/></td>
							<td><c:out value="${result.writer}"/></td>
							<td><c:out value="${result.wdt}"/></td>
							<td>
								<a href="javascript:fn_egov_cont_prev('${result.ucont_version}')">
									<img src="${pageContext.request.contextPath}/images/template/cmm/preview_file.png" width="24" height="24" alt="미리보기">
								</a>
							</td>
							<td>
								<c:if test="${totCnt > 1 && status.index ne 0}">
									<a href="javascript:fn_egov_cont_recyclever('${result.ucont_version}')" class="btn_lineSmall">되돌리기</a>
								</c:if>
							</td>
						</tr>
					</c:forEach>
					<c:if test = "${totCnt eq 0}">
						<tr>
							<td colspan="6">조회 결과가 없습니다.</td>
						</tr>
					</c:if>
					</tbody>
				</table>
				<!--  컨텐츠 버전 관리 영역 End -->
			</c:if>
			
	
	<form:hidden path="edomweivgp" />
	<form:hidden path="pageIndex"/>
	<form:hidden path="ref_menu_nix"/>
	<form:hidden path="seltab_idx" />
	
</form:form>

</div>
<form name="prevForm" method="post">
</form>    
