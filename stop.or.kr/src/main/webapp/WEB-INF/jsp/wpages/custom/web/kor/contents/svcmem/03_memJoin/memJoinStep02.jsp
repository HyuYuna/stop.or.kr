<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script src="//cdn.poesis.kr/post/popup.min.js"></script>
<form:form name="reqForm" method="post" commandName="memberVO">

	<!-- 컨텐츠영역 -->
	<div id="member_content">
		<p class="alert"><span class="point_red">*</span> 입력필수 항목입니다.</p>
		<fieldset>
			<legend>회원가입 입력 폼</legend>
			<table class="tstyle_member" summary="회원가입 입력시 아이디 입력, 비밀번호, 비밀번호 재확인, 성명, 생년월일, 핸드폰번호, 일반전화, 이메일, 주소 입력">
				<caption>
					회원가입 입력
				</caption>
				<colgroup>
					<col width="170" />
					<col width="*" />
				</colgroup>
				<tbody>			
					<c:choose>
						<c:when test="${param.tgtact eq 'memJoinStep2'}">
							<tr>
								<th scope="row"><span class="point_red">*</span> <label for="name">아이디</label></th>
								<td class="txt_left">
									<form:input path="user_id" title="아이디" value="" size="40"/>
									<input type="hidden" id="user_id_check" value="N"/>
									<button id="btnCheckDupid" type="button"><img src="${pageContext.request.contextPath}/main/images/custom/kor/member/btn_overlap.gif" alt="중복확인" /></button>
									<span class="point_red" id="spanCheckidArea"></span>
								</td>
							</tr>			
							<tr>
								<th scope="row"><span class="point_red">*</span> <label for="user_scrt">비밀번호</label></th>
								<td class="txt_left"><form:password path="user_scrt" title="비밀번호" size="40"/>  <span class="point_red">첫문자는 영문자를 사용하고, 9자 이상 영문 대,소문자, 숫자, 특수문자를 사용하세요.</span></td>
							</tr>
							<tr>
								<th scope="row"><span class="point_red">*</span> <label for="user_scrt_confirm">비밀번호 재확인</label></th>
								<td class="txt_left"><input type="password" id="user_scrt_confirm" name="user_scrt_confirm" value=""  title="비밀번호 재확인" size="40"/><!--  <span class="point_red">비밀번호가 일치하지 않습니다.</span> --></td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr>
								<th scope="row"><span class="point_red">*</span> <label for="name">아이디</label></th>
								<td class="txt_left">
									<c:out value="${memberVO.user_id}"/>
									<form:hidden path="user_id" title="아이디"/>
								</td>
							</tr>			
							<tr>
								<th scope="row"><span class="point_red">*</span> <label for="user_scrt_org">비밀번호</label></th>
								<td class="txt_left"><form:password path="user_scrt_org" title="비밀번호" size="40"/></td>
							</tr>
							<tr>
								<th scope="row"><label for="user_scrt">변경할 비밀번호</label></th>
								<td class="txt_left"><form:password path="user_scrt" title="비밀번호" size="40"/>  <span class="point_red">첫문자는 영문자를 사용하고, 9자 이상 영문 대,소문자, 숫자, 특수문자를 사용하세요.</span></td>
							</tr>
							<tr>
								<th scope="row"><label for="user_scrt_confirm">비밀번호 재확인</label></th>
								<td class="txt_left"><input type="password" id="user_scrt_confirm" name="user_scrt_confirm" value=""  title="비밀번호 재확인" size="40"/><!--  <span class="point_red">비밀번호가 일치하지 않습니다.</span> --></td>
							</tr>
						</c:otherwise>
					</c:choose>

					<tr>
						<th scope="row"><span class="point_red">*</span> <label for="user_nm">성명</label></th>
						<td class="txt_left"><form:input path="user_nm" value="${memberVO.user_nm}"  title="성명" size="40" readonly="true" /></td>
					</tr>
					<tr>
						<th scope="row"><span class="point_red">*</span> <label for="user_birth">생년월일</label></th>
						<td class="txt_left">
							<form:input path="user_birth" maxlength="10" value="${memberVO.user_birth}" size="40" class="birth" title="생년월일" readonly="true"/>
						</td>
					</tr>
					<!-- <tr>
						<th scope="row"><span class="point_red">*</span> <label for="user_mobile">핸드폰번호</label></th>
						<td class="txt_left"><input id="user_mobile" name="user_mobile" title="핸드폰번호" type="text" value="" size="40"/> <span class="point_red">숫자만 입력해주세요</span></td>
					</tr> -->
					
					<tr>
						<th scope="row"><span class="point_red">*</span> <label for="user_cp_1">핸드폰 번호</label></th>
						<td class="txt_left">
							<form:select path="user_cp_1" class="type1" title="핸드폰 번호 앞자리 선택">
								<form:option value="010" selected="selected">010</form:option>
								<form:option value="011">011</form:option>
								<form:option value="016">016</form:option>
								<form:option value="017">017</form:option>
								<form:option value="018">018</form:option>
								<form:option value="019">019</form:option>
							</form:select>
							-
							<form:input path="user_cp_2" maxlength="4" size="5" class="type3" title="핸드폰 가운데 자리"/> -
							<form:input path="user_cp_3" maxlength="4" size="5" class="type3" title="핸드폰 끝 자리"/>
							<!-- <span class="btn_smallBrown">
								<button id="btnCheckDupcp" type="button">중복검사</button>
							</span> -->
							<span class="point_red" id="spanCheckcpArea">숫자만 입력해주세요</span>
							<!-- <input type="hidden" id="user_cp_check" value="N"/> -->
							
						</td>
					</tr>
					<!-- 
					<tr>
						<th scope="row"><label for="user_phone">일반전화</label></th>
						<td class="txt_left"><input id="user_phone" name="user_phone" title="일반전화" type="text" value="" size="40"/> <span class="point_red">숫자만 입력해주세요</span></td>
					</tr>
					 -->
					<tr>
						<th scope="row"><label for="user_tel_1">일반전화</label></th>
						<td class="txt_left">
							<form:select path="user_tel_1" class="type1" title="전화 번호 앞자리 선택">
								<form:option value="02">02</form:option>
								<form:option value="031">031</form:option>
								<form:option value="032">032</form:option>
								<form:option value="033">033</form:option>
								<form:option value="041">041</form:option>
								<form:option value="042">042</form:option>
								<form:option value="043">043</form:option>
								<form:option value="044">044</form:option>
								<form:option value="051">051</form:option>
								<form:option value="052">052</form:option>
								<form:option value="053">053</form:option>
								<form:option value="054">054</form:option>
								<form:option value="055">055</form:option>
								<form:option value="061">061</form:option>
								<form:option value="062">062</form:option>
								<form:option value="063">063</form:option>
								<form:option value="064">064</form:option>
							</form:select> - 
							<form:input path="user_tel_2" maxlength="4" size="5" class="type3" title="전화번호 가운데 자리"/> -
							<form:input path="user_tel_3" maxlength="4" size="5" class="type3" title="전화번호 끝 자리"/>
							<span class="point_red">숫자만 입력해주세요</span>
						</td>
					</tr>
					
					<tr>
						<th scope="row"><span class="point_red">*</span> <label for="user_mobile">이메일</label></th>
						
						<td class="txt_left"><input type="text" name="user_email_1" id="user_email_1" title="이메일 계정 아이디"  />
							@ <input type="text" name="user_email_2" id="user_email_2" title="이메일 도메인 입력"/>
							<select name="user_email_3" id="user_email_3" title="이메일 도메인 선택">
								<option value="" selected="selected">직접입력</option>
								<option value="nate.com">nate.com</option>
								<option value="gmail.com">gmail.com</option>
								<option value="empal.com">empal.com</option>
								<option value="naver.com">naver.com</option>
								<option value="dreamwiz.com">dreamwiz.com</option>
								<option value="hanmail.net">hanmail.net</option>
								<option value="freechal.com">freechal.com</option>
								<option value="paran.com">paran.com</option>
								<option value="hitel.net">hitel.net</option>
								<option value="hanmir.com">hanmir.com</option>
								<option value="netian.com">netian.com</option>
								<option value="lycos.co.kr">lycos.co.kr</option>
								<option value="yahoo.co.kr">yahoo.co.kr</option>
								<option value="chillian.net">chillian.net</option>
								<option value="korea.com">korea.com</option>
								<option value="hotmail.com">hotmail.com</option>
								<option value="unitel.co.kr">unitel.co.kr</option>
								<option value="nownuri.net">nownuri.net</option>
								<option value="hanafos.com">hanafos.com</option>
								<option value="kornet.net">kornet.net</option>
							</select>
							<form:hidden path="user_email" title="이메일"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="user_address">주소</label></th>
						<td class="txt_left">
							<input id="zipcode1" name="zipcode1" class="postcodify_postcode6_1" type="text" size="5" value="" /> - 
							<input id="zipcode2" name="zipcode2" class="postcodify_postcode6_2" type="text" size="5s" value="" /> <button id="btnZipcode" type="button"><img src="${pageContext.request.contextPath}/main/images/custom/kor/member/btn_address.gif" alt="주소검색" /></button><br/>
							<form:hidden path="user_zip"/>
							<input id="user_addr_1" name="user_addr_1" title="주소" type="text" value="" size="80" class="margin_top10 postcodify_address" />
						</td>
					</tr>
					
				</tbody>
			</table>
			
		</fieldset>
		<p class="btn_area_center">
			<c:choose>
				<c:when test="${param.tgtact eq 'modUsrinfo'}">
					<button type="button" id="btnMemberMod"><img src="${pageContext.request.contextPath}/main/images/custom/kor/member/btn_modify.gif" alt="회원정보수정" /></button>
				</c:when>
				<c:otherwise>
					<button type="button" id="btnMemberJoin"><img src="${pageContext.request.contextPath}/main/images/custom/kor/member/btn_join.gif" alt="가입하기" /></button>
				</c:otherwise>		
			</c:choose>
			<button type="button" id="btnMemberCancel"><img src="${pageContext.request.contextPath}/main/images/custom/kor/member/btn_cancel.gif" alt="취소" /></button>
		</p>
	</div>
<!-- //컨텐츠영역-->
		
	<form:hidden path="user_auth_cd"/>			
	<form:hidden path="user_dupinfo"/>
	<form:hidden path="user_name_chk"/>
			
</form:form>

<form name="form_chkType" method="post">
	<!-- 본인 인증 부분 시작-->
	<input type="hidden" name="m" value="checkplusSerivce"><!-- 필수 데이타로, 누락하시면 안됩니다. -->
	<input type="hidden" id="EncodeData" name="EncodeData" value=""><!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
	   
	<!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다. 해당 파라미터는 추가하실 수 없습니다. -->
	<input type="hidden" id="param_r1" name="param_r1" value="">
	<input type="hidden" id="param_r2" name="param_r2" value="">
	<input type="hidden" id="param_r3" name="param_r3" value="">
	<!-- 본인 인증 부분 끝-->
</form>
<script> $(function() { $("#btnZipcode").postcodifyPopUp(); }); </script>