<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>
<style>
/* 타이틀 */
.title1 {position:relative; margin:30px 0 20px; padding-left:20px; color:#000022;}
.title1:before {position:absolute; left:0; top:11px; width:14px; height:14px; border-radius:3px; background:linear-gradient(120deg, #6132a0, #a33fa5); content:'';}
.title1:after {position:absolute; left:4px; top:15px; width:6px; height:6px; background-color:#fff; content:'';}
.title1 .txt1 {font-size:1.6rem; font-weight:400;}
.title1 .txt1 strong {font-weight:400;}
.title2 {position:relative; margin:40px 0 10px; padding-left:20px; color:#000022;}
.title2:before {position:absolute; left:0; top:11px; width:9px; height:6px; box-shadow:0 2px #fff, 0 4px #3caab1; border-top:2px solid #3caab1; border-bottom:2px solid #3caab1; content:'';}
.title2:first-child {margin-top:0;}
.title3 {margin:30px 0 10px; font-size:2.1rem; font-weight:600; color:#000022;}
.title4 {margin:30px 0 10px; font-size:1.8rem; font-weight:600; color:#222;}
.title4:first-child {margin-top:0;}
.title5 {margin-bottom:25px; font-size:4.1rem; font-weight:400; color:#000; text-align:center; line-height:1.2;}

/* 박스 */
.box1 {display:inline-block; position:relative; z-index:0; width:100%; margin-bottom:30px; padding:25px; background-color:#f8f9fa;}
.box1 .item {display:table; position:relative; width:520px; max-width:100%; margin:0 auto; padding-left:120px; color:#000022;}
.box1 .txt {display:table-cell; position:relative; height:78px; vertical-align:middle;}
.box1 .icon {position:absolute; left:0; top:0;}
.box1 .bg {position:absolute; right:50px; bottom:0; z-index:-1;}
.box1 .bg img {max-width:100%;}
.box1 .bg + .txt {padding:0 160px 0 20px; font-size:1.8rem; font-weight:500; color:#000022; word-break:keep-all;}
.box1 .title {position:absolute; left:0; top:50%; width:130px; height:42px; margin-top:-21px; padding:0 30px; font-size:2rem; color:#fff; line-height:1.05;}
.box1 .title:before {position:absolute; left:50%; top:50%; width:70px; height:34px; margin:-17px 0 0 -35px; border-right:1px solid rgba(255, 255, 255, .2); border-left:1px solid rgba(255, 255, 255, .2); content:''; transform:rotate(-45deg); -webkit-transform:rotate(-45deg);}
.box1 .title span {display:block; font-weight:600; color:#343649; text-align:right;}
.box1 .title + .bg + .txt {padding-left:170px;}
.box1 .title + .bg + .txt:before {position:absolute; left:-25px; top:-25px; bottom:-25px; z-index:-1; width:130px; background-color:#55bbc1; content:'';}
.box1 .title.type1 + .bg + .txt:before {background-color:#617ec7;}
.box1 .title.type2 + .txt {padding-left:220px;}
.box1 .title.type2 + .txt:before {position:absolute; left:-25px; top:-25px; bottom:-25px; z-index:-1; width:170px; background:url('../../images/kor/sub/box1_type2.gif') no-repeat center center #42b083; content:'';}
.box1 .title.type2 + .txt strong {display:block; margin-bottom:10px; font-size:1.8rem; font-weight:600; color:#000022; line-height:1.555;}
.box1 .title.type2 + .txt strong span {color:#2a8861;}
.box1 .title.type2:before {width:154px; margin-left:-77px;}
.box1 .title.type2 {width:170px; padding:0; font-family:'Gotham'; font-weight:300; text-align:center; line-height:42px;}
.box1 .bul1.float-left {width:50%; padding-left:5px;}
.box1 + .title1 {margin-top:0;}
p.box1 {padding:30px 40px; font-size:1.8rem; font-weight:500; color:#000022;}

/* 설문내용 */
.board-view .view-survey {border-top:1px solid #cfd4d7;}
.view-survey {margin:-1px 0 20px; padding:50px; background-color:#f8f9fa;}
.view-survey + .btns {margin-bottom:-1px; background-color:#fff;}
.view-survey {counter-reset:group;}
.view-survey .group h2 {position:relative; padding-left:80px; font-size:2.2rem; font-weight:400; color:#000022;}
.view-survey .group h2:before {position:absolute; left:0; top:-8px; padding-top:5px; border-top:3px solid #000022; font-weight:600; counter-increment:group; content:"Part " counter(group) ".";}
.view-survey .group {counter-reset:item;}
.view-survey .group + .group {margin-top:65px;}
.view-survey .group .item h3 {margin-bottom:10px; color:#222;}
.view-survey .group .item h3:before {margin-right:5px; color:#5c2e98; counter-increment:item; content:"Q" counter(item) ".";}
.view-survey .group .item {margin-top:30px;}
.view-survey .group .item select {height:33px; padding:0 10px; border:1px solid #e0e1e5;}
.view-survey textarea {width:100%; padding:10px; border:1px solid #e0e1e5;}
</style>

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
		if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
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
	});
});
</script>

<!-- 상세콘텐츠 영역 -->
<form:form id="application-form" commandName="complicityVO" enctype="multipart/form-data" class="ajax-form-submit">
<h2 class="title1">기본 정보</h2>
<div class="table-wrap board-write form">
	<table class="tstyle_view">
		<caption>기본 정보 입력 - 성명, 연락처, 이메일, 나이, 소속</caption>
		<colgroup>
			<col width="150px" />
			<col width="" />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><label for="name">성명</label></th>
				<td>
					<c:out value="${complicityVO.name}" />
				</td>
			</tr>
			<tr>
				<th scope="row">연락처</th>
				<td>
					<c:out value="${complicityVO.tel}" />
				</td>
			</tr>
			<tr>
				<th scope="row">이메일</th>
				<td>
					<c:out value="${complicityVO.email}" />
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="age">나이</label></th>
				<td>
					<c:out value="${complicityVO.age}" />
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="belong">소속</label></th>
				<td>
					<c:out value="${complicityVO.belong}" />
				</td>
			</tr>
		</tbody>
	</table>
</div>

<h2 class="title1">출품작 정보</h2>
<a id="validation-items" href="#"></a>
<input type="hidden" name="validation-items" />
<div id="application-body">
<c:set var="itemCount" value="${fn:length(complicityVO.items) > 0 ? fn:length(complicityVO.items) : 1}" />
<c:set var="itemCount" value="${itemCount>=5 ? 5 : itemCount}" />
<c:forEach var="i" begin="0" end="${itemCount-1}" step="1">
	<div class="application-item" style="margin-bottom:20px">
		<div class="table-wrap board-write form">
			<table class="tstyle_view">
				<caption>출품작 정보 - 개인/팀 구분, 공모대상, 작품명, 작품 설명, 파일 첨부</caption>
				<colgroup>
					<col width="70px" />
					<col width="150px" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" rowspan="8" class="title">${i+1}</th>
						<th scope="row">접수번호</th>
						<td>
							<form:hidden path="items[${i}].data_id"/>
							<c:out value="${complicityVO.items[i].data_id}" />
						</td>
					</tr>
					<tr>
						<th scope="row">접수상태</th>
						<td>
							<form:select path="items[${i}].item_state" class="w250">
								<form:options items="${stateSelectList}"/>
							</form:select>
						</td>
					</tr>
					<tr>
						<th scope="row">수상결과</th>
						<td>
							<form:select path="items[${i}].item_awards" class="w250">
								<form:option value="" label="-- 선택 --" />
								<form:options items="${awardSelectList}"/>
							</form:select>
						</td>
					</tr>
					<tr>
						<th scope="row">개인/팀 구분</th>
						<td>
							${cutil:complicityDivision(complicityVO.items[i].item_division)}
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="part1">공모대상</label></th>
						<td>
							<c:out value="${complicityVO.items[i].item_target}" />
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="subject1">작품명</label></th>
						<td>
							<c:out value="${complicityVO.items[i].item_name}" />
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="desc1">작품 설명</label></th>
						<td>
							<c:out value="${complicityVO.items[i].item_explain}" />
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="file1">파일 첨부</label></th>
						<td>
							<c:set var="downloadParam" value="vchkcode=${complicityVO.items[i].atchfileVO.vchkcode}"/>
							<a href="${cutil:getUrl('/atchfile/downloadAtchfile.do', downloadParam, false)}" class="btn-s btn2">
								<c:out value="${complicityVO.items[i].atchfileVO.rname}" />
							</a>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</c:forEach>
</div>

<h2 class="title1">설문조사</h2>
<div class="view-survey">
		<article class="group">			
			<article class="item">
				<h3>귀하의 성별은 무엇입니까?</h3>
				<c:choose>
					<c:when test="${complicityVO.survey_gender eq 'M'}">								
					남성			
					</c:when>
					<c:when test="${complicityVO.survey_gender eq 'F'}">
					여성
					</c:when>
				</c:choose>				
			</article>
			
			<article class="item">
				<h3>귀하의 연령대는 무엇입니까?</h3>
				<c:choose>
					<c:when test="${complicityVO.survey_age eq '10'}">								
					10대			
					</c:when>
					<c:when test="${complicityVO.survey_age eq '20'}">
					20대
					</c:when>
					<c:when test="${complicityVO.survey_age eq '30'}">
					30대
					</c:when>
					<c:when test="${complicityVO.survey_age eq '40'}">
					40대
					</c:when>
					<c:when test="${complicityVO.survey_age eq '50'}">
					50대
					</c:when>
					<c:when test="${complicityVO.survey_age eq '60'}">
					60대 이상
					</c:when>
				</c:choose>				
			</article>
			
			<article class="item">
				<h3>귀하의 현재 거주지는 어디입니까?</h3>
				<c:out value="${complicityVO.survey_city}"/>
			</article>
			
			<article class="item">
				<h3>귀하가 공모전을 알게 된 경로는 무엇입니까?(중복체크 가능)</h3>
				<div>
					<strong>(오프라인)</strong>
					${cutil:complicityFromString(complicityVO.survey_from, "off.*", ", ")}
				</div>
				<div>
					<strong>(온라인)</strong>
					${cutil:complicityFromString(complicityVO.survey_from, "on.*", ", ")}
				</div>
			</article>
			
			<article class="item">
				<h3>기타 의견(선택)</h3>
				<c:out value="${complicityVO.survey_etc}"/>
			</article>
		</article>
</div>

<div class="btn_area_right">
	<input type="submit" value="수정" class="btn_linebold" />
	<a href="${cutil:getUrl('/metsys/complicityDelete.do', '', true)}" onclick="if (confirm('삭제하시겠습니까?') == false) { return false; }" class="btn_line">삭제</a>
	<a href="${cutil:getUrl('/metsys/complicityList.do', 'group_id=&data_id=', true)}" class="btn_line">목록</a>
</div>		

</form:form>
<!-- // -->