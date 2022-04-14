<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<c:if test="${!empty popupList}">
<h2>POPUP WIDGET TEST</h2>



<div style="background-color:#f4f4f4">
	<ul>
	<c:forEach var="result" items="${popupList}" varStatus="status">
		
			<li  width="${result.pop_w}" height="${result.pop_h}">
				<a href="${pageContext.request.contextPath}/${result.pop_link}" target="${result.pop_target}"><p>${result.pop_title }</p></a>
				<img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${result.vchkcode}" width="100" alt="${result.pop_title}"/>
				<lable for="user_checkbox">1일 안보기</label><input type="checkbox" class="popup-close-chk" name="user_checkbox" value="${result.pop_seq}" />
				<a href="#" class="popup-close" id="popup-${result.pop_seq}">닫기</a>
			</li>
		
	</c:forEach>
	</ul>
</div>
</c:if>


<script type="text/javascript">
$(document).ready(function()
{
	$(".popup-close").click(function(){
		
		var li = $(this).closest("li");
		if($(li).find("input.popup-close-chk").is(":checked") == true)
		{
			
			$.ajax({
			     url: '${pageContext.request.contextPath}/widgets/setPopCookie.do',
			     data : {
			        		seq : $(li).find("input.popup-close-chk").val()
			        	},
			     dataType: 'post',
			     cache : false,
			     async : false,
			     success: function(data) {
			    
			     }   
			     });
			  
		}
		$(li).closest("li").hide();
		
		return false;
	});
	
});
</script>