<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>국립대구박물관 미리보기</title>

<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="keywords" content="국립대구박물관" />
<meta name="description" content="국립대구박물관" />
<meta name="copyright" content="Copyright 2013 국립대구박물관 all rights reserved." />
<!-- eGovFrame Common import -->

<link href="${pageContext.request.contextPath}/css/template/jquery/jquery-ui-1.9.2.custom.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/utils/fileupload/uploadify/uploadify.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/css/custom/kor/basic.css" rel="stylesheet" type="text/css"/>
<link href="${pageContext.request.contextPath}/css/template/cmmn/fileupload.css" rel="stylesheet"/>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
<script type="text/javascript"src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
<script type="text/javascript"src="${pageContext.request.contextPath}/js/plani/plani_common.js"></script>
<c:if test="${SESS_BRD_INFO.editor_gb eq 'D'}">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/hwp_common.js"></script>
</c:if>

<script type="text/javascript">
jQuery(document).ready(function(){
	
	cmmfn_remove_scrtag(jQuery("#divBrd_cont"));
	
	//이미지 크기 조정
	jQuery('div#divBrd_cont img').each(function(){		
		var bodyWidth = jQuery('#divBrd_cont').width();

		var imgWidth = jQuery(this).width();
		var imgHeight = jQuery(this).height();
		
		if(imgWidth - bodyWidth > 0){
			var reduceRate = bodyWidth / imgWidth;
			jQuery(this).width(bodyWidth);
			jQuery(this).height(imgHeight * reduceRate);
		}
	});
	
	<c:if test="${SESS_BRD_INFO.editor_gb eq 'D'}">
		fn_egov_load_hwpdata();
		var hwpctrl = document.getElementById("brd_cont");	
		hwpctrl.EditMode = 0;
	</c:if>
	
	function fn_egov_load_hwpdata()
	{
		var hwpctrl = document.getElementById("brd_cont");	
		var cont = jQuery("#brd_cont_base").val();
		hwpctrl.SetTextFile(cont, "HWP", "");
	}
});
</script>

</head>

<body>
	<div id="wrap"<c:if test="${SESS_BRD_INFO.editor_gb ne 'D'}"> style="height:700px;overflow-x:hidden;overflow-y:auto;"</c:if>>
		<div id="body_wrap">
			<div id="body" style="margin-left:50px;">
				<div id="divMainArticle">
					<section id="content">
						<article id="detail_content">
							<article class="news_view">
								<h1 class="newsTitle">타이틀</h1>
								<ul class="info_data">
									<li><span>글번호:</span> <span class="txt_bold">글번호</span>
									</li>
									<li><span>작성자:</span> 작성자</li>
									<li class="last"><span>작성일:</span> 작성일</li>
								</ul>
								<div class="view_content">
									<c:choose>
										<c:when test="${SESS_BRD_INFO.editor_gb eq 'D'}">
											<object id="brd_cont" style="LEFT: 0px; TOP: 0px" height="500" width="100%" classid="CLSID:BD9C32DE-3155-4691-8972-097D53B10052">
												<PARAM NAME="TOOLBAR_MENU" VALUE="FALSE">
												<PARAM NAME="TOOLBAR_STANDARD" VALUE="FALSE">
												<PARAM NAME="TOOLBAR_FORMAT" VALUE="FALSE">
												<PARAM NAME="SHOW_TOOLBAR" VALUE="FALSE">
												<PARAM NAME="SHOW_STATUSBAR" VALUE="TRUE">
											</object>
											<input type="hidden" id="brd_cont_base" name="brd_cont_base" value="<c:out value="${content}"/>" />
										</c:when>
										<c:otherwise>
											<div id="divBrd_cont" class="display_none">
												<c:out value="${content}" escapeXml="false"/>
											</div>
										</c:otherwise>
									</c:choose>
								</div> 
							</article>
						</article>
					</section>
				</div>
			</div>
		</div>
	</div>
</body>
</html>