<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>

<script type="text/javascript">
$(function() {
	function orderedItem() {
		$('.application-item').each(function(i) {
			$(this).find('.title').html(i+1);
			$(this).find(":input[name*='items[']").each(function () {
				var name = $(this).attr('name').split('.');
				var id = $(this).attr('id').split('.');
				$(this).attr('name', 'items['+i+'].'+name[1]);
				$(this).attr('id', 'items'+i+'.'+id[1]);
			});
			$(this).find("label[for*='items']").each(function () {
				console.log('label');
				var id = $(this).attr('for').split('.');
				$(this).attr('for', 'items'+i+'.'+id[1]);
			});
		});		
	}
	$('.item-add').live('click', function() {
		if ($('.application-item').size() < 5) {
			console.log('add');
			var addItem = $('.application-item').eq(0).clone().wrapAll("<div/>").parent();
			addItem.find('input[type=text]').val('').attr('value', '');
			addItem.find('input[type=file]').val('').attr('value', '');
			addItem.find('textarea').val('').html('');
			addItem.find('input[type=checkbox]').removeAttr('checked');
			addItem.find('input[type=radio]').removeAttr('checked');
			$('#application-body').append(addItem.html());
			orderedItem();
		} else {
			alert('공모분야별 최대 5점까지 접수 가능합니다.');
		}
		return false;
	});
	$('.item-delete').live('click', function () {
		if ($('.application-item').size() > 1) {
			if (confirm("출품작 정보를 삭제하시겠습니까?")) {
				console.log('delete');
				$(this).parents('.application-item').remove();
				orderedItem();
			}
		} else {
			alert('출품작 정보는 1개 이상이어야 합니다.')
		}
		return false;
	});
	
	$('.only-number').css('ime-mode', 'disabled').keydown(function (event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 ||keyID == 9 || keyID == 46 || keyID == 37 || keyID == 39 ) 
			return;
		else
			return false;		
	}).keyup(function (event){
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
			return;
		else
			event.target.value = event.target.value.replace(/[^0-9]/g, "");		
	}).blur(function () {
		if (parseInt($(this).val()) < 14) {
			alert('만 14세 미만의 미성년자의 경우 법정 대리인의 동의를 반드시 받아야 합니다.\n동의서 양식을 다운받아 작성한 후 center@stop.or.kr로 메일 보내주세요.');
		}
	});
	
	$('#email_select').change(function () {
		$('#email_host').val($(this).val());
	});
});
function submitCheck() {
	if (confirm("제출 이후에는 수정 및 삭제가 불가능 합니다.\n제출하시겠습니까?")) {
		$('#application-form').submit();
	}
}
</script>

<!-- 상세콘텐츠 영역 -->
<form:form id="application-form" commandName="complicityVO" enctype="multipart/form-data" class="ajax-form-submit">
<h2 class="title1">기본 정보 입력</h2>
<div class="table-wrap board-write form">
	<table>
		<caption>기본 정보 입력 - 성명, 연락처, 이메일, 나이, 소속</caption>
		<colgroup>
			<col width="150px" />
			<col width="" />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><label for="name">성명</label></th>
				<td>
					<form:input path="name" class="w340" id="name" />
				</td>
			</tr>
			<tr>
				<th scope="row">연락처</th>
				<td>
					<form:input path="tel_1" class="w100" title="연락처 중 첫번째자리" maxlength="3" /> -
					<form:input path="tel_2" class="w100" title="연락처 중 가운데자리" maxlength="4" /> -
					<form:input path="tel_3" class="w100" title="연락처 중 마지막자리" maxlength="4" />
				</td>
			</tr>
			<tr>
				<th scope="row">이메일</th>
				<td>
					<form:input path="email_id" class="w170" title="이메일 중 아이디" /> @
					<form:input path="email_host"  class="w170" title="이메일 중 도메인" />
					<form:select path="email_select" class="w170" title="이메일 중 도메인 선택">
						<form:option value="" label="직접입력" />
						<form:options items="${emailSelectList}"/>
					</form:select>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="age">나이</label></th>
				<td>
					<form:input path="age" class="w340 only-number" id="age" maxlength="3" />
					<a href="${cutil:getUrl('/down/(홍보분야_공모전)_만_14세_미만_아동의_개인정보처리를_위한_법정대리인_동의_서식(안)_180626.hwp', '', true)}" class="btn-s btn5">14세 미만 동의서 다운로드</a>
					<p class="point1">
						만 14세 미만의 미성년자의 경우 법정 대리인의 동의를 반드시 받아야 합니다. 동의서 양식을 다운받아 작성한 후 <span class="point3">center@stop.or.kr</span>로 메일 보내주세요
					</p>
					
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="belong">소속</label></th>
				<td>
					<form:input path="belong" class="w340" id="belong" />
				</td>
			</tr>
		</tbody>
	</table>
</div>

<%--
<p>items</p>
<ul>
       <c:forEach var="item" items="${complicityVO.items}">
       <li>${item.item_name}</li>
       </c:forEach>
</ul>

<input type="text" name="items[0].item_name" />
<input type="file" name="items[0].item_file" />
<input type="text" name="items[1].item_name" />
<input type="text" name="items[2].item_name" />
<input type="text" name="items[3].item_name" />
<form:input path="items[4].item_name" />

 --%>

<h2 class="title1">출품작 정보 입력</h2>
<a id="validation-items" href="#"></a>
<input type="hidden" name="validation-items" />
<div id="application-body">
<c:set var="itemCount" value="${fn:length(complicityVO.items) > 0 ? fn:length(complicityVO.items) : 1}" />
<c:set var="itemCount" value="${itemCount>=5 ? 5 : itemCount}" />
<c:forEach var="i" begin="0" end="${itemCount-1}" step="1">
	<div class="application-item">
		<div class="table-wrap board-write form">
			<table>
				<caption>출품작 정보 - 개인/팀 구분, 공모대상, 작품명, 작품 설명, 파일 첨부</caption>
				<colgroup>
					<col width="70px" />
					<col width="150px" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" rowspan="5" class="title">${i+1}</th>
						<th scope="row">개인/팀 구분</th>
						<td>
							<span class="form-set form-radio">
								<form:radiobutton path="items[${i}].item_division" value="1" label="개인" />
							</span>
							<span class="form-set form-radio">
								<form:radiobutton path="items[${i}].item_division" value="2" label="팀" />
							</span>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="part1">공모대상</label></th>
						<td>
							<form:select path="items[${i}].item_target" class="w250">
								<form:options items="${targetSelectList}"/>
							</form:select>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="subject1">작품명</label></th>
						<td>
							<form:input path="items[${i}].item_name" class="w520"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="desc1">작품 설명</label></th>
						<td>
							<form:textarea path="items[${i}].item_explain"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="file1">파일 첨부</label></th>
						<td>
							<%-- <form:input type="file" path="items[${i}].item_file"/> --%>
							<input type="file" id="items${i}.item_file" name="items[${i}].item_file" />
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<p class="btns txt-right">
			<a href="#" class="btn-m btn5 item-add">작품추가</a>
			<a href="#" class="btn-m btn2 item-delete">작품삭제</a>
		</p>
	</div>
</c:forEach>
</div>

<h3 class="title2">공모 분야별 최대 5점까지 접수 가능</h3>
<div class="box1">
	<ul class="bul1 float-left">
		<li>제출형태 : 이미지 파일(작품당 최대 5MB)</li>		
		<li>파일이름 : 작품명과 동일하게</li>
		<li>Gif, Png, Jpg, Bmp만 업로드 가능(HWP, PPT, AVI, PSD, AI 파일은 불가능)</li>
		<li>동영상의 경우 이메일 또는 유투브 등록 후 웹 경로 첨부</li>
	</ul>
	<ul class="bul1 float-left">
		<li>표어(슬로건)은 파일첨부 없이 작품 제목으로 대체가 가능합니다. </li>		
		<li>본선 진출작에 한하여 원본 요청 예정</li>
		<li>공모전 주제에 맞지 않을 경우, 심사에서 제외될 수 있습니다. </li>
		<li>중복 수상은 불가하며, 상위작을 우선하여 수상합니다. </li>
	</ul>
</div>



<h2 class="title1">설문조사</h2>
<div class="view-survey">
	<div class="box3 txt-center">
		매년 발전하는 공모전 운영을 위해 참가자 분들을 대상으로 설문을 실시하고 있습니다.<br /> 
		본 설문은 수상작 선정에 전혀 영향을 미치지 않으며, 통계를 위해서만 활용됩니다.
		<p class="point3">설문조사를 완료하셔야 정상적으로 접수가 완료됩니다.</p> 
	</div>
	
		<article class="group">			
			<article class="item">
				<h3>귀하의 성별은 무엇입니까?</h3>
				<ul class="form-survey">
					<li class="form-set form-radio">
						<form:radiobutton path="survey_gender" value="M" label="남성" />
					</li>
					<li class="form-set form-radio">
						<form:radiobutton path="survey_gender" value="F" label="여성" />
					</li>
				</ul>
			</article>
			
			<article class="item">
				<h3>귀하의 연령대는 무엇입니까?</h3>
				<ul class="form-survey">
					<li class="form-set form-radio">
						<form:radiobutton path="survey_age" value="10" label="10대" />
					</li>
					<li class="form-set form-radio">
						<form:radiobutton path="survey_age" value="20" label="20대" />
					</li>
					<li class="form-set form-radio">
						<form:radiobutton path="survey_age" value="30" label="30대" />
					</li>
					<li class="form-set form-radio">
						<form:radiobutton path="survey_age" value="40" label="40대" />
					</li>
					<li class="form-set form-radio">
						<form:radiobutton path="survey_age" value="50" label="50대" />
					</li>
					<li class="form-set form-radio">
						<form:radiobutton path="survey_age" value="60" label="60대 이상" />
					</li>
				</ul>
			</article>
			
			<article class="item">
				<h3>귀하의 현재 거주지는 어디입니까?</h3>
				<form:select path="survey_city" title="거주지">
					<form:options items="${citySelectList}"/>
				</form:select>
			</article>
			
			<article class="item">
				<h3>귀하가 공모전을 알게 된 경로는 무엇입니까?(중복체크 가능)</h3>
				<strong>(오프라인)</strong>
				<ul class="form-survey">
					<li class="form-set form-check">
						<form:checkbox path="survey_from" value="off1" label="교내 광고/게시판, 포스터" />
					</li>
					<li class="form-set form-check">
						<form:checkbox path="survey_from" value="off2" label="씽굿 공모전 잡지 및 광고" />
					</li>
					<li class="form-set form-check">
						<form:checkbox path="survey_from" value="off3" label="친구, 교수 등 지인소개" />
					</li>
					<li class="form-set form-check">
						<form:checkbox path="survey_from" value="off4" label="기타" />
					</li>
				</ul>
				<strong>(온라인)</strong>
				<ul class="form-survey">
					<li class="form-set form-check">
						<form:checkbox path="survey_from" value="on1" label="온라인 카페, 블로그, 게시판" />
					</li>
					<li class="form-set form-check">
						<form:checkbox path="survey_from" value="on2" label="인터넷 뉴스 기사" />
					</li>
					<li class="form-set form-check">
						<form:checkbox path="survey_from" value="on3" label="씽굿 공모전 홈페이지" />
					</li>
					<li class="form-set form-check">
						<form:checkbox path="survey_from" value="on4" label="페이스북" />
					</li>
					<li class="form-set form-check">
						<form:checkbox path="survey_from" value="on5" label="이메일" />
					</li>
					<li class="form-set form-check">
						<form:checkbox path="survey_from" value="on6" label="기타" />
					</li>
				</ul>
			</article>
			
			<article class="item">
				<h3>기타 의견(선택)</h3>
				<form:textarea path="survey_etc"/>
			</article>
		</article>
</div>

<p class="btns txt-center">
	<a href="#" onclick="submitCheck(); return false;" class="btn-l btn1">제출하기</a>
</p>
</form:form>
<!-- // -->
	          