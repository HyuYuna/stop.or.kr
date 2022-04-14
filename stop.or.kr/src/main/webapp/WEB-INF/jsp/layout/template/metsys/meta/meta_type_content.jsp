<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="keywords" content="${SESS_PROP_PRJTNM}" />
<meta name="description" content="${SESS_PROP_PRJTNM}" />
<meta name="copyright" content="Copyright 2013 ${SESS_PROP_PRJTNM} all rights reserved." />
<!-- eGovFrame Common import -->        

<c:if test="${SESS_BRD_INFO.brd_gb eq 'D'}">
	<link href="${pageContext.request.contextPath}/css/template/jquery/fullcalendar.css" rel="stylesheet"/>
	<link href="${pageContext.request.contextPath}/css/template/jquery/fullcalendar.print.css" rel="stylesheet"/>
	<link href="${pageContext.request.contextPath}/css/template/jquery/jquery.treetable.css" rel="stylesheet"/>
</c:if>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/template/jquery/ui.jqgrid.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/template/metsys/basic.css"  />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/template/jquery/jquery.treetable.css"  />
<link rel="stylesheet" href="${pageContext.request.contextPath}/utils/datepicker/css/datepicker.css" />

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-ui-1.9.2.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/plugin/jquery.alphanumeric.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/_cmmn/plani_common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/_cmmn/plani_brd_content.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/_cmmn/plani_gen.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/plugin/jquery.treetable.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/utils/datepicker/js/datepicker.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/plugins/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/plugins/jquery-plani.ajax_form_submit.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/metsys_common.js"></script>

<c:if test="${SESS_BRD_INFO.brd_gb eq 'D'}">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/plugin/fullcalendar.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/plugin/jquery.ui.timepicker.js"></script>
</c:if>
<c:if test="${param.srch_menu_nix eq 'Ap778PvY' or param.srch_menu_nix eq '9afxGvI7' or param.srch_menu_nix eq '3pDGzrP5'}">
<!-- Google Chart library -->
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
</c:if>

<%-- <c:if test="${(param.srch_menu_nix eq 'zumNR6AM' and param.seltab_idx eq '1') or param.srch_menu_nix eq 'h92HwHjt'}"> --%>
	<!-- 권한 관리 사용 -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/plugin/jquery.jqGrid.src.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/plugin/i18n/grid.locale-en.js"></script>
<%-- </c:if> --%>

<!-- ▼아래는 IE9 보다 버전이 낮은 브라우저에서만 이 스크립트를 해석하도록 한 것 -->
<!--[if IE]>
 <script src="${pageContext.request.contextPath}/js/plani/html5.js" ></script> 
 <script src="${pageContext.request.contextPath}/js/plani/ie_print.js" ></script> 
<![endif]-->
