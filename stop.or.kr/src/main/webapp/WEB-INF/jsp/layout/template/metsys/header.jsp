<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ page import="java.util.*" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page import="egovframework.plani.template.man.menuctgry.vo.SysmenuVO" %>
<%@ page import="egovframework.plani.template.man.menuctgry.service.SysmenuService" %>
<%@ page import="egovframework.plani.template.man.menuctgry.web.SyscodeController" %>
<%@ page import="egovframework.plani.template.cmm.utils.*" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>
<%@ page import="java.net.InetAddress" %>

<h1 class="logo"><img src="${pageContext.request.contextPath}/images/template/cmm/logo.png"/></h1>
<p class="leftMenu_hidden hide" id="btnPNavigation"><button type="button">Toggle navigation</button></p>

<div>
	<li class="auto_logout_time" style="width:100%">자동 로그아웃까지 <font color='red'>60분 0초</font> 남았습니다.</li>
	<li><a href="#" id="reset_time">[연장]</a></li>	
</div>

<div class="goto_link">	
	<span class="ip">IP: <%=request.getRemoteAddr()%></span>
	<span class="login_time">LOGIN: ${SESS_USR_LAST_LOGIN}</span>
	<span class="logout_time">LOGOUT: ${SESS_USR_LAST_LOGOUT}</span>
	<span class="home"><a href="${pageContext.request.contextPath}/contents/siteMain.do" target="_blank" title="포탈메인 새창으로 열림">포탈메인</a></span>
	<span class="logout"><a href="${cutil:getUrl('/metsys/metsysLogout.do', '', false)}" onclick="if(confirm('로그아웃 하시겠습니까?')==false){return false;}">로그아웃</a></span>
</div>
