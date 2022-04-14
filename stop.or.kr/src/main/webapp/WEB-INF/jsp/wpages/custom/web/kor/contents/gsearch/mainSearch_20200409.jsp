<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>

<ul class="tabmenu">
	<li class="<c:if test="${param.searchType eq 'CONT'}">active</c:if>"><a href="${pageContext.request.contextPath}/contents/mainTotalSearch.do?srch_menu_nix=${param.srch_menu_nix}&searchKeyword=${param.searchKeyword}&searchType=CONT<c:if test="${!empty param.srch_mu_site }">&srch_mu_site=${param.srch_mu_site }</c:if>">컨텐츠</a></li>
	<li class="<c:if test="${param.searchType eq 'BRD'}">active</c:if>"><a href="${pageContext.request.contextPath}/contents/mainTotalSearch.do?srch_menu_nix=${param.srch_menu_nix}&searchKeyword=${param.searchKeyword}&searchType=BRD<c:if test="${!empty param.srch_mu_site }">&srch_mu_site=${param.srch_mu_site }</c:if>">게시판</a></li>
	<li class="<c:if test="${param.searchType eq 'CMS'}">active</c:if>"><a href="${pageContext.request.contextPath}/contents/mainTotalSearch.do?srch_menu_nix=${param.srch_menu_nix}&searchKeyword=${param.searchKeyword}&searchType=CMS<c:if test="${!empty param.srch_mu_site }">&srch_mu_site=${param.srch_mu_site }</c:if>">기타</a></li>
</ul>

<div class="search-result">
	<p class="box1">
		<strong class="point1">"검색결과  ${param.searchKeyword}"</strong>에 대한 통합검색 결과 총 <span class="point3">${resultListCnt}</span>건 검색되었습니다.
	</p>
	
	<c:set var="more" value=""/>
	
	<c:forEach var="board" items="${boardList}" varStatus="boardStatus">
		<h2 class="title1">${board.brd_nm}<span class="txt1">(총 <strong class="point3">${board.searchCount}</strong>건)</span></h2>
		<ul class="bul1">
			<c:choose>
				<c:when test="${param.searchType eq 'CONT'}">
					<c:forEach var="result" items="${resultList}" varStatus="status">
			
						<c:set var="subject" value="${result.subject}"/>
						<c:set var="more" value="${pageContext.request.contextPath}/modedg/contentsView.do?ucont_id=${result.brd_id}&mu_lang=${result.mu_lang}&srch_menu_nix=${result.menu_nix}&srch_mu_site=${result.mu_site}"/>
						<li>
							<a href="${pageContext.request.contextPath}/modedg/contentsView.do?ucont_id=${result.brd_id}&mu_lang=${result.mu_lang}&srch_menu_nix=${result.menu_nix}&srch_mu_site=${result.mu_site}">${subject}</a>
							
						</li>
					</c:forEach>
					
				</c:when>
				<c:when test="${param.searchType eq 'CMS'}">
					<c:set var="index" value="1"/>
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<c:if test="${board.brd_id eq result.brd_id and index le 10}">
							<c:set var="more" value="#none"/>
							<c:set var="a_url" value="#none"/>	
							<c:set var="subject" value="${result.subject}"/>
							<c:choose>
								<c:when test="${result.brd_id eq 'RELEASE'}">
									<c:set var="more" value="${pageContext.request.contextPath}/release/releaseUsrList.do?srch_menu_nix=${result.menu_nix}&searchKeyword=${param.searchKeyword}&srch_mu_site=${result.mu_site}"/>
									<c:set var="a_url" value="#none"/>	
										<c:if test="${!empty result.vchkcode}">
											<c:set var="a_url" value="javascript:cmmfn_download_atchfile('${pageContext.request.contextPath}', '${result.vchkcode}')"/>
										</c:if>
										<li>
											<a href="${a_url}">${subject}</a>
										</li>
								</c:when>
								<c:when test="${result.brd_id eq 'ANNO_BUSINESS'}">
									<c:set var="more" value="${pageContext.request.contextPath}/announcement/list.do?groupId=IDX000001&srch_menu_nix=${result.menu_nix}&searchKeyword=${param.searchKeyword}&srch_mu_site=${result.mu_site}"/>
									<c:set var="a_url" value="${pageContext.request.contextPath}/announcement/view.do?groupId=IDX000001&mu_lang=${result.mu_lang}&srch_menu_nix=${result.menu_nix}&srch_mu_site=${result.mu_site}&id=${result.cont_idx}"/>	
									<li>
										<a href="${a_url}">${subject}</a>
									</li>
								</c:when>
								<c:when test="${result.brd_id eq 'ANNO_RECRUIT'}">
									<c:set var="more" value="${pageContext.request.contextPath}/announcement/list.do?groupId=IDX000002&srch_menu_nix=${result.menu_nix}&searchKeyword=${param.searchKeyword}&srch_mu_site=${result.mu_site}"/>
									<c:set var="a_url" value="${pageContext.request.contextPath}/announcement/view.do?groupId=IDX000002&mu_lang=${result.mu_lang}&srch_menu_nix=${result.menu_nix}&srch_mu_site=${result.mu_site}&id=${result.cont_idx}"/>	
									<li>
										<a href="${a_url}">${subject}</a>
									</li>
								</c:when>
								<c:when test="${result.brd_id eq 'ANNO_RECRUIT2'}">
									<c:set var="more" value="${pageContext.request.contextPath}/announcement/list.do?groupId=IDX000003&srch_menu_nix=${result.menu_nix}&searchKeyword=${param.searchKeyword}&srch_mu_site=${result.mu_site}"/>
									<c:set var="a_url" value="${pageContext.request.contextPath}/announcement/view.do?groupId=IDX000003&mu_lang=${result.mu_lang}&srch_menu_nix=${result.menu_nix}&srch_mu_site=${result.mu_site}&id=${result.cont_idx}"/>	
									<li>
										<a href="${a_url}">${subject}</a>
									</li>
								</c:when>
								<c:when test="${result.brd_id eq 'SRVY_MAIN'}">
									<c:set var="more" value="${pageContext.request.contextPath}/usract/surveySrvydata/srvymainList.do?srch_menu_nix=${result.menu_nix}&searchKeyword=${param.searchKeyword}&srch_mu_site=${result.mu_site}"/>
									<c:set var="a_url" value="${pageContext.request.contextPath}/usract/surveySrvydata/srvyView.do?mu_lang=${result.mu_lang}&srch_menu_nix=${result.menu_nix}&srch_mu_site=${result.mu_site}&id=${result.cont_idx}"/>	
									<li>
										<a href="${a_url}">${subject}</a>
									</li>
								</c:when>
								<c:when test="${result.brd_id eq 'SCHEDULE'}">
									<c:set var="more" value="${pageContext.request.contextPath}/sch/schList.do?srch_menu_nix=${result.menu_nix}&searchKeyword=${param.searchKeyword}&srch_mu_site=${result.mu_site}"/>
									<c:set var="a_url" value="${pageContext.request.contextPath}/sch/schList.do?mu_lang=${result.mu_lang}&srch_menu_nix=${result.menu_nix}&srch_mu_site=${result.mu_site}"/>	
									<li>
										<a href="${a_url}">${subject}</a>
									</li>
								</c:when>
								<c:when test="${result.brd_id eq 'MAP'}">
									<c:set var="more" value="${pageContext.request.contextPath}/map/mapList.do?srch_menu_nix=${result.menu_nix}&searchKeyword=${param.searchKeyword}&srch_mu_site=${result.mu_site}"/>
									<c:set var="a_url" value="${pageContext.request.contextPath}/map/mapList.do?mu_lang=${result.mu_lang}&searchKeyword=${param.searchKeyword}&srch_menu_nix=${result.menu_nix}&srch_mu_site=${result.mu_site}"/>	
									<li>
										<a href="${a_url}">${subject}</a>
									</li>
								</c:when>
								<c:when test="${result.brd_id eq 'CARD'}">
									<c:set var="more" value="${pageContext.request.contextPath}/cardnews/cardNewsUsrList.do?srch_menu_nix=${result.menu_nix}&searchKeyword=${param.searchKeyword}&srch_mu_site=${result.mu_site}"/>
									<c:set var="a_url" value="${pageContext.request.contextPath}/cardnews/cardNewsUsrList.do?srch_menu_nix=${result.menu_nix}&searchKeyword=${param.searchKeyword}&srch_mu_site=${result.mu_site}"/>
									<%-- <c:set var="a_url" value="${pageContext.request.contextPath}/cardnews/cardNewsUsrView.do?mu_lang=${result.mu_lang}&srch_menu_nix=${result.menu_nix}&srch_mu_site=${result.mu_site}&nownm=${status.index+1}&seq=${result.cont_idx}"/>	 --%>
									<li>
										<a href="${a_url}">${subject}</a>
									</li>
								</c:when>
								<c:when test="${result.brd_id eq 'MULTI_PP'}">
									<c:set var="more" value="${pageContext.request.contextPath}/multicms/multiCmsUsrList.do?category=pp&srch_menu_nix=${result.menu_nix}&searchKeyword=${param.searchKeyword}&srch_mu_site=${result.mu_site}"/>
									<c:set var="a_url" value="${pageContext.request.contextPath}/widgets/download_popup.do?d_vchkcode=${result.vchkcode}&div=multicms_pp"/>	
									<li>
										<a href="#download" data-url="${a_url}" class="btn-layerpopup ajajx-down">${subject}</a>
									</li>
								</c:when>
								<c:when test="${result.brd_id eq 'MULTI_PD'}">
									<c:set var="more" value="${pageContext.request.contextPath}/multicms/multiCmsUsrList.do?category=pd&srch_menu_nix=${result.menu_nix}&searchKeyword=${param.searchKeyword}&srch_mu_site=${result.mu_site}"/>
									<c:set var="a_url" value="${pageContext.request.contextPath}/widgets/download_popup.do?d_vchkcode=${result.vchkcode}&div=multicms_pd"/>	
									<li>
										<a href="#download" data-url="${a_url}" class="btn-layerpopup ajajx-down">${subject}</a>
									</li>
								</c:when>
								<c:when test="${result.brd_id eq 'MULTI_CK'}">
									<c:set var="more" value="${pageContext.request.contextPath}/multicms/multiCmsUsrList.do?category=ck&srch_menu_nix=${result.menu_nix}&searchKeyword=${param.searchKeyword}&srch_mu_site=${result.mu_site}"/>
									<c:set var="a_url" value="${pageContext.request.contextPath}/widgets/download_popup.do?d_vchkcode=${result.vchkcode}&div=multicms_ck"/>	
									<li>
										<a href="#download" data-url="${a_url}" class="btn-layerpopup ajajx-down">${subject}</a>
									</li>
								</c:when>
								
							</c:choose>
							<c:set var="index" value="${index+1 }"/>
						</c:if>
					</c:forEach>
					
				</c:when>
				<c:otherwise>
					<ul class="result_list search_list">
						<c:set var="index" value="1"/>
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<c:if test="${board.brd_id eq result.brd_id and index le 10}">
								<li>
									<c:set var="subject" value="${result.subject}"/>
									<c:choose>
										<c:when test="${elfunc:isStartsWith(result.brd_id, 'BDIDX_')}">
											<c:choose>
												<c:when test="${result.brd_gb eq 'CDIDX00042' }">
													<c:set var="more" value="${pageContext.request.contextPath}/brdartcl/boardarticleList.do?brd_id=${result.brd_id}&srch_menu_nix=${result.menu_nix}&searchKeyword=${param.searchKeyword}&srch_mu_site=${result.mu_site}"/>
													<a href="${pageContext.request.contextPath}/brdartcl/boardarticleView.do?brd_id=${result.brd_id}&cont_idx=${result.cont_idx}&srch_menu_nix=${result.menu_nix}&edomweivgp=R&srch_mu_site=${result.mu_site}">${elfunc:cutString(result.subject,50, '...')}</a>
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
								<c:set var="index" value="${index+1 }"/>
							</c:if>
												
						</c:forEach>
					</ul>
				</c:otherwise>	
			</c:choose>
				
		</ul>
		<c:if test="${param.searchType ne 'CONT'}">
			<p class="btns txt-right">
				<a href="${more}" class="btn-m btn1">더보기</a>
			</p>
		</c:if>
	</c:forEach>
</div>







<%

if(true) return;
%>


<!-- 컨텐츠영역 --> 

<div id="content">
	<br/>
	<h1 class="stitle">
		통합검색
		<span>
			한국청소년정책연구원이 청소년의 밝은 미래를 열어갑니다.
		</span>
	</h1>
	<article id="detail_content">
		<form:form name="reqForm" commandName="boardarticleVO">
			<div class="topSearchForm">
				<fieldset>
					<legend>통합검색 폼</legend>
					<form:select path="searchCondition">
						<form:option value="SUBJECT">제목</form:option>
						<form:option value="BRD_CONT">내용</form:option>
						<form:option value="SC_ALL">제목 + 내용</form:option>
						<!--<form:option value="WRITER_NM">작성자</form:option>-->
					</form:select>
					<input type="text" id="searchKeyword" name="searchKeyword" title="검색어입력" value="${boardarticleVO.searchKeyword}"/>
					<button  type="submit" id="btnTotalSearch" class="input_smallBlack">검색</button>
				</fieldset>
			</div>
			<!-- 
			<c:if test= "${resultListCnt gt 0}">
			<ul class="tab_menu">
				<li <c:if test="${empty param.searchType or param.searchType eq 'BRD'}">class="on"</c:if>><a href="javascript:fn_egov_tot_type('BRD')">게시판</a>
				<li <c:if test="${param.searchType eq 'CONT'}">class="on"</c:if>><a href="javascript:fn_egov_tot_type('CONT')">웹문서</a>
			</ul>
			</c:if>
			 -->
			 
			<c:forEach var="board" items="${boardList}" varStatus="boardStatus">
			<div class="title_wrap">
				<h2 class="search_title">${board.brd_nm}</h2>
				<!-- <p class="btn_more"><a href="#none"><img src="${pageContext.request.contextPath}/images/custom/common/btn_more.gif" alt="결과더보기"/></a></p> -->
			</div>
			<div class="result_area"><span class="point02_bold">${board.searchCount}</span>건이 검색되었습니다.</div>
				
				<c:choose>
					<c:when test="${param.searchType eq 'CONT' }">
						<ul class="result_list">
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<c:set var="subject" value="${result.subject}"/>
								<li>
									<strong><a href="${pageContext.request.contextPath}/modedg/contentsView.do?ucont_id=${result.brd_id}&mu_lang=${result.mu_lang}&srch_menu_nix=${result.srch_menu_nix}">${subject}</a></strong>
									<p><c:out value="${elfunc:cutString(elfunc:removeTag(result.brd_cont), 500, '...')}"/></p>
								</li>
							</c:forEach>
						</ul>
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
														<a href="${pageContext.request.contextPath}/brdartcl/boardarticleView.do?brd_id=${result.brd_id}&cont_idx=${result.cont_idx}&srch_menu_nix=${result.srch_menu_nix}&edomweivgp=R">${elfunc:cutString(result.subject,50, '...')}</a>
													</c:when>
													<c:when test="${result.brd_gb eq 'CDIDX00043' }">
														<a href="${pageContext.request.contextPath}/brdfaq/boardfaqList.do?brd_id=${result.brd_id}&srch_menu_nix=${result.srch_menu_nix}">${elfunc:cutString(result.subject,50, '...')}</a>
													</c:when>
													<c:when test="${result.brd_gb eq 'CDIDX00044' }">
														<a href="${pageContext.request.contextPath}/brdthm/boardthmView.do?brd_id=${result.brd_id}&cont_idx=${result.cont_idx}&srch_menu_nix=${result.srch_menu_nix}&edomweivgp=R">${elfunc:cutString(result.subject,50, '...')}</a>
													</c:when>
													<c:when test="${result.brd_gb eq 'CDIDX00045' }">
														<a href="${pageContext.request.contextPath}/brddry/boarddryList.do?brd_id=${result.brd_id}&srch_menu_nix=${result.srch_menu_nix}&srchcalYr=20${fn:substring(result.wdt, 0, 2)}&srchcalMon=${fn:substring(result.wdt, 3, 5)}">${elfunc:cutString(result.subject,50, '...')}</a>
													</c:when>
													<c:when test="${result.brd_gb eq 'CDIDX00046' }">
														<a href="${pageContext.request.contextPath}/brdrr/boardrrView.do?brd_id=${result.brd_id}&cont_idx=${result.cont_idx}&srch_menu_nix=${result.srch_menu_nix}&edomweivgp=R">${elfunc:cutString(result.subject,50, '...')}</a>
													</c:when>
													<c:otherwise>
														<a href="${pageContext.request.contextPath}/brdartcl/boardarticleView.do?brd_id=${result.brd_id}&cont_idx=${result.cont_idx}&srch_menu_nix=${result.srch_menu_nix}&edomweivgp=R">${elfunc:cutString(result.subject,50, '...')}</a>
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise>
												<a href="#none">${elfunc:cutString(result.subject,50, '...')}</a>
											</c:otherwise>
										</c:choose>
										<span class="info_append">${result.wdt}</span>
									</li>
								</c:if>
													
							</c:forEach>
						</ul>
					</c:otherwise>	
				</c:choose>
			
			</c:forEach>
			
			<c:if test= "${resultListCnt eq 0}">
			 	<div class="no_result">
					<h2>검색어 <span class="point02">'${param.searchKeyword}'</span> 에 대한 검색 결과가 없습니다.</h2>
					<ul class="list_style">
						<li>단어의 철자가 정확한지 확인해주세요.</li>
						<li>검색어의 단어 수를 줄이거나, 다른 검색어로 검색해 보세요.</li>
						<li>보다 일반적인 검색어로 다시 검색해 보세요.</li>
					</ul>
				</div>
				
			</c:if>
			
			<br/>
			<br/>
			<form:hidden path="searchType"/>
		</form:form>
	</article>
</div>

