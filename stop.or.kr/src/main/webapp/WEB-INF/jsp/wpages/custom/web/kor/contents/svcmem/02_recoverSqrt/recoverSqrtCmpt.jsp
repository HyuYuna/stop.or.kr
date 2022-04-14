<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<form:form name="reqForm" method="post" commandName="memberVO">


			<!-- content area -->
			<section id="content"> 
				<h1 class="stitle"><img src="${pageContext.request.contextPath}/images/custom/title/title08_01.gif" alt="회원마당" /></h1>
				<p class="location"><img src="${pageContext.request.contextPath}/images/custom/common/icon_home.gif" alt="홈"/>
					 <img src='${pageContext.request.contextPath}/images/custom/common/location_arrow.gif' alt='&gt;'/> 누리집안내 <img src='${pageContext.request.contextPath}/images/custom/common/location_arrow.gif' alt='&gt;'/> 회원마당 <img src='${pageContext.request.contextPath}/images/custom/common/location_arrow.gif' alt='&gt;'/> <span class="current">비밀번호 찾기</span>
				</p>
			
		        <article id="detail_content">
					
					
					
					<table class="tstyle_write" summary="비밀번호 찾기시 아이디, 이름, 휴대폰, 인증번호 입력">
						<caption>
							비밀번호 찾기
						</caption>
						<colgroup>
							<col width="150" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><label for="uid">패스워드 정보</label></th>
								<td>
									<c:if test="${empty findVO}">
										<div>입력하신 정보와 일치하는 정보가 없습니다.</div>
									</c:if>
									<c:if test="${not empty findVO}">
										<div>회원님의 휴대폰으로 임시 비밀번호가 발송되었습니다.</div>
									</c:if>
								</td>
							</tr>
						</tbody>
					</table>			
					
					<div class="btn_area_right">		
						<c:choose>
							<c:when test="${empty findVO}">
								<span class="btn_basic"><a href="javascript:history.back()"><img src="${pageContext.request.contextPath}/images/custom/button/btn_pwSearch.gif" alt="비밀번호 찾기"/></a></span> 
							</c:when>
							<c:otherwise>
								<span class="btn_basic"><a href="javascript:close()"><img src="${pageContext.request.contextPath}/images/custom/button/btn_login02.gif" alt="로그인" /></a></span>
							</c:otherwise>
						</c:choose>
					</div>
					
				</article>
				<!-- //detail content -->      
						
			</section>
			<!-- //content area --> 





</form:form>