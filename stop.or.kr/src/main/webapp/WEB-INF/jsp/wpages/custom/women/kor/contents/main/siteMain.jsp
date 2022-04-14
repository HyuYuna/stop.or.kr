<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
Calendar cal = Calendar.getInstance() ;
pageContext.setAttribute("month", cal.get(Calendar.MONTH)+1);
%>
<!-- 상세콘텐츠 영역 -->
<article class="state">
	<div class="desc">
		<h2>
			<span class="point3">2018년 연간,</span>
			여성폭력 피해지원 현황
		</h2>
		<%-- <p class="btns">
			<a href="">상담실적 바로가기</a>
			<a href="${pageContext.request.contextPath}/map/mapList.do?srch_menu_nix=764j6O0Q&srch_mu_site=CDIDX00005">지원기관 바로가기</a>
		</p> --%>
	</div>
	
	<ul class="list">
		<li>
			<p><strong>352,269</strong>건</p>
			<span>여성긴급전화 <br />1366 상담</span>
		</li>
		<li>
			<p><strong>398,690</strong>건</p>
			<span>해바라기센터 지원</span>
		</li>
		<li>
			<p><strong>130,673</strong>건</p>
			<span>성매매피해자지원기관 지원</span>
		</li>
		<li>
			<p><strong>33,921</strong>건</p>
			<span>디지털성범죄 <br />피해자지원센터 지원</span>
		</li>
		<li>
			<p><strong>2,764</strong>건</p>
			<span>성희롱·성폭력 신고센터 지원</span>
		</li>
	</ul>
</article>

<article class="know">
	<div class="title">
		<h2>
			<span>Zoom-in</span>
			여성폭력이란?
		</h2>
		<a href="${pageContext.request.contextPath}/modedg/contentsView.do?ucont_id=CTX000064&srch_menu_nix=QIuR8Qcp&srch_mu_site=CDIDX00005">자세히 알아보기</a>
	</div>
	<ul>
		<li>
			<a href="${pageContext.request.contextPath}/modedg/contentsView.do?ucont_id=CTX000064&srch_menu_nix=QIuR8Qcp&srch_mu_site=CDIDX00005">
				<img src="${pageContext.request.contextPath}/images/kor/zoomin/know1.png" alt="" /><br />
				<span>가정폭력</span>
			</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/modedg/contentsView.do?ucont_id=CTX000065&srch_menu_nix=zYCE5436&srch_mu_site=CDIDX00005">
				<img src="${pageContext.request.contextPath}/images/kor/zoomin/know2.png" alt="" /><br />
				<span>스토킹·데이트폭력</span>
			</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/modedg/contentsView.do?ucont_id=CTX000066&srch_menu_nix=O93IuxI8&srch_mu_site=CDIDX00005">
				<img src="${pageContext.request.contextPath}/images/kor/zoomin/know3.png" alt="" /><br />
				<span>성폭력·성희롱</span>
			</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/modedg/contentsView.do?ucont_id=CTX000067&srch_menu_nix=c88CaE30&srch_mu_site=CDIDX00005">
				<img src="${pageContext.request.contextPath}/images/kor/zoomin/know4.png" alt="" /><br />
				<span>성매매</span>
			</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/modedg/contentsView.do?ucont_id=CTX000068&srch_menu_nix=5hpWUOqC&srch_mu_site=CDIDX00005">
				<img src="${pageContext.request.contextPath}/images/kor/zoomin/know5.png" alt="" /><br />
				<span>디지털성폭력</span>
			</a>
		</li>
	</ul>
</article>


