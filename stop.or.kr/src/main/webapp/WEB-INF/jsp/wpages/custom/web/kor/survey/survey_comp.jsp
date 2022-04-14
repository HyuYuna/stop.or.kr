<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>

<!doctype html>
<html lang="ko">

<head>
<c:import url="/WEB-INF/jsp/layout/custom/web/kor/cmm/metacmmn.jsp"/>

<title>설문조사 완료</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/template/cmmn/basic.css" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/template/cmmn/survey.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/utils/datepicker/css/datepicker.css" />


<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/html5.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-ui-1.9.2.custom.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/_cmmn/plani_common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/_cmmn/plani_gen.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/_cmmn/plani_auth.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/utils/datepicker/js/datepicker.js"></script>

<!--[if lt IE 9]>
<script src="${pageContext.request.contextPath}/js/jquery/core/html5.js" ></script> 
<![endif]-->

<script type="text/javascript">
jQuery(document).ready(function(){
	alert("설문이 완료되었습니다.\n설문에 응해주셔서 감사합니다.");
	window.close();
});
</script>

<body>

</body>
</html>
