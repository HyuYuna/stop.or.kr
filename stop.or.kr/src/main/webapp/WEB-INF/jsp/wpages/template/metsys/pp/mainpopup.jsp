<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="keywords" content="${SESS_PROP_PRJTNM}" />
<meta name="description" content="${SESS_PROP_PRJTNM}" />
<meta name="author" content="㈜플랜아이 1644-5580" />
<meta name="copyright" content="COPYRIGHT@ 2013 ${SESS_PROP_PRJTNM} ALL RIGHTS RESERVED." />
<title>${elfunc:UTF8Decode(param.pop_title)}</title>

<style>
body{
	padding : 0;
	margin : 0;
}

.popstyle {
	vertical-align : bottom;
	text-align : center;	
}	
.chkstyle {
	padding : 8px 5px 0 0; 
	text-align : right;	
	font-size : 0.8em;
}	
</style>


<link rel="stylesheet" href="${pageContext.request.contextPath}/css/template/metsys/table.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/template/cmmn/jquery-ui-1.9.2.custom.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/utils/datepicker/css/datepicker.css" />

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-ui-1.9.2.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/plani_common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/utils/datepicker/js/datepicker.js"></script>

<script type="text/javascript">

jQuery(document).ready(function(){
	bw = cmmfn_str_trim(cmmfn_get_browserinfo());
		
	var win_w = "${param.pop_w}" == "" ? jQuery("#imgPopupMan").width() : parseInt("${param.pop_w}");
	var win_h = "${param.pop_h}" == "" ? jQuery("#imgPopupMan").height() : parseInt("${param.pop_h}");

	jQuery("#imgPopupMan").prop('width', win_w);
	jQuery("#imgPopupMan").prop('height', win_h);
	
	if(bw == "Netscape 5")
	{
		win_w += 2;
		win_h += 10;
	}
	
	window.resizeTo(win_w + 15, win_h + 70);
	
	
	
	jQuery("input[id^='chkNoopen_']").click(function(){
		
		var ckey = $(this).attr("id").replace(/chkNoopen_/g, "");
		ckey = "CKPOP_PLANI_IDX_" + ckey;
		ckey = ckey.toUpperCase();
		
		if($(this).prop('checked') == true)
		{
			cmmfn_set_cookie("CKPOP_IDX_" + ckey, "N", 1);
		}
		else
		{
			cmmfn_set_cookie("CKPOP_IDX_" + ckey, "Y", 1);
		}
		window.close();
	});
	
	
});
</script>

</head>
<body>

<div id="divPopupMan" class="popstyle">

	<c:choose>
		<c:when test="${empty param.pop_link}">
			<img id="imgPopupMan" 
				src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?atckey_1st=POPUP&atckey_2nd=${param.atckey_2nd}&atckey_3rd=${param.atckey_3rd}&atckey_4th=${param.atckey_4th}&vchkcode=${param.vchkcode}"
				class="popstyle"/>
		</c:when>
		<c:otherwise>
			<c:choose>
				<c:when test="${empty param.pop_target}">
					<img id="imgPopupMan" 
						src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?atckey_1st=POPUP&atckey_2nd=${param.atckey_2nd}&atckey_3rd=${param.atckey_3rd}&atckey_4th=${param.atckey_4th}&vchkcode=${param.vchkcode}"
						class="popstyle"/>
				</c:when>
				<c:otherwise>
					<a href="${pageContext.request.contextPath}/${param.pop_link}" target="${param.pop_target}">
						<img id="imgPopupMan" 
							src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?atckey_1st=POPUP&atckey_2nd=${param.atckey_2nd}&atckey_3rd=${param.atckey_3rd}&atckey_4th=${param.atckey_4th}&vchkcode=${param.vchkcode}"
							class="popstyle"/>
					</a>
				</c:otherwise>
			</c:choose>
		</c:otherwise>
	</c:choose>
	<br/>
</div>

<div class="chkstyle">
	<input type="checkbox" id="chkNoopen_${param.atckey_2nd}"><label for="chkNoopen_${param.atckey_2nd}">하루 동안 열지않음</label><!-- 1일간 열지않음  -->
</div>
</body>
</html>