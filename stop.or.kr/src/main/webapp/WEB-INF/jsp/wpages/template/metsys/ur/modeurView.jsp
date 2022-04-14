<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<form:form name="reqForm" commandName="memberVO">
	<table class="tstyle_view">
		<caption>
		회원 ID, 회원 성명, 성별, email, 연락처
		</caption>
		<colgroup>
			<col width="18%" />
			<col />
		</colgroup>
		<caption>회원정보 상세보기</caption>
		<tbody>
			<tr>
				<th scope="row">회원 ID</th>
				<td>
					<c:choose>
						<c:when test="${memberVO.edomweivgp eq 'M'}">
							<c:out value="${memberVO.user_id}"/>
							<form:hidden path="user_id"/>
						</c:when>
						<c:otherwise>
							<input type="text" id="user_id" name="user_id" title="회원 ID"/>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th scope="row">회원 성명</th>
				<td><form:input path="user_nm" title="회원 성명"/></td>
			</tr>
			<c:if test="${memberVO.edomweivgp eq 'M'}">
			<tr>
				<th scope="row"><label for="user_scrt">현재 패스워드</label></th>
				<td>
					<input type="password" id="user_scrt_org" name="user_scrt_org" maxlength="20" title="현재 패스워드"/>
				</td>
			</tr>
			</c:if>
			<tr>
				<th scope="row"><label for="user_scrt">패스워드</label></th>
				<td>
					<input type="password" id="user_scrt" name="user_scrt" maxlength="20" title="패스워드"/> (패스워드를 변경하고자 할때만 입력해주십시오.)
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="user_scrt_2">패스워드 확인</label></th>
				<td>
					<input type="password" id="user_scrt_2" name="user_scrt_2" maxlength="20" title="패스워드 확인"/>
				</td>
			</tr>				
			<tr>
				<th scope="row">Email</th>
				<td>
					<form:input path="user_email" title="Email" size="80"/>
				</td>
			</tr>
			<tr>
				<th scope="row">연락처</th>
				<td>
					<form:select path="user_cp_1" class="type1" title="핸드폰 번호 앞자리">
						<option value="010" selected="selected">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="017">017</option>
						<option value="018">018</option>
						<option value="019">019</option>
					</form:select>
					-
					<form:input path="user_cp_2" maxlength="4" size="8" class="type3" title="핸드폰 가운데 자리"/> -
					<form:input path="user_cp_3" maxlength="4" size="8" class="type3" title="핸드폰 끝 자리"/>
				</td>
			</tr>
			<tr>
				<th scope="row">부서/직위</th>
				<td>
					<label for="user_organ" class="hidden">부서</label>
					<form:input path="user_organ" class="type3" value="" title="부서"/> /
					<label for="user_grade" class="hidden">직위</label>
					<form:input path="user_grade" class="type3" value="" title="직위"/>
				</td>
			</tr>
			<tr>
				<th scope="row">회원 권한</th>
				<td>
					<c:choose>
						<c:when test="${SESS_USR_LV le 2}">
							<form:select path="user_auth_cd" title="회원유형 상세">
								<form:options items="${authcode}" itemLabel="auth_nm" itemValue="auth_cd"/>
							</form:select>
						</c:when>
						<c:otherwise>
							<c:out value="${memberVO.user_auth_nm}"/>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th scope="row">가입일</th>
				<td>
					<c:out value="${memberVO.wdt}"/>
				</td>
			</tr>
			<tr>
				<th scope="row">접속허용IP</th>
				<td>
					<label for="allow_ip" class="hidden">접속허용IP</label>
					<form:input path="allow_ip" class="type3" value="" title="허용IP"/>
				</td>
			</tr>
		</tbody>
	</table>
	
	<div class="btn_area_right">
		<a href="javascript:fn_egov_mem_save()" class="btn_line">저장</a>
		<c:if test="${SESS_USR_LV le 2 and memberVO.edomweivgp eq 'M'}">
			<a href="javascript:fn_egov_mem_del()" class="btn_line">삭제</a>
		</c:if>
		<a href="javascript:fn_egov_mem_list()" class="btn_line">목록</a>
	</div>	
	<!-- //content -->	
	<form:hidden path="edomweivgp"/>
	<form:hidden path="pageIndex"/>
	<form:hidden path="seltab_idx" />	
	
	<form:hidden path="srch_mu_site"/>
	<form:hidden path="srch_mu_lang"/>
	
	
</form:form>
