<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<form:form name="reqForm" commandName="memberVO" enctype="multipart/form-data">
	
	
<section id="content">
	
	<!-- path -->
	<p class="path">
		<span class="path_home"><img src="${pageContext.request.contextPath}/images/custom/web/kor/common/path_home.gif" alt="홈" /></span> 
		<span>멤버십</span><span class="path_current">회원가입</span>
	</p>
	<!-- //path -->
	
	<!-- stitle -->
	<h1 class="stitle">
		회원가입
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
						<form:input path="user_id" title="아이디" class="input_text w150" />
						<a href="javascript:fn_egov_check_dupid()" class="btn_orange_m">중복확인</a>
						&nbsp;&nbsp;
						<span id="spanCheckidArea" class="point02"></span>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="company">패스워드</label> <span class="point01">*</span></th>
					<td class="left">
						<form:password path="user_scrt" title="패스워드" class="input_text w150" />
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="company">패스워드 확인</label> <span class="point01">*</span></th>
					<td class="left">
						<input type="password" id="user_scrt_confirm" name="user_scrt_confirm" title="패스워드 확인" class="input_text w150" />
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="company">기업명</label> <span class="point01">*</span></th>
					<td class="left"><form:input path="user_nm" title="기업명" class="input_text w350" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="number">사업자등록번호</label> <span class="point01">*</span></th>
					<td class="left">
						<input type="text" id="bizreg_no_1" name="bizreg_no_1" title="사업자등록번호 앞자리" class="input_text" size="7" maxlength="3"/> -
						<input type="text" id="bizreg_no_2" name="bizreg_no_2" title="사업자등록번호 가운데자리" class="input_text" size="6" maxlength="2"/> - 
						<input type="text" id="bizreg_no_3" name="bizreg_no_3" title="사업자등록번호 뒷자리" class="input_text" size="9" maxlength="5"/>
						<form:hidden path="bizreg_no" name="bizreg_no" /> 
						<a href="javascript:fn_egov_check_dupbizreg()" class="btn_orange_m">중복확인</a>
						<span id="spanCheckbizregArea" class="point02"></span>
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
						<textarea id="biz_scope" name="biz_scope" title="사업영역"  class="textarea" cols="30" rows="10"></textarea>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="product">주요제품</label> <span class="point01">*</span></th>
					<td class="left">
						<textarea id="maj_product" name="maj_product" title="주요제품" class="textarea" cols="30" rows="10"></textarea>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="logo">로고</label></th>
					<td class="left"><input type="file" id="file_upload" name="file_upload" size="75"/></td>
				</tr>
			</tbody>
		</table>
		
		<p class="btn_center">
			<a href="javascript:history.go(-1)" class="btn_light_b">뒤로가기</a>
			<a href="javascript:fn_member_join()" class="btn_blue_b">가입하기</a>
		</p>
		<!-- //페이지 작성 -->

	</div>
	
</section>

<!-- 
<div id="content" class="contentswrap">
		
	
	<section id="location">
		<h3>
		로그인
		</h3>
		<div class="cnts_head sub01">
			<p>
				<strong>학교 밖 어디든지 <span>희망의 빛을</span></strong>
				<span class="desc">
					한국청소년정책연구원 학교 밖 청소년 지원사업에서는 <br/>학교 밖 어디든지 청소년에게 희망의 빛을 주기위해 노력합니다.
				</span>
			</p>
		</div> 
		<div class="path">
			<p id="pLinemenu">
				<a class="home" href="${pageContext.request.contextPath}/contents/siteMain.do">홈</a> 
				<c:choose>
					<c:when test="${param.srch_menu_nix eq 'Cw0QnxDe'}"><a href="${pageContext.request.contextPath}/contents/siteMapView.do?srch_menu_nix=Cw0QnxDe">가이드</a><em>사이트맵</em></c:when>
					<c:when test="${param.srch_menu_nix eq 'tSK0zRu4'}"><a href="${pageContext.request.contextPath}/contents/siteMapView.do?srch_menu_nix=Cw0QnxDe">가이드</a><em>이메일주소수집거부 </em></c:when>
					<c:when test="${param.srch_menu_nix eq '6vsdC3J5'}"><a href="${pageContext.request.contextPath}/contents/siteMapView.do?srch_menu_nix=Cw0QnxDe">가이드</a><em>이용약관 </em></c:when>
					<c:when test="${param.srch_menu_nix eq 'k0q5Yn1K'}"><a href="${pageContext.request.contextPath}/contents/siteMapView.do?srch_menu_nix=Cw0QnxDe">가이드</a><em>오시는 길</em></c:when>
					<c:when test="${param.srch_menu_nix eq 'y858FR0S'}"><a href="${pageContext.request.contextPath}/contents/siteMapView.do?srch_menu_nix=Cw0QnxDe">가이드</a><em>로그인</em></c:when>
				</c:choose>
				
			</p>
		</div>
	</section>

	<section id="content">
	
		<div id="detail_content">
	
			<div class="login_box">
				<h4>MEMBER LOGIN</h4>
				<p class="h4_desc">본인의 아이디와 비밀번호를 정확히 입력해 주세요.</p>
				<div class="login_wrap">
					<fieldset class="login">
						<legend>Login</legend>
						<div class="item">
							<label class="i_label userId" for="userId">아이디</label>
							<input type="text" maxlength="50" class="i_text uid" id="user_id" value="" name="user_id" title="아이디"/>
						</div>
						<div class="item">
							<label class="i_label userPw" for="userPw">비밀번호</label>
							<input type="password" maxlength="10" class="i_text upw" id="user_scrt" value="" name="user_scrt" title="패스워드"/>
						</div>
						<p class="btn"><button type="button" id="btnLoginChk">로그인</button></p>
						<div id="pLoginerrorArea"></div>
					</fieldset>
				</div>
			</div>
		</div>
	</section>
</div>
-->
	
	<input type="hidden" id="user_id_check" name="user_id_check" value="N"/>
	<input type="hidden" id="user_bizreg_check" name="user_id_check" value="N"/>
	
</form:form>