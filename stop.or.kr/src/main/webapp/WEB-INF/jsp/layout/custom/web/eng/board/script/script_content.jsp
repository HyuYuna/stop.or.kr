<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!-- 쓰기권한이 있는지 체크  Start -->
<c:choose>
	<c:when test="${SESS_USR_LV le 1000}">
		<c:choose>
			<c:when test="${SESS_USR_LV le 2}">
				<!-- 총괄 관리자권한인 경우는 모든권한을 가짐 -->
				<c:set var="RWAUTH" value="RWD" scope="request"></c:set>
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${fn:indexOf(SESS_BRD_INFO.brd_auth_usr, SESS_USR_ID) ge 0}">
						<!-- 서브관리자인 경우는 게시판 권한이 주어진 경우에만 권한을 가짐 -->
						<c:set var="RWAUTH" value="RWD" scope="request"></c:set>
					</c:when>
					<c:otherwise>
						<c:set var="RWAUTH" value="R" scope="request"></c:set>
					</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${SESS_USR_ID eq boardarticleVO.writer or SESS_USR_ID eq boardthmVO.writer or SESS_USR_ID eq boarddryVO.writer or SESS_USR_ID eq boardfaqVO.writer}">
				<!-- 자신이 작성한 글인 경우는 모든권한을 가짐 -->
				<c:set var="RWAUTH" value="RWD" scope="request"></c:set>
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${SESS_USR_LV gt 10000 and SESS_BRD_INFO.off_viewmode eq 2}">
						<!-- 로그인하지 않은 사용자의 경우 익명 게시판의 쓰기권한을 가짐 -->
						<c:set var="RWAUTH" value="RW" scope="request"></c:set>
					</c:when>
					<c:when test="${SESS_USR_LV gt 1000 and SESS_USR_LV le 9998 and SESS_BRD_INFO.on_viewmode eq 2}">
						<!-- 로그인한 사용자(준회원 이상)의 경우 일반 게시판의 쓰기권한을 가짐 -->
						<c:set var="RWAUTH" value="RW" scope="request"></c:set>
					</c:when>
					<c:otherwise>
						<!-- 그외의 모든 경우 쓰기권한이 없음 -->
						<c:set var="RWAUTH" value="R" scope="request"></c:set>
					</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>
<!-- 쓰기권한이 있는지 체크  End -->

<!--
	페이지별로 들어가는 공통적인 명령에 대한 스크립트만 여기에 추가한다.
	ex) 메뉴 페이지 이동 스크립트 등..
	2013.04.16 bhhan
-->	
<script type="text/javascript">

var targetAct = "";
var targetGrp = "";

var lg_brd_id = "<c:out value="${SESS_BRD_INFO.brd_id}"/>";
var lg_brd_gb = "<c:out value="${SESS_BRD_INFO.brd_gb}"/>";
var lg_brd_gb_sub = "<c:out value="${SESS_BRD_INFO.brd_gb_sub}"/>";
var lg_editor_gb = "<c:out value="${SESS_BRD_INFO.editor_gb}"/>";
var lg_pgmode = "<c:out value="${param.edomweivgp}"/>";
var lg_use_atch = "<c:out value="${SESS_BRD_INFO.use_atch}"/>";
var lg_ulv = "<c:out value="${SESS_USR_LV}"/>" == "" ? 10001 : parseInt("<c:out value="${SESS_USR_LV}"/>"); 
var lg_off_viewmode = "<c:out value="${SESS_BRD_INFO.off_viewmode}"/>";
var lg_on_viewmode = "<c:out value="${SESS_BRD_INFO.on_viewmode}"/>";
var lg_rw_png = parseInt("${fn:length(RWAUTH)}");

jQuery(document).ready(function(){
	
	fn_egov_init_brdcontent();
});


function fn_egov_get_argstr()
{
	var argstr = "";
	var srch_ctgry_idx = "";
	var seltab_idx = "";
	var srch_mu_lang = "";
	
	if(cmmfn_exist_object("srch_ctgry_idx") == true)
		srch_ctgry_idx = jQuery("#srch_ctgry_idx").val();			
	else
		srch_ctgry_idx = "${param.srch_ctgry_idx}";

	if(cmmfn_exist_object("seltab_idx") == true)
		seltab_idx = jQuery("#seltab_idx").val();			
	else
		seltab_idx = "${param.seltab_idx}";

	if(cmmfn_exist_object("srch_mu_lang") == true)
		srch_mu_lang = jQuery("#srch_mu_lang").val();			
	else
		srch_mu_lang = "${param.srch_mu_lang}" == "" ? "" : "${param.srch_mu_lang}";
 
	/*
	if(cmmfn_exist_object("ctgry_idx") == false && srch_ctgry_idx != "")
		argstr += "&ctgry_idx=" + srch_ctgry_idx;
	*/
	
	if(cmmfn_exist_object("srch_mu_lang") == false && srch_mu_lang != "" && srch_mu_lang != "CDIDX00022")
		argstr += "&srch_mu_lang=" + srch_mu_lang;
	
	if(cmmfn_exist_object("srch_ctgry_idx") == false && srch_ctgry_idx != "")
		argstr += "&srch_ctgry_idx=" + srch_ctgry_idx;

	if(cmmfn_exist_object("seltab_idx") == false && seltab_idx != "")
		argstr += "&seltab_idx=" + seltab_idx;

	return argstr;
}

</script>