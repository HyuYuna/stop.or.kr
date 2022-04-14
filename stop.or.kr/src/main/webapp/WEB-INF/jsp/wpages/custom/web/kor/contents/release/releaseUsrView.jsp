<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- <div class="box1">
	<span class="bg"><img src="/images/kor/sub/bg2.gif" alt=""></span>
	<p class="txt">
		한국여성인권진흥원의 성매매 방지, 여성·아동폭력 방지, 가정폭력 방지 등 여성인권 관련 다양한 사업내용을 국민들이 알 수 있도록 진흥원의 보유·관리 정보를 공개합니다.<br /><br />※ 공시주기 : 정기(매월), 최종수정일, 갱신예정일 : 익월 첫주 ~ 둘째주
	</p>
</div> -->

<div id="divMainArticle">
	<form:form name="reqForm" commandName="releaseVO">
		<div class="board-view">
			<h1 class="view-title">
				<c:if test="${empty releaseVO.rel_dept }">
					2020년 이전 공표 자료
				</c:if>
				<c:if test="${not empty releaseVO.rel_dept }">
					<c:out value="${releaseVO.rel_title}"/>
				</c:if>
			</h1>
			<ul class="info">
				<li><strong>공개시기</strong><c:out value="${releaseVO.rel_era }"/></li>
				<li><strong>공개주기</strong><c:out value="${releaseVO.rel_pblntf_cycle }"/></li>
			</ul>
			<div class="view-content">
				<p>${releaseVO.rel_content}</p>
			</div>
			<div class="download-list open-list">
				<p class="open-type">공개방법</p>
				<div class="open-box-wrap">
					<c:if test="${fn:trim(releaseVO.rel_mth) eq '2' }">
						<div>
							<strong class="title">첨부파일</strong>
							<ul>
								<c:forEach var="result" items="${atchfileList}" varStatus="status">
									<li>
										<%-- <div id="divAtcharea_${result.atckey_4th}" class="uploadify-queue-item">
											<div class="file_area"> --%>
												<%-- <img src="${pageContext.request.contextPath}/images/template/exticos/${elfunc:getImgicoByExt(result.fext)}.gif" width="16" height="16" alt="htp"/> --%>
												<%-- <a href="javascript:cmmfn_download_atchfile('${pageContext.request.contextPath}', '${result.vchkcode}')">${result.rname} (${result.size_mb}Mb)</a> --%>
												<a href="javascript:cmmfn_download_atchfile('${pageContext.request.contextPath}', '${result.vchkcode}')"><i class="xi-attachment"><span class="sr-only">Download</span></i>${result.rname} </a>
												<!-- <span class="data"></span> -->
											<!-- </div> 
										</div> -->
									</li>
								</c:forEach>
							</ul>
						</div>
					</c:if>
					<c:if test="${fn:trim(releaseVO.rel_mth) eq '1' }">
						<div>
							<strong class="title">URL</strong>
							<ul>
								<li><a href="<c:out value="${releaseVO.rel_url }"/>" target="_blank" title="새창열림"><c:out value="${releaseVO.rel_url }"/></a></li>
							</ul>
						</div>
					</c:if>
				</div>
			</div>

			<div class="open-list-damdang">
				<p class="title">담당자 정보</p>
				<ul>
					<li><strong>담당부서</strong><c:out value="${releaseVO.rel_dept }"/></li>
					<c:if test="${not empty releaseVO.rel_charger }"><li><strong>담당자</strong><c:out value="${releaseVO.rel_charger }"/></li></c:if>
					<c:if test="${not empty releaseVO.rel_cttpc }"><li><strong>연락처</strong><c:out value="${releaseVO.rel_cttpc }"/></li></c:if>
				</ul>
			</div>
		</div>
		<div class="btns txt-right">
			<a href="${pageContext.request.contextPath}/release/releaseUsrList.do?srch_menu_nix=${param.srch_menu_nix}" class="btn-m btn1">목록</a>
		</div>
	</form:form>
</div>