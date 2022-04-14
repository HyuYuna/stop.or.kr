<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
					<c:when
						test="${fn:indexOf(SESS_BRD_INFO.brd_auth_usr, SESS_USR_ID) ge 0}">
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
			<c:when
				test="${SESS_USR_ID eq boardarticleVO.writer or SESS_USR_ID eq boardthmVO.writer or SESS_USR_ID eq boarddryVO.writer or SESS_USR_ID eq boardfaqVO.writer}">
				<!-- 자신이 작성한 글인 경우는 모든권한을 가짐 -->
				<%-- <c:set var="RWAUTH" value="RWD" scope="request"></c:set> --%>
				<c:set var="RWAUTH" value="RWD" scope="request"></c:set>
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when
						test="${SESS_USR_LV gt 10000 and SESS_BRD_INFO.off_viewmode eq 2}">
						<!-- 로그인하지 않은 사용자의 경우 익명 게시판의 쓰기권한을 가짐 -->
						<c:set var="RWAUTH" value="RWD" scope="request"></c:set>
					</c:when>
					<c:when
						test="${SESS_USR_LV gt 1000 and SESS_USR_LV le 10000 and SESS_BRD_INFO.on_viewmode eq 2}">
						<!-- 로그인한 사용자의 경우 일반 게시판의 쓰기권한을 가짐 -->
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
var lg_use_uploadify = "<c:out value="${SESS_BRD_INFO.use_uploadify}"/>";
var lg_use_ctgry = "<c:out value="${SESS_BRD_INFO.use_ctgry}"/>";
var lg_reply_gb = "<c:out value="${SESS_BRD_INFO.reply_gb}"/>";
var lg_ulv = "<c:out value="${SESS_USR_LV}"/>" == "" ? 10001 : parseInt("<c:out value="${SESS_USR_LV}"/>"); 
var lg_on_viewmode = "<c:out value="${SESS_BRD_INFO.on_viewmode}"/>";
var lg_off_viewmode = "<c:out value="${SESS_BRD_INFO.off_viewmode}"/>";
var lg_atch_ctlimit = "<c:out value="${SESS_BRD_INFO.attach_cnt_limit}"/>" == "" ? 0 : parseInt("<c:out value="${SESS_BRD_INFO.attach_cnt_limit}"/>");
var lg_atch_szlimit = "<c:out value="${SESS_BRD_INFO.attach_size_limit}"/>" == "" ? 0 : parseInt("<c:out value="${SESS_BRD_INFO.attach_size_limit}"/>");
var lg_atch_cnt = "<c:out value="${atchfileListCount}"/>" == "" ? 0 : parseInt("<c:out value="${atchfileListCount}"/>"); 
var lg_rcmnd_cnt = "<c:out value="${rcmndCnt}"/>" == "" ? 0 : parseInt("<c:out value="${rcmndCnt}"/>"); 
var lg_rjct_cnt = "<c:out value="${rjctCnt}"/>" == "" ? 0 : parseInt("<c:out value="${rjctCnt}"/>"); 


jQuery(document).ready(function(){

	fn_egov_init_brdeditor();
	
});


</script>