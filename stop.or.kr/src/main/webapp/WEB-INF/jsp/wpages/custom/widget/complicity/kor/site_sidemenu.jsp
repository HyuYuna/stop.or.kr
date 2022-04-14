<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="i" value="1"/>




<div id="snb">
	<nav>
		<ul class="depth1">
<c:forEach var="sidemenu" items="${sidemenu}">
	<c:choose> 
		<c:when test="${sidemenu.value.blank_yn eq 'Y'}">
			<c:set var="target" value="_blank" />
		</c:when>
		<c:otherwise>
			<c:set var="target" value=""/>
		</c:otherwise>
	</c:choose>
	
	<c:choose> 
		<c:when test="${fn:indexOf(sidemenu.value.menu_link,'?') > 0}">
			<c:set var="tag_url" value="&"/>
		</c:when>
		<c:otherwise>
			<c:set var="tag_url" value="?"/>
		</c:otherwise>
	</c:choose>
	
	
	<c:choose>
		<c:when test="${fn:indexOf(sidemenu.value.menu_link,'srch_menu_nix=') < 0}">
			<c:set var="a_link" value="${pageContext.request.contextPath}${sidemenu.value.menu_link}${tag_url}srch_menu_nix=${sidemenu.value.menu_nix}"/>
		</c:when>
		<c:otherwise>
			<c:choose> 
				<c:when test="${sidemenu.value.menu_link eq 'UNDER_CONSTRUCT'}">
					<c:set var="a_link" value="javascript:fn_egov_under_construct()"/>
				</c:when>
				
				<c:otherwise>
					<c:set var="a_link" value="${pageContext.request.contextPath}${sidemenu.value.menu_link}${tag_url}"/>
				</c:otherwise>
			</c:choose>
		</c:otherwise>
	</c:choose>
	
	
	<c:if test="${i eq '1'}">
		<c:set var="i" value="2"/>
	</c:if>
	<!-- 
	<li class="active"><a href="${a_link}" target="${target}">${sidemenu.value.menu_nm}</a>
	 -->
	<c:if test="${!empty sidemenu.value._children_}">
	
		<c:forEach var="sub_menu" items="${sidemenu.value._children_}">
		<c:if test="${sub_menu.value.use_yn eq 'Y' }">
			<c:choose> 
			<c:when test="${sub_menu.value.blank_yn eq 'Y'}">
				<c:set var="target" value="_blank" />
			</c:when>
			<c:otherwise>
				<c:set var="target" value=""/>
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
				<c:when test="${sub_menu.value.menu_link eq 'UNDER_CONSTRUCT'}">
					<c:set var="a_link" value="javascript:fn_egov_under_construct()"/>
				</c:when>
				<c:otherwise>
					<c:set var="a_link" value="${pageContext.request.contextPath}${sub_menu.value.menu_link}${tag_url}srch_menu_nix=${sub_menu.value.menu_nix}"/>
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
							<c:set var="a_link" value="${pageContext.request.contextPath}${sub_menu.value.menu_link}${tag_url}"/>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
			
			
			
			<c:choose>
				<c:when test="${secondPathIdx == sub_menu.value.menu_idx}">
					<c:set var="activeClass" value="active"/>
				</c:when>
				<c:otherwise>
					<c:set var="activeClass" value=""/>
				</c:otherwise>
			</c:choose>
	
			<li class="${activeClass}"><a href="${a_link}" <c:if test="${!empty target}">target="${target}"</c:if>>${sub_menu.value.menu_nm}</a>
			
			
			<c:if test="${!empty sub_menu.value._children_}">
				<ul class="depth2">
				<c:forEach var="sub_menu_3depth" items="${sub_menu.value._children_}">
				<c:if test="${sub_menu_3depth.value.use_yn eq 'Y' }">
					<c:choose>
					<c:when test="${sub_menu_3depth.value.blank_yn eq 'Y'}">
						<c:set var="target" value="_blank" />
					</c:when>
					<c:otherwise>
						<c:set var="target" value=""/>
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
						<c:when test="${fn:indexOf(sub_menu_3depth.value.menu_link,'srch_menu_nix=') < 0}">
							<c:set var="a_link" value="${pageContext.request.contextPath}${sub_menu_3depth.value.menu_link}${tag_url}srch_menu_nix=${sub_menu_3depth.value.menu_nix}"/>
						</c:when>
						<c:otherwise>
							<c:choose> 
								<c:when test="${sub_menu_3depth.value.menu_link eq 'UNDER_CONSTRUCT'}">
									<c:set var="a_link" value="javascript:fn_egov_under_construct()"/>
								</c:when>
								
								<c:otherwise>
									<c:set var="a_link" value="${pageContext.request.contextPath}${sub_menu_3depth.value.menu_link}${tag_url}"/>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
					
					<c:choose>
						<c:when test="${thirdPathIdx == sub_menu_3depth.value.menu_idx}">
							<c:set var="thirdActiveClass" value="active"/>
						</c:when>
						<c:otherwise>
							<c:set var="thirdActiveClass" value=""/>
						</c:otherwise>
					</c:choose>
					
					
					<li class="${thirdActiveClass}"><a href="${a_link}" <c:if test="${!empty target}">target="${target}"</c:if>>${sub_menu_3depth.value.menu_nm}</a></li>
					</c:if>
				</c:forEach>
				</ul>
			</c:if>
			</li>
			</c:if>
		</c:forEach>
	</c:if>
</c:forEach>
		</ul>
	</nav>
</div>



<!-- 
	<div id="snb">
		<nav>
			<ul class="depth1">
				<li>
					<a href="sub4_1.jsp">소식</a>
					<ul class="depth2">
						<li><a href="sub4_1.jsp">진흥원소식</a></li>
						<li><a href="sub4_1_2.jsp">현장기관소식</a></li>
					</ul>
				</li>
				<li class="active">
					<a href="sub4_2.jsp">공지/공고</a>
					<ul class="depth2">
						<li class="active"><a href="sub4_2.jsp">공지사항</a></li>
						<li><a href="sub4_2_2.jsp">사업/입찰공고</a></li>
						<li><a href="sub4_2_3.jsp">채용공고</a></li>
						<li><a href="sub4_2_4.jsp">현장기관 채용공고</a></li>
					</ul>
				</li>
				<li>
					<a href="sub4_3.jsp">참여마당</a>
					<ul class="depth2">
						<li><a href="sub4_3.jsp">공모전</a></li>
						<li><a href="sub4_3_2.jsp">이벤트</a></li>
						<li><a href="sub4_3_3.jsp">설문조사</a></li>
					</ul>
				</li>
				<li><a href="sub4_4.jsp">여성인권달력</a></li>
			</ul>
		</nav>
	</div>
 -->
