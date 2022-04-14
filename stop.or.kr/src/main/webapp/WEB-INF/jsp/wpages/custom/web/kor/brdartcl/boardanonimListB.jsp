<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 	<c:if test="${nowMenuVO.tabmenu_yn eq 'Y'}">
		탭메뉴
		<div class="tabmenu">
			<ul class="sub01">sub01~sub05 글로벌메뉴 넘버링
				<c:forEach var="result" items="${siblmenuList}" varStatus="status">
					<c:choose>
						<c:when test="${fn:startsWith(result.menu_link, 'javascript:fn_egov_under_construct()') eq true}">
							<li id="liTabcont_${status.index}" <c:if test="${param.seltab_idx eq status.index or (empty param.seltab_idx and status.index eq 0)}">class="active"</c:if>><a href="${result.menu_link}"><span>${result.menu_nm}</span><span class="arrow">활성화표시</span></a></li>
						</c:when>
						<c:otherwise>
							<li id="liTabcont_${status.index}" <c:if test="${param.seltab_idx eq status.index or (empty param.seltab_idx and status.index eq 0)}">class="active"</c:if>><a href="javascript:fn_egov_move_action(document.reqForm, '${result.menu_link}&srch_menu_nix=${result.srch_menu_nix}&seltab_idx=${status.index}')"><span>${result.menu_nm}</span><span class="arrow">활성화표시</span></a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
		</div>
		//탭메뉴
	</c:if> --%>

<form:form name="reqForm" commandName="boardarticleVO">
	<c:if test="${SESS_BRD_INFO.use_ctgry eq 'Y'}">
		<ul class="tabmenu_blue"> 
			<c:choose>
				<c:when test="${empty param.srch_ctgry_idx}">
					<li class="on"><a href="${pageContext.request.contextPath}/brdanm/boardanonimList.do?brd_id=${SESS_BRD_INFO.brd_id}&&srch_menu_nix=${param.srch_menu_nix}"><spring:message code="BOARD.TOTAL" /><%-- 전체 --%></a></li>
				</c:when>
				<c:otherwise>
					<li><a href="${pageContext.request.contextPath}/brdanm/boardanonimList.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_ctgry_idx=${result.ctgry_idx}&srch_menu_nix=${param.srch_menu_nix}"><spring:message code="BOARD.TOTAL" /><%-- 전체 --%></a></li>
				</c:otherwise>
			</c:choose>
			<c:forEach var="result" items="${ctgryList}" varStatus="status">
				<c:choose>
					<c:when test="${result.ctgry_idx eq 'CTIDX00022' or result.ctgry_idx eq 'CTIDX00023'}">
						<c:choose>
							<c:when test="${result.ctgry_idx eq param.srch_ctgry_idx}">
								<li class="on"><a href="${pageContext.request.contextPath}/brdanm/boardanonimList.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_ctgry_idx=${result.ctgry_idx}&srch_menu_nix=${param.srch_menu_nix}"><c:out value="${result.ctgry_nm}"/> 공지사항</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="${pageContext.request.contextPath}/brdanm/boardanonimList.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_ctgry_idx=${result.ctgry_idx}&srch_menu_nix=${param.srch_menu_nix}"><c:out value="${result.ctgry_nm}"/> 공지사항</a></li>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${result.ctgry_idx eq param.srch_ctgry_idx}">
								<li class="on"><a href="${pageContext.request.contextPath}/brdanm/boardanonimList.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_ctgry_idx=${result.ctgry_idx}&srch_menu_nix=${param.srch_menu_nix}"><c:out value="${result.ctgry_nm}"/></a></li>
							</c:when>
							<c:otherwise>
								<li><a href="${pageContext.request.contextPath}/brdanm/boardanonimList.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_ctgry_idx=${result.ctgry_idx}&srch_menu_nix=${param.srch_menu_nix}"><c:out value="${result.ctgry_nm}"/></a></li>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<%-- <li><a href="/">예약</a></li> --%>
		</ul>
	</c:if>
	<%-- 게시글 리스트 --%>
	<div class="table-wrap board" id="content">
		<table class="table_style_01 table_list">
			<caption><spring:message code="BOARD.LIST-CAPTION" /> <spring:message code="BOARD.LIST-SUMMARY" /><%-- 게시판 --%></caption>
			<colgroup>
					<col class="num">
					<c:if test="${SESS_BRD_INFO.use_ctgry eq 'Y'}">
						<col class="category" />
					</c:if>
					<col/>
					<!-- 여분필드  -->
					<c:if test="${extra1_array.extra1_use eq 'Y'}">
						<col class="extra1">
					</c:if>
					<c:if test="${extra2_array.extra2_use eq 'Y'}">
						<col class="extra2">
					</c:if>
					
					<c:if test="${SESS_BRD_INFO.use_rcmnd eq 'Y'}">
						<col width="_rcmnd" />
					</c:if>
					<c:if test="${SESS_BRD_INFO.use_rjct eq 'Y'}">
						<col width="rjct" />
					</c:if>
					<col class="hit">
					<col class="date">
					<%--<col width="8%" />--%>
			</colgroup>
			<thead>
				<tr>
					<th scope='col' class="num"><spring:message code="BOARD.NUM" /><%-- 번호 --%> </th>
						<c:set var="colspan" value="1" />
						<c:choose>
							<c:when test="${SESS_BRD_INFO.use_ctgry eq 'Y'}">
								<th scope='col'><spring:message code="BOARD.CATEGORY" /><%-- 분류 --%> </th>
								<th scope='col'><spring:message code="BOARD.TITLE" /><%-- 제목 --%> </th>
								<c:set var="colspan" value="${colspan + 1}" />
							</c:when>
							<c:otherwise>
								<th scope='col'><spring:message code="BOARD.TITLE" /><%-- 제목 --%> </th>
								<c:set var="colspan" value="${colspan + 1}" />
							</c:otherwise>
						</c:choose>
						
						<th scope='col'><spring:message code="BOARD.WRITER" /><%-- 작성자 --%> </th>
						<th scope='col'><spring:message code="BOARD.CREATED" /><%-- 작성일 --%> </th>
						<c:set var="colspan" value="${colspan + 1}" />
						<c:if test="${SESS_BRD_INFO.use_rcmnd eq 'Y'}">
							<th scope='col'><spring:message code="BOARD.RECOMMENDATION" /><%-- 추천 --%> </th>
							<c:set var="colspan" value="${colspan + 1}" />
						</c:if>
						<c:if test="${SESS_BRD_INFO.use_rjct eq 'Y'}">
							<th scope='col'><spring:message code="BOARD.OPPOSITION" /><%-- 반대 --%> </th>
							<c:set var="colspan" value="${colspan + 1}" />
						</c:if>
						<%-- <th scope='col'>조회</th> --%>
				</tr>
			</thead>
			<tbody>
				<%-- 공지사항 영역 --%>
				<c:forEach var="notice" items="${noticeList}" varStatus="status">
					<tr class="row_point">
							<td><span class="notice">NOTICE</span></td>
							<c:if test="${SESS_BRD_INFO.use_ctgry eq 'Y'}">
								<td class="point1">
									<c:out value="${notice.ctgry_nm}" />
								</td>
							</c:if>
							<td class="subject">
								<%-- 관리자는 무조건 게시판 내용을 확인 가능함. --%>
								<a href="${pageContext.request.contextPath}/brdanm/boardanonimView.do?brd_id=${param.brd_id}&srch_menu_nix=${param.srch_menu_nix}&cont_idx=${notice.cont_idx}">
									<c:if test="${notice.grp_lv > 1}">
										<img
											src="${pageContext.request.contextPath}/images/template/cmm/icon_reply.gif"
											alt="Reply Symbol" />
									</c:if> <span id="spanListSubject${status.index}" title="${notice.subject}">
										<c:out value="${notice.subject}" /> </span> </a>
								<%-- 댓글 개수 표시 --%>
								<c:if test="${(SESS_BRD_INFO.reply_gb eq 'R' or SESS_BRD_INFO.reply_gb eq 'B') and notice.reply_cnt > 0}">
									<span class="color-orange">(<c:out
											value="${notice.reply_cnt}" />)</span>
								</c:if>
								<%-- 신규 게시물 표시 --%>
								<c:if test="${notice.dfr_wdt < 2}">
									<span class="new">새글</span>
								</c:if>
							</td>
							<td>
								<%-- 작성자 --%> 
								<span title="<c:out value="${notice.writer}"/>">
									<c:out value="${notice.writer_nm}" />
								</span>
							</td>
							<c:if test="${extra1_array.extra1_use eq 'Y'}">
								<td><c:out value="${notice.extra1 }"/></td>
							</c:if>
							<c:if test="${extra2_array.extra2_use eq 'Y'}">
								<td><c:out value="${notice.extra2 }"/></td>
							</c:if>
							<td>
								<c:out value="${notice.wdt}" />
							</td>
							<c:if test="${SESS_BRD_INFO.use_rcmnd eq 'Y'}">
								<%-- 추천 수 표시 --%>
								<td><c:out value="${notice.rcmnd_cnt}" />
								</td>
							</c:if>
							<c:if test="${SESS_BRD_INFO.use_rjct eq 'Y'}">
								<%-- 반대 수 표시 --%>
								<td><c:out value="${notice.rjct_cnt}" />
								</td>
							</c:if>
							<%-- <td><c:out value="${notice.hits}" /></td> --%>
					</tr>
				</c:forEach>
				<%-- 일반 게시물 영역--%>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td><c:out value="${totCnt - (result.rn - 1)}" />
						</td>
							<c:if test="${SESS_BRD_INFO.use_ctgry eq 'Y'}">
								<td>
									<c:out value="${result.ctgry_nm}" />
								</td>
							</c:if>
							<td class="subject">

								<a href="${pageContext.request.contextPath}/brdanm/boardanonimView.do?brd_id=${param.brd_id}&srch_menu_nix=${param.srch_menu_nix}&cont_idx=${result.cont_idx}">
									<c:if test="${result.grp_lv > 1}">
										<img src="${pageContext.request.contextPath}/images/template/cmm/icon_reply.gif" alt="Reply Symbol" />
									</c:if> 
									<span id="spanListSubject${status.index}" title="${result.subject}"><c:out value="${result.subject}" /></span> 
								</a>
	
								<%-- 댓글 개수 표시 --%>
								<c:if
									test="${(SESS_BRD_INFO.reply_gb eq 'R' or SESS_BRD_INFO.reply_gb eq 'B') and result.reply_cnt > 0}">
									<span class="color-orange">(<c:out value="${result.reply_cnt}" />)</span>
								</c:if>
								<%-- 비공개 표시 --%> 
								<c:if test="${result.is_scrt eq 'Y'}">
									<%-- <img src="${pageContext.request.contextPath}/images/template/webadm/icon/icon_secret.gif" alt="<spring:message code="BOARD.SECRET" />비공개"/> --%>
								</c:if>
								<%-- 신규 게시물 표시 --%>
								<c:if test="${result.dfr_wdt < 2}">
									<span class="new">새글</span>
								</c:if>

							</td>
							<td>
								<%-- 작성자 --%> 
								<c:choose>
									<c:when test="${SESS_BRD_INFO.off_viewmode eq '2' and not empty result.add_info_01}">
										${result.add_info_01}
									</c:when>
									<c:otherwise>
										<span title="<c:out value="${result.writer}"/>"><c:out value="${result.writer_nm}" /></span>
									</c:otherwise>
								</c:choose>
							</td>
							<td><c:out value="${result.wdt}" />
							</td>
							<c:if test="${SESS_BRD_INFO.use_rcmnd eq 'Y'}">
								<%-- 추천 수 표시 --%>
								<td><c:out value="${result.rcmnd_cnt}" />
								</td>
							</c:if>
							<c:if test="${SESS_BRD_INFO.use_rjct eq 'Y'}">
								<%-- 반대 수 표시 --%>
								<td><c:out value="${result.rjct_cnt}" />
								</td>
							</c:if>
							<%-- <td><c:out value="${result.hits}" /></td> --%>
					</tr>
				</c:forEach>
				<c:if test="${totCnt eq 0}">
					<tr>
						<td colspan="${colspan}"> <spring:message code="BOARD.NO-DATA" /><%-- 조회 결과가 없습니다 --%> </td>
					</tr>
				</c:if>
			</tbody>
		</table>
		<%-- contents //--%>
		<form:hidden path="edomweivgp" />
		<form:hidden path="pageIndex" />
		<input type="hidden" id="cont_idx" name="cont_idx" value="0" />
		<input type="hidden" id="mod_gb"/>	
		<form:hidden path="brd_pass"/>
	</div>
	<%-- 게시글 리스트 //--%>
	
	<%-- 게시글 리스트 페이징 --%>
	<c:if test="${totPage gt 1}">
		<div class="pager">
			<ui:pagination paginationInfo="${paginationInfo}" type="text" jsFunction="fn_egov_link_page" />
		</div>
	</c:if>
	<%-- 게시글 리스트 페이징 //--%>
	
		<%-- 검색 --%>	
	<div class="board-search">
		<c:set var="select_title"><spring:message code="BOARD.SEARCH-DIVISION" /></c:set> 
		<label for="searchCondition" class="hidden-text">검색 구분</label>
		<form:select path="searchCondition" title="${select_title}">
			<form:option value=""><spring:message code="BOARD.SELECT" /><%-- 선택 --%></form:option>
			<form:option value="SUBJECT"><spring:message code="BOARD.TITLE" /><%-- 제목 --%></form:option>
			<form:option value="BRD_CONT"><spring:message code="BOARD.CONTENTS" /><%-- 내용 --%></form:option>
			<form:option value="SC_ALL"><spring:message code="BOARD.TITLE+CONTENTS" /><%-- 제목 + 내용 --%></form:option>
		</form:select>
		<c:set var="keyword_title"><spring:message code="BOARD.SEARCH-KEYWORD" /></c:set> 
		<label for="searchKeyword" class="hidden-text">검색어 입력</label>
		<form:input path="searchKeyword" class="keyword" title="${keyword_title}" />
		<a href="javascript:fn_egov_brd_search()" class="btn"><spring:message code="BOARD.SEARCH" /><%-- 검색 --%></a>
	</div>
	<%-- 버튼 --%>
	<div class="btns txt-right">
		<c:if test="${RWAUTH eq 'RWD' or RWAUTH eq 'RW'}">
			<%-- <a href="javascript:fn_egov_brd_add()" class="btn_blue_m"><spring:message code="BOARD.WRITE" />글쓰기</a> --%>
			<a href="${pageContext.request.contextPath}/brdanm/boardanonimMoveView.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_menu_nix=${ param.srch_menu_nix}&edomweivgp=A" class="btn-m btn1"><spring:message code="BOARD.WRITE" /><%-- 글쓰기 --%></a>
		</c:if>
		<c:if test="${fn:startsWith(param.srch_menu_nix, '794x409U') eq true}">	
			<a href="javascript:fn_egov_brd_alllist()" class="btn_orange_m"><spring:message code="BOARD.BOARD-LIST" /><%-- 게시판목록 --%></a>
		</c:if>
	</div>
	<script>
	$(function(){
		$(".table-wrap .table_style_01 caption").text($(".cont-title").text() + "-" + $(".table-wrap .table_style_01 thead th").text() + "정보제공");
	});
	</script>
</form:form>

<form name="form_chkType" method="post">
	<%-- 본인 인증 부분 시작--%>
	<input type="hidden" name="m" value="checkplusSerivce"><%-- 필수 데이타로, 누락하시면 안됩니다. --%>
	<input type="hidden" id="EncodeData" name="EncodeData" value=""><%-- 위에서 업체정보를 암호화 한 데이타입니다. --%>
	<%-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다. 해당 파라미터는 추가하실 수 없습니다. --%>
	<input type="hidden" id="param_r1" name="param_r1" value="">
	<c:choose>
		<c:when test="${SESS_BRD_INFO.off_viewmode eq '2'}">
			<input type="hidden" id="param_r2" name="param_r2" value="A">
		</c:when>
	</c:choose>
	<input type="hidden" id="param_r3" name="param_r3" value="">
	<%-- 본인 인증 부분 끝--%>
</form>	
<form name="evtinfoForm" method="post">
</form>	
	

	
<%-- <form name="board_pwd" class="ajax-form-submit" action="${pageContext.request.contextPath}/brdanm/chkBoardPwd.do?srch_menu_nix=${param.srch_menu_nix}&brd_id=${SESS_BRD_INFO.brd_id}" method="POST">
	<input type="hidden" id="pwd_cont_idx" name="pwd_cont_idx" value="0" />
	<div id="articleChkPwd" class="display_none">
		<article class="area_layerpopup">
			<h2><spring:message code="BOARD.PASSWORD-CHECK" />비밀번호 확인</h2>
			<div class="area_layerpopup_content">
				<table class="tstyle_list">
					<caption><spring:message code="BOARD.PASSWORD-CHECK" />비밀번호 확인</caption>
					<colgroup>
						<col width="25%" />
					</colgroup>
					<tbody>
						<tr>
						   <th scope="row"><label for="chkpwdval"><spring:message code="BOARD.PASSWORD" />비밀번호</label></th>
						   <td class="txt_left"><input type="password" name="chkpwdval" id="chkpwdval" value="" ></td>
						</tr>
					</tbody>
				</table>
			</div>
		
			<p class="right">
				<input type="submit" value="<spring:message code="BOARD.OK" />" class="">
				<a href="javascript:fn_egov_chk_pwd()"><img src="${pageContext.request.contextPath}/images/template/content/btn_ok.gif" alt="<spring:message code="BOARD.OK" />확인" /></a>
				<a href="javascript:fn_egov_hide_pwdlayer()"><img src="${pageContext.request.contextPath}/images/template/content/btn_close.gif" alt="<spring:message code="BOARD.CLOSE" />닫기" /></a>
			</p>
		</article>
	</div>
</form>		
	 --%>
	
	
	
	
	
	
	
	
	
	
<%
if(true) return;
%>	
<form:form name="reqForm" commandName="boardarticleVO">
	<c:if test="${SESS_BRD_INFO.use_ctgry eq 'Y'}">
		<ul class="tabmenu_blue"> 
			<c:choose>
				<c:when test="${empty param.srch_ctgry_idx}">
					<li class="on"><a href="${pageContext.request.contextPath}/brdanm/boardanonimList.do?brd_id=${SESS_BRD_INFO.brd_id}&&srch_menu_nix=${param.srch_menu_nix}"><spring:message code="BOARD.TOTAL" /><%-- 전체 --%></a></li>
				</c:when>
				<c:otherwise>
					<li><a href="${pageContext.request.contextPath}/brdanm/boardanonimList.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_ctgry_idx=${result.ctgry_idx}&srch_menu_nix=${param.srch_menu_nix}"><spring:message code="BOARD.TOTAL" /><%-- 전체 --%></a></li>
				</c:otherwise>
			</c:choose>
			<c:forEach var="result" items="${ctgryList}" varStatus="status">
				<c:choose>
					<c:when test="${result.ctgry_idx eq 'CTIDX00022' or result.ctgry_idx eq 'CTIDX00023'}">
						<c:choose>
							<c:when test="${result.ctgry_idx eq param.srch_ctgry_idx}">
								<li class="on"><a href="${pageContext.request.contextPath}/brdanm/boardanonimList.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_ctgry_idx=${result.ctgry_idx}&srch_menu_nix=${param.srch_menu_nix}"><c:out value="${result.ctgry_nm}"/> 공지사항</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="${pageContext.request.contextPath}/brdanm/boardanonimList.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_ctgry_idx=${result.ctgry_idx}&srch_menu_nix=${param.srch_menu_nix}"><c:out value="${result.ctgry_nm}"/> 공지사항</a></li>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${result.ctgry_idx eq param.srch_ctgry_idx}">
								<li class="on"><a href="${pageContext.request.contextPath}/brdanm/boardanonimList.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_ctgry_idx=${result.ctgry_idx}&srch_menu_nix=${param.srch_menu_nix}"><c:out value="${result.ctgry_nm}"/></a></li>
							</c:when>
							<c:otherwise>
								<li><a href="${pageContext.request.contextPath}/brdanm/boardanonimList.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_ctgry_idx=${result.ctgry_idx}&srch_menu_nix=${param.srch_menu_nix}"><c:out value="${result.ctgry_nm}"/></a></li>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<%-- <li><a href="/">예약</a></li> --%>
		</ul>
	</c:if>
	<div id="detail_content">
		<%-- 게시글 리스트 --%>
		<div class="tablewrap">
			<table class="table_style_01 table_list">
				<caption><spring:message code="BOARD.LIST-CAPTION" /><%-- 게시판 --%> <spring:message code="BOARD.LIST-SUMMARY" /></caption>
				<colgroup>
						<col width="8%" />
						<c:if test="${SESS_BRD_INFO.use_ctgry eq 'Y'}">
							<col width="12%" />
						</c:if>
						<col/>
						<col width="15%" />
						<col width="15%" />
						<c:if test="${SESS_BRD_INFO.use_rcmnd eq 'Y'}">
							<col width="8%" />
						</c:if>
						<c:if test="${SESS_BRD_INFO.use_rjct eq 'Y'}">
							<col width="8%" />
						</c:if>
						<%--<col width="8%" />--%>
				</colgroup>
				<thead>
					<tr>
						<th scope='col' class="num"><spring:message code="BOARD.NUM" /><%-- 번호 --%></th>
							<c:set var="colspan" value="1" />
							<c:choose>
								<c:when test="${SESS_BRD_INFO.use_ctgry eq 'Y'}">
									<th scope='col'><spring:message code="BOARD.CATEGORY" /><%-- 분류 --%></th>
									<th scope='col'><spring:message code="BOARD.TITLE" /><%-- 제목 --%></th>
									<c:set var="colspan" value="${colspan + 2}" />
								</c:when>
								<c:otherwise>
									<th scope='col'><spring:message code="BOARD.TITLE" /><%-- 제목 --%></th>
									<c:set var="colspan" value="${colspan + 1}" />
								</c:otherwise>
							</c:choose>
							
							<th scope='col'><spring:message code="BOARD.WRITER" /><%-- 작성자 --%></th>
							<th scope='col'><spring:message code="BOARD.CREATED" /><%-- 작성일 --%></th>
							<c:set var="colspan" value="${colspan + 2}" />
							<c:if test="${SESS_BRD_INFO.use_rcmnd eq 'Y'}">
								<th scope='col'><spring:message code="BOARD.RECOMMENDATION" /><%-- 추천 --%></th>
								<c:set var="colspan" value="${colspan + 1}" />
							</c:if>
							<c:if test="${SESS_BRD_INFO.use_rjct eq 'Y'}">
								<th scope='col'><spring:message code="BOARD.OPPOSITION" /><%-- 반대 --%></th>
								<c:set var="colspan" value="${colspan + 1}" />
							</c:if>
							<%-- <th scope='col'>조회</th> --%>
					</tr>
				</thead>
				<tbody>
					<%-- 공지사항 영역 --%>
					<c:forEach var="notice" items="${noticeList}" varStatus="status">
						<tr class="row_point">
								<td><img src="${pageContext.request.contextPath}/images/template/cmm/notice.png"/></td>
								<c:if test="${SESS_BRD_INFO.use_ctgry eq 'Y'}">
									<td>
										<c:choose>
											<c:when test="${notice.ctgry_nm eq '공지'}">
												<span class="btn_navySmall"><c:out value="${notice.ctgry_nm}" /></span>
											</c:when>
											<c:when test="${notice.ctgry_nm eq '교육'}">
												<span class="btn_graySmall"><c:out value="${notice.ctgry_nm}" /></span>
											</c:when>
											<c:when test="${notice.ctgry_nm eq '전시'}">
												<span class="btn_purpleSmall"><c:out value="${notice.ctgry_nm}" /></span>
											</c:when>
											<c:when test="${notice.ctgry_nm eq '채용'}">
												<span class="btn_brownSmall"><c:out value="${notice.ctgry_nm}" /></span>
											</c:when>
											<c:when test="${notice.ctgry_nm eq '입찰'}">
												<span class="btn_greenSmall"><c:out value="${notice.ctgry_nm}" /></span>
											</c:when>
											<c:otherwise>
												<span class="btn_navySmall"><c:out value="${notice.ctgry_nm}" /></span>
											</c:otherwise>
										</c:choose>
									</td>
								</c:if>
								<td class="ellipsis"><nobr>
										<%-- 제목 --%>
										<span class="sbjt_width_x${notice.grp_lv}"></span>
										<%-- 관리자는 무조건 게시판 내용을 확인 가능함. --%>
										<a href="${pageContext.request.contextPath}/brdanm/boardanonimView.do?brd_id=${param.brd_id}&srch_menu_nix=${param.srch_menu_nix}&cont_idx=${notice.cont_idx}">
											<c:if test="${notice.grp_lv > 1}">
												<img
													src="${pageContext.request.contextPath}/images/template/cmm/icon_reply.gif"
													alt="Reply Symbol" />
											</c:if> <span id="spanListSubject${status.index}" title="${notice.subject}">
												<c:out value="${notice.subject}" /> </span> </a>
										<%-- 댓글 개수 표시 --%>
										<c:if test="${(SESS_BRD_INFO.reply_gb eq 'R' or SESS_BRD_INFO.reply_gb eq 'B') and notice.reply_cnt > 0}">
											<span class="color-orange">(<c:out
													value="${notice.reply_cnt}" />)</span>
										</c:if>
										<%-- 신규 게시물 표시 --%>
										<c:if test="${notice.dfr_wdt < 2}">
											<img
												src="${pageContext.request.contextPath}/images/template/webadm/icon/icon_new.gif"
												alt="New" class="new_img" />
										</c:if>
									</nobr>
								</td>
								<td>
									<%-- 작성자 --%> 
									<span title="<c:out value="${notice.writer}"/>">
										<c:out value="${notice.writer_nm}" />
									</span>
								</td>
								<td>
									<c:out value="${notice.wdt}" />
								</td>
								<c:if test="${SESS_BRD_INFO.use_rcmnd eq 'Y'}">
									<%-- 추천 수 표시 --%>
									<td><c:out value="${notice.rcmnd_cnt}" />
									</td>
								</c:if>
								<c:if test="${SESS_BRD_INFO.use_rjct eq 'Y'}">
									<%-- 반대 수 표시 --%>
									<td><c:out value="${notice.rjct_cnt}" />
									</td>
								</c:if>
								<%-- <td><c:out value="${notice.hits}" /></td> --%>
						</tr>
					</c:forEach>
					<%-- 일반 게시물 영역--%>
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td><c:out value="${totCnt - (result.rn - 1)}" />
							</td>
								<c:if test="${SESS_BRD_INFO.use_ctgry eq 'Y'}">
									<td>
										<c:choose>
											<c:when test="${result.ctgry_nm eq '공지'}">
												<span class="btn_navySmall"><c:out value="${result.ctgry_nm}" /></span>
											</c:when>
											<c:when test="${result.ctgry_nm eq '교육'}">
												<span class="btn_graySmall"><c:out value="${result.ctgry_nm}" /></span>
											</c:when>
											<c:when test="${result.ctgry_nm eq '전시'}">
												<span class="btn_purpleSmall"><c:out value="${result.ctgry_nm}" /></span>
											</c:when>
											<c:when test="${result.ctgry_nm eq '채용'}">
												<span class="btn_brownSmall"><c:out value="${result.ctgry_nm}" /></span>
											</c:when>
											<c:when test="${result.ctgry_nm eq '입찰'}">
												<span class="btn_greenSmall"><c:out value="${result.ctgry_nm}" /></span>
											</c:when>
											<c:otherwise>
												<span class="btn_navySmall"><c:out value="${result.ctgry_nm}" /></span>
											</c:otherwise>
										</c:choose>
									</td>
								</c:if>
								<td class="ellipsis">
									<nobr>
										<%-- 제목 --%>
										<span class="sbjt_width_x${result.grp_lv}"></span>
										<%-- 관리자는 무조건 게시판 내용을 확인 가능함. --%>
										<c:choose>
											<c:when test="${result.is_scrt eq 'Y' and SESS_USR_LV gt 1000}">
												<a href="javascript:fn_egov_show_pwdlayer('${result.cont_idx}')">
													<input type="hidden" id="contidx_${result.cont_idx}">
													<c:if test="${result.grp_lv > 1}">
														<img src="${pageContext.request.contextPath}/images/template/cmm/icon_reply.gif" alt="Reply Symbol" />
													</c:if> 
													<span id="spanListSubject${status.index}" title="${result.subject}"><c:out value="${result.subject}" /></span> 
												</a>
											</c:when>
											<c:otherwise>
												<a href="${pageContext.request.contextPath}/brdanm/boardanonimView.do?brd_id=${param.brd_id}&srch_menu_nix=${param.srch_menu_nix}&cont_idx=${result.cont_idx}">
													<c:if test="${result.grp_lv > 1}">
														<img src="${pageContext.request.contextPath}/images/template/cmm/icon_reply.gif" alt="Reply Symbol" />
													</c:if> 
													<span id="spanListSubject${status.index}" title="${result.subject}"><c:out value="${result.subject}" /></span> 
												</a>
											</c:otherwise>
										</c:choose>
										<%-- 댓글 개수 표시 --%>
										<c:if
											test="${(SESS_BRD_INFO.reply_gb eq 'R' or SESS_BRD_INFO.reply_gb eq 'B') and result.reply_cnt > 0}">
											<span class="color-orange">(<c:out value="${result.reply_cnt}" />)</span>
										</c:if>
										<%-- 비공개 표시 --%> 
										<c:if test="${result.is_scrt eq 'Y'}">
											<img src="${pageContext.request.contextPath}/images/template/webadm/icon/icon_secret.gif" alt="<spring:message code="BOARD.SECRET" /><%-- 비공개 --%>"/>
										</c:if>
										<%-- 신규 게시물 표시 --%>
										<c:if test="${result.dfr_wdt < 2}">
											<img src="${pageContext.request.contextPath}/images/template/webadm/icon/icon_new.gif" alt="New"/>
										</c:if>
									</nobr>
								</td>
								<td>
									<%-- 작성자 --%> 
									<c:choose>
										<c:when test="${SESS_BRD_INFO.off_viewmode eq '2' and not empty result.add_info_01}">
											${result.add_info_01}
										</c:when>
										<c:otherwise>
											<span title="<c:out value="${result.writer}"/>"><c:out value="${result.writer_nm}" /></span>
										</c:otherwise>
									</c:choose>
								</td>
								<td><c:out value="${result.wdt}" />
								</td>
								<c:if test="${SESS_BRD_INFO.use_rcmnd eq 'Y'}">
									<%-- 추천 수 표시 --%>
									<td><c:out value="${result.rcmnd_cnt}" />
									</td>
								</c:if>
								<c:if test="${SESS_BRD_INFO.use_rjct eq 'Y'}">
									<%-- 반대 수 표시 --%>
									<td><c:out value="${result.rjct_cnt}" />
									</td>
								</c:if>
								<%-- <td><c:out value="${result.hits}" /></td> --%>
						</tr>
					</c:forEach>
					<c:if test="${totCnt eq 0}">
						<tr>
							<td colspan="${colspan}"> <spring:message code="BOARD.NO-DATA" /><%-- 조회 결과가 없습니다 --%> </td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		<%-- 게시글 리스트 //--%>
		<%-- 게시글 리스트 페이징 --%>
		<c:if test="${totPage gt 1}">
			<article class="area_paging"><div>
					<ui:pagination paginationInfo="${paginationInfo}" type="image"
						jsFunction="fn_egov_link_page" />
			</div></article>
		</c:if>
		<%-- 게시글 리스트 페이징 //--%>
		<br />
		<p class="right">
			<c:if test="${RWAUTH eq 'RWD' or RWAUTH eq 'RW'}">
				<%-- <a href="javascript:fn_egov_brd_add()" class="btn_blue_m"><spring:message code="BOARD.WRITE" />글쓰기</a> --%>
				<a href="${pageContext.request.contextPath}/brdanm/boardanonimMoveView.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_menu_nix=${ param.srch_menu_nix}&edomweivgp=A" class="btn_line"><spring:message code="BOARD.WRITE" /><%-- 글쓰기 --%></a>
			</c:if>
			<c:if test="${fn:startsWith(param.srch_menu_nix, '794x409U') eq true}">	
				<a href="javascript:fn_egov_brd_alllist()" class="btn_orange_m"><spring:message code="BOARD.BOARD-LIST" /><%-- 게시판목록 --%></a>
			</c:if>
		</p>
		<br />
		<div class="board_search">
			<div class="form">
				<label for="searchCondition" class="hidden-text">검색 구분</label>
				<form:select path="searchCondition">
					<form:option value=""><spring:message code="BOARD.SELECT" /><%-- 선택 --%></form:option>
					<form:option value="SUBJECT"><spring:message code="BOARD.TITLE" /><%-- 제목 --%></form:option>
					<form:option value="BRD_CONT"><spring:message code="BOARD.CONTENTS" /><%-- 내용 --%></form:option>
					<form:option value="SC_ALL"><spring:message code="BOARD.TITLE+CONTENTS" /><%-- 제목 + 내용 --%></form:option>
				</form:select>
				<label for="searchKeyword" class="hidden-text">검색어 입력</label>
				<form:input path="searchKeyword" class="keyword" />
				<button class="btn" value="<spring:message code="BOARD.SEARCH" /><%-- 검색 --%>" id="btnBoardSearch" onclick="return false;"><spring:message code="BOARD.SEARCH" /><%-- 검색 --%></button>
			</div>
		</div>
		<%-- //페이지 작성 --%>
		<br />
	</div>
	<%-- contents //--%>
	<form:hidden path="edomweivgp" />
	<form:hidden path="pageIndex" />
	<input type="hidden" id="cont_idx" name="cont_idx" value="0" />
	<input type="hidden" id="mod_gb"/>	
	<form:hidden path="brd_pass"/>
</form:form>

<form name="form_chkType" method="post">
	<%-- 본인 인증 부분 시작--%>
	<input type="hidden" name="m" value="checkplusSerivce"><%-- 필수 데이타로, 누락하시면 안됩니다. --%>
	<input type="hidden" id="EncodeData" name="EncodeData" value=""><%-- 위에서 업체정보를 암호화 한 데이타입니다. --%>
	<%-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다. 해당 파라미터는 추가하실 수 없습니다. --%>
	<input type="hidden" id="param_r1" name="param_r1" value="">
	<c:choose>
		<c:when test="${SESS_BRD_INFO.off_viewmode eq '2'}">
			<input type="hidden" id="param_r2" name="param_r2" value="A">
		</c:when>
	</c:choose>
	<input type="hidden" id="param_r3" name="param_r3" value="">
	<%-- 본인 인증 부분 끝--%>
</form>	
<form name="evtinfoForm" method="post">
</form>
