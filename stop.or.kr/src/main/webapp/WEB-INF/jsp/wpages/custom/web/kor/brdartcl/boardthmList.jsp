<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>

<%-- <c:if test="${param.srch_menu_nix eq '7j6mBDN6' }">
	<div class="box1">
		<div class="item">
			<span class="icon"><img src="${pageContext.request.contextPath}/images/kor/sub/icon1.gif" alt="" /></span>
			<p class="txt">다운로드를 원하실 경우 사용계획 및 연락처를 기재하여 메일(기획홍보팀 center@stop.or.kr)로 문의하시기 바랍니다.</p>
		</div>
	</div>
</c:if> --%>
<form:form name="reqForm" commandName="boardthmVO">
	<%-- 카테고리 --%>

	<c:if test="${SESS_BRD_INFO.use_ctgry eq 'Y'}">

		<p style="margin:0 0 10px 0;">’20.3.1일부터 유튜브는 인터넷 익스플로러를 지원하지 않습니다.<br />유튜브 동영상을 시청하시려면 브라우저를 업데이트(크롬, 엣지, 파이어폭스, 오페라 등) 하시길 바랍니다.</p>

		<ul class="category"> 
			<c:choose>
				<c:when test="${empty param.srch_ctgry_idx}">
					<li class="active"><a href="${pageContext.request.contextPath}/brdthm/boardthmList.do?brd_id=${SESS_BRD_INFO.brd_id}&&srch_menu_nix=${param.srch_menu_nix}">전체</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="${pageContext.request.contextPath}/brdthm/boardthmList.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_ctgry_idx=${result.ctgry_idx}&srch_menu_nix=${param.srch_menu_nix}">전체</a></li>
				</c:otherwise>
			</c:choose>
			<c:forEach var="result" items="${ctgryList}" varStatus="status">
				<c:choose>
					<c:when test="${result.ctgry_idx eq 'CTIDX00022' or result.ctgry_idx eq 'CTIDX00023'}">
						<c:choose>
							<c:when test="${result.ctgry_idx eq param.srch_ctgry_idx}">
								<li class="active"><a href="${pageContext.request.contextPath}/brdthm/boardthmList.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_ctgry_idx=${result.ctgry_idx}&srch_menu_nix=${param.srch_menu_nix}"><c:out value="${result.ctgry_nm}"/> 공지사항</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="${pageContext.request.contextPath}/brdthm/boardthmList.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_ctgry_idx=${result.ctgry_idx}&srch_menu_nix=${param.srch_menu_nix}"><c:out value="${result.ctgry_nm}"/> 공지사항</a></li>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${result.ctgry_idx eq param.srch_ctgry_idx}">
								<li class="active"><a href="${pageContext.request.contextPath}/brdthm/boardthmList.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_ctgry_idx=${result.ctgry_idx}&srch_menu_nix=${param.srch_menu_nix}"><c:out value="${result.ctgry_nm}"/></a></li>
							</c:when>
							<c:otherwise>
								<li><a href="${pageContext.request.contextPath}/brdthm/boardthmList.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_ctgry_idx=${result.ctgry_idx}&srch_menu_nix=${param.srch_menu_nix}"><c:out value="${result.ctgry_nm}"/></a></li>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</ul>
	</c:if>


	<ul class="board-thumb type1">
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<li>
				<c:set var="a_url" value="brd_id=${param.brd_id}&srch_menu_nix=${param.srch_menu_nix}&cont_idx=${result.cont_idx}"/>
				<a href="${cutil:getUrl('/brdthm/boardthmView.do',a_url,true)}">
				<%-- <a href="${pageContext.request.contextPath}/brdthm/boardthmView.do?brd_id=${param.brd_id}&srch_menu_nix=${param.srch_menu_nix}&cont_idx=${result.cont_idx}" title="${result.subject}"> --%>
					<span class="img">
						<img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${result.vchkcode}" width="163" height="113"/>
					</span>
					<c:if test="${SESS_BRD_INFO.use_ctgry eq 'Y'}">
						<span class="icon1 type1">
							${result.ctgry_nm}
						</span>
					</c:if>
					<strong><c:out value="${result.subject}"/></strong>
					<p class="info">
						${result.wdt}
					</p>
					
				</a>
			</li>
		</c:forEach>

		<c:if test="${totCnt eq 0}">
			<li><spring:message code="BOARD.NO-DATA" /><%-- 조회 결과가 없습니다. --%></li>
		</c:if>
	</ul>
	<%-- 게시글 리스트 페이징 --%>
	<c:if test="${totPage gt 1}">
		<div class="pager">
			<ui:pagination paginationInfo="${paginationInfo}" type="text" jsFunction="fn_egov_link_page" />
		</div>
	</c:if>
	<%-- 게시글 리스트 페이징 //--%>
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
		<form:input path="searchKeyword" title="${keyword_title}" />
		<a href="javascript:fn_egov_brd_search()" class="btn"><spring:message code="BOARD.SEARCH" /><%-- 검색 --%></a>
	</div>
	
	<%-- 버튼 --%>
	<div class="btns txt-right">
		<c:if test="${RWAUTH eq 'RWD' or RWAUTH eq 'RW'}">
			<%-- <span class="button basic"><span class="write"><button id="btnBoardAdd" type="button"><spring:message code="BOARD.WRITE" />글쓰기</button></span></span> --%>
			<c:set var="a_url" value="brd_id=${param.brd_id}&srch_menu_nix=${param.srch_menu_nix}&cont_idx=${result.cont_idx}&edomweivgp=A"/>
			<a href="${cutil:getUrl('/brdthm/boardthmMoveView.do',a_url,false)}" class="btn-m btn1"><spring:message code="BOARD.WRITE" /><%-- 글쓰기 --%></a>
			<%-- <a href="${pageContext.request.contextPath}/brdthm/boardthmMoveView.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_menu_nix=${param.srch_menu_nix}&edomweivgp=A" class="btn-m btn1"><spring:message code="BOARD.WRITE" />글쓰기</a> --%>
		</c:if>
		<c:if test="${fn:startsWith(param.srch_menu_nix, '794x409U') eq true}">	
			<span class="button basic"><span class="list"><button id="btnBoardAllList" type="button"><spring:message code="BOARD.BOARD-LIST" /><%-- 게시판목록 --%></button></span></span>
		</c:if>
	</div>
	<%-- 버튼 --%>
	
	<c:if test="${empty param.srch_mu_lang}">
	<div class="box1 gongnr">
		<div class="item">
			<span class="icon"><img src="/images/kor/sub/ggnr_type4.png" alt="OPEN 공공누리 공공저작물 자유이용허락 출처표시 / 상업용금지 / 변경금지" style="width:200px;"></span>
			<p class="txt">본 저작물은 &quot;공공누리 제4유형 : 출처표시+상업적이용금지+변경금지&quot; 조건에 따라 이용할 수 있습니다. 개인 외 기관 등에서 활용 목적으로 다운로드 시 활용 전 담당자에게 문의 바랍니다. 홍보 담당자</p>
		</div>
	</div>
	</c:if>
	<br />
	<br />
	<form:hidden path="edomweivgp" />
	<form:hidden path="pageIndex" />
	<input type="hidden" id="cont_idx" name="cont_idx" value="0" />
</form:form>




<%
if(true) return;
%>


<form:form name="reqForm" commandName="boardthmVO">
	<div id="detail_content">
		<div class="sch_wrap">
			<label class="hide" for="searchCondition"><spring:message code="BOARD.SEARCH-DIVISION" /><%-- 검색구분 선택 --%></label>
			<form:select path="searchCondition">
				<form:option value=""><spring:message code="BOARD.SELECT" /><%-- 선택 --%></form:option>
				<form:option value="SUBJECT"><spring:message code="BOARD.TITLE" /><%-- 제목 --%></form:option>
				<form:option value="BRD_CONT"><spring:message code="BOARD.CONTENTS" /><%-- 내용 --%></form:option>
				<form:option value="SC_ALL"><spring:message code="BOARD.TITLE+CONTENTS" /><%-- 제목 + 내용 --%></form:option>
			</form:select>
			<label for="searchKeyword" class="hidden-text"><spring:message code="BOARD.SEARCH-KEYWORD-HINT" /><%-- 검색어를 입력하세요. --%></label>
			<form:input path="searchKeyword" class="area_search_keyword"/>
			<a href="javascript:fn_egov_brd_search()" class="input_smallBlack"><spring:message code="BOARD.SEARCH" /><%-- 검색 --%></a>
			
		</div>					
		<div class="thumb_box">
			<ul>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<li><a href="${pageContext.request.contextPath}/brdthm/boardthmView.do?brd_id=${param.brd_id}&srch_menu_nix=${param.srch_menu_nix}&cont_idx=${result.cont_idx}" title="${result.subject}">
							<div class="figureimg">
								<img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${result.vchkcode}" alt="${result.subject}" width="163" height="113"/>
							</div>
							<div class="post">
								<p class="title"><c:out value="${elfunc:cutString(result.subject, 30, '...')}"/></p>
								<p class="txtp">${elfunc:cutString(elfunc:removeTag(result.brd_cont), 200, '...')}</p>
								<p class="date">${result.wdt}</p>
							</div>
						</a>
					</li>
					<%--  
					<li><a href="${pageContext.request.contextPath}/html/web/kor/news/sub020100_view.jsp">
							<div class="figureimg"><img src="http://www.nypi.re.kr/data/upload/1412181022175988.jpg" alt="경제·인문사회연구회 및 소관 연구기관과 충청권 대학과의 업무협약식 개최" /></div>
							<div class="post">
								<p class="title">경제·인문사회연구회 및 소관 연구기관과 충청권 대학과의 업무협약식 개최</p>
								<p class="txtp">경제ㆍ인문사회연구회 및 한국청소년정책연구원을 비롯한 소관 연구기관은 충청권 5개 대학(공주대, 우송대, 청주대, 충남대, 충북대)과 16일(화) 세종시 국책연구단지에서 인적교류, 연구ㆍ교육 협력 및 지식ㆍ정보공유 등을 통한 상호 협력 네트워크 구축을 위한...</p>
								<p class="date">2014.12.18</p>
							</div>
						</a>
					</li>
					--%>
				</c:forEach>
			</ul>
		</div>
	</div>
	<%-- http://img.youtube.com/vi/Ix9etmGoXP0/1.jpg --%>
	<c:if test="${totCnt eq 0}">
		<div class="nobbs"><span><spring:message code="BOARD.NO-DATA" /><%-- 조회 결과가 없습니다. --%></span></div>
	</c:if>
	<%-- 게시글 리스트 페이징 --%>
	<c:if test="${totPage gt 1}">
		<div class="board_pager">
			<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
		</div>
	</c:if>
	<%-- 게시글 리스트 페이징 //--%>
	<%-- 버튼 --%>
	<div class="btn_area_right">
		<c:if test="${RWAUTH eq 'RWD' or RWAUTH eq 'RW'}">
			<span class="button basic"><span class="write"><button id="btnBoardAdd" type="button"><spring:message code="BOARD.WRITE" /><%-- 글쓰기 --%></button></span></span>
		</c:if>
		<c:if test="${fn:startsWith(param.srch_menu_nix, '794x409U') eq true}">	
			<span class="button basic"><span class="list"><button id="btnBoardAllList" type="button"><spring:message code="BOARD.BOARD-LIST" /><%-- 게시판목록 --%></button></span></span>
		</c:if>
	</div>
	<%-- 버튼 --%>
	<br />
	<br />
	<form:hidden path="edomweivgp" />
	<form:hidden path="pageIndex" />
	<input type="hidden" id="cont_idx" name="cont_idx" value="0" />
</form:form>