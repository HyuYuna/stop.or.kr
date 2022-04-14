<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>




<h1 class="cont-title">${path.get(path.size()-1).menu_nm}</h1>
<div class="path">
	<a href="${pageContext.request.contextPath}/"><span class="home"><i class="xi-home">홈</i></span></a>
	
	<div class="group depth1">
		<p class="label"><a href="#">${path.get(0).menu_nm}<span>펼치기</span></a></p>
		<ul>
			<c:forEach var="menu" items="${menu}">
			<c:if test="${menu.value.use_yn eq 'Y'}">
				<c:choose> 
					<c:when test="${menu.value.blank_yn eq 'Y'}">
						<c:set var="target" value="_blank"/>
					</c:when>
					<c:otherwise>
						<c:set var="target" value="_self"/>
					</c:otherwise>
				</c:choose>
			
				<c:choose> 
					<c:when test="${fn:indexOf(menu.value.menu_link,'?') > 0}">
						<c:set var="tag_url" value="&"/>
					</c:when>
					<c:otherwise>
						<c:set var="tag_url" value="?"/>
					</c:otherwise>
				</c:choose>
			
				<c:choose> 
					<c:when test="${menu.value.menu_link eq 'UNDER_CONSTRUCT'}">
						<c:set var="a_link" value="javascript:fn_egov_under_construct()"/>
					</c:when>
					<c:otherwise>
						<c:set var="a_link" value="${pageContext.request.contextPath}${menu.value.menu_link}${tag_url}"/>
					</c:otherwise>
				</c:choose>
				
				<c:if test="${menu.value.menu_idx eq path.get(0).menu_idx}">
					<c:set var="secondList" value="${menu.value._children_}"/>
				</c:if>
			
				<li><a href="${a_link}" target="${target}">${menu.value.menu_nm}</a></li>
				</c:if>
			</c:forEach>
		</ul>
	</div>
	
	<div class="group depth2">
		<p class="label"><a href="#">${path.get(1).menu_nm}<span>펼치기</span></a></p>
		<!-- 2뎁스 메뉴 나오게 해주세여 -->
		<ul>
			<c:if test="${!empty secondList}">
					<c:forEach var="sub_menu" items="${secondList}">
					<c:if test="${sub_menu.value.use_yn eq 'Y'}">
						<c:choose> 
							<c:when test="${sub_menu.value.blank_yn eq 'Y'}">
								<c:set var="target" value="_blank"/>
							</c:when>
							<c:otherwise>
								<c:set var="target" value="_self"/>
							</c:otherwise>
							</c:choose>
							
							<c:choose>
								<c:when test="${fn:indexOf(sub_menu.value.menu_link,'?') > 0}">
									<c:set var="tag_url" value="&"/>
								</c:when>
								<c:otherwise>
									<c:set var="tag_url" value="?"/>
								</c:otherwise>
							</c:choose>
							
							<c:choose>
								<c:when test="${fn:indexOf(sub_menu.value.menu_link,'srch_menu_nix') > 0}">
									<c:set var="srch_menu_url" value=""/>
								</c:when>
								<c:otherwise>
									<c:set var="srch_menu_url" value="srch_menu_nix=${sub_menu.value.menu_nix}"/>
								</c:otherwise>
							</c:choose>
							
							<c:choose> 
								<c:when test="${sub_menu.value.menu_link eq 'UNDER_CONSTRUCT'}">
									<c:set var="a_link" value="javascript:fn_egov_under_construct()"/>
								</c:when>
								<c:otherwise>
									<c:set var="a_link" value="${pageContext.request.contextPath}${sub_menu.value.menu_link}${tag_url}"/>
								</c:otherwise>
						</c:choose>
						
						<li><a href="${a_link}${srch_menu_url}" target="${target}">${sub_menu.value.menu_nm}</a></li>
					</c:if>
					</c:forEach>
			</c:if>
		</ul>
	</div>
</div>
<div class="cont-util">
	<p class="sns">
		<a href="javascript:cmmfn_sns_send('facebook', '${nowMenuVO.menu_nm}', '${SESS_SNS_URL}', 80)" class="facebook" title="새창열림"><i class="xi-facebook"></i><span class="sr-only">페이스북</span></a>
		<a href="javascript:cmmfn_sns_send('twitter', '${nowMenuVO.menu_nm}', '${SESS_SNS_URL}', 80)" class="twiiter" title="새창열림"><i class="xi-twitter"></i><span class="sr-only">트위터</span></a>
		<a href="javascript:cmmfn_sns_send('naver', '${nowMenuVO.menu_nm}', '${SESS_SNS_URL}', 80)" class="blog" title="새창열림"><i class="xi-blogger"></i><span class="sr-only">블로그</span></a>
		<%-- <a href="javascript:cmmfn_sns_send('kakaostory', '${nowMenuVO.menu_nm}', '${SESS_SNS_URL}', 8080)" class="story"><i class="xi-kakaostory"></i><span class="sr-only">카카오스토리</span></a> --%>
		<!-- <a href="#" class="talk"><i class="xi-kakaotalk"></i><span class="sr-only">카카오톡</span></a> -->
	</p>

	<a href="javascript:window.print()" class="print"><i class="xi-print"></i><span class="sr-only">프린트</span></a>
</div>
<script>
$(function(){
	$(".path .group p a").click(function(){
		$(this).children().text("접기");
		if ($(".path .group").hasClass("active")) {
		  $(this).children().text("펼치기");
		}
	});
});
</script>































<!-- 
<ul class="path">
home >
<c:set var="i" value="1"/>
<c:set var="last" value="${path.size()}"/>
<c:forEach var="path" items="${path}">
${path.menu_nm } 
<c:if test="${last ne i }">
>
</c:if>
<c:set var="i" value="${i+1}"/>
</c:forEach>
</ul>
 -->