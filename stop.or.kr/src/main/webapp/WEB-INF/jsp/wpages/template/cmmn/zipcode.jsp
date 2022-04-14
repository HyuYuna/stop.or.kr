<%@page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<html>
<head>
<title>우편번호 찾기</title>

<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="keywords" content="${SESS_PROP_PRJTNM}" />
<meta name="description" content="${SESS_PROP_PRJTNM}" />
<meta name="author" content="㈜플랜아이 1644-5580" />
<meta name="copyright" content="COPYRIGHT@ 2013 ${SESS_PROP_PRJTNM} ALL RIGHTS RESERVED." />
<link href="${pageContext.request.contextPath}/css/contents/popup.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-1.9.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-migrate-1.2.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/core/jquery-ui-1.9.2.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plani/plani_common.js"></script>

<script type="text/javascript">

$(document).ready(function(){
	positLoading();
	$(window).resize(function(){positLoading();});
	jQuery("#searchKeyword").focus();
	
	
	jQuery("#searchKeyword").unbind("keypress");
	jQuery("#searchKeyword").keydown(function(event){
		if(event.keyCode == 13)
		{
			searchZipcode();
		}
	});
	
});

function positLoading(){
	var obj = $('#loading');
	$(obj).css('position', 'absolute');
	$(obj).css('top', Math.round(($(window).height() - $(obj).css('height').replace('px', '')) / 2));
	$(obj).css('left', Math.round(($(window).width() - $(obj).css('width').replace('px', '')) / 2));
}

function searchZipcode()
{
	var keyword = jQuery("#searchKeyword").val();
	
	if(keyword == '')
	{
		alert('검색어를 입력하여 주십시오.');
		return;
	}

	jQuery('#divSearchResult').html("");
	positLoading();
	jQuery('#loading').css('display', '');
	
	$.ajax({
		type: 'POST',
		dataType: 'xml',
		url: '${pageContext.request.contextPath}/findZipcode.do',
		data: 'searchKeyword=' + keyword,
		success: function(result, stat){
			var buf = '';
			
			if($(result).find('item').size() < 1)
			{
				buf = '<p style="align:center">검색된 결과가 없습니다.</p>';
				jQuery('#zipTable').append(buf);
			}
			else
			{
				jQuery(result).find('item').each(
					function(idx, el){
						var zip, zip1, zip2, addr, addr1;
						zip = $(el).find('postcd').text();
						zip1 = zip.substring(0, 3);
						zip2 = zip.substring(3);
						addr = $(el).find('address').text();
						addr1 = addr.replace(/ [0-9]+~[0-9]+/gi, '');
						
						//buf = '<tr><td class="txt_center">' + zip1 + '-' + zip2 + '</td><td>' + addr + '</td><td class="txt_center"><a href="javascript:setZipcode(\'' + zip1 + '\', \'' + zip2 + '\', \'' + addr1 + '\')">선택</a></td></tr>';
						buf = "<p><a href=\"javascript:selectZipcode('" + zip1 + "','" + zip2 + "','" + addr + "')\">[" + zip1 + "-" + zip2 +"] " + addr + "</a></p>";
						jQuery('#divSearchResult').append(buf);
					}	
				);
			}
			
			jQuery('#loading').css('display', 'none');
		},
		error: function(result, stat){
			alert('우편번호를 검색하는 도중 에러가 발생했습니다.');
		}
	});
}

function selectZipcode(zip1, zip2, addr){
	try{
		
		if(typeof opener != 'object'){
			alert('부모창과의 연결이 끊어졌습니다. 창을 닫은 후 다시 열어주십시오.');
		}
		else{
			
			jQuery("input[id$=zip_1]", opener.document).val(zip1);
			jQuery("input[id$=zip_2]", opener.document).val(zip2);
			jQuery("input[id$=addr_1]", opener.document).val(addr);
			window.close();
		}
	}
	catch(e){
		alert(e.message);
	}
}
</script>


</head>
<body>

<!-- 
<form action="${pageContext.request.contextPath}/findZipcode.do" method="post">
	읍/면/동 <input type="text" id="searchKeyword" name="searchKeyword" value=""/>
	<a href="javascript:searchZipcode()"><img src="${pageContext.request.contextPath}/images/template/sub/btn_srch.gif"/ class="img_valign"></a>
</form>

<table id="zipTable" width="550">
	<tr>
		<th width="20%">우편번호</th>
		<th width="60%">주소</th>
		<th width="20%">선택</th>
	</tr>
</table>
 -->
 
<div id="loading" style="display:none; width:300px; height:100px; text-align:center;">처리중입니다...</div>


<!-- 팝업창  -->
<div class="layout-popup">
	<div class="popup-wrap">
		<div class="header">
			<h1 class="hl">우편번호 검색</h1>
		</div>
		<div class="contents">
			<p class="tx align-center"><strong>주소(읍/면/동)를 입력해 주세요</strong></p>
			<div class="id-check">
				<label for="userid" class="hidden">주소 입력</label>
				<input type="text" id="searchKeyword" name="searchKeyword" value="" size="30" class="type3" />
				<a href="javascript:searchZipcode()">
					<img src="${pageContext.request.contextPath}/images/custom/02_sub/btn_post2.gif" title="우편번호 검색하기" />
				</a>
			</div>
			<div class="post-result">
				<div id="divSearchResult" class="result">
					[305-222] 우편번호 검색 결과
				</div>
			</div>
		</div>
		<p class="btn-close">
			<a href="javascript:self.close()">
				<img src="${pageContext.request.contextPath}/images/custom/63_sub/sub6303/btn_close.gif" alt="닫기" />
			</a>
		</p>
	</div>
</div>

<!-- 팝업창 // -->



</body>
</html>