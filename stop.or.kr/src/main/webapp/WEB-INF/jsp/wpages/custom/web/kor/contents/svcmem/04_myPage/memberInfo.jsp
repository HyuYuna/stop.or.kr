<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>

<form:form name="reqForm" commandName="memberVO" enctype="multipart/form-data">
		
	<section id="content">
		
		<!-- path -->
		<p class="path">
			<span class="path_home"><img src="${pageContext.request.contextPath}/images/custom/web/kor/common/path_home.gif" alt="홈" /></span> 
			<span>멤버십</span><span class="path_current">회원정보 수정</span>
		</p>
		<!-- //path -->
		
		<!-- stitle -->
		<h1 class="stitle">
			회원정보 수정
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
						<th scope="row"><label for="company">아이디</label> <span class="point01">*</span></th>
						<td class="left">
							${memberVO.user_id}
							<form:hidden path="user_id"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="company">현재 패스워드</label> <span class="point01">*</span></th>
						<td class="left">
							<input type="password" id="user_scrt_org" name="user_scrt_org" title="현재 패스워드" class="input_text w150" />
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="company">변경할 패스워드</label></th>
						<td class="left">
							<input type="password" id="user_scrt" name="user_scrt" title="변경할 패스워드" class="input_text w150" />
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="company">변경할 패스워드 확인</label> <span class="point01">*</span></th>
						<td class="left">
							<input type="password" id="user_scrt_confirm" name="user_scrt_confirm" title="변경할 패스워드 확인" class="input_text w150" />
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="company">기업명</label> <span class="point01">*</span></th>
						<td class="left"><form:input path="user_nm" title="기업명" class="input_text w350" /></td>
					</tr>
					<tr>
						<th scope="row"><label for="number">사업자등록번호</label> <span class="point01">*</span></th>
						<td class="left">
							${memberVO.bizreg_no} 
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="name">대표자</label> <span class="point01">*</span></th>
						<td class="left"><form:input path="president" title="대표자" class="input_text w350" /></td>
					</tr>
					<tr>
						<th scope="row"><label for="tel">대표번호</label> <span class="point01">*</span></th>
						<td class="left">
							<form:input path="user_tel_1" title="대표번호 앞자리" class="input_text" size="7" maxlength="3"/> -
							<form:input path="user_tel_2" title="대표번호 가운데자리" class="input_text" size="7" maxlength="4"/> - 
							<form:input path="user_tel_3" title="대표번호 뒷자리" class="input_text" size="7" maxlength="4"/> 
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="add">주소</label></th>
						<td class="left"><form:input path="user_addr_1" title="주소"  class="input_text w550" /></td>
					</tr>
					<tr>
						<th scope="row"><label for="business">사업영역</label> <span class="point01">*</span></th>
						<td class="left">
							<textarea id="biz_scope" name="biz_scope" title="사업영역"  class="textarea" cols="30" rows="10">${elfunc:removeScrtag(memberVO.biz_scope)}</textarea>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="product">주요제품</label> <span class="point01">*</span></th>
						<td class="left">
							<textarea id="maj_product" name="maj_product" title="주요제품" class="textarea" cols="30" rows="10">${elfunc:removeScrtag(memberVO.maj_product)}</textarea>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="logo">로고</label></th>
						<td class="left">
							<c:choose>
								<c:when test="${empty atchfileList}">
									<input type="file" id="file_upload" name="file_upload" size="75"/>
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
				<a href="javascript:fn_member_modify()" class="btn_blue_b">변경하기</a>
			</p>
			<!-- //페이지 작성 -->
	
		</div>
		
	</section>
	
	<input type="hidden" id="user_id_check" name="user_id_check" value="N"/>
	<input type="hidden" id="user_bizreg_check" name="user_id_check" value="N"/>
		
</form:form>