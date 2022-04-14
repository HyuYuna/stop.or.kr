<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


	<!-- 다운로드 팝업 -->
	<article class="layerpopup type1" id="downlode">
		<form name="download_popup" class="pdown-submit" method="post">
	
		<input type="hidden" name="d_path" id="d_path" value="/${pageContext.request.contextPath}"/>
		<input type="hidden" name="d_vchkcode" id="d_vchkcode" value="${d_vchkcode}"/>
		<input type="hidden" name="div" id="div" value="${d_div}"/>
		<div class="group">
			<h2>[사용자]-[자료실] 하위 게시판들은 다운로드 시 <br />개인/기관 확인 후 다운로드 진행 <br />기관명 필수 개인은 별도 정보 수집 없음</h2>
			<div class="item">
				<div class="table-wrap">
					<table>
						<caption>다운로드 받으시는 분의 정보를 입력해 주세요.</caption>
						<thead>
							<tr>
								<th scope="col" class="txt-left">다운로드 받으시는 분의 정보를 입력해 주세요.</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="txt-left">
									<span class="form-set form-radio">
										<input type="radio" name="company_type" checked id="type1" value="2" />
										<label for="type1">기관</label>
									</span>
									<span class="form-set form-radio">
										<input type="radio" name="company_type" id="type2" value="3" />
										<label for="type2">개인</label>
									</span>
								</td>
							</tr>
							<tr>
								<td class="txt-left">
									<input type="text" name="name" id="name" title="기관명" placeholder="기관명">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
							
				<p class="btns txt-center">
					<input type="submit" class="btn-l btnl" value="다운로드">
					<a href="#downlode" class="btn-m btn2 close">닫기</a>
				<!-- 	<a href="" class="btn-l btn1">다운로드</a> -->
				</p>
			</div>
		</div>
	
	</form>
</article>
	<!-- //다운로드 팝업 -->
<script>
$('input[name=company_type]').click(function()
{
	if($(this).val() == 3) {
		$("#name").hide();
	}
	else if($(this).val() == 2) {
		$("#name").show();
	}
});
;jQuery(document).ready(function($)
{
	$('form.pdown-submit').submit(function() {
		$.ajax({
	        url 		: g_context+"/widgets/pdownload.do",
	        type  		: "post",
	        data		: $('form.pdown-submit').serialize(),
	        datatype	: "json",
			async 		: false,	        
			'success'	: function (result, status, xhr) {
 				if(result.error) {
					alert(result.messages.name);
					return false;
				} else {
					cmmfn_download_atchfile(g_context,result.data);
					$('article#downlode').hide();
				} 
	        },
			error: function(xhr, err){
	        	alert("에러가 발생했습니다.");
	        }
		});
		
		return false;
	});
	
	$('.layerpopup').find('.close').on('click', function()
	{
		$(this).parents('.layerpopup').fadeOut();
		
		return false;
	});
	
}); 

</script>