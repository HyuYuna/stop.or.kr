<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>

<script type="text/javascript">
jQuery(document).ready(function(){
	
	jQuery("#srch_mu_site, #srch_mu_lang").change(function(){
		jQuery("#pageIndex").val(1);
		fn_egov_sysmenu_list();
	});
	
});

</script>			
<form:form name="reqForm" commandName="sysmenuVO">
	
	<div class="articles_search">
		<div class="basic_searchForm">
			<c:choose>
				<c:when test="${param.srch_menu_nix eq 'fCHJYUo1'}">
					<input type="hidden" id="srch_mu_gub" name="srch_mu_gub" value="USR"/>
					사이트 : 
					<form:select path="srch_mu_site" title="사이트구분 선택">
						<form:options items="${sitecode}" itemLabel="code_nm" itemValue="code_idx"/>
					</form:select>
					&nbsp;
					언어 : 
					<form:select path="srch_mu_lang" title="언어구분 선택">
						<form:options items="${langcode}" itemLabel="code_nm" itemValue="code_idx"/>
					</form:select>
				</c:when>
				<c:otherwise>
					<input type="hidden" id="srch_mu_gub" name="srch_mu_gub" value="MAN"/>
					<form:hidden path="srch_mu_site"/>
					<form:hidden path="srch_mu_lang"/>
					
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	
	<table id="tableSysmenuList" class="tstyle_list">
		<caption>
		</caption>
		<colgroup>
			<col width="60">
			<col width="300">
			<col width="110"> 
			<col width="100">
			<col width="*">
			<col width="100">
			<col width="80">
			<col width="90">
			<col width="115">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">선택</th>
			<!-- 
				<th scope="col">ID</th>
				<th scope="col">상위 ID</th>
 			-->				
				<th scope="col">메뉴 명</th>
				<th scope="col">연동</th>
				<th scope="col">탭메뉴</th>
				<th scope="col">링크</th>
				<th scope="col">사용여부</th>
				<th scope="col">Level</th>
				<th scope="col">순서</th>
				<th scope="col">서브메뉴 추가</th>
			</tr>
		</thead>
		<tbody>		
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:choose>
				<c:when test="${SESS_USR_LV > 0 and (result.menu_idx eq 'MNIDX00001' or result.menu_idx eq 'MNIDX00101')}">
					<c:set var="linebg" value="mn_devonly"/>
				</c:when>
				<c:when test="${result.use_yn eq 'Y'}">
					<c:set var="use_yn_kr" value="사용"/>
					<c:choose>
						<c:when test="${result.menu_lv eq 1}">
							<c:set var="linebg" value="mn_toplv"/>
						</c:when>
						<c:otherwise>
							<c:set var="linebg" value="mn_normal"/>
						</c:otherwise>
					</c:choose>
					
				</c:when>
				<c:when test="${result.use_yn eq 'N'}">
					<c:set var="use_yn_kr" value="사용안함"/>
					<c:set var="linebg" value="mn_disable"/>
				</c:when>
			</c:choose>
			
			<tr class="${linebg}" data-tt-id="tr_${result.menu_idx}" <c:if test="${result.menu_lv gt 1}">data-tt-parent-id="tr_${result.up_menu_idx}"</c:if>>
				<td>
					<input type="checkbox" id="menu_idx_${status.count}_${result.menu_lv}" name="menu_idx" value="<c:out value="${result.menu_idx}"/>"/>
				</td>
			<!-- 
				<td><a href="javascript:fn_egov_sysmenu_view('<c:out value="${result.menu_idx}"/>')"><c:out value="${result.menu_idx}"/></a></td>
				<td><c:out value="${result.up_menu_idx}"/></td>
 			-->				
				<td class="txt_left">
					<span title="<c:out value="${result.menu_nm}"/>">
						<a href="javascript:fn_egov_sysmenu_view('<c:out value="${result.menu_idx}"/>')">
							<c:choose>
								<c:when test="${result.is_leaf eq 0}">
									<img src="${pageContext.request.contextPath}/images/template/metsys/common/folder-open-add2.png" width="16px"/>
									<c:out value="${elfunc:cutString(result.menu_nm, 18,'..')}"/>
								</c:when>							
								<c:otherwise>
									<img src="${pageContext.request.contextPath}/images/template/metsys/common/folder-document.png" width="16px"/>
									<c:out value="${elfunc:cutString(result.menu_nm, 18,'..')}"/>
									</span>
								</c:otherwise>
							</c:choose>
						</a>
					</span>
				</td>
				<td>
					<c:choose>
						<c:when test="${not empty result.ucont_id }">
							<a href="javascript:fn_egov_menucont_view('${result.ucont_id}')" class="btn_lineSmall">컨텐츠</a>								
						</c:when>
						<c:when test="${not empty result.brd_id }">
							<a href="javascript:fn_egov_menubrd_view('${result.brd_id}')" class="btn_lineSmall">게시판</a>								
						</c:when>
					</c:choose>
				</td>
				<td><c:if test="${result.tabmenu_yn eq 'Y'}"><img src="${pageContext.request.contextPath}/images/template/cmm/tab_breakoff.png" height="24px" width="24px"/></c:if></td>						
				<td class="txt_left">
					<span title="${result.menu_link}"><c:out value="${elfunc:cutString(result.menu_link, 50, '...')}"/></span>
				</td>
			<!-- 
				<td><c:out value="${result.sub_menu_cnt}"/></td>
			-->
				<td>	
					<c:out value="${use_yn_kr}"/>
				</td>
				<td><c:out value="${result.menu_lv}"/></td>
				<td><c:out value="${result.menu_ord}"/></td>
				<td>
					<c:if test="${result.use_yn eq 'Y'}">
						<c:choose>
							<c:when test="${result.mu_gub eq 'USR'}">
								<a href="javascript:fn_egov_sysmenu_subadd('<c:out value="${result.menu_idx}"/>')" class="btn_lineSmall">추가</a>
							</c:when>
							<c:otherwise>
								<c:if test="${result.menu_lv eq 1}">
									<a href="javascript:fn_egov_sysmenu_subadd('<c:out value="${result.menu_idx}"/>')" class="btn_lineSmall">추가</a>
								</c:if>
							</c:otherwise>
						</c:choose>
					
					</c:if>
				</td>
				
			</tr>
		</c:forEach>
		<c:if test = "${totCnt eq 0}">
			<tr id="trSysmenuEmpty">
				<td colspan="9">조회 결과가 없습니다.</td>
			</tr>
		</c:if>
		</tbody>
	</table>
	
	
	<div class="btn_area_right">
		<a href="javascript:fn_egov_menu_allopen(false)" class="btn_line">모두펼침</a>
		<a href="javascript:fn_egov_menu_allclose(false)" class="btn_line">모두닫음</a>
		&nbsp;&nbsp;&nbsp;
		<a href="javascript:fn_egov_sysmenu_add()" class="btn_line">추가</a>
		<a href="javascript:fn_egov_sysmenu_del()" class="btn_line">삭제</a>
		<!-- <a href="javascript:fn_egov_sysmenu_script()">스크립트</a> -->
	</div>
	
	<form:hidden path="edomweivgp"/>
	<form:hidden path="use_yn"/>
	<form:hidden path="mu_gub"/>
	<form:hidden path="menu_idx"/>
	
	<input type="hidden" id="ucont_id" name="ucont_id" value=""/>
	<input type="hidden" id="ucont_version" name="ucont_version" value="0"/>
	<input type="hidden" id="brd_id" name="brd_id" value=""/>
	
</form:form>
	
	<!-- 	
	<div id="divMenuScript">
	
	 	<div id="divMenuScriptOnlyArea" style="border:solid 1px; padding:10px;">		
			<h4># 메뉴 스크립트 #</h4> <br/>
			<c:set var="lastlv" value=""/>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<c:if test="${result.use_yn eq 'Y'}">
					<c:choose>
						<c:when test="${result.menu_lv eq 1}">
							<c:choose>
								<c:when test="${lastlv eq '1'}">	
									<span id="sbjt_width_x2"></span>&lt;/li&gt;<br/>
								</c:when>
								<c:when test="${lastlv eq '2'}">
									<span id="sbjt_width_x3"></span>&lt;/ul&gt;<br/>
									<span id="sbjt_width_x2"></span>&lt;/li&gt;<br/>
								</c:when>
								<c:otherwise>
									&lt;ul id="ulTopNav"&gt;<br/>
								</c:otherwise>
							</c:choose>	
							<span id="sbjt_width_x2"></span>&lt;li id="liMenuIdx_${status.count}" &gt;<br/><span id="sbjt_width_x3"></span>&lt;a href="${pageContext.request.contextPath}<c:out value="${result.menu_link}"/>"><c:out value="${result.menu_nm}"/>&lt;/a&gt;<br/>
							<c:set var="lastlv" value="1"/>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${lastlv eq '1'}">
									<span id="sbjt_width_x3"></span>&lt;ul id="ulSubIdx_${status.count - 1}"&gt;<br/>
								</c:when>
							</c:choose>	
							<c:set var="lastlv" value="2"/>
							<span id="sbjt_width_x4"></span>&lt;li&gt;&lt;a href="${pageContext.request.contextPath}<c:out value="${result.menu_link}"/>"><c:out value="${result.menu_nm}"/>&lt;/a&gt;&lt;/li&gt;<br/>
						</c:otherwise>
					</c:choose>
				</c:if>
			</c:forEach>
			<c:if test = "${totCnt ne 0}">
				<c:if test = "${lastlv eq '2'}">
					<span id="sbjt_width_x3"></span>&lt;/ul&gt;<br/>
				</c:if>
				<span id="sbjt_width_x2"></span>&lt;/li&gt;<br/>
				&lt;/ul&gt;
			</c:if>
		</div>
		<br/>
		<br/>
		<div style="border:solid 1px; padding:10px;">
			<h4># CSS 적용 #</h4> <br/>
			<textarea id="txtMenuCss" rows="30" cols="175">
		
		#ulTopNav li {
			float : left;
			width : 120px;
			font-size : 1.2em;
			height: 70px;
		}
		
		#ulTopNav li ul{
			width : 1024px;
			padding : 10px 0px 0 0;
			font-size : 0.8em;
		}
		
		#ulTopNav li ul li {
			float:none;
			width : 120px;
			height : 30px;
		}		
			
		</textarea>
		<div class="btn_area_right">
			<a href="javascript:fn_egov_refresh_menupreveiw()">미리보기</a>
		</div>
		</div>	
		<br/>
		<br/>
		<h4># 미리보기 #</h4> 
		<div id="divMenupPrevArea" style="border:solid 1px; padding:10px;">
			<br/>
		</div>	
	</div>
	 -->