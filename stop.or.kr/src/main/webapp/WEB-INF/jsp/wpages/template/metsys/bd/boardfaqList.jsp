<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
	
   	## TPCODE : TPAGE0021: 일반 게시판 목록 페이지 ## 
-->

<form:form name="reqForm" commandName="boardfaqVO">
			
	<c:if test="${SESS_BRD_INFO.use_ctgry eq 'Y'}">
		<ul class="tabmenu_blue"> 
			<c:choose>
				<c:when test="${empty param.srch_ctgry_idx}">
					<li class="on"><a href="${pageContext.request.contextPath}/brdartcl/boardfaqList.do?brd_id=${SESS_BRD_INFO.brd_id}&&srch_menu_nix=${param.srch_menu_nix}">전체</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="${pageContext.request.contextPath}/brdartcl/boardfaqList.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_ctgry_idx=${result.ctgry_idx}&srch_menu_nix=${param.srch_menu_nix}">전체</a></li>
				</c:otherwise>
			</c:choose>
			<c:forEach var="result" items="${ctgryList}" varStatus="status">
			
				<c:choose>
					<c:when test="${result.ctgry_idx eq 'CTIDX00022' or result.ctgry_idx eq 'CTIDX00023'}">
						<c:choose>
							<c:when test="${result.ctgry_idx eq param.srch_ctgry_idx}">
								<li class="on"><a href="${pageContext.request.contextPath}/brdartcl/boardfaqList.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_ctgry_idx=${result.ctgry_idx}&srch_menu_nix=${param.srch_menu_nix}"><c:out value="${result.ctgry_nm}"/> 공지사항</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="${pageContext.request.contextPath}/brdartcl/boardfaqList.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_ctgry_idx=${result.ctgry_idx}&srch_menu_nix=${param.srch_menu_nix}"><c:out value="${result.ctgry_nm}"/> 공지사항</a></li>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${result.ctgry_idx eq param.srch_ctgry_idx}">
								<li class="on"><a href="${pageContext.request.contextPath}/brdartcl/boardfaqList.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_ctgry_idx=${result.ctgry_idx}&srch_menu_nix=${param.srch_menu_nix}"><c:out value="${result.ctgry_nm}"/></a></li>
							</c:when>
							<c:otherwise>
								<li><a href="${pageContext.request.contextPath}/brdartcl/boardfaqList.do?brd_id=${SESS_BRD_INFO.brd_id}&srch_ctgry_idx=${result.ctgry_idx}&srch_menu_nix=${param.srch_menu_nix}"><c:out value="${result.ctgry_nm}"/></a></li>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<!-- <li><a href="/">예약</a></li> -->
		</ul>
	</c:if>
	
	<div id="detail_content">
		
		<!-- 	
		<p class="area_list_info">
			전체 <strong>${elfunc:getNumberFormat(totCnt)}건</strong>, 현재 페이지 <span>${elfunc:getNumberFormat(curPage)}</span>/${elfunc:getNumberFormat(totPage)}
		</p>
		 -->
		
		<div class="articles_search">
			<div class="basic_searchForm">
				<form:select path="searchCondition">
					<form:option value="">선택</form:option>
					<form:option value="SUBJECT">제목</form:option>
					<form:option value="BRD_CONT">내용</form:option>
					<form:option value="SC_ALL">제목 + 내용</form:option>
				</form:select>
				<form:input path="searchKeyword" class="keyword" />
				<a href="javascript:fn_egov_brd_search()" class="input_smallBlack">검색</a>
			</div>
			<!-- 
			<div class="inquiry">
				<span class="icon_inquiry">문의 : 채정숙 (T. 042-612-8512)</span>
			</div>
			-->
		</div>
		<!-- //페이지 작성 -->
		 
		 
		<!-- 게시글 리스트 -->
		<div class="tablewrap">
			<table class="tstyle_list" summary="게시판으로 글 번호, 제목, 작성일, 작성자, 조회수를 제공하고 있음">
				<caption>게시판</caption>
			
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
						<col width="8%" />
				</colgroup>
				<thead>
					<tr>
						<th scope='col' class="num">번호</th>
						
							<c:set var="colspan" value="1" />
							<c:choose>
								<c:when test="${SESS_BRD_INFO.use_ctgry eq 'Y'}">
									<th scope='col'>분류</th>
									<th scope='col'>제목</th>
									<c:set var="colspan" value="${colspan + 2}" />
								</c:when>
								<c:otherwise>
									<th scope='col'>제목</th>
									<c:set var="colspan" value="${colspan + 1}" />
								</c:otherwise>
							</c:choose>
							
							<th scope='col'>작성자</th>
							<th scope='col'>작성일</th>
							<c:set var="colspan" value="${colspan + 2}" />
							<c:if test="${SESS_BRD_INFO.use_rcmnd eq 'Y'}">
								<th scope='col'>추천</th>
								<c:set var="colspan" value="${colspan + 1}" />
							</c:if>
							<c:if test="${SESS_BRD_INFO.use_rjct eq 'Y'}">
								<th scope='col'>반대</th>
								<c:set var="colspan" value="${colspan + 1}" />
							</c:if>
							<th scope='col'>조회</th>
							<c:set var="colspan" value="${colspan + 1}" />
						
					</tr>
				</thead>
				<tbody>
					
					<!-- 공지사항 영역 -->
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
										<!-- 제목 -->
										<!-- 관리자는 무조건 게시판 내용을 확인 가능함. -->
										<a href="javascript:fn_egov_brd_view('${notice.cont_idx}')">
											<c:if test="${notice.grp_lv > 1}">
												<img
													src="${pageContext.request.contextPath}/images/template/cmm/icon_reply.gif"
													alt="Reply Symbol" />
											</c:if> <span id="spanListSubject${status.index}" title="${notice.subject}">
												<c:out value="${notice.subject}" /> </span> </a>
										<!-- 댓글 개수 표시 -->
									
										<!-- 신규 게시물 표시 -->
										<c:if test="${notice.dfr_wdt < 2}">
											<img
												src="${pageContext.request.contextPath}/images/template/webadm/icon/icon_new.gif"
												alt="New" class="new_img" />
										</c:if>
									</nobr>
								</td>
								<td>
									<!-- 작성자 --> 
									<span title="<c:out value="${notice.writer}"/>">
										<c:out value="${notice.writer_nm}" />
									</span>
								</td>
								<td>
									<c:out value="${notice.wdt}" />
								</td>
								<c:if test="${SESS_BRD_INFO.use_rcmnd eq 'Y'}">
									<!-- 추천 수 표시 -->
									<td><c:out value="${notice.rcmnd_cnt}" />
									</td>
								</c:if>
								<c:if test="${SESS_BRD_INFO.use_rjct eq 'Y'}">
									<!-- 반대 수 표시 -->
									<td><c:out value="${notice.rjct_cnt}" />
									</td>
								</c:if>
								<td><c:out value="${notice.hits}" /></td>
								
							
						</tr>
					</c:forEach>
	
					<!-- 일반 게시물 영역-->
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td><c:out value="${totCnt - (result.rn - 1)}" />
							</td>
								<c:if test="${SESS_BRD_INFO.use_ctgry eq 'Y'}">
									<td><c:out value="${result.ctgry_nm}" /></td>
								</c:if>
								<td class="ellipsis">
									<nobr>
										<!-- 제목 -->
										<c:choose>
											<c:when test="${result.is_scrt eq 'Y' and SESS_USR_LV gt 1000}">
												<a href="javascript:fn_egov_show_pwdlayer('${result.cont_idx}')">
													<c:if test="${result.grp_lv > 1}">
														<img src="${pageContext.request.contextPath}/images/template/cmm/icon_reply.gif" alt="Reply Symbol" />
													</c:if> 
													<span id="spanListSubject${status.index}" title="${result.subject}"><c:out value="${result.subject}" /></span> 
												</a>
											</c:when>
											<c:otherwise>
												<a href="javascript:fn_egov_brd_view('${result.cont_idx}')">
													<span id="spanListSubject${status.index}" title="${result.subject}"><c:out value="${result.subject}" /></span> 
												</a>
											</c:otherwise>
										</c:choose>
										<!-- 신규 게시물 표시 -->
										<c:if test="${result.dfr_wdt < 2}">
											<img src="${pageContext.request.contextPath}/images/template/webadm/icon/icon_new.gif" alt="New"/>
										</c:if>
									</nobr>
								</td>
								<td>
									<!-- 작성자 --> 
									<c:choose>
										<c:when test="${SESS_BRD_INFO.off_viewmode eq '2'}">
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
									<!-- 추천 수 표시 -->
									<td><c:out value="${result.rcmnd_cnt}" />
									</td>
								</c:if>
								<c:if test="${SESS_BRD_INFO.use_rjct eq 'Y'}">
									<!-- 반대 수 표시 -->
									<td><c:out value="${result.rjct_cnt}" />
									</td>
								</c:if>
								<td><c:out value="${result.hits}" /></td>
							
						</tr>
					</c:forEach>
					<c:if test="${totCnt eq 0}">
						<tr>
							<td colspan="${colspan}"> 조회 결과가 없습니다 </td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		<!-- 게시글 리스트 //-->
		<br/>
		
		<div class="btn_area_right">
			<c:if test="${RWAUTH eq 'RWD' or RWAUTH eq 'RW'}">
				<a href="javascript:fn_egov_brd_add()" class="btn_line">글쓰기</a>
			</c:if>

			<c:if test="${fn:indexOf('794x409U|wZ311Dfx|IR3T73EE', param.srch_menu_nix) ge 0}">
				<a href="javascript:fn_egov_brd_alllist()" class="btn_line">게시판목록</a>
			</c:if>
		</div>
		
		<br/>

		<!-- 게시글 리스트 페이징 -->
		<c:if test="${totPage gt 1}">
			<div class="board_pager">
				<ui:pagination paginationInfo="${paginationInfo}" type="image"
					jsFunction="fn_egov_link_page" />
			</div>
		</c:if>
		<!-- 게시글 리스트 페이징 //-->

		<br/>
		
	</div>
	
	<!-- contents //-->
	<form:hidden path="edomweivgp" />
	<form:hidden path="pageIndex" />
	<input type="hidden" id="cont_idx" name="cont_idx" value="0" />
	<input type="hidden" id="mod_gb"/>	
	
				
</form:form>
