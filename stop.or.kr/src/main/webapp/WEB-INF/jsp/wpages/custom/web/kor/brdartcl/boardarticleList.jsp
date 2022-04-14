<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>
<%-- 
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
	
   	## TPCODE : TPAGE0021: 일반 게시판 목록 페이지 ## 
--%>

<form:form name="reqForm" commandName="boardarticleVO">
	<%-- 카테고리 --%>
	<c:if test="${SESS_BRD_INFO.use_ctgry eq 'Y'}">
		<ul class="category"> 
			<c:choose>
				<c:when test="${empty param.srch_ctgry_idx}">
					<li class="active"><a href="${pageContext.request.contextPath}/brdartcl/boardarticleList.do?brd_id=${SESS_BRD_INFO.brd_id}&&srch_menu_nix=${param.srch_menu_nix}">전체</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="${pageContext.request.contextPath}/brdartcl/boardarticleList.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_ctgry_idx=${result.ctgry_idx}&srch_menu_nix=${param.srch_menu_nix}">전체</a></li>
				</c:otherwise>
			</c:choose>
			<c:forEach var="result" items="${ctgryList}" varStatus="status">
				<c:choose>
					<c:when test="${result.ctgry_idx eq 'CTIDX00022' or result.ctgry_idx eq 'CTIDX00023'}">
						<c:choose>
							<c:when test="${result.ctgry_idx eq param.srch_ctgry_idx}">
								<li class="active"><a href="${pageContext.request.contextPath}/brdartcl/boardarticleList.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_ctgry_idx=${result.ctgry_idx}&srch_menu_nix=${param.srch_menu_nix}"><c:out value="${result.ctgry_nm}"/> 공지사항</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="${pageContext.request.contextPath}/brdartcl/boardarticleList.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_ctgry_idx=${result.ctgry_idx}&srch_menu_nix=${param.srch_menu_nix}"><c:out value="${result.ctgry_nm}"/> 공지사항</a></li>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${result.ctgry_idx eq param.srch_ctgry_idx}">
								<li class="active"><a href="${pageContext.request.contextPath}/brdartcl/boardarticleList.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_ctgry_idx=${result.ctgry_idx}&srch_menu_nix=${param.srch_menu_nix}"><c:out value="${result.ctgry_nm}"/></a></li>
							</c:when>
							<c:otherwise>
								<li><a href="${pageContext.request.contextPath}/brdartcl/boardarticleList.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_ctgry_idx=${result.ctgry_idx}&srch_menu_nix=${param.srch_menu_nix}"><c:out value="${result.ctgry_nm}"/></a></li>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</ul>
	</c:if>

	<%-- 현재페이지 --%>
<%-- 	<div class="page-count">
		<div class="page-total">모두<em>${elfunc:getNumberFormat(totCnt)}</em>개의 글이 있습니다.</div>
	</div> --%>
	
	<%-- 게시글 리스트 --%>
	<p class="brd-tit hidden-text"></p>
	<div class="table-wrap board">
		<table>
			<caption><strong><spring:message code="BOARD.LIST-CAPTION" /></strong><%-- 게시판 --%>
				<spring:message code="BOARD.LIST-SUMMARY" /><%-- 게시판으로 글 번호, 제목, 작성일, 조회수를 제공하고 있음 --%>
			</caption>
			<colgroup>
			
					<col class="num">
					<c:if test="${SESS_BRD_INFO.use_ctgry eq 'Y'}">
						<col class="category" />
					</c:if>
					<col class="subject">
					<c:if test="${param.srch_menu_nix ne 'qa061Y4n' and param.srch_menu_nix ne 'CQv80aU3' and param.srch_menu_nix ne '037684p5'}">
						<!-- 여분필드  -->
						<c:if test="${extra1_array.extra1_use eq 'Y'}">
							<col class="extra1">
						</c:if>
						<c:if test="${extra2_array.extra2_use eq 'Y'}">
							<col class="extra2">
						</c:if>
					</c:if>
				<%-- 	<col class="name"> --%>
					<col class="date">
					<c:if test="${SESS_BRD_INFO.use_rcmnd eq 'Y'}">
						<col width="_rcmnd" />
					</c:if>
					<c:if test="${SESS_BRD_INFO.use_rjct eq 'Y'}">
						<col width="rjct" />
					</c:if>
					
					<col class="hit">
					
										
			</colgroup>
			<thead>
				<tr>
					<th scope='col'><spring:message code="BOARD.NUM" /> <%-- 번호 --%></th>
					<c:set var="colspan" value="1" />
					<c:choose>
						<c:when test="${SESS_BRD_INFO.use_ctgry eq 'Y'}">
							<th scope='col'><spring:message code="BOARD.CATEGORY" /> <%-- 분류 --%></th>
							<th scope='col'><spring:message code="BOARD.TITLE" /> <%-- 제목 --%></th>
							<c:set var="colspan" value="${colspan + 1}" />
						</c:when>
						<c:otherwise>
							<th scope='col'><spring:message code="BOARD.TITLE" /> <%-- 제목 --%></th>
							<c:set var="colspan" value="${colspan + 1}" />
						</c:otherwise>
					</c:choose>
					<c:if test="${param.srch_menu_nix ne 'qa061Y4n' and param.srch_menu_nix ne 'CQv80aU3' and param.srch_menu_nix ne '037684p5'}">
						<c:if test="${extra1_array.extra1_use eq 'Y'}">
							<th scope='col'><c:out value="${extra1_array.extra1_name}"/></th>
							<c:set var="colspan" value="${colspan + 1}" />
						</c:if>
						<c:if test="${extra2_array.extra2_use eq 'Y'}">
							<th scope='col'><c:out value="${extra2_array.extra2_name}"/></th>
							<c:set var="colspan" value="${colspan + 1}" />
						</c:if>
					</c:if>
					<%-- <th scope='col'><spring:message code="BOARD.WRITER" />작성자</th> --%>
					<th scope='col'><spring:message code="BOARD.CREATED" /> <%-- 작성일 --%></th>
					<c:set var="colspan" value="${colspan + 1}" />
					<c:if test="${SESS_BRD_INFO.use_rcmnd eq 'Y'}">
						<th scope='col'><spring:message code="BOARD.RECOMMENDATION" /> <%-- 추천 --%></th>
						<c:set var="colspan" value="${colspan + 1}" />
					</c:if>
					<c:if test="${SESS_BRD_INFO.use_rjct eq 'Y'}">
						<th scope='col'><spring:message code="BOARD.OPPOSITION" /> <%-- 반대 --%></th>
						<c:set var="colspan" value="${colspan + 1}" />
					</c:if>
					
						<th scope='col'><spring:message code="BOARD.HIT" /> <%-- 조회 --%></th>
						<c:set var="colspan" value="${colspan + 1}" />
				
				</tr>
			</thead>
			<tbody>
				<%--
					2018-04-25(pigcos) : spring:message 값을 JSTL에서 사용할경우 아래 처럼 정의해서 사용 
					<c:set var="sBreakFast"><spring:message code="b.rcom.PNA" /></c:set> 					
				--%>
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
								<%-- <a href="${pageContext.request.contextPath}/brdartcl/boardarticleView.do?brd_id=${param.brd_id}&srch_menu_nix=${param.srch_menu_nix}&cont_idx=${notice.cont_idx}"> --%>
									<c:choose>
										<c:when test="${param.srch_menu_nix ne 'qa061Y4n'}">
											<a href="${pageContext.request.contextPath}/brdartcl/boardarticleView.do?brd_id=${param.brd_id}&srch_menu_nix=${param.srch_menu_nix}&cont_idx=${notice.cont_idx}">
										</c:when>
										<c:otherwise>
											<a href="#none" class="view_hit" data-brd_id="${result.brd_id}" data-cont_idx="${result.cont_idx}" data-extra2="${result.extra2}" target="_blank" title="새창열림">
										</c:otherwise>
									</c:choose>
									<c:if test="${notice.grp_lv > 1}">
										<img
											src="${pageContext.request.contextPath}/images/template/cmm/icon_reply.gif"
											alt="Reply Symbol" />
									</c:if>
										<c:out value="${notice.subject}" /></a>
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
						<%-- <td>
							작성자 
							<span title="<c:out value="${notice.writer}"/>">
								<c:out value="${notice.writer_nm}" />
							</span>
						</td> --%>
						<c:if test="${param.srch_menu_nix ne 'qa061Y4n' and param.srch_menu_nix ne 'CQv80aU3' and param.srch_menu_nix ne '037684p5'}">
							<c:if test="${extra1_array.extra1_use eq 'Y'}">
								<td><c:out value="${notice.extra1 }"/></td>
							</c:if>
							<c:if test="${extra2_array.extra2_use eq 'Y'}">
								<td><c:out value="${notice.extra2 }"/></td>
							</c:if>
						</c:if>
						<td>
							<c:out value="${notice.wdt}" />
						</td>
						<c:if test="${SESS_BRD_INFO.use_rcmnd eq 'Y'}">
							<%-- 추천 수 표시 --%>
							<td><c:out value="${notice.rcmnd_cnt}" /></td>
						</c:if>
						<c:if test="${SESS_BRD_INFO.use_rjct eq 'Y'}">
							<%-- 반대 수 표시 --%>
							<td><c:out value="${notice.rjct_cnt}" /></td>
						</c:if>
						
						<td><c:out value="${notice.hits}" /></td>
						
					</tr>
				</c:forEach>
				<%-- 일반 게시물 영역 --%>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td><c:out value="${totCnt - (result.rn - 1)}" />
						</td>
						<c:if test="${SESS_BRD_INFO.use_ctgry eq 'Y'}">
							<td><c:out value="${result.ctgry_nm}" /></td>
						</c:if>
						<%-- 제목 --%>
						<td class="subject">
							<%-- 관리자는 무조건 게시판 내용을 확인 가능함. --%>
							<c:if test="${result.grp_lv eq 1}">
								<c:set var = "top_writer" value="${result.writer}"/>
							</c:if>
							<c:choose>
								<c:when test="${result.is_scrt eq 'Y' and SESS_USR_LV gt 100 and SESS_USR_ID ne result.writer and SESS_USR_ID ne top_writer}">
									<a href="javascript:fn_egov_show_pwdlayer('${result.cont_idx}')">
										<c:if test="${result.grp_lv > 1}">
											<img src="${pageContext.request.contextPath}/images/template/cmm/icon_reply.gif" alt="Reply Symbol" />
										</c:if> 
										<c:out value="${result.subject}" />
									</a>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${param.srch_menu_nix ne 'qa061Y4n'}">
											<c:set var="a_url" value="brd_id=${param.brd_id}&srch_menu_nix=${param.srch_menu_nix}&cont_idx=${result.cont_idx}"/>
											<a href="${cutil:getUrl('/brdartcl/boardarticleView.do',a_url,true)}">
											<%-- <a href="${pageContext.request.contextPath}/brdartcl/boardarticleView.do?brd_id=${param.brd_id}&srch_menu_nix=${param.srch_menu_nix}&cont_idx=${result.cont_idx}"> --%>
										</c:when>
										<c:otherwise>
											<a href="#none" class="view_hit" data-brd_id="${result.brd_id}" data-cont_idx="${result.cont_idx}" data-extra2="${result.extra2}" target="_blank" title="새창열림">
										</c:otherwise>
									</c:choose>
									
										<c:if test="${result.grp_lv > 1}">
											<img src="${pageContext.request.contextPath}/images/template/cmm/icon_reply.gif" alt="Reply Symbol" />
										</c:if> 
										<c:out value="${result.subject}" />
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
								<img src="${pageContext.request.contextPath}/images/template/webadm/icon/icon_secret.gif" alt="비공개"/>
							</c:if>
							<%-- 신규 게시물 표시 --%>
							<c:if test="${result.dfr_wdt < 2}">
								<span class="new">새글</span>
							</c:if>
						</td>
						<%-- <td>
							작성자
							<c:choose>
								<c:when test="${SESS_BRD_INFO.off_viewmode eq '2'}">
									${result.add_info_01}
								</c:when>
								<c:otherwise>
									<c:out value="${result.writer_nm}" />
								</c:otherwise>
							</c:choose>
						</td> --%>
						<c:if test="${param.srch_menu_nix ne 'qa061Y4n' and param.srch_menu_nix ne 'CQv80aU3' and param.srch_menu_nix ne '037684p5'}">
							<c:if test="${extra1_array.extra1_use eq 'Y'}">
								<td><c:out value="${result.extra1 }"/></td>
							</c:if>
							<c:if test="${extra2_array.extra2_use eq 'Y'}">
								<td><c:out value="${result.extra2 }"/></td>
							</c:if>
						</c:if>
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
						
						<td><c:out value="${result.hits}" /></td>
						
					</tr>
				</c:forEach>
				<c:if test="${totCnt eq 0}">
					<tr>
						<td colspan="${colspan}"><spring:message code="BOARD.NO-DATA" /><%-- 조회 결과가 없습니다 --%></td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>

	
	<%-- 페이징 --%>
	<c:if test="${totPage gt 1}">
		<div class="pager">
			<ui:pagination paginationInfo="${paginationInfo}" type="text" jsFunction="fn_egov_link_page" />
		</div>
	</c:if>
	
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
			<%-- <a href="javascript:fn_egov_brd_add()" class="btn_line"><spring:message code="BOARD.WRITE" />글쓰기</a> --%>
			<c:set var="a_url" value="brd_id=${param.brd_id}&srch_menu_nix=${param.srch_menu_nix}&cont_idx=${result.cont_idx}&edomweivgp=A"/>
			<a href="${cutil:getUrl('/brdartcl/boardarticleMoveView.do',a_url,false)}" class="btn-m btn1"><spring:message code="BOARD.WRITE" /></a>
			<%-- <a href="${pageContext.request.contextPath}/brdartcl/boardarticleMoveView.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_menu_nix=${ param.srch_menu_nix}&edomweivgp=A" class="btn-m btn1"><spring:message code="BOARD.WRITE" />글쓰기</a> --%>
		</c:if>
		<c:if test="${fn:indexOf('794x409U|wZ311Dfx|IR3T73EE', param.srch_menu_nix) ge 0}">
			<a href="javascript:fn_egov_brd_alllist()" class="btn-m btn1"><spring:message code="BOARD.BOARD-LIST" /><%-- 게시판목록 --%></a>
		</c:if>
	</div>
	
	<!-- 상세콘텐츠 영역 -->
	<c:if test="${empty param.srch_mu_lang}">
	<div class="box1 gongnr">
	    <div class="item">
	        <span class="icon">
	            <img src="/images/kor/sub/ggnr_type4.png" alt="OPEN 공공누리 공공저작물 자유이용허락 출처표시 / 상업용금지 / 변경금지" style="width:200px;">
	        </span>
	        <p class="txt">본 저작물은 "공공누리 제4유형 : 출처표시+상업적이용금지+변경금지" 조건에 따라 이용할 수 있습니다. 활용 관련 문의: 홍보담당자</p>
	    </div>
	</div>
	</c:if>
	

	<!-- contents //-->
	<form:hidden path="edomweivgp" />
	<form:hidden path="pageIndex" />
	<input type="hidden" id="cont_idx" name="cont_idx" value="0" />
	<input type="hidden" id="mod_gb"/>	
	<form:hidden path="brd_pass"/>
</form:form>
<form name="form_chkType" method="post">
	<%-- 본인 인증 부분 시작 --%>
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
	<%-- 본인 인증 부분 끝 --%>
</form>	
<form name="evtinfoForm" method="post">
</form>

<script>
$("div.table-wrap").on("click","a.view_hit",function()
{
	var extra2 = $(this).attr("data-extra2");
	
	$.ajax({
        url 		: g_context+"/brdartcl/updateHits.do",
        type  		: "post",
        data		:  {"brd_id":$(this).attr('data-brd_id'),"cont_idx":$(this).attr('data-cont_idx')},
        datatype	: "json",
		async 		: false,	        
		'success'	: function (result, status, xhr) {
			if(result == "SUCCESS")
				window.open(extra2, '_blank'); 
        },
		error: function(xhr, err){
        	alert("에러가 발생했습니다.");
        }
	});
	
	return false;
});
$(function(){
	$(".table-wrap.board caption").text($(".cont-title").text() + "-" + $(".table-wrap.board thead th").text() + "정보제공");
	$(".brd-tit").text($(".cont-title").text());
});
</script>