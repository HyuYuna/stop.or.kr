<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 
	중요 !!!!!
	이 파일의 내용은 수정하지 않습니다.
	
	또한 퍼블리셔와 협업을 할때
	프로젝트마다 반복되는 작업량을 줄이기 위해
	게시판 테이블의 css 클래스명은 오직 "tstyle_list" 만 사용하기로 했으며,
	새로운 프로젝트 수행시 퍼블리셔는 위 클래스명으로
	/webapp/css/template/metsys/bbs.css 만을 이용해서 작업하기로 협의 되었습니다.   
	
	현 프로젝트에서 기본적인 게시판을 제외한 추가된 부분(레이아웃)이 있으면
	이 파일의 컨텐츠를 감싸고 있는
	/WEB-INF/jsp/layout/custom/web/kor/board/boardLayout.jsp 파일의 표시된 부분에 추가합니다.
	
	2016.3.11 bhhan	
	
	## TPCODE : TPAGE0022: 일반 게시판 상세조회 페이지 ## 
-->

<form:form name="reqForm" commandName="boardarticleVO">
	
	<div id="divMainArticle">
		
		<br/>
		<!-- 실질 컨텐츠 영역 -->
		<div class="tablewrap bbs_view">
			<table class="tstyle_view" summary="${SESS_BRD_INFO.brd_nm} 대한 상세보기입니다.">
				<caption>${SESS_BRD_INFO.brd_nm} 상세보기</caption>
				<colgroup>
					<col width="20%" />
					<col />
					<col width="20%" />
					<col />
				</colgroup>
				<tbody>
				<tr>
					<th scope="row"><label for="title">제목</label></th>
					<td colspan="3" class="left">
						<strong><span class="txt_bold">${boardarticleVO.subject}</span></strong>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">작성자</label></th>
					<td class="title">
						<strong><span class="txt_bold">${boardarticleVO.writer_nm}</span></strong>
					</td>
					<th scope="row"><label for="title">작성일</label></th>
					<td class="title">
						<strong><span class="txt_bold">${boardarticleVO.wdt}</span></strong>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">내용</label></th>
					<td colspan="3" class="left">
						<c:choose>
							<c:when test="${SESS_BRD_INFO.editor_gb eq 'D'}">
								<object id="brd_cont" style="LEFT: 0px; TOP: 0px" height="500" width="100%" classid="CLSID:BD9C32DE-3155-4691-8972-097D53B10052">
									<PARAM NAME="TOOLBAR_MENU" VALUE="FALSE">
									<PARAM NAME="TOOLBAR_STANDARD" VALUE="FALSE">
									<PARAM NAME="TOOLBAR_FORMAT" VALUE="FALSE">
									<!-- <PARAM NAME="TOOLBAR_TABLE" VALUE="TRUE"> -->
									<PARAM NAME="SHOW_TOOLBAR" VALUE="FALSE">
									<PARAM NAME="SHOW_STATUSBAR" VALUE="TRUE">
								</object>
							</c:when>
							<c:otherwise>
								<div id="divBrd_cont">
									${elfunc:removeScrtag(boardarticleVO.brd_cont)}
									<!-- 이미지 첨부파일 내용에 표시하기 (취소)
									 
									<br/>
									<c:forEach var="result" items="${atchfileList}" varStatus="status">
										<c:if test="${fn:indexOf('jpg|png|bmp|gif', result.fext) ge 0}">
											<p class="cls_center"><img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${result.vchkcode}" width="95%" alt="${result.rname}"/></p><br/>
										</c:if>
									</c:forEach>
									 -->
								</div>
							</c:otherwise>
						</c:choose>
						<input type="hidden" id="brd_cont_base" name="brd_cont_base" value="<c:out value="${boardarticleVO.brd_cont}"/>"/>
						
					</td>
				</tr>
				</tbody>
			</table>
			
			<c:if test="${not empty boardarticleVO.kogl}">
				<div class="source_area">
					<div class="source_info">
						<span class="float_left">
							<c:choose>
								<c:when test="${boardarticleVO.kogl eq 'bYcY'}">								
									<a href="http://kogl.or.kr/open/info/license_info/by.do" target="_blank" title="새창으로 열림"><img src="${pageContext.request.contextPath}/images/custom/guide/kogl_img02.gif" alt="공공누리 마크" /></a>			
								</c:when>
								<c:when test="${boardarticleVO.kogl eq 'bNcY'}">
									<a href="http://kogl.or.kr/open/info/license_info/nc.do" target="_blank" title="새창으로 열림"><img src="${pageContext.request.contextPath}/images/custom/guide/kogl_img03.gif" alt="공공누리 마크" /></a>
								</c:when>
								<c:when test="${boardarticleVO.kogl eq 'bYcN'}">
									<a href="http://kogl.or.kr/open/info/license_info/nd.do" target="_blank" title="새창으로 열림"><img src="${pageContext.request.contextPath}/images/custom/guide/kogl_img04.gif" alt="공공누리 마크" /></a>
								</c:when>
								<c:when test="${boardarticleVO.kogl eq 'bNcN'}">
									<a href="http://kogl.or.kr/open/info/license_info/all.do" target="_blank" title="새창으로 열림"><img src="${pageContext.request.contextPath}/images/custom/guide/kogl_img05.gif" alt="공공누리 마크" /></a>
								</c:when>
							</c:choose>
						</span>							
						<span class="float_left"><span class="display_block">${boardarticleVO.writer_nm} 이(가) 창작한 ${boardarticleVO.subject} 저작물은</span>
							<c:choose>
								<c:when test="${boardarticleVO.kogl eq 'bYcY'}">
									 <span class="txt_bold">"공공누리" <a href="http://kogl.or.kr/open/info/license_info/by.do" target="_blank">출처표시</a> 조건</span>에 따라 이용할 수 있습니다.
								</c:when>
								<c:when test="${boardarticleVO.kogl eq 'bNcY'}">
									<span class="txt_bold">"공공누리" <a href="http://kogl.or.kr/open/info/license_info/nc.do" target="_blank">출처표시-상업적 이용금지</a> 조건</span>에 따라 이용할 수 있습니다.
								</c:when>
								<c:when test="${boardarticleVO.kogl eq 'bYcN'}">
									<span class="txt_bold">"공공누리" <a href="http://kogl.or.kr/open/info/license_info/nd.do" target="_blank">출처표시-변경금지</a> 조건</span>에 따라 이용할 수 있습니다.
								</c:when>
								<c:when test="${boardarticleVO.kogl eq 'bNcN'}">
									<span class="txt_bold">"공공누리" <a href="http://kogl.or.kr/open/info/license_info/all.do" target="_blank">출처표시-상업적 이용금지-변경금지</a> 조건</span>에 따라 이용할 수 있습니다.
								</c:when>
							</c:choose>
						</span>
					</div>
				</div>
			</c:if>
			
			<c:if test="${atchfileListCount > 0}">
				<div class="fileUpload_area">
					<h2>첨부파일</h2>
					<ul class="fileUpload_progress">
						<c:forEach var="result" items="${atchfileList}" varStatus="status">
							<li>
								<div id="divAtcharea_${result.atckey_4th}" class="uploadify-queue-item">
									<div class="file_area">
										<img src="${pageContext.request.contextPath}/images/template/exticos/${elfunc:getImgicoByExt(result.fext)}.gif" width="16" height="16" alt="htp"/>
										<a href="javascript:cmmfn_download_atchfile('${pageContext.request.contextPath}', '${result.vchkcode}')">${result.rname} (${result.size_mb}Mb)</a>
										<span class="data"></span>
									</div> 
								</div>
							</li>
						</c:forEach>
						<li><div id="divSelectFileArea"></div></li>
					</ul>
				</div>
			</c:if>
			
	
			<%-- <c:if test="${boardarticleVO.is_notice eq 'N' }">
				<ul class="nextPrev_list">
					<li><strong class="prev_list">이전글</strong>
						<c:choose> 
							<c:when test="${empty boardarticleVO.pre_atcl or boardarticleVO.pre_atcl eq '0'}">
								이전글이 없습니다.
							</c:when>
							<c:otherwise>
								<a href="javascript:fn_egov_brd_view('${boardarticleVO.pre_atcl}')">${elfunc:removeScrtag(boardarticleVO.pre_subj)}</a>
							</c:otherwise>
						</c:choose>
					</li>
					<li><strong class="next_list">다음글</strong> 
						<c:choose> 
							<c:when test="${empty boardarticleVO.next_atcl or boardarticleVO.next_atcl eq '0'}">
								다음글이 없습니다.
							</c:when>
							<c:otherwise>
								<a href="javascript:fn_egov_brd_view('${boardarticleVO.next_atcl}')">${elfunc:removeScrtag(boardarticleVO.next_subj)}</a>
							</c:otherwise>
						</c:choose>
					</li>
				</ul>
			</c:if> --%>
		</div>
		
		<!-- 댓글 영역 Start -->
		<c:if test="${ boardarticleVO.edomweivgp eq 'R' and (SESS_BRD_INFO.reply_gb eq 'R' or SESS_BRD_INFO.reply_gb eq 'B')}">
			
			<article class="comment">
				
				
				<c:choose>
					<c:when test="${SESS_USR_LV le 1000}">
						<dl class="comment_write">
							<dt>
								<label for="write_comment">답글등록</label>
								<!-- <span>로그인 또는 본인확인 후 작성 가능합니다.</span> -->
								<span><input type="hidden" name="writer_nm" id="writer_nm" value="${SESS_USR_INFO.user_nm}"/> <input type="hidden" name="brd_pwd" id="brd_pwd" type="password" size="15" /></span>
							</dt>
							<dd>
								<textarea name="reply_cont" id="reply_cont" cols="30" rows="10"></textarea>
								<a href="javascript:fn_egov_reply_save()" title="댓글 등록하기">
									<img src="${pageContext.request.contextPath}/images/template/content/btn_write_comment.gif" alt="입력" title="입력"/>
								</a>
								
							</dd>
						</dl>
					</c:when>
				</c:choose>
			
				
				<c:choose>
					<c:when test="${replyCnt eq 0}">
					
					</c:when>
					<c:otherwise>
					
					
						<dl class="comment_write">
							<dt>
								<label for="write_comment">답글</label>
							</dt>
						</dl>
						
						<ul class="comment_write" id="comment_write">
							<c:forEach var="result" items="${replyList}" varStatus="status">
								<li id="dlidx_${result.reply_idx}">
									<strong class="comment_write_name">${result.writer_nm}</strong>
									<span class="comment_write_date">${result.wdt}</span>
									<div class="comment_write_content" id="spanReplyArea_${result.reply_idx}">${result.reply_cont}</div>
									
									<p class="comment_write_btn">
										<c:choose>
											<c:when test="${SESS_USR_LV le 1000}">
												<!-- 관리자는 댓글 삭제 권한을 갖는다. -->
												<a href="javascript:fn_egov_reply_mod('${result.reply_idx}')"><img src="${pageContext.request.contextPath}/images/template/content/btn_comment_modify.gif" alt="수정"></a>
												<a href="javascript:fn_egov_reply_del('${result.reply_idx}')" class="background-none"><img src="${pageContext.request.contextPath}/images/template/content/btn_comment_del.gif" alt="삭제"></a>
											</c:when>
											<c:otherwise>
												<%-- 
												
												<a href="javascript:fn_egov_reply_mod_pwd('${result.reply_idx}')"><img src="${pageContext.request.contextPath}/images/custom/web/kor/button/btn_comment_modify.gif" alt="수정"></a>
												<a href="javascript:fn_egov_reply_del_pwd('${result.reply_idx}')"><img src="${pageContext.request.contextPath}/images/custom/web/kor/button/btn_comment_del.gif" alt="삭제"></a>
												 --%>
											</c:otherwise>
										</c:choose>
									</p>
								</li>
								
							</c:forEach>
						</ul>
			
					
					</c:otherwise>
				</c:choose>

			</article>
			
		</c:if>
		<!-- 댓글 영역 End -->
				

		<!-- 버튼영역 Start -->
		<!-- 
		<p class="board_butt">
			<span class="button basic"><span class="list"><a href="${pageContext.request.contextPath}/html/web/kor/news/sub020100.jsp">목록</a></span></span>
			<span class="button basic"><span class="write"><a href="${pageContext.request.contextPath}/html/web/kor/news/sub020100_write.jsp">글쓰기</a></span></span>
		</p>
		 -->
		</br>
		
		<div class="btn_area_right">
	
			<c:if test="${(SESS_BRD_INFO.reply_gb eq 'A' or SESS_BRD_INFO.reply_gb eq 'B') and (RWAUTH eq 'RW' or RWAUTH eq 'RWD')}">
				<!-- 계단식 답글 게시판이고 쓰기권한이 있는 경우 / 공지사항이 아닌경우 -->
				<c:if test="${boardarticleVO.is_notice eq 'N' and SESS_USR_LV le 100}">
					<a href="javascript:fn_egov_brd_reply()" class="btn_line">답글</a>
				</c:if>
				
			</c:if>
			<%-- <c:if test="${RWAUTH eq 'RW'}"> --%>
				<a href="${pageContext.request.contextPath}/brdanm/boardanonimMoveView.do?srch_menu_nix=${param.srch_menu_nix}&brd_id=${SESS_BRD_INFO.brd_id}&cont_idx=${boardarticleVO.cont_idx}&edomweivgp=M" class="btn_line">수정</a>
			<%-- </c:if>
			<c:if test="${RWAUTH eq 'RWD'}"> --%>
				<!-- 수정/삭제권한이 있는 경우 -->
				<%-- <a href="${pageContext.request.contextPath}/brdanm/boardanonimMoveView.do?srch_menu_nix=${param.srch_menu_nix}&brd_id=${SESS_BRD_INFO.brd_id}&cont_idx=${boardarticleVO.cont_idx}&edomweivgp=M" class="btn_line">수정</a> --%>
				<a href="javascript:fn_egov_brd_del()" class="btn_line">삭제</a>
				<%-- <c:if test="${SESS_USR_LV le 2}"> --%>
					<a href="javascript:cmmfn_cpy_clipboard('txt_cpy_url')" class="btn_line">주소복사</a>
					<input type="text" style="opacity:0" id="txt_cpy_url" value="${pageContext.request.contextPath}/brdartcl/boardarticleView.do?srch_menu_nix=${SESS_BRD_INFO.ref_menu_nix}&brd_id=${boardarticleVO.brd_id}&cont_idx=${boardarticleVO.cont_idx}&edomweivgp=R" size="1"/>
				<%-- </c:if>
			</c:if> --%>
				<a href="${pageContext.request.contextPath}/brdanm/boardanonimList.do?srch_menu_nix=${param.srch_menu_nix}&brd_id=${SESS_BRD_INFO.brd_id}" class="btn_line"><spring:message code="BOARD.LIST" /><%-- 목록 --%></a>
	
		</div>
		<!-- 버튼영역 End -->
		<!-- contents //-->				
		<!-- container-right //-->
		<br/>	
		<br/>
			
		<form:hidden path="edomweivgp"/>
		<form:hidden path="pageIndex"/>
		<form:hidden path="cont_idx"/>
		<form:hidden path="grp_no"/>
		<form:hidden path="grp_lv"/>
		<form:hidden path="grp_ord"/>
		<form:hidden path="editor_gb"/>
		<form:hidden path="ctgry_idx"/>
		<form:hidden path="srch_ctgry_idx"/>
		<form:hidden path="searchCondition"/>
		<form:hidden path="searchKeyword"/>
		<form:hidden path="seltab_idx"/>
		<input type="hidden" id="mod_reply_idx" name="mod_reply_idx" value=""/>
		<input type="hidden" id="mod_gb" name="mod_gb" value=""/>
		<input type="hidden" id="brd_pass" name="brd_pass" value=""/>
		<input type="hidden" id="reply_gb" name="reply_gb" value="mdf"/>
		
	</div>	

	<br/>
	
</form:form>
	
