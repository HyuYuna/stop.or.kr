<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="egovframework.plani.template.atchfile.service.AtchfileService"%>
<%
	try{
		WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext());
		AtchfileService service = (AtchfileService)wac.getBean("atchfileService");
		service.uploadProc(request);
	}catch(Exception e){
		e.printStackTrace();	
	}
%>