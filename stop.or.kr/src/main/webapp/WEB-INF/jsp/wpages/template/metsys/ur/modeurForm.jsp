<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
function passwordCheck(){//20200408 추가
	//var form = document.reqForm;
	var scrt1 = $("#user_scrt").val();
	var scrt2 = $("#user_scrt_confirm").val();
	if(scrt1 != ""){
		if(scrt1 != scrt2)
		{
			alert("신규 패스워드와 패스워드 확인의 값이 서로 일치하지 않습니다.");
			$("#user_scrt_confirm").focus();
			return false;
		}
		if(scrt1 != "" && scrt1.length < 9)
		{
			alert("패스워드는 9자리 이상으로 입력해주십시오");
			$("#user_scrt").focus();
			return false;
		}	
		var reg_pwd = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{9,}$/;
	    if(!reg_pwd.test($.trim(scrt1)))
	    {
	        alert('비밀번호는 영문, 숫자, 특수문자를 반드시 포함하여 9자리 이상이어야 합니다.');
	        $("#user_scrt").focus();
	        return false;
	    }
	}
    return true;
}
</script>

<form:form name="reqForm" commandName="memberVO" enctype="multipart/form-data" action="${isModify == true ? cutil:getUrl('/modeur/modeurView.do', '', true) : cutil:getUrl('/modeur/modeurAdd.do', '', false) }" onSubmit="return passwordCheck();" class="ajax-form-submit">
	<input type="hidden" id="dupChecked" name="dupChecked" value="Y"/>
	<input type="hidden" name="urlParams" value="${userVo.urlParams}"/>
	<input type="submit" style="display:none;"/>
	
	<table class="tstyle_view">
		<colgroup>
			<col width="18%" />
			<col />
		</colgroup>
		<caption>등록 폼</caption>
		<tbody>
			<tr>
				<th scope="row"><label for="user_id">회원 ID</label></th>
				<td>
				<c:choose>
					<c:when test="${isModify == true}">
						<form:hidden path="user_id"/>
						${memberVO.user_id}
					</c:when>
					<c:otherwise>
						<form:input path="user_id" />
						<!-- <input type="text" id="user_id" name="user_id" class="input_width_150" maxlength="20" title="아이디"/> -->
						<!-- <button  type="button" class="btn_graySmall" id="btnChkdupID" value="ID 중복체크">ID 중복체크</button> -->
						<!-- <span class="txt_blue" id="spanIdfeedback">(ID를 입력해주십시오)</span> -->
						<!-- <div class="btn_area_right" style="margin:0; padding:0; width:80px; align:left; display:inline;"><a href="" id="btn_dup">중복확인</a></div> -->
						<form:errors path="user_id"></form:errors>
					</c:otherwise> 
				</c:choose>
				
				</td>
			</tr>
			
			
			<c:if test="${isModify == true and SESS_USR_LV gt 2}">
				<tr>
					<th scope="row"><label for="user_scrt">현재 패스워드</label></th>
					<td>
						<input type="password" id="user_scrt_org" name="user_scrt_org" class="input_width_150" maxlength="20" title="현재 패스워드"/>
					</td>
				</tr>
			</c:if>
			<tr>
				<th scope="row"><label for="user_scrt">비밀번호</label></th>
				<td>
					<form:password path="user_scrt" />
					<form:errors path="user_scrt"></form:errors>
					<!-- <input type="password" id="user_scrt" name="user_scrt" class="input_width_150" maxlength="20" title="비밀번호"/> -->
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="user_scrt_2">비밀번호 확인</label></th>
				<td>
					<form:password path="user_scrt_confirm" />
					<form:errors path="user_scrt_confirm"></form:errors>
					<!-- <input type="password" id="user_scrt_2" name="user_scrt_2" class="input_width_150" maxlength="20" title="비밀번호 확인"/> -->
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="user_nm">성명</label></th>
				<td>
				<c:choose>
					<c:when test="${isModify == true}">
						<c:out value="${memberVO.user_nm}"/>
					</c:when>
					<c:otherwise>
						<form:input path="user_nm" class="input_width_150" title="회원 성명"/>
						<form:errors path="user_nm"></form:errors>
					</c:otherwise> 
				</c:choose>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="title">Email</label></th>
				<td>
					<form:input path="user_email" class="input_width_300" title="이메일"/>
					<form:errors path="user_email"></form:errors>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="title">핸드폰</label></th>
				<td>
					<form:input path="user_cp_1" class="input_width_50" maxlength="3" title="핸드폰 첫째 자리"/> -
					<form:input path="user_cp_2" class="input_width_50" maxlength="4" title="핸드폰 두번째 자리"/> -
					<form:input path="user_cp_3" class="input_width_50" maxlength="4" title="핸드폰 세번째 자리"/>
					<form:errors path="user_cp_1"></form:errors>
					<form:errors path="user_cp_2"></form:errors>
					<form:errors path="user_cp_3"></form:errors>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="add">주소</label></th>
				<td>
					<form:input path="user_addr_1" title="주소"  class="input_width_500" />
					<form:errors path="user_addr_1"></form:errors>
				</td>
			</tr>
			<c:if test="${isModify == true and SESS_USR_LV le 2}">
			
				<tr>
					<th scope="row"><label for="is_lock">계정잠금</label></th>
					<td>
						<input type="radio" name="is_lock" id="is_lock_y" value="Y" <c:if test="${ fn:trim(memberVO.is_lock) eq 'Y'}">checked="checked"</c:if>><label for="is_lock_y">차단</label>
						<input type="radio" name="is_lock" id="is_lock_n" value="N" <c:if test="${ fn:trim(memberVO.is_lock) eq 'N'}">checked="checked"</c:if>><label for="is_lock_n">해제</label>
					</td>
				</tr>
				
				<tr>
					<th scope="row"><label for="reset">비밀번호 초기화</label></th>
					<td>
						<a href="javascript:rest_password();" class="btn_linebold">초기화</a>&nbsp;&nbsp;stop1050*
					</td>
				</tr>
			</c:if>
			<!-- 
			<tr>
				<th scope="row"><label for="title">생년월일</label></th>
				<td><form:input path="user_birth" class="input_width_100" title="생년월일"/></td>
			</tr>
			 
			<tr>
				<th scope="row"><label for="title">부서</label></th>
				<td><form:input path="user_dept" class="input_width_100" title="부서"/></td>
			</tr>
			<tr>
				<th scope="row"><label for="title">직위/직급</label></th>
				<td><form:input path="user_grade" class="input_width_100" title="직위/직급"/></td>
			</tr>
			-->
			<c:if test="${SESS_USR_LV le 2}">
				<tr>
					<th scope="row"><label for="title">권한구분</label></th>
					<td>
						<form:select path="up_auth_cd" title="회원유형">
							<form:options items="${upauthcode}" itemLabel="auth_nm" itemValue="auth_cd"/>
						</form:select>
						<form:select path="user_auth_cd" title="회원유형 상세">
							<form:options items="${authcode}" itemLabel="auth_nm" itemValue="auth_cd"/>
						</form:select>
					</td>
				</tr>
				<!-- 사용안함
				<tr>
					<th scope="row">접속허용IP</th>
					<td>
						<label for="allow_ip" class="hidden">접속허용IP</label>
						<form:input path="allow_ip" class="input_width_300" value="" title="허용IP"/> <br/>
						<span class="txt_blue">( '*'는 모두 허용, IP대역을 이용할때는 xxx.xxx.xxx.* 등의 표현 허용, IP가 여러개일때는 | 로 이어붙임)</span>
					</td>
				</tr>
				 -->
			</c:if>
			<c:if test="${isModify == true}">
			<tr>
				<th scope="row">가입일</th>
				<td>
					<c:out value="${memberVO.wdt}"/>
				</td>
			</tr>
			</c:if>
			
			
			<c:if test="${isModify == true and SESS_USR_LV gt 2}">
				<form:hidden path="is_lock" value="${memberVO.is_lock}"/>
			</c:if>
			
			
			
		</tbody>
	</table>	
	
	<div class="btn_area_right">
		<c:choose>
			<c:when test="${isModify == false}">
				<input type="submit" value="저장" class="btn_linebold" />
				<!-- <a href="javascript:fn_egov_mem_save();" class="btn_linebold">저장</a> -->
			</c:when>
			<c:otherwise>
				<input type="submit" value="수정" class="btn_linebold" />
				<!-- <a href="javascript:fn_egov_mem_save();" class="btn_linebold">저장</a> -->
				<c:if test="${SESS_USR_LV le 2}">
					<a href="javascript:fn_egov_mem_del()" class="btn_line">삭제</a>
				</c:if>
			</c:otherwise>
		</c:choose>
		
		<a href="${cutil:getUrl('/modeur/modeurList.do', 'id=', true)}" class="btn_line">목록</a>
		<!-- <a href="javascript:fn_egov_mem_list()" class="btn_line">목록</a> -->
	</div>		
	<form:hidden path="edomweivgp"/>
	<form:hidden path="pageIndex"/>
	<form:hidden path="seltab_idx" />
	<form:hidden path="srch_mu_site"/>
	<form:hidden path="srch_mu_lang"/>
	
</form:form>


<script type="text/javascript">
	
	function rest_password()
	{
		if(confirm("초기화 하시겠습니까?"))
		{
			$.ajax({
			     url: '${pageContext.request.contextPath}/modeur/resetPass.do',
			     data : {
			    	 		user_id : '${memberVO.user_id}'
			        	},
			     type: 'POST',
			     cache : false,
			     async : false,
			     success: function(data) {
			    	
			    	 if(data == 'OK')
		    		 {
			    		 alert('수정 되었습니다.');
			    		 location.reload();
		    		 }
			    	 else
		    		 {
		    		 	alert("비밀번호 초기화 에러.");
		    		 }
			     }   
		     });
		}
		
	}
	
	
</script>
