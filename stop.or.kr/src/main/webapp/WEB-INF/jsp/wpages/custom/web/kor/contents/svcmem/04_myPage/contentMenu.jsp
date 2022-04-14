<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<ul class="tab_menu menuCount5">
	<li id="liGbtabList01"<c:if test="${fn:startsWith(tgtact, 'member')==true}"> class="on"</c:if>><a href="${pageContext.request.contextPath}/mypage/memberInfo.do?srch_menu_nix=p20RQqzK">회원정보 수정</a></li>
	<li id="liGbtabList02"<c:if test="${fn:startsWith(tgtact, 'resvdApplGrp')==true}"> class="on"</c:if>><a href="${pageContext.request.contextPath}/mypage/resvdApplGrpList.do?srch_menu_nix=p20RQqzK">단체관람</a></li>
	<li id="liGbtabList03"<c:if test="${fn:startsWith(tgtact, 'resvdCulture')==true}"> class="on"</c:if>><a href="${pageContext.request.contextPath}/mypage/resvdCultureList.do?srch_menu_nix=p20RQqzK">우리문화체험실</a></li>
	<li id="liGbtabList04"<c:if test="${fn:startsWith(tgtact, 'resvdApplEdu')==true}"> class="on"</c:if>><a href="${pageContext.request.contextPath}/mypage/resvdApplEduList.do?srch_menu_nix=p20RQqzK">박물관교육</a></li>
	<li id="liGbtabList05"<c:if test="${fn:startsWith(tgtact, 'resvdEvent')==true}"> class="on"</c:if>><a href="${pageContext.request.contextPath}/mypage/resvdEventList.do?srch_menu_nix=p20RQqzK">문화행사</a></li>
</ul>