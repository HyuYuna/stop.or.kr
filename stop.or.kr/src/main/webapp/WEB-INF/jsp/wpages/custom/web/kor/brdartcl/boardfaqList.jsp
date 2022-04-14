<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="content" class="contentswrap"> 
	<%-- container-right --%>
	<form:form name="reqForm" commandName="boardfaqVO">
		<section id="content">
			<div id="detail_content">
			    <%-- 실질 컨텐츠 영역 --%>
				<div class="sch_wrap">
					<label class="hide" for="searchCondition"><spring:message code="BOARD.SEARCH-DIVISION" /><%-- 검색구분 선택 --%></label>
					<form:select path="searchCondition">
						<form:option value=""><spring:message code="BOARD.SELECT" /><%-- 선택 --%></form:option>
						<form:option value="SUBJECT"><spring:message code="BOARD.TITLE" /><%-- 제목 --%></form:option>
						<form:option value="BRD_CONT"><spring:message code="BOARD.CONTENTS" /><%-- 내용 --%></form:option>
						<form:option value="SC_ALL"><spring:message code="BOARD.TITLE+CONTENTS" /><%-- 제목 + 내용 --%></form:option>
					</form:select>
					<label class="flow" for="searchkeyword"><spring:message code="BOARD.SEARCH-KEYWORD-HINT" /><%-- 검색어를 입력하세요. --%></label>
					<form:input path="searchKeyword" class="area_search_keyword"/>
					<a href="javascript:fn_egov_brd_search()" class="input_smallBlack"><spring:message code="BOARD.SEARCH" /><%-- 검색 --%></a>
					<%--<a href="javascript:fn_egov_brd_list()"><img src="${pageContext.request.contextPath}/images/template/content/btn_boardsearch.png" alt="검색"/></a>--%>
				</div>	
				<div class="accordion">
					<dl class="accordion_lst">
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<dt>
								<c:choose>
									<c:when test="${RWAUTH eq 'RWD'}">
										<a href="javascript:fn_egov_brd_mod('${result.cont_idx}')"><span>Q</span> <c:out value="${result.subject}"/> </a>
									</c:when>
									<c:otherwise>
										<a href="javascript:;"><span>Q</span> <c:out value="${result.subject}"/> </a>
									</c:otherwise>
								</c:choose>
							</dt>
							<dd>${elfunc:removeScrtag(result.brd_cont)}</dd>
						</c:forEach>
					</dl>
					<c:if test="${totCnt eq 0}">
						<div class="nobbs"><span><spring:message code="BOARD.NO-DATA" /><%-- 조회 결과가 없습니다. --%></span></div>
					</c:if>
				</div>
				<%-- 게시글 리스트 페이징 --%>
				<c:if test="${totPage gt 1}">
					<div class="board_pager">
						<ui:pagination paginationInfo="${paginationInfo}" type="image"
							jsFunction="fn_egov_link_page" />
					</div>
				</c:if>
				<%-- 게시글 리스트 페이징 //--%>
			</div>
			<div class="btn_area_right">
				<c:if test="${RWAUTH eq 'RWD' or RWAUTH eq 'RW'}">
					<span class="button basic"><span class="write"><button id="btnBoardAdd" type="button"><spring:message code="BOARD.WRITE" /><%-- 글쓰기 --%></button></span></span>
				</c:if>
				<c:if test="${fn:startsWith(param.srch_menu_nix, '794x409U') eq true}">	
					<span class="button basic"><span class="list"><button id="btnBoardAllList" type="button"><spring:message code="BOARD.BOARD-LIST" /><%-- 게시판목록 --%></button></span></span>
				</c:if>
			</div>
			<br />
			<br />
			<form:hidden path="edomweivgp" />
			<form:hidden path="pageIndex" />
			<input type="hidden" id="cont_idx" name="cont_idx" value="0" />
		</section>
	</form:form>
</div>