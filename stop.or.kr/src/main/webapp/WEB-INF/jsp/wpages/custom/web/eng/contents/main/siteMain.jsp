<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


	<div id="visual">
	    <c:import url="/widgets/visual.do" >
				<c:param name="visual_cnt" value="3" />
				<c:param name="language" value="eng" />
				<c:param name="pop_type" value="E" />
			</c:import>
	  </div>
	  
	  <div id="contents">
		<article class="news">
			<h2>Global News Monitoring</h2>
			<c:import url="/widgets/board.do" >
				<c:param name="brd_id" value="BDIDX_udfB14x24a3HON35c674Z8" />
				<c:param name="menu_nix" value="rJ1hiGeU" />
				<c:param name="article_cnt" value="6" />
				<c:param name="language" value="eng" />
			</c:import>
			
			<a href="${pageContext.request.contextPath}/brdartcl/boardarticleList.do?brd_id=BDIDX_udfB14x24a3HON35c674Z8&srch_menu_nix=rJ1hiGeU&srch_mu_lang=CDIDX00023" class="more">more</a>
		</article>
		
		<%--<article class="twitter">
			<h2>STOP Sex Trafficking <span>@WHRCK</span></h2>
			<div class="item">
				<ul>
					<c:import url="/widgets/twitter.do" >
					</c:import>		
				</ul>
			</div>
			<a href="https://twitter.com/WHRCK" class="more" target="_blank">more</a>
		</article>--%>
		
		<article class="publication">
			<h2>WHRIK Publication </h2>
			
			<c:import url="/widgets/multiCms.do" >
				<c:param name="category" value="wp" />
				<c:param name="language" value="eng" />
			</c:import>
			
			<a href="${pageContext.request.contextPath}/multicms/multiCmsUsrList.do?category=wp&srch_menu_nix=cQdZfk88&srch_mu_lang=CDIDX00023" class="more">more</a>
		</article>
		
		<ul class="icon">
			<li>
				<a href="${pageContext.request.contextPath}/modedg/contentsView.do?ucont_id=CTX000071&srch_menu_nix=018DiIEV&srch_mu_lang=CDIDX00023">
					<span class="img"><img src="${pageContext.request.contextPath}/images/eng/main/icon1.gif" alt=""></span>
					<span class="txt">Greeting</span>
				</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/modedg/contentsView.do?ucont_id=CTX000072&srch_menu_nix=y6q3o9GZ&srch_mu_lang=CDIDX00023">
					<span class="img"><img src="${pageContext.request.contextPath}/images/eng/main/icon2.gif" alt=""></span>
					<span class="txt">Goals and Vision</span>
				</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/modedg/contentsView.do?ucont_id=CTX000078&srch_menu_nix=I04SKt12&&srch_mu_lang=CDIDX00023">
					<span class="img"><img src="${pageContext.request.contextPath}/images/eng/main/icon3.gif" alt=""></span>
					<span class="txt">History</span>
				</a>
			</li>
		</ul>
	  </div>