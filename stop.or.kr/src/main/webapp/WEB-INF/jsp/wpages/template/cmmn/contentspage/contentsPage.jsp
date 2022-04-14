<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!--   ## TPCODE : TPAGE0020: 컨텐츠 페이지 ## --> 

<c:if test="${param.srch_menu_nix ne 'twGjDnop'}">
<c:if test="${contentsmanVO.ucont_id eq 'CTX000019'}">
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ekropqh97o"></script>
</c:if>
<form name="reqForm" method="post">
</c:if>	
	<div id="detail_content">
		<div id="divUcont_cont">
			${elfunc:removeScrtag(contentsmanVO.ucont_cont)}
		</div>
	</div>
<c:if test="${param.srch_menu_nix ne 'twGjDnop'}">
</form>
</c:if>
<c:if test="${contentsmanVO.ucont_id eq 'CTX000019'}">
<script>
var map = new naver.maps.Map('map', {
    center: new naver.maps.LatLng(37.56092, 126.96701),
    zoom: 17
});

var marker = new naver.maps.Marker({
    position: new naver.maps.LatLng(37.56092, 126.96701),
    map: map
});
</script> 
</c:if>
<!-- 2. 설치 스크립트 -->
<!-- script charset="UTF-8" class="daum_roughmap_loader_script" src="http://dmaps.daum.net/map_js_init/roughmapLoader.js"></script-->

<!-- 3. 실행 스크립트 -->
<!--<script charset="UTF-8">
	new daum.roughmap.Lander({
		"timestamp" : "1530511617413",
		"key" : "ouby",
		"mapWidth" : "990",
		"mapHeight" : "520"
	}).render();
</script>-->

<!-- 20200727 -->
<!-- 2. 설치 스크립트 
<script type="text/javascript" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
-->
<!-- 3. 실행 스크립트 
<script type="text/javascript">
	new daum.roughmap.Lander({
		"timestamp" : "1535970383319",
		"key" : "pt9x",
		"mapWidth" : "990",
		"mapHeight" : "520"
	}).render();
</script>-->
<!--// 20200727 -->