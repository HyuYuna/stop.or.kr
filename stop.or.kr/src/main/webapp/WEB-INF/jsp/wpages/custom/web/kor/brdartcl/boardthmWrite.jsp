<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 
	## TPCODE : TPAGE0023: 일반 게시판 쓰기 페이지 ## 
--%>
<div class="table-wrap board-write" id="divMainArticle">	
<form:form name="reqForm" commandName="boardthmVO" enctype="multipart/form-data" class="board-ajax-form-submit">
		<%-- <h3 class="heading3">${nowMenuVO.menu_nm}</h3> --%>
		<table class="tstyle_view" summary="${SESS_BRD_INFO.brd_nm}<spring:message code="BOARD.WRITE-SUMMARY" /><%-- 에 대한 글쓰기입니다. --%>">
			<caption><spring:message code="BOARD.WRITE-CAPTION" /><%-- 글 등록 --%></caption>
			<colgroup>
				<col width="20%" />
				<col />
			</colgroup>
			<c:choose>
				<c:when test="${boardthmVO.edomweivgp eq 'P'}">
					<%-- 답글 모드 --%>
					<tr>
						<th scope="row"><label for="title"><spring:message code="BOARD.WRITER" /><%-- 작성자 --%></label></th>
						<td class="left">
							<c:out value="${SESS_USR_NM}"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="title"><spring:message code="BOARD.CREATED" /><%-- 작성일 --%></label></th>
						<td class="left">
							<c:out value="${boardthmVO.wdt}"/>
						</td>
					</tr>		
					<c:if test="${SESS_BRD_INFO.use_ctgry eq 'Y'}">
						<tr>
							<th scope="row"><label for="title"><spring:message code="BOARD.CATEGORY" /><%-- 분류 --%></label></th>
							<td class="left">
								<c:out value="${boardthmVO.ctgry_nm}"/>
								<form:hidden path="ctgry_idx"/>
							</td>
						</tr>		
					</c:if>
					<tr>
						<th scope="row"><label for="title"><spring:message code="BOARD.TITLE" /><%-- 제목 --%></label></th>
						<td class="left">
							<form:input path="subject" size="100" class="text"/>
						</td>
					</tr>
					<tr>
						<%-- <th scope="row"><span class="point01">*</span> <label for="title">내용</label></th> --%>
						<td colspan="2" class="form" id="editorWrapper">
							<c:choose>
								<c:when test="${SESS_BRD_INFO.editor_gb eq 'D'}">
									<object id="brd_cont" style="LEFT: 0px; TOP: 0px" height="500" width="100%" classid="CLSID:BD9C32DE-3155-4691-8972-097D53B10052">
										<PARAM NAME="TOOLBAR_MENU" VALUE="TRUE">
										<PARAM NAME="TOOLBAR_STANDARD" VALUE="TRUE">
										<PARAM NAME="TOOLBAR_FORMAT" VALUE="TRUE">
										<%-- <PARAM NAME="TOOLBAR_TABLE" VALUE="TRUE"> --%>
										<PARAM NAME="SHOW_TOOLBAR" VALUE="TRUE">
										<PARAM NAME="SHOW_STATUSBAR" VALUE="TRUE">
									</object>
								</c:when>
								<c:when test="${SESS_BRD_INFO.editor_gb eq 'E'}">
									<form:hidden path="brd_cont" id="brd_cont" />
									<input type="hidden" id="mime_contents" name="mime_contents" />
									<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/tweditor.js"></script>
								</c:when>
								<c:when test="${SESS_BRD_INFO.editor_gb eq 'G'}">
									<div id="editor_frame"></div>
									<form:textarea path="brd_cont" class="display_none"></form:textarea>
								</c:when>
								<c:otherwise>
									<form:textarea path="brd_cont"></form:textarea>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>											
				</c:when>
				<c:otherwise>
					<%-- 등록 / 수정 --%>
					<tr>
						<th scope="row"><label for="title"><spring:message code="BOARD.WRITER" /><%-- 작성자 --%></label></th>
						<td class="left">
							<c:out value="${SESS_USR_NM}"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="title"><spring:message code="BOARD.CREATED" /><%-- 작성일 --%></label></th>
						<td class="left">
							<c:out value="${boardthmVO.wdt}"/>
							<%-- <c:choose>
								<c:when test="${SESS_USR_LV le 2}">
									<c:set var="created"><spring:message code="BOARD.CREATED" /></c:set>
									<form:input path = "wdt" title="${created}" value="${boardthmVO.wdt}"/>										
								</c:when>
								<c:otherwise>
									<c:out value="${boardthmVO.wdt}"/>
								</c:otherwise>
							</c:choose> --%>
						</td>
					</tr>	
					<c:if test="${SESS_BRD_INFO.use_ctgry eq 'Y'}">
						<tr>
							<th scope="row"><label for="title"><spring:message code="BOARD.CATEGORY" /><%-- 분류 --%></label></th>
							<td class="left">
								<c:set var="selectCategory"><spring:message code="BOARD.SELECT-CATEGORY" /></c:set>
								<form:select path="ctgry_idx" class="select">
									<form:option value="">${selectCategory}</form:option>
									<form:options items="${ctgryList}" itemLabel="ctgry_nm" itemValue="ctgry_idx"/>
								</form:select>
							</td>
						</tr>		
					</c:if>
					<c:if test="${SESS_BRD_INFO.use_notice eq 'Y' or SESS_BRD_INFO.use_scrt eq 'Y'}">
						<tr>
							<th scope="row"><label for="title"><spring:message code="BOARD.SETUP" /><%-- 설정 --%></label></th>
							<td class="left">
							<c:if test="${SESS_USR_LV le 1000}">
								<c:if test="${SESS_BRD_INFO.use_notice eq 'Y'}">
									<input type="checkbox" id="is_notice" name="is_notice" value="N" <c:if test="${boardthmVO.is_notice eq 'Y'}">checked="checked"</c:if>/><label for="is_notice"><spring:message code="BOARD.SETUP-NOTICE" /><%-- 공지 설정 --%></label>
								</c:if>
							</c:if>
								<c:if test="${SESS_BRD_INFO.use_scrt eq 'Y'}">
									<input type="checkbox" id="is_scrt" name="is_scrt" value="N" <c:if test="${boardthmVO.is_scrt eq 'Y'}">checked="checked"</c:if>/><label for="is_scrt"><spring:message code="BOARD.SETUP-SECRET" /><%-- 비공개 설정 --%></label>
								</c:if>
							</td>
						</tr>
					</c:if>	
					<!-- 여분필드 시작  -->
					<c:if test="${extra1_array.extra1_use eq 'Y'}">
						<tr>
							<th scop="row"><label for="title"><c:out value="${extra1_array.extra1_name}"/></th>
							<td>
								<input type="text" name="extra1" value="<c:out value='${boardthmVO.extra1}'/>"/>
							</td>
						</tr>
					</c:if>
					<c:if test="${extra2_array.extra2_use eq 'Y'}">
						<tr>
							<th scop="row"><label for="title"><c:out value="${extra2_array.extra2_name}"/></th>
							<td>
								<input type="text" name="extra2"  value="<c:out value='${boardthmVO.extra2}'/>"/>
							</td>
						</tr>
					</c:if>
					<c:if test="${SESS_BRD_INFO.off_viewmode eq '2'}">
						<tr>
							<th scope="row"><c:if test="${boardthmVO.edomweivgp eq 'A'}"><!-- <span class="point01">*</span> --></c:if> <label for="add_info_04"><spring:message code="BOARD.PASSWORD" /><%-- 비밀번호 --%></label></th>
							<td class="left">												
								<input type="text" id="add_info_04" name="add_info_04" title="<spring:message code="BOARD.PASSWORD" /><%-- 비밀번호 --%>"/>
							</td>
						</tr>
					</c:if>
				
					<tr>
						<th scope="row"><!-- <span class="point01">*</span> --> <label for="title"><spring:message code="BOARD.TITLE" /><%-- 제목 --%></label></th>
						<td class="left">
							<c:set var="title"><spring:message code="BOARD.TITLE" /></c:set>
							<form:input path="subject" size="100" class="text" title="${title}"/>
						</td>
					</tr>									
					<tr>
						<%-- <th scope="row"><span class="point01">*</span> <label for="title">내용</label></th> --%>
						<td colspan="2" class="form" id="editorWrapper">
							<c:choose>
								<c:when test="${SESS_BRD_INFO.editor_gb eq 'D'}">
									<object id="brd_cont" style="LEFT: 0px; TOP: 0px" height="500" width="100%" classid="CLSID:BD9C32DE-3155-4691-8972-097D53B10052">
										<PARAM NAME="TOOLBAR_MENU" VALUE="TRUE">
										<PARAM NAME="TOOLBAR_STANDARD" VALUE="TRUE">
										<PARAM NAME="TOOLBAR_FORMAT" VALUE="TRUE">
										<%-- <PARAM NAME="TOOLBAR_TABLE" VALUE="TRUE"> --%>
										<PARAM NAME="SHOW_TOOLBAR" VALUE="TRUE">
										<PARAM NAME="SHOW_STATUSBAR" VALUE="TRUE">
									</object>
									<input type="hidden" id="brd_cont_base" name="brd_cont_base" value="<c:out value="${boardthmVO.brd_cont}"/>"/>
								</c:when>
								<c:when test="${SESS_BRD_INFO.editor_gb eq 'E'}">
									<form:hidden path="brd_cont" id="brd_cont" />
									<input type="hidden" id="mime_contents" name="mime_contents" />
									<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/tweditor.js"></script>
								</c:when>
								<c:when test="${SESS_BRD_INFO.editor_gb eq 'G'}">
									<div id="editor_frame"></div>
									<form:textarea path="brd_cont" class="display_none"></form:textarea>
								</c:when>
								<c:otherwise>
									<form:textarea path="brd_cont"></form:textarea>
									<c:if test="${SESS_BRD_INFO.use_atch eq 'Y' and SESS_BRD_INFO.use_uploadify eq 'N'}">
										* <input type="checkbox" id="chk_imgintocont" name="chk_imgintocont" checked="checked" value="Y"/><label for="chk_imgintocont"><spring:message code="" /><%-- 첨부파일에 이미지를 첨부하시면 내용에 자동으로 추가합니다 --%></label>
									</c:if>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>										
					<c:if test = "${SESS_BRD_INFO.use_kogl eq 'Y'}">
						<tr>
							<th scope="row"><label for="title"><spring:message code="BOARD.KOGL-TYPE1" /><%-- 공공저작물 <br /> 자유이용 --%></label></th>
							<td class="form">
								<strong><spring:message code="BOARD.KOGL-TYPE1-1" /><%-- ※ 공공저작물 자유이용을 적용하면 이 정보가 공공누리 사이트로 전송됩니다. --%> ${boardthmVO.kogl}</strong></br>
								<c:choose>
									<c:when test="${not empty boardthmVO.kogl}">
										<input type="radio" id="pKoglUseYn_1" name="pKoglUseYn" value="Y" onclick="chkRadio();" checked/> <label for="pKoglUseYn_1"><spring:message code="BOARD.KOGL-TYPE1-1-1" /><%-- 적용함 --%></label>
										<input type="radio" id="pKoglUseYn_2" name="pKoglUseYn" value="N" onclick="chkRadio();"/> <label for="pKoglUseYn_2"><spring:message code="BOARD.KOGL-TYPE1-1-2" /><%-- 적용안함 --%></label>
									</c:when>
									<c:otherwise>
										<input type="radio" id="pKoglUseYn_1" name="pKoglUseYn" value="Y" onclick="chkRadio();"/> <label for="pKoglUseYn_1"><spring:message code="BOARD.KOGL-TYPE1-1-1" /><%-- 적용함 --%></label>
										<input type="radio" id="pKoglUseYn_2" name="pKoglUseYn" value="N" onclick="chkRadio();" checked/> <label for="pKoglUseYn_2"><spring:message code="BOARD.KOGL-TYPE1-1-2" /><%-- 적용안함 --%></label>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th scope="row" rowspan="2"><label for="title"><spring:message code="BOARD.KOGL-TYPE2" /><%-- 공공저작물 <br /> 유형선택 --%></label></th>
							<td class="form">
								<strong><spring:message code="BOARD.KOGL-TYPE2-1" /><%-- 상업적 이용표시를 허락하시겠습니까? --%></strong></br>
								<c:choose>
									<c:when test="${elfunc:isStartsWith(boardthmVO.kogl, 'bY') eq true}">
										<input type="radio" id="pKoglType1_1" name="pKoglType1" value="bY" onclick="setRadio();" checked> <label for="pKoglType1_1"><spring:message code="BOARD.KOGL-TYPE2-1-1" /><%-- 상업적 비상업적 이용 가능 --%></label>
										<input type="radio" id="pKoglType1_2" name="pKoglType1" value="bN" onclick="setRadio();"> <label for="pKoglType1_2"><spring:message code="BOARD.KOGL-TYPE2-1-2" /><%-- 비상업적만 이용 가능 --%></label>
									</c:when>
									<c:otherwise>
										<input type="radio" id="pKoglType1_1" name="pKoglType1" value="bY" onclick="setRadio();"> <label for="pKoglType1_1"><spring:message code="BOARD.KOGL-TYPE2-1-1" /><%-- 상업적 비상업적 이용 가능 --%></label>
										<input type="radio" id="pKoglType1_2" name="pKoglType1" value="bN" onclick="setRadio();" checked> <label for="pKoglType1_2"><spring:message code="BOARD.KOGL-TYPE2-1-2" /><%-- 비상업적만 이용 가능 --%></label>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<td class="form">
								<strong><spring:message code="BOARD.KOGL-TYPE2-2" /><%-- 변경을 허용하시겠습니까? --%></strong><br/>
								<c:choose>
									<c:when test="${elfunc:isEndsWith(boardthmVO.kogl, 'cY') eq true}">
										<input type="radio" id="pKoglType2_1" name="pKoglType2" value="cY" onclick="setRadio();" checked> <label for="pKoglType2_1"><spring:message code="BOARD.KOGL-TYPE2-2-1" /><%-- 변형 등 2차적 저작물 작성이 가능 --%></label>
										<input type="radio" id="pKoglType2_2" name="pKoglType2" value="cN" onclick="setRadio();"> <label for="pKoglType2_2"><spring:message code="BOARD.KOGL-TYPE2-2-2" /><%-- 변형 등 2차적 저작물 작성 금지 --%></label>
									</c:when>
									<c:otherwise>
										<input type="radio" id="pKoglType2_1" name="pKoglType2" value="cY" onclick="setRadio();"> <label for="pKoglType2_1"><spring:message code="BOARD.KOGL-TYPE2-2-1" /><%-- 변형 등 2차적 저작물 작성이 가능 --%></label>
										<input type="radio" id="pKoglType2_2" name="pKoglType2" value="cN" onclick="setRadio();" checked> <label for="pKoglType2_2"><spring:message code="BOARD.KOGL-TYPE2-2-2" /><%-- 변형 등 2차적 저작물 작성 금지 --%></label>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:if>
				</c:otherwise>
			</c:choose>
			<c:if test="${SESS_BRD_INFO.use_atch eq 'Y' and SESS_BRD_INFO.use_uploadify eq 'N'}">
				<c:forEach begin="1" end="${SESS_BRD_INFO.attach_cnt_limit eq 0 ? 5 : SESS_BRD_INFO.attach_cnt_limit}" varStatus="formstat">
					<tr>
						<th scope="row"><!-- <span class="point01">*</span> --> <label for="title"><spring:message code="BOARD.ATTACH" /><%-- 첨부파일 --%> #${formstat.index}</label></th>
						<td class="form">
							<c:set var="empty_file" value="Y"/> <%--첨부파일의 개수만큼 --%>
							<c:forEach var="result" items="${atchfileList}" varStatus="status">
								<c:if test="${result.atckey_4th eq formstat.index}">
								<%-- 대표이미지 --%>
									<p class="fileName">
										<img src="${pageContext.request.contextPath}/images/template/exticos/${elfunc:getImgicoByExt(result.fext)}.gif" width="16" height="16" alt="htp"/>
										<a href="javascript:cmmfn_download_atchfile('${pageContext.request.contextPath}', '${result.vchkcode}')" title="${result.rname}">${elfunc:cutString(result.rname, 25, "... ")} (${result.size_kb}kb)</a>
										<a href="javascript:cmmfn_delete_onefile('${pageContext.request.contextPath}', '${result.vchkcode}','')">
											<span class="btn_imgSmall"><img src="${pageContext.request.contextPath}/images/template/cmm/btn_reply_delete.gif" alt="<spring:message code="BOARD.DELETE" /><%-- 삭제 --%>"/></span>
										</a>
									</p>
									<c:set var="empty_file" value="N"/>
								</c:if>
							</c:forEach>
							<input type="file" id="file_upload${formstat.index}" name="file_upload" size="80"/>
							<input type="hidden" id="empty_file${formstat.index}" name="empty_file${formstat.index}" value="${empty_file}"/>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<%-- 첨부파일영역 Start --%>
		<c:if test="${SESS_BRD_INFO.use_atch eq 'Y' and SESS_BRD_INFO.use_uploadify eq 'Y'}">
			<c:choose>
				<c:when test="${boardthmVO.edomweivgp eq 'P' or boardthmVO.edomweivgp eq 'A'}">
					<div class="fileUpload_area">
						<h2><spring:message code="BOARD.ATTACH" /><%-- 첨부파일 --%></h2><input type="file" name="file_upload" id="file_upload"/>
						<ul class="fileUpload_progress">
							<li><div id="divSelectFileArea"><br/></div></li>
						</ul>
					</div>
				</c:when>
				<c:otherwise>
					<div class="fileUpload_area">
						<h2><spring:message code="BOARD.ATTACH" /><%-- 첨부파일 --%></h2><input type="file" name="file_upload" id="file_upload"/>
						<ul class="fileUpload_progress">
							<c:forEach var="result" items="${atchfileList}" varStatus="status">
								<li>
									<div id="divAtcharea_${result.atckey_4th}" class="uploadify-queue-item">
										<div class="cancel">
											<a href="javascript:cmmfn_delete_onefile('${pageContext.request.contextPath}', '${result.vchkcode}', '')">X</a>
										</div>
										<div class="file_area">
											<span class="fileName">
												<img src="${pageContext.request.contextPath}/images/template/exticos/${elfunc:getImgicoByExt(result.fext)}.gif" width="16" height="16" alt="htp"/>
												<a href="javascript:cmmfn_download_atchfile('${pageContext.request.contextPath}', '${result.vchkcode}')" title="${result.rname}">${elfunc:cutString(result.rname, 25, "... ")} (${result.size_mb}Mb)</a>
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
		</c:if>
		<%-- 댓글 영역 Start --%>
	<%-- 	<c:if test="${ boardthmVO.edomweivgp eq 'R' and (SESS_BRD_INFO.reply_gb eq 'R' or SESS_BRD_INFO.reply_gb eq 'B')}">
			<div id="board-comment">
				<c:forEach var="result" items="${replyList}" varStatus="status">
					<dl id="dlidx_${result.reply_idx}">
						<dt class="name">${result.writer_nm}</dt>
						<dd class="day">${result.wdt}</dd>
						<dd class="btn">
							<c:choose>
								<c:when test="${result.writer eq SESS_USR_ID}">
									본인이 작성한 글인 경우 수정 / 삭제 권한 가짐
									<a href="javascript:fn_egov_reply_mod('${result.reply_idx}')"><img src="${pageContext.request.contextPath}/images/template/sub/btn_modify2.gif" alt="<spring:message code="BOARD.MODIFY" />수정"/></a>
									<a href="javascript:fn_egov_reply_del('${result.reply_idx}')" class="background-none"><img src="${pageContext.request.contextPath}/images/template/sub/btn_delete2.gif" alt="<spring:message code="BOARD.DELETE" />삭제"/></a>
								</c:when>
								<c:otherwise>
									<c:if test="${SESS_USR_LV le 1000}">
										관리자는 댓글 삭제 권한을 갖는다.
										<a href="javascript:fn_egov_reply_del('${result.reply_idx}')"><img src="${pageContext.request.contextPath}/images/template/sub/btn_delete2.gif" alt="<spring:message code="BOARD.DELETE" />삭제"/></a>
									</c:if>
								</c:otherwise>
							</c:choose>
						</dd>
						<dd class="comment">
							<span id="spanReplyArea_${result.reply_idx}"><c:out value="${result.reply_cont}"/></span>
						</dd>
					</dl>
				</c:forEach>
			</div>
			<c:if test="${SESS_USR_LV le 9998}">
				<fieldset class="default">
					<legend class="default"><spring:message code="BOARD.COMMENT-WRITE" />댓글쓰기</legend>
					<div id="board-comment-write">
						<dl>
							<dt class="name">${SESS_USR_NM}</dt>
							<dd class="day"><c:out value="${boardthmVO.wdt}"/></dd>
							<dd class="comment"><textarea name="reply_cont" id="reply_cont" cols="30" rows="10" class="board-textarea"></textarea></dd>
							<dd class="btn"><span class="board-btn-comment"><a href="javascript:fn_egov_reply_save()" title="<spring:message code="BOARD.COMMENT-SAVE" />댓글 등록하기"><spring:message code="BOARD.SAVE" />저장</a></span></dd>
						</dl>
					</div>
				</fieldset>
			</c:if>
		</c:if> --%>
		<%-- 댓글 영역 End --%>
		<%-- 버튼영역 Start --%>
		<div class="btn_area_right">
			<c:choose>
				<c:when test="${boardthmVO.edomweivgp eq 'R'}">
					<c:if test="${(SESS_BRD_INFO.reply_gb eq 'A' or SESS_BRD_INFO.reply_gb eq 'B') and (RWAUTH eq 'RW' or RWAUTH eq 'RWD')}">
						<%-- 계단식 답글 게시판이고 쓰기권한이 있는 경우 / 공지사항이 아닌경우 --%>
						<c:if test="${boardthmVO.is_notice eq 'N'}">
							<a href="javascript:fn_egov_brd_reply()" class="btn-m btn1"><spring:message code="BOARD.REPLY" /><%-- 답글 --%></a>
						</c:if>
					</c:if>
				</c:when>
				<c:otherwise>
					<%--<a href="javascript:fn_egov_brd_preview()" title="미리보기"><img src="${pageContext.request.contextPath}/images/custom/button/btn_preview.gif" alt="미리보기"/></a>--%>
					<c:if test="${RWAUTH eq 'RWD' and boardthmVO.edomweivgp ne 'A'}">
						<a href="javascript:fn_egov_brd_del()" class="btn-m btn1"><spring:message code="BOARD.DELETE" /><%-- 삭제 --%></a>
					</c:if>
					<%-- <a href="javascript:fn_egov_brd_save()" class="btn_line"><spring:message code="BOARD.SAVE" />저장</a> --%>
					<input type="submit" class="btn-m btn1" value="<spring:message code="BOARD.SAVE" />">
				</c:otherwise>		
			</c:choose>
			<a href="javascript:fn_egov_brd_list()" class="btn-m btn1"><spring:message code="BOARD.LIST" /><%-- 목록 --%></a>
		</div>	
	
		<%-- 버튼영역 End --%>
		<%-- contents //--%>
		<br />	
		<%-- container-right //--%>
		<form:hidden path="edomweivgp" />
		<form:hidden path="pageIndex" />
		<form:hidden path="cont_idx" />
		<form:hidden path="editor_gb" />
		<form:hidden path="searchCondition" />
		<form:hidden path="searchKeyword" />
		<form:hidden path="srch_ctgry_idx" />
		<input type="hidden" id="brd_gb_sub" name="brd_gb_sub" value="${SESS_BRD_INFO.brd_gb_sub}" />
		<form:hidden path="seltab_idx" />
		<input type="hidden" id="mod_reply_idx" name="mod_reply_idx" value="" />
		<input type="hidden" id="pRegKogl" name="pRegKogl" value="${boardthmVO.kogl}" />
	
	</form:form>
	<form:form name="replyForm">
		<c:if test="${ boardthmVO.edomweivgp eq 'R' and (SESS_BRD_INFO.reply_gb eq 'R' or SESS_BRD_INFO.reply_gb eq 'B')}">
			<div id="board-comment">
				<c:forEach var="result" items="${replyList}" varStatus="status">
					<dl id="dlidx_${result.reply_idx}">
						<dt class="name">${result.writer_nm}</dt>
						<dd class="day">${result.wdt}</dd>
						<dd class="btn">
							<c:choose>
								<c:when test="${result.writer eq SESS_USR_ID}">
									<%-- 본인이 작성한 글인 경우 수정 / 삭제 권한 가짐 --%>
									<a href="javascript:fn_egov_reply_mod('${result.reply_idx}')"><img src="${pageContext.request.contextPath}/images/template/sub/btn_modify2.gif" alt="<spring:message code="BOARD.MODIFY" /><%-- 수정 --%>"/></a>
									<a href="javascript:fn_egov_reply_del('${result.reply_idx}')" class="background-none"><img src="${pageContext.request.contextPath}/images/template/sub/btn_delete2.gif" alt="<spring:message code="BOARD.DELETE" /><%-- 삭제 --%>"/></a>
								</c:when>
								<c:otherwise>
									<c:if test="${SESS_USR_LV le 1000}">
										<%-- 관리자는 댓글 삭제 권한을 갖는다. --%>
										<a href="javascript:fn_egov_reply_del('${result.reply_idx}')"><img src="${pageContext.request.contextPath}/images/template/sub/btn_delete2.gif" alt="<spring:message code="BOARD.DELETE" /><%-- 삭제 --%>"/></a>
									</c:if>
								</c:otherwise>
							</c:choose>
						</dd>
						<dd class="comment">
							<span id="spanReplyArea_${result.reply_idx}"><c:out value="${result.reply_cont}"/></span>
						</dd>
					</dl>
				</c:forEach>
			</div>
			<c:if test="${SESS_USR_LV le 9998}">
				<fieldset class="default">
					<legend class="default"><spring:message code="BOARD.COMMENT-WRITE" /><%-- 댓글쓰기 --%></legend>
					<div id="board-comment-write">
						<dl>
							<dt class="name">${SESS_USR_NM}</dt>
							<dd class="day"><c:out value="${boardthmVO.wdt}"/></dd>
							<dd class="comment"><textarea name="reply_cont" id="reply_cont" cols="30" rows="10" class="board-textarea"></textarea></dd>
							<dd class="btn"><span class="board-btn-comment"><a href="javascript:fn_egov_reply_save()" title="<spring:message code="BOARD.COMMENT-SAVE" /><%-- 댓글 등록하기 --%>"><spring:message code="BOARD.SAVE" /><%-- 저장 --%></a></span></dd>
						</dl>
					</div>
				</fieldset>
			</c:if>
		</c:if>
	</form:form>
</div>
<form id="previewForm" name="previewForm" method="post">
	<input type="hidden" name="previewContent" id="previewContent" />
</form>









<%
if(true) return;
%>
<form:form name="reqForm" commandName="boardthmVO">
	<div id="divMainArticle">
		<div id="detail_content" class="container-sub">
			<div class="tablewrap bbs_write">
				<div class="articles_search">
					<div class="basic_searchForm"><span class="point01">*</span> <spring:message code="BOARD.REQUIRED" /><%-- 항목은 필수입력 항목입니다. --%></div>
				</div>						
				<h3 class="heading3">${nowMenuVO.menu_nm}</h3>
				<table class="tstyle_view" summary="${SESS_BRD_INFO.brd_nm}<spring:message code="BOARD.WRITE-SUMMARY" /><%-- 에 대한 글쓰기입니다. --%>">
					<caption><spring:message code="BOARD.WRITE-CAPTION" /><%-- 글 등록 --%></caption>
					<colgroup>
						<col width="20%" />
						<col />
					</colgroup>
					<c:choose>
						<c:when test="${boardthmVO.edomweivgp eq 'P'}">
							<%-- 답글 모드 --%>
							<tr>
								<th scope="row"><label for="title"><spring:message code="BOARD.WRITER" /><%-- 작성자 --%></label></th>
								<td class="left">
									<c:out value="${SESS_USR_NM}"/>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="title"><spring:message code="BOARD.CREATED" /><%-- 작성일 --%></label></th>
								<td class="left">
									<c:out value="${boardthmVO.wdt}"/>
								</td>
							</tr>		
							<c:if test="${SESS_BRD_INFO.use_ctgry eq 'Y'}">
								<tr>
									<th scope="row"><label for="title"><spring:message code="BOARD.CATEGORY" /><%-- 분류 --%></label></th>
									<td class="left">
										<c:out value="${boardthmVO.ctgry_nm}"/>
										<form:hidden path="ctgry_idx"/>
									</td>
								</tr>		
							</c:if>
							<tr>
								<th scope="row"><span class="point01">*</span> <label for="title"><spring:message code="BOARD.TITLE" /><%-- 제목 --%></label></th>
								<td class="left">
									<form:input path="subject" size="100" class="text"/>
								</td>
							</tr>
							<tr>
								<%-- <th scope="row"><span class="point01">*</span> <label for="title">내용</label></th> --%>
								<td colspan="2" class="form" id="editorWrapper">
									<c:choose>
										<c:when test="${SESS_BRD_INFO.editor_gb eq 'D'}">
											<object id="brd_cont" style="LEFT: 0px; TOP: 0px" height="500" width="100%" classid="CLSID:BD9C32DE-3155-4691-8972-097D53B10052">
												<PARAM NAME="TOOLBAR_MENU" VALUE="TRUE">
												<PARAM NAME="TOOLBAR_STANDARD" VALUE="TRUE">
												<PARAM NAME="TOOLBAR_FORMAT" VALUE="TRUE">
												<%-- <PARAM NAME="TOOLBAR_TABLE" VALUE="TRUE"> --%>
												<PARAM NAME="SHOW_TOOLBAR" VALUE="TRUE">
												<PARAM NAME="SHOW_STATUSBAR" VALUE="TRUE">
											</object>
										</c:when>
										<c:when test="${SESS_BRD_INFO.editor_gb eq 'E'}">
											<form:hidden path="brd_cont" id="brd_cont" />
											<input type="hidden" id="mime_contents" name="mime_contents" />
											<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/tweditor.js"></script>
										</c:when>
										<c:when test="${SESS_BRD_INFO.editor_gb eq 'G'}">
											<div id="editor_frame"></div>
											<form:textarea path="brd_cont" class="display_none"></form:textarea>
										</c:when>
										<c:otherwise>
											<form:textarea path="brd_cont"></form:textarea>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>											
						</c:when>
						<c:otherwise>
							<%-- 등록 / 수정 --%>
							<tr>
								<th scope="row"><label for="title"><spring:message code="BOARD.WRITER" /><%-- 작성자 --%></label></th>
								<td class="left">
									<c:out value="${SESS_USR_NM}"/>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="title"><spring:message code="BOARD.CREATED" /><%-- 작성일 --%></label></th>
								<td class="left">
									<c:choose>
										<c:when test="${SESS_USR_LV le 2}">
											<c:set var="created"><spring:message code="BOARD.CREATED" /></c:set>
											<form:input path = "wdt" title="${created}" value="${boardthmVO.wdt}"/>										
										</c:when>
										<c:otherwise>
											<c:out value="${boardthmVO.wdt}"/>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>	
							<c:if test="${SESS_BRD_INFO.use_ctgry eq 'Y'}">
								<tr>
									<th scope="row"><label for="title"><spring:message code="BOARD.CATEGORY" /><%-- 분류 --%></label></th>
									<td class="left">
										<c:set var="selectCategory"><spring:message code="BOARD.SELECT-CATEGORY" /></c:set>
										<form:select path="ctgry_idx" class="select">
											<form:option value="">${selectCategory}</form:option>
											<form:options items="${ctgryList}" itemLabel="ctgry_nm" itemValue="ctgry_idx"/>
										</form:select>
									</td>
								</tr>		
							</c:if>
							<c:if test="${SESS_BRD_INFO.use_notice eq 'Y' or SESS_BRD_INFO.use_scrt eq 'Y'}">
								<tr>
									<th scope="row"><label for="title"><spring:message code="BOARD.SETUP" /><%-- 설정 --%></label></th>
									<td class="left">
									<c:if test="${SESS_USR_LV le 1000}">
										<c:if test="${SESS_BRD_INFO.use_notice eq 'Y'}">
											<input type="checkbox" id="is_notice" name="is_notice" value="N" <c:if test="${boardthmVO.is_notice eq 'Y'}">checked="checked"</c:if>/><label for="is_notice"><spring:message code="BOARD.SETUP-NOTICE" /><%-- 공지 설정 --%></label>
										</c:if>
									</c:if>
										<c:if test="${SESS_BRD_INFO.use_scrt eq 'Y'}">
											<input type="checkbox" id="is_scrt" name="is_scrt" value="N" <c:if test="${boardthmVO.is_scrt eq 'Y'}">checked="checked"</c:if>/><label for="is_scrt"><spring:message code="BOARD.SETUP-SECRET" /><%-- 비공개 설정 --%></label>
										</c:if>
									</td>
								</tr>
							</c:if>	
							
							<c:if test="${SESS_BRD_INFO.off_viewmode eq '2'}">
								<tr>
									<th scope="row"><c:if test="${boardthmVO.edomweivgp eq 'A'}"><span class="point01">*</span></c:if> <label for="add_info_04"><spring:message code="BOARD.PASSWORD" /><%-- 비밀번호 --%></label></th>
									<td class="left">												
										<input type="text" id="add_info_04" name="add_info_04" title="<spring:message code="BOARD.PASSWORD" /><%-- 비밀번호 --%>"/>
									</td>
								</tr>
							</c:if>
						
							<tr>
								<th scope="row"><span class="point01">*</span> <label for="title"><spring:message code="BOARD.TITLE" /><%-- 제목 --%></label></th>
								<td class="left">
									<c:set var="title"><spring:message code="BOARD.TITLE" /></c:set>
									<form:input path="subject" size="100" class="text" title="${title}"/>
								</td>
							</tr>									
							<tr>
								<%-- <th scope="row"><span class="point01">*</span> <label for="title">내용</label></th> --%>
								<td colspan="2" class="form" id="editorWrapper">
									<c:choose>
										<c:when test="${SESS_BRD_INFO.editor_gb eq 'D'}">
											<object id="brd_cont" style="LEFT: 0px; TOP: 0px" height="500" width="100%" classid="CLSID:BD9C32DE-3155-4691-8972-097D53B10052">
												<PARAM NAME="TOOLBAR_MENU" VALUE="TRUE">
												<PARAM NAME="TOOLBAR_STANDARD" VALUE="TRUE">
												<PARAM NAME="TOOLBAR_FORMAT" VALUE="TRUE">
												<%-- <PARAM NAME="TOOLBAR_TABLE" VALUE="TRUE"> --%>
												<PARAM NAME="SHOW_TOOLBAR" VALUE="TRUE">
												<PARAM NAME="SHOW_STATUSBAR" VALUE="TRUE">
											</object>
											<input type="hidden" id="brd_cont_base" name="brd_cont_base" value="<c:out value="${boardthmVO.brd_cont}"/>"/>
										</c:when>
										<c:when test="${SESS_BRD_INFO.editor_gb eq 'E'}">
											<form:hidden path="brd_cont" id="brd_cont" />
											<input type="hidden" id="mime_contents" name="mime_contents" />
											<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/tweditor.js"></script>
										</c:when>
										<c:when test="${SESS_BRD_INFO.editor_gb eq 'G'}">
											<div id="editor_frame"></div>
											<form:textarea path="brd_cont" class="display_none"></form:textarea>
										</c:when>
										<c:otherwise>
											<form:textarea path="brd_cont"></form:textarea>
											<c:if test="${SESS_BRD_INFO.use_atch eq 'Y' and SESS_BRD_INFO.use_uploadify eq 'N'}">
												* <input type="checkbox" id="chk_imgintocont" name="chk_imgintocont" checked="checked" value="Y"/><label for="chk_imgintocont"><spring:message code="" /><%-- 첨부파일에 이미지를 첨부하시면 내용에 자동으로 추가합니다 --%></label>
											</c:if>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>										
							<c:if test = "${SESS_BRD_INFO.use_kogl eq 'Y'}">
								<tr>
									<th scope="row"><label for="title"><spring:message code="BOARD.KOGL-TYPE1" /><%-- 공공저작물 <br /> 자유이용 --%></label></th>
									<td class="form">
										<strong><spring:message code="BOARD.KOGL-TYPE1-1" /><%-- ※ 공공저작물 자유이용을 적용하면 이 정보가 공공누리 사이트로 전송됩니다. --%> ${boardthmVO.kogl}</strong></br>
										<c:choose>
											<c:when test="${not empty boardthmVO.kogl}">
												<input type="radio" id="pKoglUseYn_1" name="pKoglUseYn" value="Y" onclick="chkRadio();" checked/> <label for="pKoglUseYn_1"><spring:message code="BOARD.KOGL-TYPE1-1-1" /><%-- 적용함 --%></label>
												<input type="radio" id="pKoglUseYn_2" name="pKoglUseYn" value="N" onclick="chkRadio();"/> <label for="pKoglUseYn_2"><spring:message code="BOARD.KOGL-TYPE1-1-2" /><%-- 적용안함 --%></label>
											</c:when>
											<c:otherwise>
												<input type="radio" id="pKoglUseYn_1" name="pKoglUseYn" value="Y" onclick="chkRadio();"/> <label for="pKoglUseYn_1"><spring:message code="BOARD.KOGL-TYPE1-1-1" /><%-- 적용함 --%></label>
												<input type="radio" id="pKoglUseYn_2" name="pKoglUseYn" value="N" onclick="chkRadio();" checked/> <label for="pKoglUseYn_2"><spring:message code="BOARD.KOGL-TYPE1-1-2" /><%-- 적용안함 --%></label>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
								<tr>
									<th scope="row" rowspan="2"><label for="title"><spring:message code="BOARD.KOGL-TYPE2" /><%-- 공공저작물 <br /> 유형선택 --%></label></th>
									<td class="form">
										<strong><spring:message code="BOARD.KOGL-TYPE2-1" /><%-- 상업적 이용표시를 허락하시겠습니까? --%></strong></br>
										<c:choose>
											<c:when test="${elfunc:isStartsWith(boardthmVO.kogl, 'bY') eq true}">
												<input type="radio" id="pKoglType1_1" name="pKoglType1" value="bY" onclick="setRadio();" checked> <label for="pKoglType1_1"><spring:message code="BOARD.KOGL-TYPE2-1-1" /><%-- 상업적 비상업적 이용 가능 --%></label>
												<input type="radio" id="pKoglType1_2" name="pKoglType1" value="bN" onclick="setRadio();"> <label for="pKoglType1_2"><spring:message code="BOARD.KOGL-TYPE2-1-2" /><%-- 비상업적만 이용 가능 --%></label>
											</c:when>
											<c:otherwise>
												<input type="radio" id="pKoglType1_1" name="pKoglType1" value="bY" onclick="setRadio();"> <label for="pKoglType1_1"><spring:message code="BOARD.KOGL-TYPE2-1-1" /><%-- 상업적 비상업적 이용 가능 --%></label>
												<input type="radio" id="pKoglType1_2" name="pKoglType1" value="bN" onclick="setRadio();" checked> <label for="pKoglType1_2"><spring:message code="BOARD.KOGL-TYPE2-1-2" /><%-- 비상업적만 이용 가능 --%></label>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
								<tr>
									<td class="form">
										<strong><spring:message code="BOARD.KOGL-TYPE2-2" /><%-- 변경을 허용하시겠습니까? --%></strong><br/>
										<c:choose>
											<c:when test="${elfunc:isEndsWith(boardthmVO.kogl, 'cY') eq true}">
												<input type="radio" id="pKoglType2_1" name="pKoglType2" value="cY" onclick="setRadio();" checked> <label for="pKoglType2_1"><spring:message code="BOARD.KOGL-TYPE2-2-1" /><%-- 변형 등 2차적 저작물 작성이 가능 --%></label>
												<input type="radio" id="pKoglType2_2" name="pKoglType2" value="cN" onclick="setRadio();"> <label for="pKoglType2_2"><spring:message code="BOARD.KOGL-TYPE2-2-2" /><%-- 변형 등 2차적 저작물 작성 금지 --%></label>
											</c:when>
											<c:otherwise>
												<input type="radio" id="pKoglType2_1" name="pKoglType2" value="cY" onclick="setRadio();"> <label for="pKoglType2_1"><spring:message code="BOARD.KOGL-TYPE2-2-1" /><%-- 변형 등 2차적 저작물 작성이 가능 --%></label>
												<input type="radio" id="pKoglType2_2" name="pKoglType2" value="cN" onclick="setRadio();" checked> <label for="pKoglType2_2"><spring:message code="BOARD.KOGL-TYPE2-2-2" /><%-- 변형 등 2차적 저작물 작성 금지 --%></label>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</c:if>
						</c:otherwise>
					</c:choose>
					<c:if test="${SESS_BRD_INFO.use_atch eq 'Y' and SESS_BRD_INFO.use_uploadify eq 'N'}">
						<c:forEach begin="1" end="${SESS_BRD_INFO.attach_cnt_limit eq 0 ? 5 : SESS_BRD_INFO.attach_cnt_limit}" varStatus="formstat">
							<tr>
								<th scope="row"><span class="point01">*</span> <label for="title"><spring:message code="BOARD.ATTACH" /><%-- 첨부파일 --%> #${formstat.index}</label></th>
								<td class="form">
									<c:set var="empty_file" value="Y"/> <%--첨부파일의 개수만큼 --%>
									<c:forEach var="result" items="${atchfileList}" varStatus="status">
										<c:if test="${result.atckey_4th eq formstat.index}">
										<%-- 대표이미지 --%>
											<p class="fileName">
												<img src="${pageContext.request.contextPath}/images/template/exticos/${elfunc:getImgicoByExt(result.fext)}.gif" width="16" height="16" alt="htp"/>
												<a href="javascript:cmmfn_download_atchfile('${pageContext.request.contextPath}', '${result.vchkcode}')" title="${result.rname}">${elfunc:cutString(result.rname, 25, "... ")} (${result.size_kb}kb)</a>
												<a href="javascript:cmmfn_delete_onefile('${pageContext.request.contextPath}', '${result.vchkcode}', fn_egov_brd_view)">
													<span class="btn_imgSmall"><img src="${pageContext.request.contextPath}/images/template/cmm/btn_reply_delete.gif" alt="<spring:message code="BOARD.DELETE" /><%-- 삭제 --%>"/></span>
												</a>
											</p>
											<c:set var="empty_file" value="N"/>
										</c:if>
									</c:forEach>
									<input type="file" id="file_upload${formstat.index}" name="file_upload" size="80"/>
									<input type="hidden" id="empty_file${formstat.index}" name="empty_file${formstat.index}" value="${empty_file}"/>
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</table>
				<%-- 첨부파일영역 Start --%>
				<c:if test="${SESS_BRD_INFO.use_atch eq 'Y' and SESS_BRD_INFO.use_uploadify eq 'Y'}">
					<c:choose>
						<c:when test="${boardthmVO.edomweivgp eq 'P' or boardthmVO.edomweivgp eq 'A'}">
							<div class="fileUpload_area">
								<h2><spring:message code="BOARD.ATTACH" /><%-- 첨부파일 --%></h2><input type="file" name="file_upload" id="file_upload"/>
								<ul class="fileUpload_progress">
									<li><div id="divSelectFileArea"><br/></div></li>
								</ul>
							</div>
						</c:when>
						<c:otherwise>
							<div class="fileUpload_area">
								<h2><spring:message code="BOARD.ATTACH" /><%-- 첨부파일 --%></h2><input type="file" name="file_upload" id="file_upload"/>
								<ul class="fileUpload_progress">
									<c:forEach var="result" items="${atchfileList}" varStatus="status">
										<li>
											<div id="divAtcharea_${result.atckey_4th}" class="uploadify-queue-item">
												<div class="cancel">
													<a href="javascript:cmmfn_delete_onefile('${pageContext.request.contextPath}', '${result.vchkcode}', fn_egov_brd_mod)">X</a>
												</div>
												<div class="file_area">
													<span class="fileName">
														<img src="${pageContext.request.contextPath}/images/template/exticos/${elfunc:getImgicoByExt(result.fext)}.gif" width="16" height="16" alt="htp"/>
														<a href="javascript:cmmfn_download_atchfile('${pageContext.request.contextPath}', '${result.vchkcode}')" title="${result.rname}">${elfunc:cutString(result.rname, 25, "... ")} (${result.size_mb}Mb)</a>
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
				</c:if>
				<%-- 댓글 영역 Start --%>
				<c:if test="${ boardthmVO.edomweivgp eq 'R' and (SESS_BRD_INFO.reply_gb eq 'R' or SESS_BRD_INFO.reply_gb eq 'B')}">
					<div id="board-comment">
						<c:forEach var="result" items="${replyList}" varStatus="status">
							<dl id="dlidx_${result.reply_idx}">
								<dt class="name">${result.writer_nm}</dt>
								<dd class="day">${result.wdt}</dd>
								<dd class="btn">
									<c:choose>
										<c:when test="${result.writer eq SESS_USR_ID}">
											<%-- 본인이 작성한 글인 경우 수정 / 삭제 권한 가짐 --%>
											<a href="javascript:fn_egov_reply_mod('${result.reply_idx}')"><img src="${pageContext.request.contextPath}/images/template/sub/btn_modify2.gif" alt="<spring:message code="BOARD.MODIFY" /><%-- 수정 --%>"/></a>
											<a href="javascript:fn_egov_reply_del('${result.reply_idx}')" class="background-none"><img src="${pageContext.request.contextPath}/images/template/sub/btn_delete2.gif" alt="<spring:message code="BOARD.DELETE" /><%-- 삭제 --%>"/></a>
										</c:when>
										<c:otherwise>
											<c:if test="${SESS_USR_LV le 1000}">
												<%-- 관리자는 댓글 삭제 권한을 갖는다. --%>
												<a href="javascript:fn_egov_reply_del('${result.reply_idx}')"><img src="${pageContext.request.contextPath}/images/template/sub/btn_delete2.gif" alt="<spring:message code="BOARD.DELETE" /><%-- 삭제 --%>"/></a>
											</c:if>
										</c:otherwise>
									</c:choose>
								</dd>
								<dd class="comment">
									<span id="spanReplyArea_${result.reply_idx}"><c:out value="${result.reply_cont}"/></span>
								</dd>
							</dl>
						</c:forEach>
					</div>
					<c:if test="${SESS_USR_LV le 9998}">
						<fieldset class="default">
							<legend class="default"><spring:message code="BOARD.COMMENT-WRITE" /><%-- 댓글쓰기 --%></legend>
							<div id="board-comment-write">
								<dl>
									<dt class="name">${SESS_USR_NM}</dt>
									<dd class="day"><c:out value="${boardthmVO.wdt}"/></dd>
									<dd class="comment"><textarea name="reply_cont" id="reply_cont" cols="30" rows="10" class="board-textarea"></textarea></dd>
									<dd class="btn"><span class="board-btn-comment"><a href="javascript:fn_egov_reply_save()" title="<spring:message code="BOARD.COMMENT-SAVE" /><%-- 댓글 등록하기 --%>"><spring:message code="BOARD.SAVE" /><%-- 저장 --%></a></span></dd>
								</dl>
							</div>
						</fieldset>
					</c:if>
				</c:if>
				<%-- 댓글 영역 End --%>
				<%-- 버튼영역 Start --%>
				<div class="btn_area_right">
					<c:choose>
						<c:when test="${boardthmVO.edomweivgp eq 'R'}">
							<c:if test="${(SESS_BRD_INFO.reply_gb eq 'A' or SESS_BRD_INFO.reply_gb eq 'B') and (RWAUTH eq 'RW' or RWAUTH eq 'RWD')}">
								<%-- 계단식 답글 게시판이고 쓰기권한이 있는 경우 / 공지사항이 아닌경우 --%>
								<c:if test="${boardthmVO.is_notice eq 'N'}">
									<a href="javascript:fn_egov_brd_reply()" class="btn_line"><spring:message code="BOARD.REPLY" /><%-- 답글 --%></a>
								</c:if>
							</c:if>
						</c:when>
						<c:otherwise>
							<%--<a href="javascript:fn_egov_brd_preview()" title="미리보기"><img src="${pageContext.request.contextPath}/images/custom/button/btn_preview.gif" alt="미리보기"/></a>--%>
							<c:if test="${RWAUTH eq 'RWD' and boardthmVO.edomweivgp ne 'A'}">
								<a href="javascript:fn_egov_brd_del()" class="btn_line"><spring:message code="BOARD.DELETE" /><%-- 삭제 --%></a>
							</c:if>
							<a href="javascript:fn_egov_brd_save()" class="btn_line"><spring:message code="BOARD.SAVE" /><%-- 저장 --%></a>
						</c:otherwise>		
					</c:choose>
					<a href="javascript:fn_egov_brd_list()" class="btn_line"><spring:message code="BOARD.LIST" /><%-- 목록 --%></a>
				</div>		
				<%-- 버튼영역 End --%>
				<%-- contents //--%>
				<br />	
			</div>
			<br />	
		</div>
		<%-- container-right //--%>
		<form:hidden path="edomweivgp" />
		<form:hidden path="pageIndex" />
		<form:hidden path="cont_idx" />
		<form:hidden path="editor_gb" />
		<form:hidden path="searchCondition" />
		<form:hidden path="searchKeyword" />
		<form:hidden path="srch_ctgry_idx" />
		<input type="hidden" id="brd_gb_sub" name="brd_gb_sub" value="${SESS_BRD_INFO.brd_gb_sub}" />
		<form:hidden path="seltab_idx" />
		<input type="hidden" id="mod_reply_idx" name="mod_reply_idx" value="" />
		<input type="hidden" id="pRegKogl" name="pRegKogl" value="${boardthmVO.kogl}" />
	</div>
</form:form>
<form id="previewForm" name="previewForm" method="post">
	<input type="hidden" name="previewContent" id="previewContent" />
</form>