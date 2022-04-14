<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>


<!-- 상세콘텐츠 영역 -->
<div id="visual">
	<c:import url="/widgets/complicityVisual.do" >
		<c:param name="visual_cnt" value="1" />
	</c:import>
</div>

<article class="go">
	<!--div class="title">
		<h2>세상에는 거래할 수 없는 것이 있습니다</h2>
		<span>보다 나은 사회를 만들어가는 첫 걸음 입니다.</span>
	</div-->
	
	<ul>
		<!--li>
			<a href="${cutil:getUrl('/modedg/contentsView.do', 'ucont_id=CTX000062&srch_menu_nix=nZ5h0kWo', false)}">
				<img src="${cutil:url('/images/kor/contest/go1.gif')}" alt="" />
				<span>소개</span>
			</a>
		</li-->
		<li>
			<a href="${cutil:getUrl('/modedg/contentsView.do', 'ucont_id=CTX000058&srch_menu_nix=6a0c75Ak', false)}">
				<img src="${cutil:url('/images/kor/contest/go2.gif')}" alt="" />
				<span>공모요강</span>
			</a>
		</li>
		<li>
			<a href="${cutil:getUrl('/complicity/agree.do', 'srch_menu_nix=v03WS79x', false)}">
				<img src="${cutil:url('/images/kor/contest/go3.gif')}" alt="" />
				<span>접수하기</span>
			</a>
		</li>
		<li>
			<a href="${cutil:getUrl('/awards/list.do', 'groupId=IDX000012&srch_menu_nix=J2UKZKGV&srch_mu_site=CDIDX00004', false)}">
				<img src="${cutil:url('/images/kor/contest/go4.gif')}" alt="" />
				<span>자료실</span>
			</a>
		</li>
		<%--
		<li>
			<a href="${cutil:getUrl('/brdthm/boardthmList.do', 'brd_id=BDIDX_wrR6Y75NERer1TjATq005t&srch_menu_nix=da547j6T&srch_mu_site=', false)}" target="_blank">
				<img src="${cutil:url('/images/kor/contest/go5.gif')}" alt="" />
				<span>이벤트</span>
			</a>
		</li>
		 --%>
	</ul>
</article>
<!-- // -->

