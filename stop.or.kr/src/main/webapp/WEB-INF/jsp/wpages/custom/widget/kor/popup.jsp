<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<c:if test="${!empty popupList}">
<div id="divPopupMan" class="popstyle">
	<ul>
	<c:forEach var="result" items="${popupList}" varStatus="status">
		<li>
			<a href="${result.pop_link}" target="${result.pop_target}"><img id="imgPopupMan" class="popstyle" src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=${result.vchkcode}" alt="${result.pop_alt}" width="${result.pop_w}px" height="${result.pop_h}px"/></a>
			<label for="user_checkbox" class="ml20 font10">하루동안 열지 않기</label>&nbsp;<input type="checkbox" class="popup-close-chk" id="user_checkbox" name="user_checkbox" value="${result.pop_seq}" /><a href="#" class="popup-close" id="popup-${result.pop_seq}">닫기</a>
		</li>
	</c:forEach>
	</ul>
</div>
</c:if>


<script type="text/javascript">
$(document).ready(function()
{
	window.setTimeout(function(){
        var target = $("#divPopupMan");
        var win_height = $(window).height();
        var pop_height = target.height();
        var top_value = $(window).scrollTop() + (win_height - pop_height) /2;
        target.attr("tabindex","0");
        target.show().css("top",top_value);
        target.focus();
    },500);
	
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
		$("#header").focus();
		
		return false;
	});
	
});
</script>