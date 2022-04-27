<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!--h1 class="logo"><a href="${cutil:url('/complicity/')}"><img src="${cutil:getUrl('/images/kor/contest/logo.png', '', false)}" alt="공모전" /></a></h1-->
<h1 class="logo"><a href="${cutil:url('/awards/list.do?groupId=IDX000016&srch_menu_nix=IMj03EC4&srch_mu_site=CDIDX00004')}"><img src="${cutil:getUrl('/images/kor/contest/logo-new.png', '', false)}" alt="공모전 수상작" /></a></h1>
<nav>
	<ul id="gnb">
		<c:import url="/SiteMenuWidget/menu.do" >
			<c:param name="use" value="Y"/>
		</c:import>	
	</ul>
</nav>
<div class="util">
	<span class="sns">
		<a href="https://www.facebook.com/wrstar" target="_blank" class="facebook">페이스북</a>
		<a href="https://twitter.com/whrik2009" target="_blank" class="twitter">트위터</a>
	</span>
	<!-- 20180822 추가 -->
	<a href="${pageContext.request.contextPath}/" class="go-link"><i class="xi-home"></i><span>진흥원 바로가기</span></a>
	<!-- //20180822 추가 -->
	
	<a href="#allmenu" class="all-menu">전체메뉴</a>
</div>
<article class="layerpopup" id="allmenu">
	<ul class="allmenu">
		<c:import url="/SiteMenuWidget/menu.do" >
			<c:param name="use" value="Y"/>
			<c:param name="type" value="site_allmenu"/>
			<c:param name="srch_mu_site" value="CDIDX00002"></c:param>
		</c:import>	
	</ul>
</article>

<%--
<article class="layerpopup" id="allmenu">
	<ul class="allmenu">
		<li>
			<a href="/html/kor/sub1/sub1_1.jsp">진흥원소개</a>
			<div class="depth2">
				<ul>
					<li><a href="/html/kor/sub1/sub1_1.jsp">인사말</a></li>
					<li><a href="/html/kor/sub1/sub1_2.jsp">목적 및 비전</a></li>
					<li><a href="/html/kor/sub1/sub1_3.jsp">연혁</a></li>
					<li><a href="/html/kor/sub1/sub1_4.jsp">조직도</a></li>
					<li><a href="/html/kor/sub1/sub1_5.jsp">CI</a></li>
					<li>
						<a href="/html/kor/sub1/sub1_6.jsp">윤리경영</a>
						<ul class="depth3 bul1">
							<li><a href="/html/kor/sub1/sub1_6.jsp">윤리헌장</a></li>
							<li><a href="/html/kor/sub1/sub1_6_2.jsp">윤리강령</a></li>
							<li><a href="/html/kor/sub1/sub1_6_3.jsp">행동강령</a></li>
						</ul>
					</li>
					<li>
						<a href="/html/kor/sub1/sub1_7.jsp">고객만족경영</a>
						<ul class="depth3 bul1">
							<li><a href="/html/kor/sub1/sub1_7.jsp">고객서비스 헌장</a></li>
							<li><a href="/html/kor/sub1/sub1_7_2.jsp">고객서비스 이행표준</a></li>
						</ul>
					</li>
					<li><a href="/html/kor/sub1/sub1_8.jsp">클린신고센터</a></li>
					<li><a href="/html/kor/sub1/sub1_9.jsp">오시는 길</a></li>
				</ul>
			</div>
		</li>
		<li>
			<a href="/html/kor/sub2/sub2_1.jsp">주요사업</a>
			<div class="depth2">
				<ul>
					<li>
						<a href="/html/kor/sub2/sub2_1.jsp">정책사업</a>
						<ul class="depth3 bul1">
							<li><a href="/html/kor/sub2/sub2_1.jsp">국제 네트워크 사업</a></li>
							<li><a href="/html/kor/sub2/sub2_1_2.jsp">연구·개발사업</a></li>
							<li><a href="/html/kor/sub2/sub2_1_3.jsp">포럼·토론회</a></li>
						</ul>
					</li>
					<li>
						<a href="/html/kor/sub2/sub2_2.jsp">현장지원사업</a>
						<ul class="depth3 bul1">
							<li><a href="/html/kor/sub2/sub2_2.jsp">현장기관 역량강화사업</a></li>
							<li><a href="/html/kor/sub2/sub2_2_2.jsp">현장기관 네트워크사업</a></li>
							<li><a href="/html/kor/sub2/sub2_2_3.jsp">피해자지원 실적 및 성과관리</a></li>
							<li><a href="/html/kor/sub2/sub2_2_4.jsp">피해자 직접지원사업</a></li>
						</ul>
					</li>
					<li>
						<a href="/html/kor/sub2/sub2_3.jsp">교육사업</a>
						<ul class="depth3 bul1">
							<li><a href="/html/kor/sub2/sub2_3.jsp">직무 관련 교육</a></li>
							<li><a href="/html/kor/sub2/sub2_3_2.jsp">현장기관 종사자 교육</a></li>
						</ul>
					</li>
					<li>
						<a href="/html/kor/sub2/sub2_4.jsp">홍보사업</a>
						<ul class="depth3 bul1">
							<li><a href="/html/kor/sub2/sub2_4.jsp">대국민 참여</a></li>
							<li><a href="/html/kor/sub2/sub2_4_2.jsp">대국민 인식개선</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</li>
		<li>
			<a href="/html/kor/sub3/sub3_1.jsp">정보공개</a>
			<div class="depth2">
				<ul>
					<li>
						<a href="/html/kor/sub3/sub3_1.jsp">경영공시</a>
						<ul class="depth3 bul1">
							<li><a href="/html/kor/sub3/sub3_1.jsp">정기/수시공시</a></li>
							<li><a href="/html/kor/sub3/sub3_1_2.jsp">사전공표목록</a></li>
							<li><a href="/html/kor/sub3/sub3_1_3.jsp">정보공개목록</a></li>
						</ul>
					</li>
					<li>
						<a href="/html/kor/sub3/sub3_2.jsp">정보공개제도</a>
						<ul class="depth3 bul1">
							<li><a href="/html/kor/sub3/sub3_2.jsp">정보공개제도 안내</a></li>
							<li><a href="/html/kor/sub3/sub3_2_2.jsp">정보공개청구</a></li>
						</ul>
					</li>
					<li><a href="/html/kor/sub3/sub3_3.jsp">사업실명제</a></li>
					<li><a href="/html/kor/sub3/sub3_4.jsp">공공데이터개방</a></li>
				</ul>
			</div>
		</li>
		<li>
			<a href="/html/kor/sub4/sub4_1.jsp">알림마당</a>
			<div class="depth2">
				<ul>
					<li>
						<a href="/html/kor/sub4/sub4_1.jsp">소식</a>
						<ul class="depth3 bul1">
							<li><a href="/html/kor/sub4/sub4_1.jsp">진흥원소식</a></li>
							<li><a href="/html/kor/sub4/sub4_1_2.jsp">현장기관소식</a></li>
						</ul>
					</li>
					<li>
						<a href="/html/kor/sub4/sub4_2.jsp">공지/공고</a>
						<ul class="depth3 bul1">
							<li><a href="/html/kor/sub4/sub4_2.jsp">공지사항</a></li>
							<li><a href="/html/kor/sub4/sub4_2_2.jsp">사업/입찰공고</a></li>
							<li><a href="/html/kor/sub4/sub4_2_3.jsp">채용공고</a></li>
							<li><a href="/html/kor/sub4/sub4_2_4.jsp">현장기관 채용공고</a></li>
						</ul>
					</li>
					<li>
						<a href="/html/kor/sub4/sub4_3.jsp">참여마당</a>
						<ul class="depth3 bul1">
							<li><a href="/html/kor/sub4/sub4_3.jsp">공모전</a></li>
							<li><a href="/html/kor/sub4/sub4_3_2.jsp">이벤트</a></li>
							<li><a href="/html/kor/sub4/sub4_3_3.jsp">설문조사</a></li>
						</ul>
					</li>
					<li><a href="/html/kor/sub4/sub4_4.jsp">여성인권달력</a></li>
				</ul>
			</div>
		</li>
		<li>
			<a href="/html/kor/sub5/sub5_1.jsp">네트워크</a>
			<div class="depth2">
				<ul>
					<li>
						<a href="/html/kor/sub5/sub5_1.jsp">현장네트워크</a>
						<ul class="depth3 bul1">
							<li><a href="/html/kor/sub5/sub5_1.jsp">기관정보</a></li>
							<li><a href="/html/kor/sub5/sub5_1_2.jsp">기관발간자료</a></li>
						</ul>
					</li>
					<li>
						<a href="/html/kor/sub5/sub5_2.jsp">국제네트워크</a>
						<ul class="depth3 bul1">
							<li><a href="/html/kor/sub5/sub5_2.jsp">기관정보</a></li>
							<li><a href="/html/kor/sub5/sub5_2_2.jsp">국외동향</a></li>
							<li><a href="/html/kor/sub5/sub5_2_3.jsp">국제네트워크 홈</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</li>
		<li>
			<a href="/html/kor/sub6/sub6_1.jsp">브리핑룸</a>
			<div class="depth2">
				<ul>
					<li><a href="/html/kor/sub6/sub6_1.jsp">뉴스레터</a></li>
					<li><a href="/html/kor/sub6/sub6_2.jsp">카드뉴스</a></li>
					<li><a href="/html/kor/sub6/sub6_3.jsp">보도자료</a></li>
					<li><a href="/html/kor/sub6/sub6_4.jsp">언론동향</a></li>
					<li><a href="/html/kor/sub6/sub6_5.jsp">채비포커스</a></li>
				</ul>
			</div>
		</li>
		<li>
			<a href="/html/kor/sub7/sub7_1.jsp">자료실</a>
			<div class="depth2">
				<ul>
					<li><a href="/html/kor/sub7/sub7_1.jsp">정기간행물</a></li>
					<li><a href="/html/kor/sub7/sub7_2.jsp">영상자료</a></li>
					<li><a href="/html/kor/sub7/sub7_3.jsp">발간자료</a></li>
					<li><a href="/html/kor/sub7/sub7_4.jsp">공모전작품</a></li>
					<li><a href="/html/kor/sub7/sub7_5.jsp">캠페인Kit</a></li>
				</ul>
			</div>
		</li>
		<li>
			<a href="/html/kor/sub8/sub8_1.jsp">여성폭력Zoomin</a>
			<div class="depth2">
				<ul>
					<li>
						<a href="/html/kor/sub8/sub8_1.jsp">여성폭력바로알기</a>
						<ul class="depth3 bul1">
							<li><a href="/html/kor/sub8/sub8_1.jsp">가정폭력</a></li>
							<li><a href="/html/kor/sub8/sub8_1_2.jsp">스토킹.데이트폭력</a></li>
							<li><a href="/html/kor/sub8/sub8_1_3.jsp">성폭력.성희롱</a></li>
							<li><a href="/html/kor/sub8/sub8_1_4.jsp">성매매</a></li>
							<li><a href="/html/kor/sub8/sub8_1_5.jsp">디지털성폭력</a></li>
						</ul>
					</li>
					<li><a href="/html/kor/sub8/sub8_2.jsp">지원기관</a></li>
					<li><a href="/html/kor/sub8/sub8_3.jsp">여성폭력동향</a></li>
					<li><a href="/html/kor/sub8/sub8_4.jsp">추천도서</a></li>
				</ul>
			</div>
		</li>
	</ul>
</article>
 --%>

<%--
<%/* 언어 설정만 필요한 경우 */%>
<c:set var="languageParam" value="srch_mu_lang=${param.srch_mu_lang}" />
<!--  ## TPCODE : TPAGE0002 : 헤더 ## -->
<h1 class="logo"><a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/images/kor/layout/logo.png" alt="한국여성인권진흥원" /></a></h1>

<nav>
	<ul id="gnb">
		<c:import url="/SiteMenuWidget/menu.do" >
			<c:param name="use" value="Y"/>
			<c:param name="srch_mu_site" value="CDIDX00005"/>
		</c:import>	
	</ul>
</nav>

<div class="util">
	<form:form name="search_form" id="search_form"  action="${pageContext.request.contextPath}/contents/mainTotalSearch.do" method="get">
		<div class="search">
			<p class="form">
				<input type="hidden" name="srch_menu_nix" value="3c76Sg13"/>
				<input type="text" name="searchKeyword" placeholder="검색어를 입력해주세요" title="검색어" value="<c:out value='${param.searchKeyword}'/>"/>
				<input type="hidden" name="searchType" value="CONT"/>
				<input type="submit" class="btn" value="검색"/>
			</p>
			<a href="#none" class="control open">검색</a>
		</div>
	</form:form>

	<p class="language">
		<a href="${pageContext.request.contextPath}/" class="active">한국어</a>
		<a href="">ENG</a>
	</p>
	<a href="#gnb" class="all-menu">전체메뉴</a>
</div>

 --%>

<%--

<h1 class="logo"></h1>
<article class="tsidemenu">
	<ul>
		<c:choose>
			<c:when test="${cutil:isLogin() == true}">
				<li><a href="javascript:fn_site_logout()">로그아웃</a></li>
				<li><a href="${cutil:getUrl('/svcmem/memUserInfo.do', languageParam, false)}">회원정보수정</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="${cutil:getUrl('/svcmem/siteLogin.do', languageParam, false)}">로그인 </a></li>
				<li><a href="${cutil:getUrl('/svcmem/memJoinForm.do', languageParam, false)}">회원가입</a></li>
			</c:otherwise>
		</c:choose>
		<li>
			<a href="javascript:fn_egov_tot_chk();"><img src="/images/custom/web/kor/common/btn_search.gif" alt="검색"></a>	
			<div class="popupSearch" style="display:none;">
				<input type="text" title="검색어입력" id="search-keyword" placeholder="검색어를 입력하세요">
				<input type="submit" onclick="fn_egov_tot_search()" value="SEARCH">
			</div>
		</li>
		<li><a href="${cutil:getUrl('/', '', false)}">국문</a></li>
		<li><a href="${cutil:getUrl('/', 'srch_mu_lang=CDIDX00023', false)}">영문</a></li>
	</ul>
</article>
<%-- <c:import url="/widgets/menu.do" >
	<c:param name="mu_site" value="CDIDX00002" />
	<c:param name="mu_lang" value="CDIDX00022" />
	<c:param name="srch_mu_gub" value="USR" />
</c:import>
<c:import url="/SiteMenuWidget/menu.do" >
	<c:param name="use" value="Y"/>
</c:import>
--%>