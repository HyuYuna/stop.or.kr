<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<form:form name="reqForm" method="post" commandName="memberVO">

<div id="contentWrap">	

	<!-- 컨텐츠영역 -->
	<h1 class="margin_bottom10"><img src="${pageContext.request.contextPath}/images/custom/kor/member/ptitle_id_search.gif" alt="아이디 찾기" /></h2>
	<p class="margin_bottom20">입력하신 정보와 일치하는 아이디는 다음과 같습니다.</p>
	<fieldset>
		<legend>아이디 찾기</legend>
		<table class="tstyle_member" summary="아이디 찾기시 이름, 이메일 입력">
			<caption>
				아이디 찾기
			</caption>
			<colgroup>
				<col width="170" />
				<col width="*" />
			</colgroup>
			<tbody>			
				<tr>
					<th scope="row"><label for="name">아이디</label></th>
					<td class="txt_left height_plus">
						
						<c:choose>
							<c:when test="${empty findVO}">
								일치하는 아이디가 없습니다.
							</c:when>
							<c:otherwise>
								<strong class="point_green font_14">${findVO.user_id}</strong>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>			
			</tbody>
		</table>
		<div class="btn_area_center">
			<span><a href="javascript:close()" class="btn_black_arrow">로그인</a></span> 
			<span><a href="javascript:fn_memsvc_pagemove('recoverScrt')" class="btn_black_arrow">비밀번호 찾기</a></span>
		</div>
	</fieldset>
	<!-- //컨텐츠영역-->
	
</div>
</form:form>	