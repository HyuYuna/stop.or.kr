<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>

<script type="text/javascript">
jQuery(document).ready(function() {

	
});


</script>
<form:form name="reqForm" commandName="boardinfoVO">
	<c:choose>
		<c:when test="${boardinfoVO.edomweivgp eq 'A'}">
			<c:set var="pgname" value="게시판 추가" />
		</c:when>
		<c:when test="${boardinfoVO.edomweivgp eq 'M'}">
			<c:set var="pgname" value="게시판정보 수정" />
		</c:when>
	</c:choose>
	<h2 class="depth2_bbsTitle">
		${pgname} 
		<!-- <select id="selBrdsetType">
			<option value="C">일반설정</option>
			<option value="D">상세설정</option>
		</select> -->
	</h2>
	
	<!-- content -->
	<div class="txt_right" ></div>
	
	<table class="tstyle_view">
		<colgroup>
			<col width="150" />
			<col />
		</colgroup>
		<caption>갱신 페이지</caption>
		<tr>
			<th scope="row"><label for="title">사이트 구분</label></th>
			<td>
				<select id = "sel_mu_site" name="sel_mu_site" title="사이트구분 선택">
					<c:forEach var="site" items="${sitecode}" varStatus="status">
						<option value="${site.code_idx}">${site.code_nm}</option>
					</c:forEach>
				</select>
				<form:hidden path="mu_site"/>
				<form:hidden path="srch_mu_site"/>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="title">언어 구분</label>
			<td>
				<select id="sel_mu_lang" name="sel_mu_lang" title="언어구분 선택">
					<c:forEach var="lang" items="${langcode}" varStatus="status">
						<option value="${lang.code_idx}">${lang.code_nm}</option>
					</c:forEach>
				</select>
				<form:hidden path="mu_lang"/>
				<form:hidden path="srch_mu_lang"/>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="title">게시판 ID</label>
			</th>
			<td>
				<c:out value="${boardinfoVO.brd_id}"/><form:hidden path="brd_id"/> <span class="point01"> ( 자동으로 입력되는 값입니다 )</span>
			</td>
		</tr>
		<tr>
			<th scope="row">게시판명</th>
			<td><form:input path="brd_nm" class="input_width_200" />
			</td>
		</tr>
		<tr>
			<th scope="row">게시판설명</th>
			<td><form:input path="brd_dft" class="input_width_600" />
			</td>
		</tr>
		<tr class="brdsetTypeDetail">
			<th scope="row">카테고리 사용여부</th>
			<td><form:select path="use_ctgry">
					<form:option value="N">미사용</form:option>
					<form:option value="Y">사용</form:option>
				</form:select> <span class="sbjt_width_x3"></span> 카테고리 : <form:select
					path="ctgry_idx" class="input_width_200">
					<form:option value="">카테고리를 선택해주십시오 </form:option>
					<form:options items="${ctgryList}" itemLabel="ctgry_nm"
						itemValue="ctgry_idx" />
				</form:select> <span class="sbjt_width_x2"></span> <span class="point01">(
					카테고리는 '기타관리' 메뉴에서 등록할 수 있습니다 )</span></td>
		</tr>
		<tr>
			<th scope="row">여분필드1 사용여부</th>
			<td>
				<form:select path="brd_extra.extra1_use">
					<form:option value="N">미사용</form:option>
					<form:option value="Y">사용</form:option>
				</form:select>
				<form:select path="brd_extra.extra1_require">
					<form:option value="N">필수아님</form:option>
					<form:option value="Y">필수</form:option>
				</form:select>
				<form:input path="brd_extra.extra1_name"/>
			</td>
		</tr>
		<tr>
			<th scope="row">여분필드2 사용여부</th>
			<td>
				<form:select path="brd_extra.extra2_use">
					<form:option value="N">미사용</form:option>
					<form:option value="Y">사용</form:option>
				</form:select>
				<form:select path="brd_extra.extra2_require">
					<form:option value="N">필수아님</form:option>
					<form:option value="Y">필수</form:option>
				</form:select>
				<form:input path="brd_extra.extra2_name"/>
			</td>
		</tr>
		<tr class="brdsetTypeDetail">
			<th scope="row">공지기능 포함여부</th>
			<td><form:select path="use_notice">
					<form:option value="N">미포함</form:option>
					<form:option value="Y">포함</form:option>
				</form:select></td>
		</tr>
		<tr class="brdsetTypeDetail">
			<th scope="row">비공개(비밀글)기능 포함여부</th>
			<td><form:select path="use_scrt">
					<form:option value="N">미포함</form:option>
					<form:option value="Y">포함</form:option>
				</form:select></td>
		</tr>
		<tr class="brdsetTypeDetail">
			<th scope="row">게시물 추천 사용여부</th>
			<td><form:select path="use_rcmnd">
					<form:option value="N">미사용</form:option>
					<form:option value="Y">사용</form:option>
				</form:select></td>
		</tr>
		<tr class="brdsetTypeDetail">
			<th scope="row">게시물 반대 사용여부</th>
			<td><form:select path="use_rjct">
					<form:option value="N">미사용</form:option>
					<form:option value="Y">사용</form:option>
				</form:select></td>
		</tr>
		<tr>
			<th scope="row">게시판 종류</th>
			<td>
				<c:choose>
					<c:when test="${boardinfoVO.edomweivgp eq 'A'}">
						<form:select path="brd_gb" title="게시판 종류">
							<form:options items="${brdcode}" itemLabel="code_nm" itemValue="code_idx"/>
						</form:select>
					</c:when>
					<c:otherwise>
						<c:out value="${boardinfoVO.brd_gb_nm}"/>
						<form:hidden path="brd_gb"/>
					</c:otherwise>
				</c:choose>
				<span class="point01">(한번 설정된 후에는 변경될 수 없습니다 )</span>
			</td>
		</tr>
		<tr class="brdsetTypeDetail">
			<th scope="row">게시판 세부 종류</th>
			<td>
				<form:select path="brd_gb_sub">
					<form:option value="A">Type A</form:option>
					<form:option value="B">Type B</form:option>
					<form:option value="C">Type C</form:option>
					<form:option value="D">Type D</form:option>
					<form:option value="E">Type E</form:option>
					<form:option value="F">Type F</form:option>
					<form:option value="G">Type G</form:option>
				</form:select>			
				<span class="point01">(동일 종류의 게시판에서 기능을 세부 구분하기 위해 사용합니다)</span>		
				
			</td>
		</tr>
		<tr class="brdsetTypeDetail">
			<th scope="row">답글 형식</th>
			<td>
				<form:select path="reply_gb">
					<form:option value="N">답글 없음</form:option>
					<form:option value="A">계층형 답글 게시판</form:option>
					
					<form:option value="R">댓글형 게시판</form:option>
					<form:option value="B">답글 + 댓글 게시판</form:option>
					
				</form:select>
			</td>
		</tr>
		<tr>
			<th scope="row">로그인 사용자에 대한 공개 방식</th>
			<td><form:select path="on_viewmode">
					<form:option value="1">읽기만 가능 (공지사항 게시판 등)</form:option>
					<form:option value="2">읽기/쓰기 가능 (일반 게시판 / 자료실)</form:option>
					<form:option value="0">사용 불가능 (관리자 전용 게시판)</form:option>
				</form:select></td>
		</tr>
		<tr class="brdsetTypeDetail">
			<th scope="row">비로그인 사용자에 대한 공개 방식</th>
			<td><form:select path="off_viewmode">
					<form:option value="2">읽기/쓰기 가능 (익명게시판)</form:option> <!-- 비로그인 쓰기를 허용하려면 별도로 캡챠와 비밀번호 입력 기능을 구현한다. -->
					<form:option value="1">읽기만 가능 (공지사항 게시판 / 공개 게시판 / 자료실)</form:option>
					<form:option value="0">사용 불가능 (로그인 전용 게시판)</form:option>
				</form:select></td>
		</tr>
		<tr id="trSeleditorArea" class="brdsetTypeDetail">
			<th scope="row">에디터 종류</th>
			<td>
				<!--<form:radiobutton path="editor_gb" value="A" />
				<label for="editor_gb1">cleditor</label>
				<form:radiobutton path="editor_gb" value="B" />
				<label for="editor_gb2">TinyMCE</label>
				<form:radiobutton path="editor_gb" value="C" />
				<label for="editor_gb3">ckeditor</label>
				<form:radiobutton path="editor_gb" value="D" />
				<label for="editor_gb4">한글컨트롤</label>
				<form:radiobutton path="editor_gb" value="F" />
				<label for="editor_gb5">스마트에디터</label>-->
				<form:radiobutton path="editor_gb" value="G" />
				<label for="editor_gb6">다음에디터 (최적화)</label>
				<form:radiobutton path="editor_gb" value="Z" />
				<label for="editor_gb7">Textarea</label> <br /> 
				<!-- <span class="txt_red">&lt;한글컨트롤은 아래한글 2002 이상이 설치된 PC에서 MSIE를 사용할때만 가능합니다&gt;</span> <br /> -->
				<div id="divTextarea">
					<iframe id="iframeEditor"
						src="${pageContext.request.contextPath}/template/metsys/bd/editorView.stpg?editor_gb=${boardinfoVO.editor_gb}"
						width="740" height="370" frameborder="0"></iframe>
				</div>
			</td>
		</tr>
		<!-- 
		<tr>
			<th scope="row">스킨 (기능추가 예정)</th>
			<td><form:radiobutton path="brd_dft_skin" value="A" /> <label
				for="brd_dft_skin1">스킨 A</label> ...... <--!--<form:radiobutton path="editor_gb" value="B"/> <label for="editor_gb2">TinyMCE</label>
				<form:radiobutton path="editor_gb" value="C"/> <label for="editor_gb3">Textarea</label>--///>
				<form:radiobutton path="brd_dft_skin" value="Z" /> <label
				for="brd_dft_skin2">스킨 Z(사용자 정의 스킨)</label></td>
		</tr>
		 -->
		<tr class="brdsetTypeDetail">
			<th scope="row">공공누리 적용여부</th>
			<td><form:select path="use_kogl">
					<form:option value="N">미적용</form:option>
					<form:option value="Y">적용</form:option>
				</form:select>
			</td>
		</tr>
		<tr>
			<th scope="row">첨부파일 사용 여부 / 첨부방식 / 첨부파일 개수</th>
			<td>
				<form:select path="use_atch">
					<!--<form:option value="2">읽기/쓰기 가능 (익명게시판)</form:option>-->
					<form:option value="N">미사용</form:option>
					<form:option value="Y">사용</form:option>
				</form:select><span class="sbjt_width_x3"></span>/<span class="sbjt_width_x3"></span>
				<form:select path="use_uploadify">
					<form:option value="Y">UPLOADIFY</form:option> 
					<form:option value="N">FORM</form:option>
				</form:select><span class="sbjt_width_x3"></span>/<span class="sbjt_width_x3"></span>
				<form:input path="attach_cnt_limit" class="input_width_20" /> [ 0 : 무제한 ]</td>
		</tr>
		<tr class="brdsetTypeDetail">
			<th scope="row">첨부파일 크기 제한</th>
			<td>
				<form:input path="attach_size_limit" class="input_width_50" /> MB 
				<span class="point01">( 첨부방식이 "UPLOADIFY" 로 설정되었을 경우에만 적용됩니다 )</span>
			</td>
		</tr>
		<tr class="brdsetTypeDetail">
			<th scope="row">페이지당 게시물 개수</th>
			<td><c:choose>
					<c:when test="${boardinfoVO.brd_gb eq 'T'}">
						<form:input path="atcl_per_pg" class="input_width_20" />
					</c:when>
					<c:otherwise>
						<form:radiobutton path="atcl_per_pg" value="5" label="5개" />
						<form:radiobutton path="atcl_per_pg" value="10" label="10개" />
						<form:radiobutton path="atcl_per_pg" value="15" label="15개" />
						<form:radiobutton path="atcl_per_pg" value="20" label="20개" />
						<form:radiobutton path="atcl_per_pg" value="30" label="30개" />
						<form:radiobutton path="atcl_per_pg" value="50" label="50개" />
					</c:otherwise>
				</c:choose></td>
		</tr>
		<tr class="brdsetTypeDetail">
			<th scope="row">페이지당 네비게이션 개수</th>
			<td><form:radiobutton path="pg_per_navi" value="5" /> <label
				for="pg_per_navi1">5개</label> <form:radiobutton path="pg_per_navi"
					value="10" /> <label for="pg_per_navi2">10개</label> <form:radiobutton
					path="pg_per_navi" value="15" /> <label for="pg_per_navi3">15개</label>
			</td>
		</tr>
		<c:if test="${SESS_USR_LV le 2 and not empty boardinfoVO.ref_menu_nix}">
			<tr class="brdsetTypeDetail">
				<th scope="row">연동 메뉴</th>
				<td>
					<span title="${boardinfoVO.ref_menu_nix}"><c:out value="${boardinfoVO.ref_menu_nm}"/></span>
					<button  type="button" class="btn_graySmall" id="btnRefmenuDel" value="연동메뉴정보 삭제">연동메뉴정보 삭제</button>
				</td>
			</tr>
		</c:if>
		 <!-- 
		 <tr>
			<th scope="row">게시판 안내(개요)</th>
			<td><form:textarea path="info_cont"/>
			</td>
		</tr>
		  -->
		<tr class="brdsetTypeDetail">
			<th scope="row">관리자</th>
			<td><form:input path="brd_auth_usr" class="input_width_500"/> <span class="point01">[ , ] 로 구분된 ID 문자열</span>
			</td>
		</tr>
		<tr>
			<th scope="row">생성일</th>
			<td><c:out value="${boardinfoVO.wdt}" />
			</td>
		</tr>
		
		<!-- 
		<tr>
			<th scope="row">전용 저장소 생성 여부</th>
			<td>
				<c:choose>
					<c:when test="${boardinfoVO.edomweivgp eq 'A'}">
						<form:select path="create_new_table">
							<form:option value="N">기본 저장소 사용</form:option>
							<form:option value="Y">전용 저장소 생성</form:option>
						</form:select>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${boardinfoVO.create_new_table eq 'N'}">기본테이블 사용</c:when>
							<c:when test="${boardinfoVO.create_new_table eq 'Y'}">전용 테이블 생성</c:when>
						</c:choose>
						<form:hidden path="create_new_table"/>
					</c:otherwise>
				</c:choose>
				<span class="point01">(한번 설정된 후에는 변경될 수 없습니다 )</span>
			</td>
		</tr>
			-->
	</table>
	<div class="btn_area_right">
		<c:if test="${boardinfoVO.edomweivgp eq 'M'}">
			<c:choose>
				<c:when test="${boardinfoVO.brd_gb eq 'CDIDX00042'}"> <!-- 일반게시판 -->
					<c:set var="b_url" value="brdartcl/boardarticleList.do" />
				</c:when>
				<c:when test="${boardinfoVO.brd_gb eq 'CDIDX00044'}"> <!-- 이미지게시판  -->
					<c:set var="b_url" value="brdthm/boardthmList.do" />
				</c:when>
				<c:when test="${boardinfoVO.brd_gb eq 'CDIDX00046'}"> <!-- 익명게시판  -->
					<c:set var="b_url" value="brdanm/boardanonimList.do" />
				</c:when>
				<c:when test="${boardinfoVO.brd_gb eq 'CDIDX00043'}"> <!-- faq게시판  -->
					<c:set var="b_url" value="brdfaq/boardfaqList.do" />
				</c:when>
			</c:choose>
			
			<a href="${pageContext.request.contextPath}/${b_url}?srch_menu_nix=${param.srch_menu_nix}&brd_id=${boardinfoVO.brd_id}" class="btn_line">게시글보기</a>
		</c:if>
		&nbsp;&nbsp;&nbsp;
		<a href="javascript:fn_egov_brd_save()" class="btn_line">저장</a>
		<c:if test="${boardinfoVO.edomweivgp ne 'A'}">
			<a href="javascript:fn_egov_brd_del()" class="btn_line">삭제</a>
		</c:if>
		<a href="javascript:fn_egov_brd_list()" class="btn_line">목록</a>
	</div>
	<br/>
	<form:hidden path="edomweivgp" />
	<form:hidden path="seltab_idx" />

</form:form>
<script>
/* $('#extra1_use,#extra2_use').change(function()
{
	console.log($(this));
	if($(this).val() == "Y") {
		$(this).closest('tr').find('select').eq(1).show();
		$(this).closest('tr').find('input').show();
	}
	else
	{
		$(this).closest('tr').find('select').eq(1).hide();
		$(this).closest('tr').find('input').hide();
	}
});
 */
</script>