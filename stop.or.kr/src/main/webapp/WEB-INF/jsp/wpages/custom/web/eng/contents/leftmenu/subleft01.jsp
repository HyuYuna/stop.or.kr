<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<script type="text/javascript">
	jQuery(document).ready(function(){
		//왼쪽 메뉴 이미지 롤링
		var posterControl = jQuery('#poster_control').attr('id');
		/* if(typeof posterControl != "undefined"){
			
			var timer = setInterval(function () {
				fn_egov_poster_next();
			}, 5000);
		} */
	});
</script>

	<nav id="snavigation">
		<h2>
			<c:choose>
				<!-- 최상위 메뉴 표시  -->
				<c:when test="${not empty upmenu.left_img_path}"> 
					<img src="${pageContext.request.contextPath}${upmenu.left_img_path}" alt="${upmenu.menu_nm}" />
				</c:when>
				<c:otherwise>
					<c:out value="${upmenu.menu_nm}"/>
				</c:otherwise>
			</c:choose>
		</h2>
		<ul>
			<c:set var = "lv1cnt" value="0"/>
			<c:set var = "menuhref" value=""/>
			<c:forEach var="result" items="${submenuList}" varStatus="status">
				
				<c:choose>
					<c:when test="${elfunc:isStartsWith(result.menu_link, 'http') eq true}">
						<c:set var = "menuhref" value="${result.menu_link}"/>
					</c:when>
					<c:otherwise>
						<c:set var = "menuhref" value="${pageContext.request.contextPath}${result.menu_link}"/>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${result.blank_yn eq 'Y'}">
						<c:set var = "blank" value="target='_blank'"/>
					</c:when>
					<c:otherwise>
						<c:set var = "blank" value=""/>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${result.menu_lv eq 1}">
						<c:set var = "lv1cnt" value="${lv1cnt + 1}"/>
						<c:choose>
							<c:when test="${lastlv eq 1}">
									</li>
							</c:when>
							<c:when test="${lastlv eq 2}">
									</ul>
								</li>
							</c:when>
						</c:choose>
						
						<li id="lisublv1_${lv1cnt}">
							<c:choose>
								<c:when test="${not empty result.left_img_path}"> 
									<a id="aLmenu_${result.srch_menu_nix}" href="${menuhref}" ${blank}>
										<img id="imgLmenu_${result.srch_menu_nix}" src="${pageContext.request.contextPath}${result.left_img_path}" alt="${result.menu_nm}" />
									</a>
								</c:when>
								<c:otherwise>
									<a id="aLmenu_${result.srch_menu_nix}" href="${menuhref}" <c:out value="${clsactive}"/> ${blank}>${result.menu_nm}</a>
								</c:otherwise>
							</c:choose>
						
						<c:set var="lastlv" value="1"/>
					</c:when>
					<c:when test="${result.menu_lv eq 2}">
						<c:choose>
							<c:when test="${lastlv eq 1}">
								<ul class="depth3">
							</c:when>
						</c:choose>
						<li id="lisublv2_${lv1cnt}">
							<c:choose>
								<c:when test="${not empty result.left_img_path}"> 
									<a id="aLmenu_${result.srch_menu_nix}" href="${menuhref}" ${blank}>
										<img id="imgLmenu_${result.srch_menu_nix}" src="${pageContext.request.contextPath}${result.left_img_path}" alt="${result.menu_nm}" />
									</a>
								</c:when>
								<c:otherwise>
									<a id="aLmenu_${result.srch_menu_nix}" href="${menuhref}" <c:out value="${clsactive}"/> ${blank}>${result.menu_nm}</a>
								</c:otherwise>
							</c:choose>
						</li>

						<c:set var="lastlv" value="2"/>
					</c:when>
				</c:choose>
				<c:if test="${result.srch_menu_nix eq param.srch_menu_nix}">
					<input type="hidden" id="hid_menu_nm" value="${result.menu_nm}"/>
					<input type="hidden" id="hid_upmenu_nm" value="${upmenu.menu_nm}"/>
					<input type="hidden" id="hid_title_img" value="${result.title_img_path}"/>
					<input type="hidden" id="hid_info01_img" value="${result.info01_img_path}"/>
					<input type="hidden" id="hid_info02_img" value="${result.info02_img_path}"/>
					<input type="hidden" id="hid_own_info" value="${result.own_info}"/>
				</c:if>				
			</c:forEach>
		</ul>
	</nav>
