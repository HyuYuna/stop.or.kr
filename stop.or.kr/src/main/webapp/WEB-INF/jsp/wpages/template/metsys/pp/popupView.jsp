<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%> 

<!-- content -->
<div id="divMainArticle">
	<form:form name="reqForm" action="deletePopup.do?srch_menu_nix=${param.srch_menu_nix}&seltab_idx=${param.seltab_idx}" commandName="popupVO">
	<h2>팝업 관리</h2>
	
		<table class="tstyle_view">
			<colgroup>
				<col width="18%" />
				<col />
			</colgroup>
			<caption>상세보기</caption>
			<tr>
				<th scope="row"><label for="pop_title">제목</label></th>
				<td>
					${popupVO.pop_title}
					<form:hidden path="pop_title"/>
				</td>
			</tr>
			<tr>
				<th scope="row">구분</th>
				<td>
					<c:choose>
						<c:when test="${popupVO.pop_type eq 'W'}">
							팝업창
						</c:when>
						<c:when test="${popupVO.pop_type eq 'Z'}">
							팝업존
						</c:when>
						<c:when test="${popupVO.pop_type eq 'V'}">
							비주얼
						</c:when>
						<c:when test="${popupVO.pop_type eq 'E'}">
							영문비주얼
						</c:when>
						<c:when test="${popupVO.pop_type eq 'R'}">
							배너(관련사이트)
						</c:when>
					</c:choose>
				</td>
			</tr>
			<c:if test="${popupVO.pop_type eq 'W' or popupVO.pop_type eq 'Z'}">
				<tr>
					<th scope="row"><label for="pop_from">게시 기간</label></th>
					<td>
						<c:out value="${popupVO.pop_from} ~ ${popupVO.pop_to}"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="pop_w">크기</label></th>
					<td>
						Width : <c:out value="${popupVO.pop_w}"/><br/>
						Height : <c:out value="${popupVO.pop_h}"/>
						<form:hidden path="pop_w"/>
						<form:hidden path="pop_h"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="pop_w">위치</label></th>
					<td>
						Top : <c:out value="${popupVO.pop_y}"/> <br/>
						Left : <c:out value="${popupVO.pop_x}"/>
						<form:hidden path="pop_y"/>
						<form:hidden path="pop_x"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="title">내용</label></th>
					<td><c:out value="${popupVO.pop_content}"/></td>
				</tr>
			</c:if>
			<tr>
				<th scope="row"><label for="title">ALT속성값</label></th>
				<td>
					<c:out value="${popupVO.pop_alt}"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="user_addr_1">이미지</label></th>
				<td>
					<c:forEach var="result" items="${atchfileList}" varStatus="status">

						<img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${result.vchkcode}"/><br/>
 						<div id="divAtcharea_${result.atckey_4th}" class="uploadify-queue-item">
 							<div class="file_area">
								<span class="fileName">
									<img src="${pageContext.request.contextPath}/images/template/exticos/${elfunc:getImgicoByExt(result.fext)}.gif" width="16" height="16" alt="htp"/>
									<a href="javascript:cmmfn_download_atchfile('${pageContext.request.contextPath}', '${result.vchkcode}')">
										${result.rname} (${result.size_kb}kb)
									</a>
								</span>
								<span class="data"></span>
							</div>
						</div>
						<input type="hidden" id="atckey_1st" name="atckey_1st" value="${result.atckey_1st}"/>
						<input type="hidden" id="atckey_2nd" name="atckey_2nd" value="${result.atckey_2nd}"/>
						<input type="hidden" id="atckey_3rd" name="atckey_3rd" value="${result.atckey_3rd}"/>
						<input type="hidden" id="atckey_4th" name="atckey_4th" value="${result.atckey_4th}"/>
						<input type="hidden" id="vchkcode" name="vchkcode" value="${result.vchkcode}"/>
						
					</c:forEach>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="title">링크</label></th>
				<td>
					${popupVO.pop_link}
					<form:hidden path="pop_target"/>
					<form:hidden path="pop_link"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="title">팝업순서</label></th>
				<td>
					${popupVO.pop_sort}
				</td>
			</tr>

		</table>
		
		<div class="btn_area_right">
			<a href="javascript:fn_egov_popup_mod()" class="btn_line">수정</a>			
			<c:if test="${popupVO.pop_type eq 'W'}">
				<a href="javascript:fn_egov_show_poppreview()" class="btn_line">미리보기</a>
			</c:if>
			<a href="javascript:fn_egov_popup_list()" class="btn_line">목록</a>
		</div>
		
		<form:hidden path="pop_seq" />
		<form:hidden path="edomweivgp" />
		<form:hidden path="pageIndex"/>
		<form:hidden path="srch_mu_site"/>
		<form:hidden path="srch_mu_lang"/>
		
	</form:form>

</div>
