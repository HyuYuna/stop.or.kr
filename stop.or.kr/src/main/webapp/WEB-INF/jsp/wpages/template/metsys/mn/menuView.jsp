<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<div id="divMainArticle">
<form:form name="reqForm" commandName="sysmenuVO">
	<h2 class="depth2_bbsTitle">
		<c:choose>
			<c:when test="${sysmenuVO.edomweivgp eq 'A'}">메뉴 추가</c:when>
			<c:when test="${sysmenuVO.edomweivgp eq 'M'}">메뉴 수정</c:when>
			<c:when test="${sysmenuVO.edomweivgp eq 'S'}">하위메뉴 추가</c:when>
		</c:choose>
		<select id="selMenusetType">
			<option value="C">일반설정</option>
			<option value="D">상세설정</option>
		</select>
	</h2>
	<table class="tstyle_view">
		<colgroup>
			<col width="180" />
			<col />
		</colgroup>
		<caption>갱신 페이지</caption>
		<tbody>
			<c:if test="${SESS_USR_LV le '2'}">
				<tr>
					<th scope="row"><label for="title">사용자메뉴 / 관리자메뉴 구분</label></th>
					<td>
						<select id="sel_mu_gub" name="sel_mu_gub">
							<option value="USR">사용자 메뉴</option>					
							<option value="MAN">관리자 메뉴</option>					
						</select>
						<form:hidden path="srch_mu_gub"/>
						<form:hidden path="mu_gub"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">사이트 구분</label></th>
					<td>
						<select id = "sel_mu_site" name="sel_mu_site" title="사이트구분 선택">
							<c:forEach var="site" items="${sitecode}" varStatus="status">
								<option value="${site.code_idx}">${site.code_nm}</option>
							</c:forEach>
						</select>
						<form:hidden path="srch_mu_site"/>
						<form:hidden path="mu_site"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">언어 구분</label></th>
					<td>
						<select id="sel_mu_lang" name="sel_mu_lang" title="언어구분 선택">
							<c:forEach var="lang" items="${langcode}" varStatus="status">
								<option value="${lang.code_idx}">${lang.code_nm}</option>
							</c:forEach>
						</select>
						<form:hidden path="srch_mu_lang"/>
						<form:hidden path="mu_lang"/>
					</td>
				</tr>
			</c:if>
			<c:choose>
				<c:when test="${sysmenuVO.edomweivgp eq 'A'}">
					<tr>
						<th scope="row"><label for="title">ID</label></th>
						<td>
							<span class="point02">(자동으로 입력되는 값입니다)</span>
						</td> 
					</tr>
					<tr class="menusetTypeDetail">
						<th scope="row"><label for="title">Menu 고유코드</label></th>
						<td>
							<span class="point02">(자동으로 입력되는 값입니다)</span>
						</td> 
					</tr>
					<tr class="menusetTypeDetail">
						<th scope="row"><label for="title">상위메뉴 ID</label></th>
						<td><span class="point02">(자동으로 입력되는 값입니다)</span></td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr>
						<th scope="row"><label for="title">ID</label></th>
						<td>
							<c:out value="${sysmenuVO.menu_idx}"/>
							<form:hidden path="menu_idx"/> <span class="point02">(자동으로 입력되는 값입니다 )</span>
						</td> 
					</tr>
					<tr class="menusetTypeDetail">
						<th scope="row"><label for="title">Menu 고유코드</label></th>
						<td>
							<c:out value="${sysmenuVO.menu_nix}"/>
							<form:hidden path="menu_nix"/> <span class="point02">(자동으로 입력되는 값입니다 )</span>
						</td> 
					</tr>
					<tr class="menusetTypeDetail">
						<th scope="row"><label for="title">상위 ID</label></th>
						<td>
							<c:out value="${sysmenuVO.up_menu_idx}"/>
							<form:hidden path="up_menu_idx"/> <span class="point02">(자동으로 입력되는 값입니다 )</span></td>
					</tr>
				</c:otherwise>
			</c:choose>
			<tr>
				<th scope="row"><label for="title">메뉴 명</label></th>
				<td><form:input path="menu_nm" class="input_mid"/></td>
			</tr>
			<tr class="menusetTypeDetail">
				<th scope="row"><label for="title">메인메뉴 이미지 경로</label></th>
				<td><form:input path="menu_img_path" class="input_mid"/> <span class="point02">(사용할 경우에만 )</span></td>
			</tr>
			<tr class="menusetTypeDetail">
				<th scope="row"><label for="title">레프트메뉴 이미지 경로</label></th>
				<td><form:input path="left_img_path" class="input_mid"/> <span class="point02">(사용할 경우에만 )</span></td>
			</tr>
			<tr class="menusetTypeDetail">
				<th scope="row"><label for="title">타이틀 이미지 경로</label></th>
				<td><form:input path="title_img_path" class="input_mid"/> <span class="point02">(사용할 경우에만)</span></td>
			</tr>
			<tr class="menusetTypeDetail">
				<th scope="row"><label for="title">사이트맵 이미지 경로</label></th>
				<td><form:input path="sitemap_img_path" class="input_mid"/> <span class="point02">(사용할 경우에만)</span></td>
			</tr>
			<tr class="menusetTypeDetail">
				<th scope="row"><label for="title">기타 이미지 경로 1</label></th>
				<td><form:input path="info01_img_path" class="input_mid"/><span class="point02">(사용할 경우에만)</span></td>
			</tr>
			<tr class="menusetTypeDetail">
				<th scope="row"><label for="title">기타 이미지 경로 2</label></th>
				<td><form:input path="info02_img_path" class="input_mid"/> <span class="point02">(사용할 경우에만)</span></td>
			</tr>
			<tr>
				<th scope="row"><label for="title">링크</label></th>
				<td>
					<form:input path="menu_link" class="input_mid" readonly="false"/><br/>
					<span class="point02">(작업중인 경우, 또는 작업 예정인 경우 - UNDER_CONSTRUCT)</span>
				</td>
			</tr>
			<c:if test="${param.edomweivgp eq 'A' or param.edomweivgp eq 'S'}">
				<tr>
					<th scope="row"><label for="title">메뉴컨텐츠 유형</label></th>
					<td>
						<p><form:radiobutton path="menucont_type" value="N" label="일반 (개발이 필요한 기능)"/></p>
						<p><form:radiobutton path="menucont_type" value="U" label="상위메뉴 (하위 첫번째 메뉴에 의해 링크가 결정되므로, 하위메뉴가 등록될때 링크가 자동 변경됩니다.)"/></p>
						<p>
							<form:radiobutton path="menucont_type" value="B" label="게시판(게시판을 생성합니다)"/> &gt;&gt;
							<form:select path="menubrd_type" title="게시판 유형">
								<form:options items="${brdcode}" itemLabel="code_nm" itemValue="code_idx"/>
							</form:select>
						</p>
						<p><form:radiobutton path="menucont_type" value="C" label="컨텐츠(컨텐츠를 생성합니다)"/></p>
						<p><form:radiobutton path="menucont_type" value="R" label="작업중으로 표시 (UNDER_CONSTRUCT)"/></p>
						<br/>
						<span class="point02">(이미 생성되어있는 게시판 또는 컨텐츠와 연동하시려면 상세설정을 이용해주십시오)</span>
					</td>
				</tr>
			</c:if>
			<tr class="menusetTypeDetail">
				<th scope="row"><label for="title">게시판 연동</label></th>
				<td>
					<select id="selectBrdlist">
						<option value=""> 게시판 선택 </option> 
					</select> <span class="point02">(게시판 관리에서 생성된 게시판을 메뉴와 연동하려는 경우 선택하십시오)</span>
				</td>
			</tr>
			<tr class="menusetTypeDetail">
				<th scope="row"><label for="title">컨텐츠 연동</label></th>
				<td>
					<select id="selectContlist">
						<option value=""> 컨텐츠 연동 </option> 
					</select> 
					<span class="point02">(컨텐츠 관리에서 생성된 컨텐츠를 메뉴와 연동하려는 경우 선택하십시오)</span>
					또는 메뉴와 연동된 컨텐츠를 생성합니다.
				</td>
			</tr>
			<tr class="menusetTypeDetail">
				<th scope="row"><label for="title">공고 연동</label></th>
				<td>
					<select id="selectAnnouncementlist">
						<option value=""> 공고 선택 </option> 
					</select> <span class="point02">(공고 관리에서 생성된 공고를 메뉴와 연동하려는 경우 선택하십시오)</span>
				</td>
			</tr>
			<tr class="menusetTypeDetail">
				<th scope="row"><label for="title">수상작 연동</label></th>
				<td>
					<select id="selectAwardslist">
						<option value="">수상작 선택 </option> 
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="title">링크 새창열기</label></th>
				<td>
					<form:select path="blank_yn">
						<form:option value="N">사용안함</form:option>					
						<form:option value="Y">사용</form:option>					
					</form:select>
				</td>
			</tr>
			<tr class="menusetTypeDetail">
				<th scope="row"><label for="title">탭메뉴 여부</label></th>
				<td>
					<form:select path="tabmenu_yn">
						<form:option value="N">사용안함</form:option>					
						<form:option value="Y">사용</form:option>					
					</form:select> <span class="point02"> (탭메뉴와 텝메뉴의 부모메뉴는 모두 '사용'으로 해줘야 합니다.)</span>
				</td>
			</tr>
			<tr class="menusetTypeDetail">
				<th scope="row"><label for="title">회원메뉴(회원가입 / 약관 등) 여부</label></th>
				<td>
					<form:select path="memmenu_yn">
						<form:option value="N">아니오</form:option>					
						<form:option value="Y">예</form:option>					
					</form:select> <span class="point02"> (회원 메뉴는 상단메뉴에 나타나지 않습니다)</span>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="title">메뉴 사용여부</label></th>
				<td>
					<form:select path="use_yn">
						<form:option value="Y">사용</form:option>					
						<form:option value="N">사용안함</form:option>					
					</form:select>
				</td>
			</tr>
			<tr class="menusetTypeDetail">
				<th scope="row"><label for="title">담당자 정보</label></th>
				<td><form:input path="own_info" class="input_mid"/></td>
			</tr>
			<tr>
				<th scope="row"><label for="title">순서</label></th>
				<td><form:input path="menu_ord" size="4"/></td>
			</tr>
		</tbody>
	</table>	
	<div class="btn_area_right">
		<a href="javascript:fn_egov_sysmenu_save()" class="btn_line">저장</a>
		<a href="javascript:fn_egov_sysmenu_list()" class="btn_line">목록</a>
	</div>
	<br/>
	<form:hidden path="edomweivgp"/>
	<form:hidden path="seltab_idx" />
	<input type="hidden" id="org_menu_ord" name="org_menu_ord" value="${sysmenuVO.menu_ord}"/>
</form:form>
</div>