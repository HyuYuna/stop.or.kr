<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>


<form:form name="reqForm" commandName="memberVO" enctype="multipart/form-data" class="ajax-form-submit">
	
<section id="content">
	
	<!-- path -->
	<p class="path">
		<span class="path_home"><img src="${pageContext.request.contextPath}/images/custom/web/kor/common/path_home.gif" alt="홈" /></span> 
		<span>멤버십</span><span class="path_current">회원가입</span>
	</p>
	<!-- //path -->
	
	<!-- stitle -->
	<h1 class="stitle">
		<c:choose>
			<c:when test="${cutil:isLogin() == true}">정보수정</c:when>
			<c:otherwise>회원가입</c:otherwise>
		</c:choose>
	</h1>
	<!-- //stitle -->
	
	<!-- detail_content -->
	<div id="detail_content">
				
		<!-- 페이지 작성 -->
		<h2 class="title_style_01">가입정보</h2>
		<p class="right"> <span class="point01">*</span> 항목은 필수입력 항목입니다.</p>
		<table class="table_style_01">
			<caption>가입정보 작성 표</caption>
			<tbody>
				<tr>
					<th scope="row">아이디</th>
					<td class="left">
						<c:choose>
							<c:when test="${cutil:isLogin() == true}">${memberVO.user_id}</c:when>
							<c:otherwise>
								<form:input path="user_id" />
								<a href="javascript:fn_egov_check_dupid()" class="btn_orange_m">중복확인</a>
								&nbsp;&nbsp;
								<span id="spanCheckidArea" class="point02"></span>
								<form:errors path="user_id" />
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<c:if test="${cutil:isLogin() != true}">
				<tr>
					<th scope="row">비밀번호</th>
					<td class="left">
						<form:password path="user_scrt" />
						<form:errors path="user_scrt" />
					</td>
				</tr>
				<tr>
					<th scope="row">패스워드 확인</th>
					<td class="left">
						<form:password path="user_scrt_confirm" />
						<form:errors path="user_scrt_confirm" />
					</td>
				</tr>
				</c:if>
				<tr>
					<th scope="row">이름</th>
					<td class="left">
						<c:choose>
							<c:when test="${cutil:isLogin() == true}">${memberVO.user_nm}</c:when>
							<c:otherwise>
								<form:input path="user_nm" />
								<form:errors path="user_nm" />
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th scope="row">이메일</th>
					<td class="left">
						<form:input path="user_email" />
						<form:errors path="user_email" />
					</td>
				</tr>
				<tr>
					<th scope="row">핸드폰</th>
					<td class="left">
						<form:input path="user_cp_1" /> -
						<form:input path="user_cp_2" /> -
						<form:input path="user_cp_3" />
						<p><form:errors path="user_cp_1" /></p>
						<p><form:errors path="user_cp_2" /></p>
						<p><form:errors path="user_cp_3" /></p>
					</td>
				</tr>
				<tr>
					<th scope="row">주소</th>
					<td class="left">
						<form:input path="user_addr_1" />
						<form:errors path="user_addr_1" />
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="logo">로고</label></th>
					<td class="left">
						<c:choose>
							<c:when test="${empty atchfileList}">
								<input type="file" id="file_upload" name="file_upload" size="75"/>
								<form:errors path="file_upload_check" />
							</c:when>
							<c:otherwise>
								<c:forEach var="result" items="${atchfileList}" varStatus="status">
									<c:if test="${status.index eq 0}">
										<img src="${pageContext.request.contextPath}/images/template/exticos/${elfunc:getImgicoByExt(result.fext)}.gif" width="16" height="16" alt="htp"/>
										<a href="javascript:cmmfn_download_atchfile('${pageContext.request.contextPath}', '${result.vchkcode}')" title="${result.rname}">${elfunc:cutString(result.rname, 25, "... ")} (${result.size_kb}kb)</a>
										<a href="javascript:cmmfn_delete_onefile('${pageContext.request.contextPath}', '${result.vchkcode}', fn_memsvc_myinfochange)">
											<span class="btn_imgSmall"><img src="${pageContext.request.contextPath}/images/template/cmm/btn_reply_delete.gif" alt="삭제"/></span>
										</a>
									</c:if>
								</c:forEach>										
							</c:otherwise>
						</c:choose>					
					</td>
				</tr>
			</tbody>
		</table>
		
		<p class="btn_center">
			<a href="javascript:history.go(-1)" class="btn_light_b">뒤로가기</a>
			<a href="javascript:fn_member_join()" class="btn_blue_b">가입하기</a>
			<input type="submit" value="가입하기" />
		</p>
		<!-- //페이지 작성 -->

	</div>
	
</section>

	
	<input type="hidden" id="user_id_check" name="user_id_check" value="N"/>
	<input type="hidden" id="user_bizreg_check" name="user_id_check" value="N"/>
	
</form:form>