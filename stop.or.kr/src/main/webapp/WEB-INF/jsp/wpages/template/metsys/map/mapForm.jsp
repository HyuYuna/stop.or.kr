<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%> 

<form:form name="reqForm" commandName="mapVO" class="ajax-form-submit">

<!-- content -->
<div id="divMainArticle">
	<h2>지원기관 관리</h2><br/>

	<table class="tstyle_view">
		<colgroup>
			<col width="18%" />
			<col />
		</colgroup>
		<caption>지원기관 폼</caption>
		<tr>
			<th scope="row"><label for="category">카테고리</label></th>
			<td>
				<form:select path="category">
					<form:option value="가정폭력상담소">가정폭력상담소</form:option>
					<form:option value="성매매피해지원기관">성매매피해지원기관</form:option>
					<form:option value="성폭력상담소">성폭력상담소</form:option>
					<form:option value="여성긴급전화">여성긴급전화</form:option>
					<form:option value="해바라기센터">해바라기센터</form:option>
				</form:select>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="sido">시도/구/군</label></th>
			<td>
				<form:select path="sido" name="sido" id="sido" title="지역">
					<form:option value="">지역을 선택하세요</form:option>
					<c:forEach var="result" items="${sidolist}" varStatus="status">
						<form:option value="${result.sido}">${result.sido}</form:option>
					</c:forEach>
				</form:select>
				
				<form:select path="gugun" name="gugun" id="gugun" title="시/군/구">
					<form:option value="">시/군/구를 선택하세요</form:option>
					<c:forEach var="result" items="${gugunlist}" varStatus="status">
						<form:option value="${result.gugun}">${result.gugun}</form:option>
					</c:forEach>
				</form:select>
			</td>
			
		</tr>
		<tr>
			<th scope="row"><label for="name">기관명</label></th>
			<td><form:input path="name" class="input_width_300" title="기관명"/></td>
		</tr>
		<tr>
			<th scope="row"><label for="addr">주소</label></th>
			<td><form:input path="addr" class="input_width_300" title="주소"/></td>
		</tr>
		<tr>
			<th scope="row"><label for="tel">전화번호</label></th>
			<td><form:input path="tel" class="input_width_300" title="전화번호"/></td>
		</tr>
		<tr>
			<th scope="row"><label for="urlx">위도</label></th>
			<td><form:input path="urlx" class="input_width_300" title="urlx"/></td>
		</tr>
		<tr>
			<th scope="row"><label for="urly">경도</label></th>
			<td><form:input path="urly" class="input_width_300" title="urly"/></td>
		</tr>
	</table>
	<br/>
	<div class="btn_area_right">
		<input type="submit" value="저장" class="btn_line">
		<a href="${pageContext.request.contextPath}/manmap/mapList.do?srch_menu_nix=${param.srch_menu_nix}" class="btn_line">목록</a>
		<%-- <a href="${pageContext.request.contextPath}/manmap/mapDelete.do?srch_menu_nix=${param.srch_menu_nix}&map_idx=${mapVO.map_idx}" id="del" class="btn_line">삭제</a> --%>
	</div>
	
</div>
<form:hidden path="map_idx"/>
</form:form>

<script>
	/* $('a#del').click(function() {
		if(confirm("삭제 하시겠습니까?") == false) {
			return false;
		}
	}); */
	
	$('select#sido').change(function() {
		//alert($(this).val());
		if($(this).val()!="")
		{
			$.ajax({
		        url 		: "${pageContext.request.contextPath}/manmap/mapSearchGugunList.do?srch_menu_nix=${param.srch_menu_nix}",
		        type  		: "post",
		        data 		: {"sido":$(this).val()},
		        datatype	: "json",
				async 		: false,	        
		        success 	: function(data){
		        	$("select#gugun option").remove();
		        	$("select#gugun").append("<option value=''>시/군/구를 선택하세요</option>");
		        	$.each(data,function(key,value) {
		        		//console.log(value.gugun);
		        		if(value.gugun)
		        			$("select#gugun").append("<option value="+value.gugun+">"+value.gugun+"</option>");
		
		        	});
		
		        },
		        error: function(xhr, err){
		            
		        	alert("에러가 발생했습니다.");
		        }
		    }); 
		} else {
			$("select#gugun option").remove();
	    	$("select#gugun").append("<option value=''>시/군/구를 선택하세요</option>");
		}
	});
</script>