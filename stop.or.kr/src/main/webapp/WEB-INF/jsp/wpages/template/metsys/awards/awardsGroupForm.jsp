<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>

<form:form name="reqForm" commandName="awardsGroupVO" class="ajax-form-submit">
	<table class="tstyle_view">
		<colgroup>
			<col width="18%" />
			<col />
		</colgroup>
		<caption>등록 폼</caption>
		<tbody>
			<tr>
				<th scope="row"><label for="user_id">수상작 그룹</label></th>
				<td>
					<form:input path="name" />
					<form:errors path="name"></form:errors>
				</td>
			</tr>
			<c:if test="${isModify == true}">
			<tr>
				<th scope="row">등록일</th>
				<td>
					<c:out value="${awardsGroupVO.wdt}"/>
				</td>
			</tr>
			</c:if>
		</tbody>
	</table>	
	
	<div class="btn_area_right">
		<c:choose>
			<c:when test="${isModify == false}">
				<input type="submit" value="저장" class="btn_linebold" />
			</c:when>
			<c:otherwise>
				<input type="submit" value="수정" class="btn_linebold" />
				<a href="${cutil:getUrl('/metsys/awardsGroupDelete.do', '', true)}" onclick="if (confirm('삭제하시겠습니까?\n등록된 공고데이터도 삭제됩니다.') == false) { return false; }" class="btn_line">삭제</a>
			</c:otherwise>
		</c:choose>
		
		<a href="${cutil:getUrl('/metsys/awardsGroupList.do', 'id=', true)}" class="btn_line">목록</a>
	</div>		
</form:form>
