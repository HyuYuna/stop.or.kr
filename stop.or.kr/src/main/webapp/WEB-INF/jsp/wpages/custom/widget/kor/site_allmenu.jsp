<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:forEach var="menu" items="${menu}">
	<c:if test="${menu.value.use_yn eq 'Y' }">
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
			<c:when test="${fn:indexOf(menu.value.menu_link,'srch_menu_nix=') < 0}">
				<c:set var="a_link" value="${pageContext.request.contextPath}${menu.value.menu_link}${tag_url}srch_menu_nix=${menu.value.menu_nix}"/>
				<c:if test="${menu.value.menu_idx eq 'MNIDX02008'}">
					<c:set var="a_link" value="${pageContext.request.contextPath}${menu.value.menu_link}"/>
				</c:if>
			</c:when>
			<c:otherwise>
				<c:choose> 
					<c:when test="${menu.value.menu_link eq 'UNDER_CONSTRUCT'}">
						<c:set var="a_link" value="javascript:fn_egov_under_construct()"/>
					</c:when>
					<c:otherwise>
						<c:set var="a_link" value="${pageContext.request.contextPath}${menu.value.menu_link}"/>
					</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>				
		<li><a href="${a_link}" target="${target}">${menu.value.menu_nm}</a>
		<c:if test="${!empty menu.value._children_}">
			<div class="depth2">
				<ul>
					<c:forEach var="sub_menu" items="${menu.value._children_}">
						<c:if test="${sub_menu.value.use_yn eq 'Y' }">
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
								<c:when test="${fn:indexOf(sub_menu.value.menu_link,'srch_menu_nix=') < 0}">
									<c:set var="a_link" value="${pageContext.request.contextPath}${sub_menu.value.menu_link}${tag_url}srch_menu_nix=${sub_menu.value.menu_nix}"/>
								</c:when>
								<c:otherwise>
									<c:choose> 
										<c:when test="${sub_menu.value.menu_link eq 'UNDER_CONSTRUCT'}">
											<c:set var="a_link" value="javascript:fn_egov_under_construct()"/>
										</c:when>
										
										<c:otherwise>
											<c:set var="a_link" value="${pageContext.request.contextPath}${sub_menu.value.menu_link}"/>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
					
					
					
							<li <c:if test="${sub_menu.value.menu_nix eq param.srch_menu_nix}">class="bgcolor1 color1"</c:if>><a href="${a_link}" target="${target}">${sub_menu.value.menu_nm}<c:if test="${target eq '_blank'}">&nbsp;&nbsp;<img src="../../images/kor/main/icon-open.jpg" alt="새창열림"/></c:if></a>
							
							
							<c:if test="${!empty sub_menu.value._children_}">
								<ul class="depth3 bul1">
									<c:forEach var="sub_menu_3depth" items="${sub_menu.value._children_}">
										<c:if test="${sub_menu_3depth.value.use_yn eq 'Y' }">
											<c:choose>
											<c:when test="${sub_menu_3depth.value.blank_yn eq 'Y'}">
												<c:set var="target" value="_blank"/>
											</c:when>
											<c:otherwise>
												<c:set var="target" value="_self"/>
											</c:otherwise>
											</c:choose>
											
											<c:choose>
											<c:when test="${fn:indexOf(sub_menu_3depth.value.menu_link,'?') > 0}">
												<c:set var="tag_url" value="&"/>
											</c:when>
											<c:otherwise>
												<c:set var="tag_url" value="?"/>
											</c:otherwise>
											</c:choose>
											
											<c:choose> 
												<c:when test="${sub_menu_3depth.value.menu_link eq 'UNDER_CONSTRUCT'}">
													<c:set var="a_link" value="javascript:fn_egov_under_construct()"/>
												</c:when>
												<c:otherwise>
													<c:set var="a_link" value="${pageContext.request.contextPath}${sub_menu_3depth.value.menu_link}${tag_url}srch_menu_nix=${sub_menu_3depth.value.menu_nix}" />
												</c:otherwise>
											</c:choose>
											<li <c:if test="${sub_menu_3depth.value.menu_nix eq param.srch_menu_nix}">class="bgcolor1 color1"</c:if>><a href="${a_link}" target="${target}">${sub_menu_3depth.value.menu_nm}<c:if test="${target eq '_blank'}">&nbsp;&nbsp;<img src="../../images/kor/main/icon-open.jpg" alt="새창열림"/></c:if></a></li>
											<!-- 
											<c:if test="${!empty sub_menu_3depth.value._children_}">
												<ul class="4_depth">
													<c:forEach var="sub_menu_4depth" items="${sub_menu_3depth.value._children_}" varStatus="status4">
														<c:choose>
														<c:when test="${sub_menu_4depth.value.blank_yn eq 'Y'}">
															<c:set var="target" value="_blank"/>
														</c:when>
														<c:otherwise>
															<c:set var="target" value=""/>
														</c:otherwise>
														</c:choose>
														
														<c:choose>
														<c:when test="${fn:indexOf(sub_menu_4depth.value.menu_link,'?') > 0}">
															<c:set var="tag_url" value="&"/>
														</c:when>
														<c:otherwise>
															<c:set var="tag_url" value="?"/>
														</c:otherwise>
														</c:choose>
														
														<c:choose> 
															<c:when test="${sub_menu_4depth.value.menu_link eq 'UNDER_CONSTRUCT'}">
																<c:set var="a_link" value="javascript:fn_egov_under_construct()"/>
															</c:when>
															<c:otherwise>
																<c:set var="a_link" value="${pageContext.request.contextPath}${sub_menu_4depth.value.menu_link}${tag_url}srch_menu_nix=${sub_menu_4depth.value.menu_nix}"/>
															</c:otherwise>
														</c:choose>
														<li><a href="${a_link}" target="${target}">${sub_menu_4depth.value.menu_nm}</a></li>
													</c:forEach>
												</ul>
											</c:if>
											-->
										</c:if>
									</c:forEach>
								</ul>
							</c:if>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</div>
		</c:if>
		</li>
	</c:if>
</c:forEach>