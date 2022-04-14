<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>
	<c:out value="${SESS_PROP_PRJTNM}"/> : <tiles:insertAttribute name="previewTitle" ignore="true" />
</title>

<link href="${pageContext.request.contextPath}/css/cmmn/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css"/>
<link href="${pageContext.request.contextPath}/css/custom/web/kor/content.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-ui-1.9.2.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/plani_common.js"></script>


</head>

<body>

<div id="wrap">
	<section id="body">
		<!-- container-left -->
		<tiles:insertAttribute name="previewContent"/>
	</section>
</div>
		
</body>
</html>