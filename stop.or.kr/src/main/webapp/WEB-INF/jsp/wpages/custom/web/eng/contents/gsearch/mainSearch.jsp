<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>

<ul class="tabmenu">
	<li class="<c:if test="${param.searchType eq 'CONT'}">active</c:if>"><a href="${pageContext.request.contextPath}/contents/mainTotalSearch.do?srch_menu_nix=${param.srch_menu_nix}&searchKeyword=${param.searchKeyword}&searchType=CONT<c:if test="${!empty param.srch_mu_site }">&srch_mu_site=${param.srch_mu_site }</c:if><c:if test="${!empty param.srch_mu_lang }">&srch_mu_lang=${param.srch_mu_lang }</c:if>">Contents</a></li>
	<li class="<c:if test="${param.searchType eq 'BRD'}">active</c:if>"><a href="${pageContext.request.contextPath}/contents/mainTotalSearch.do?srch_menu_nix=${param.srch_menu_nix}&searchKeyword=${param.searchKeyword}&searchType=BRD<c:if test="${!empty param.srch_mu_site }">&srch_mu_site=${param.srch_mu_site }</c:if><c:if test="${!empty param.srch_mu_lang }">&srch_mu_lang=${param.srch_mu_lang }</c:if>">Board</a></li>
	<li class="<c:if test="${param.searchType eq 'CMS'}">active</c:if>"><a href="${pageContext.request.contextPath}/contents/mainTotalSearch.do?srch_menu_nix=${param.srch_menu_nix}&searchKeyword=${param.searchKeyword}&searchType=CMS<c:if test="${!empty param.srch_mu_site }">&srch_mu_site=${param.srch_mu_site }</c:if><c:if test="${!empty param.srch_mu_lang }">&srch_mu_lang=${param.srch_mu_lang }</c:if>">Etc</a></li>
</ul>

<div class="search-result">
	<p class="box1">
		<strong class="point1">"${param.searchKeyword}"</strong> is searched Total <span class="point3">${resultListCnt}</span>
	</p>
	
	<c:if test= "${resultListCnt eq 0}">
	 	<div class="no_result">
			<h2>search word <span class="point02">'${param.searchKeyword}'</span>no search results found.</h2>
			<ul class="list_style">
				<li>Please check the words are spelled correctly.</li>
				<li>Try reducing the number of words in your search term, or try a different search term.</li>
				<li>Please try again in a more general search word.</li>
			</ul>
		</div>
	</c:if>
	
	<c:set var="more" value=""/>
	
	<c:forEach var="board" items="${boardList}" varStatus="boardStatus">

		<h2 class="title1">${board.brd_nm}<span class="txt1">(Total <strong class="point3">${board.searchCount}</strong>)</span></h2>
		
		<ul class="bul1">
			<c:choose>
				<c:when test="${param.searchType eq 'CONT'}">
					<c:forEach var="result" items="${resultList}" varStatus="status">
			
						<c:set var="subject" value="${result.subject}"/>
						<c:set var="more" value="${pageContext.request.contextPath}/modedg/contentsView.do?ucont_id=${result.brd_id}&srch_mu_lang=${result.mu_lang}&srch_menu_nix=${result.menu_nix}&srch_mu_site=${result.mu_site}"/>
						<li>
							<a href="${pageContext.request.contextPath}/modedg/contentsView.do?ucont_id=${result.brd_id}&srch_mu_lang=${result.mu_lang}&srch_menu_nix=${result.menu_nix}&srch_mu_site=${result.mu_site}">${subject}</a>
							
						</li>
					</c:forEach>
					
				</c:when>
				<c:when test="${param.searchType eq 'CMS'}">
					
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<c:set var="subject" value="${result.subject}"/>
						<c:choose>
							<c:when test="${result.brd_nm eq 'USE_RELEASE'}">
								<c:set var="more" value="${pageContext.request.contextPath}/release/releaseUsrList.do?srch_menu_nix=${result.menu_nix}&searchKeyword=${param.searchKeyword}&srch_mu_site=${result.mu_site}"/>
								<c:set var="a_url" value="#none"/>	
									<c:if test="${!empty result.vchkcode}">
										<c:set var="a_url" value="javascript:cmmfn_download_atchfile('${pageContext.request.contextPath}', '${result.vchkcode}')"/>
									</c:if>
								<li>
									<a href="${a_url}">${subject}</a>
								</li>
							</c:when>
							<c:when test="${result.brd_nm eq 'WHRIK Publication'}">
								<c:set var="more" value="${pageContext.request.contextPath}/multicms/multiCmsUsrList.do?category=wp&srch_menu_nix=${result.menu_nix}&searchKeyword=${param.searchKeyword}&srch_mu_lang=${param.srch_mu_lang}"/>
								<c:set var="a_url" value="#none"/>	
									<c:if test="${!empty result.vchkcode}">
										<c:set var="a_url" value="javascript:cmmfn_download_atchfile('${pageContext.request.contextPath}', '${result.vchkcode}')"/>
									</c:if>
								<li>
									<a href="${a_url}">${subject}</a>
								</li>
							</c:when>
						</c:choose>
						
					</c:forEach>
					
				</c:when>
				<c:otherwise>
					<ul class="result_list search_list">
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<c:if test="${board.brd_id eq result.brd_id}">
								<li>
									<c:set var="subject" value="${result.subject}"/>
									<c:choose>
										<c:when test="${elfunc:isStartsWith(result.brd_id, 'BDIDX_')}">
											<c:choose>
												<c:when test="${result.brd_gb eq 'CDIDX00042' }">
													<c:set var="more" value="${pageContext.request.contextPath}/brdartcl/boardarticleList.do?brd_id=${result.brd_id}&srch_menu_nix=${result.menu_nix}&searchKeyword=${param.searchKeyword}&srch_mu_site=${result.mu_site}"/>
													<a href="${pageContext.request.contextPath}/brdartcl/boardarticleView.do?brd_id=${result.brd_id}&cont_idx=${result.cont_idx}&srch_menu_nix=${result.menu_nix}&edomweivgp=R&srch_mu_site=${result.mu_site}&srch_mu_lang=${param.srch_mu_lang}">${elfunc:cutString(result.subject,50, '...')}</a>
												</c:when>
												<c:when test="${result.brd_gb eq 'CDIDX00043' }">
													<c:set var="more" value="${pageContext.request.contextPath}/brdfaq/boardfaqList.do?brd_id=${result.brd_id}&srch_menu_nix=${result.srch_menu_nix}&searchKeyword=${param.searchKeyword}&srch_mu_site=${result.mu_site}"/>
													<a href="${pageContext.request.contextPath}/brdfaq/boardfaqList.do?brd_id=${result.brd_id}&srch_menu_nix=${result.srch_menu_nix}&srch_mu_site=${result.mu_site}">${elfunc:cutString(result.subject,50, '...')}</a>
												</c:when>
												<c:when test="${result.brd_gb eq 'CDIDX00044' }">
													<c:set var="more" value="${pageContext.request.contextPath}/brdthm/boardthmList.do?brd_id=${result.brd_id}&srch_menu_nix=${result.menu_nix}&searchKeyword=${param.searchKeyword}&srch_mu_site=${result.mu_site}"/>
													<a href="${pageContext.request.contextPath}/brdthm/boardthmView.do?brd_id=${result.brd_id}&cont_idx=${result.cont_idx}&srch_menu_nix=${result.menu_nix}&edomweivgp=R&srch_mu_site=${result.mu_site}">${elfunc:cutString(result.subject,50, '...')}</a>
												</c:when>
												<c:when test="${result.brd_gb eq 'CDIDX00045' }">
													<c:set var="more" value="${pageContext.request.contextPath}/brddry/boarddryList.do?brd_id=${result.brd_id}&srch_menu_nix=${result.srch_menu_nix}&srchcalYr=20${fn:substring(result.wdt, 0, 2)}&srchcalMon=${fn:substring(result.wdt, 3, 5)}&searchKeyword=${param.searchKeyword}&srch_mu_site=${result.mu_site}"/>
													<a href="${pageContext.request.contextPath}/brddry/boarddryList.do?brd_id=${result.brd_id}&srch_menu_nix=${result.srch_menu_nix}&srchcalYr=20${fn:substring(result.wdt, 0, 2)}&srchcalMon=${fn:substring(result.wdt, 3, 5)}&srch_mu_site=${result.mu_site}">${elfunc:cutString(result.subject,50, '...')}</a>
												</c:when>
												<c:when test="${result.brd_gb eq 'CDIDX00046' }">
													<c:set var="more" value="${pageContext.request.contextPath}/brdanm/boardanonimList.do?brd_id=${result.brd_id}&srch_menu_nix=${result.menu_nix}&searchKeyword=${param.searchKeyword}&srch_mu_site=${result.mu_site}"/>
													<a href="${pageContext.request.contextPath}/brdanm/boardanonimView.do?brd_id=${result.brd_id}&cont_idx=${result.cont_idx}&srch_menu_nix=${result.menu_nix}&edomweivgp=R&srch_mu_site=${result.mu_site}">${elfunc:cutString(result.subject,50, '...')}</a>
												</c:when>
												<c:otherwise>
													<c:set var="more" value="${pageContext.request.contextPath}/brdartcl/boardarticleList.do?brd_id=${result.brd_id}&srch_menu_nix=${result.menu_nix}&searchKeyword=${param.searchKeyword}&srch_mu_site=${result.mu_site}"/>
													<a href="${pageContext.request.contextPath}/brdartcl/boardarticleView.do?brd_id=${result.brd_id}&cont_idx=${result.cont_idx}&srch_menu_nix=${result.menu_nix}&edomweivgp=R&srch_mu_site=${result.mu_site}">${elfunc:cutString(result.subject,50, '...')}</a>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<a href="#none">${elfunc:cutString(result.subject,50, '...')}</a>
										</c:otherwise>
									</c:choose>
								</li>
							</c:if>
												
						</c:forEach>
					</ul>
				</c:otherwise>	
			</c:choose>
				
		</ul>
		<c:if test="${param.searchType ne 'CONT'}">
			<p class="btns txt-right">
				<a href="${more}" class="btn-m btn1">More</a>
			</p>
		</c:if>
	</c:forEach>
</div>