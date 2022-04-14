<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%> 

<form:form name="reqForm" commandName="scheduleVO" class="ajax-form-submit">

<!-- content -->
<div id="divMainArticle">
	<h2>스케쥴 관리</h2><br/>

	<table class="tstyle_view">
		<colgroup>
			<col width="18%" />
			<col />
		</colgroup>
		<caption>스케쥴 폼</caption>
		<tr>
			<th scope="row"><label for="s_date">게시기간</label></th>
			<td>
				<form:input path="s_date" class="input_width_100"/>
				~
				<form:input path="e_date" class="input_width_100"/>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="subject">제목</label></th>
			<td><form:input path="subject" class="input_width_300" title="제목"/></td>
		</tr>
	</table>
	<br/>
	<div class="btn_area_right">
		<input type="submit" value="저장" class="btn_line">
		<a href="${pageContext.request.contextPath}/mansch/schList.do?srch_menu_nix=${param.srch_menu_nix}" class="btn_line">목록</a>
		<%-- <a href="${pageContext.request.contextPath}/mansch/schDelete.do?srch_menu_nix=${param.srch_menu_nix}&sch_idx=${scheduleVO.sch_idx}" id="del" class="btn_line">삭제</a> --%>
	</div>
	
</div>
<form:hidden path="sch_idx"/>
</form:form>