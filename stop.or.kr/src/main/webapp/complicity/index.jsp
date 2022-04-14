<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.plani.template.cmm.utils.EgovWebUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="remoteos" value="<%=EgovWebUtil.getRemoteOS(request)%>"/>
<%-- 2018-07-30 pigcos : 공모전 메인 --%> 
<c:choose>
	<c:when test="${remoteos eq 'IOS' or remoteos eq 'Android'}">
		<jsp:forward page="/contents/complicityMain.do?srch_mu_site=CDIDX00004"/>
	</c:when>
	<c:otherwise>
		<jsp:forward page="/contents/complicityMain.do?srch_mu_site=CDIDX00004"/>
	</c:otherwise>
</c:choose>