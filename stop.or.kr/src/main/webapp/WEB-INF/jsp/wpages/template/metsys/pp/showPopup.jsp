<%@page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 부터 창팝업 스크립트 -->
<script language="javascript">
function hide_pop(seq){
	$('#pop_' + seq).css('display', 'none');
}

function hide_pop_today(seq){
	//TODO: cookie 설정
	var date = new Date();
	date.setDate(date.getDate() + 1);
	document.cookie = 'ck_pop_' + seq + '=' + escape('true') + ';expires=' + date.toGMTString();
	hide_pop(seq);
}

$(document).ready(function(){
	/* 창팝업 표시 */
	$.ajax({
		url: '/findValidPopup.do',
		type: 'GET',
		data: 'pop_type=W',
		dataType: 'xml',
		success: function(result, stat){
			$(result).find('popup').each(function(idx, el){
				/* 팝업 속성값들 */
				var seq = $(el).find('seq').text();
				var popX = $(el).find('popX').text();
				var popY = $(el).find('popY').text();
				var popW = $(el).find('popW').text();
				var popH = $(el).find('popH').text();
				var popImage = $(el).find('popImage').text();
				var popAlt = $(el).find('popAlt').text();
				var popLink = $(el).find('popLink').text();
				var popTarget = $(el).find('popTarget').text();
				var popContent = $(el).find('popContent').text();
				if(document.cookie.indexOf('ck_pop_' + seq) < 0){	//쿠키가 없을때만 띄웁니다.
					/* 팝업 관련 엘리먼트들 */
					var outer = document.createElement('DIV');
					var content = document.createElement('DIV');
					var bar = document.createElement('DIV');
					var img;
					
					//하단 오늘하루 열지 않음 DIV
					$(bar).html('<div style="float:left; color:#FFFFFF; line-height:30px;">'
							+	 '<input type="checkbox" id="close_pop_' + seq + '" onclick="hide_pop_today(' + seq + '); return false;" onkeypress="hide_pop_today(' + seq + '); return false;"/><label for="close_pop_' + seq + '">오늘 하루 이 창을 열지 않습니다.</label>'
							+ '</div>'
							+ '<div style="float:right;"><a href="" onclick="hide_pop(' + seq + '); return false;" onkeypress="hide_pop(' + seq + '); return false;" style="color:#FFFFFF;"><img src="/images/template/cmm/pop_x.gif" alt="닫기"/></a></div>');
					$(bar).css('width', popW + 'px')
							.css('height', '30px')
							.css('background-color', '#000000')
							.css('padding', '0')
							.css('margin', '0')
							;

					if($.browser.msie)	$(bar).css('filter', 'alpha(opacity=70)');
					else				$(bar).css('opacity', '0.7');
	
					
					/* 이미지가 있을 경우 이미지가 우선 */
					if(popImage != ''){
						img = document.createElement('IMG');
						
						$(img).prop('src', popImage)
								.prop('alt', popAlt);
					}
					else{
						img = document.createElement('DIV');
						$(img).css('background-color', '#FFFFFF')
								.css('border', '1px solid #000000')
								;
						$(img).html(popContent);
					}
					
					//팝업 내용에 너비/높이 설정
					$(img).css('width', popW)
							.css('height', popH);
					
	
					$(content).css('line-height', '0px')
							;

					$(outer).prop('id', 'pop_' + seq);
					$(outer).css('width', popW + 'px')
							.css('height', (popH + $(bar).css('height').replace('px', '')) + 'px')
							.css('position', 'absolute')
							.css('top', popY + 'px')
							.css('left', popX + 'px')
							.css('padding', '0')
							.css('margin', '0')
							;

					//링크주소가 입력되어 있으면 A태그 생성
					if(popLink != ''){
						var a = document.createElement('A');
						$(a).prop('id', 'pop_link_' + seq)
							.prop('href', popLink)
							.prop('target', popTarget)
							;
						$(a).append(img);
						$(content).append(a);
						$('#pop_link_' + seq).append(img);
					}
					else{
						$(content).append(img);						
					}
					
					$(outer).append(content);
					$(outer).append(bar);
					$('body').append(outer);
				}
			});
			
		},
		error: function(result, stat){
			
		}
	});
});
</script>
<!-- 까지 창팝업 스크립트 -->




<!-- 부터 팝업존 스크립트 -->
<script language="javascript">	
var pzTid;	//타이머 ID
var baseZIndex = '50';	//선택된 이미지에 사용될 z-index
var pzCnt = 0;	//팝업존 개수
var pzPlay = true; // 페이지 이동 후에 다시 재생 여부

/**
 * 다음에 표시할 팝업존 인덱스
 */
function getNextPzIdx(pzIdx){
	var nextIdx = parseInt(pzIdx, 10) + 1;
	if(nextIdx > pzCnt - 1)	nextIdx = 0;
	return nextIdx;
}

/**
 * 현재 보이는 팝업존 이미지 object
 */
function getTopPzEl(){
	var pzEls = $('#pz_elements').find('img');
	$(pzEls).each(function(idx, el){
		if($(el).css('z-index') == baseZIndex){	//z-index가 baseZIndex인게 현재 보이는 이미지
			topEl = el;
			return false;
		}
	});
	return topEl;
}

/**
 * 팝업존 이미지 변경
 */
function changePz(pzIdx){
	if(pzIdx == undefined) pzIdx = 1;
	var pzEls = $('#pz_elements').find('img');
	
	var btnIdx = pzIdx + 1;
	if(btnIdx > pzCnt - 1) btnIdx = 0;
	$('#pz_buttons').find('img').each(function(idx, el){
		$(el).prop('src', $(el).prop('src').replace('_on', ''));
	});
	$('#pz_btn_' + pzIdx).prop('src', $('#pz_btn_' + pzIdx).prop('src').replace('.jpg', '_on.jpg'));
	
	//가장 위에 보이는 element(z-index가 baseZIndex인 element)를 구해서
	$(pzEls).each(function(idx, el){
		if($(el).css('z-index') != baseZIndex){
			$(el).css('z-index', baseZIndex - 2);
		}
	});

	var topEl = getTopPzEl();
	var clickEl = null;
	
	if($(topEl).prop('id') == 'pz_' + pzIdx) return false;

	//클릭한 element를 curEl 바로 아래에 끼워 넣고
	clickEl = $('#pz_' + pzIdx);
	$(clickEl).css('z-index', baseZIndex - 1);

	//topEl을 fadeOut 실행
	$(topEl).fadeOut(500, function(){
		//topEl을 바닥으로 보냄
		$(clickEl).css('z-index', baseZIndex);
		$(topEl).css('z-index', baseZIndex - 2);
		$(topEl).fadeIn(0);
		
		if(pzPlay)
			pzTid = setTimeout('changePz(' + getNextPzIdx(pzIdx) + ')', 2000);
	});
}

/**
 * 페이지 강제 이동
 */
function movePz(pzIdx){
	var topEl = getTopPzEl();
	
	if($(topEl).prop('id') == 'pz_' + pzIdx) return false;
	stopPz(pzPlay);
	changePz(pzIdx);
	
}

/**
 * 팝업존 정지
 */
function stopPz(tf){
	var topEl = getTopPzEl();
	if(!pzPlay) return false;
	var fx = $(topEl).queue('fx').length;
	if(fx > 0){
		$(topEl).stop(true, true);
	}
	pzPlay = tf;
	clearTimeout(pzTid);
}

/**
 * 팝업존 재생
 */
function startPz(){
	var topEl = getTopPzEl();
	if(pzPlay){	//오류방지
		return false;		
	}

	pzPlay = true;
	var tmpId = $(topEl).prop('id');
	tmpId = tmpId.substring(tmpId.lastIndexOf('_') + 1);
	changePz(getNextPzIdx(tmpId));
}


$(document).ready(function(){	
	/* 팝업존 표시 */
	$.ajax({
		url: '/findValidPopup.do',
		type: 'GET',
		data: 'pop_type=Z',
		dataType: 'xml',
		success: function(result, stat){
			var pzWidth = 400, pzHeight = 250;
			
			var pzEl = $('#pz_elements');
			var pzWrap = $('#pz_wrapper');
			var pzBtn = $('#pz_buttons');
			var pzCtrl = $('#pz_control');
			
			//팝업존 외곽
			$(pzWrap).css('position', 'relative')
					.css('z-index', '0');
			
			//정지 재생 단추
			$(pzCtrl).css('position', 'absolute')
			.css('z-index', baseZIndex + 1)
			.css('top', pzHeight - 30)
			.css('left', pzWidth - 50)
			;
			
			//직접 이동 단추
			$(pzBtn).css('position', 'absolute')
			.css('z-index', baseZIndex + 2)
			.css('top', pzHeight - 30)
			.css('left', '10px')
			;
			
			$(result).find('popup').each(function(idx, el){
				var seq = $(el).find('seq').text();
				var popImage = $(el).find('popImage').text();
				var popAlt = $(el).find('popAlt').text();
				var popLink = $(el).find('popLink').text();
				var popTarget = $(el).find('popTarget').text();
				
				if(popImage != ''){	//이미지가 있을때만 추가 합니다.
	
					img = document.createElement('IMG');
					
					$(img).prop('src', popImage)
							.prop('id', 'pz_' + pzCnt)
							.prop('alt', popAlt)
							.css('width', pzWidth + 'px')
							.css('height', pzHeight + 'px')
							.css('position', 'absolute')
							.css('z-index', baseZIndex - pzCnt)
							;
					
					if(popLink != ''){
						$(img).css('cursor', 'pointer');
						$(img).bind({
							click: function(){
								if(popTarget == '') location.href=popLink;
								else				window.open(popLink, '', '');
							},
							keypress: function(){
								if(popTarget == '') location.href=popLink;
								else				window.open(popLink, '', '');								
							}
						});
					}
							
					pzEl.prepend(img);
					
					if(pzCnt == 0)
						pzBtn.append('<a href=""><img id="pz_btn_' + pzCnt + '" src="/images/template/cmm/pz_button_on.jpg" style="margin-left:3px;" onkeypress="alert(\'\'); movePz(\'' + pzCnt + '\'); return false;" onclick="movePz(\'' + pzCnt + '\'); return false;"/></a>');
					else
						pzBtn.append('<a href=""><img id="pz_btn_' + pzCnt + '" src="/images/template/cmm/pz_button.jpg" style="margin-left:3px;" onkeypress="movePz(\'' + pzCnt + '\'); return false;" onclick="movePz(\'' + pzCnt + '\'); return false;"/></a>');

					pzCnt++;
				}

			});
			
			// 팝업존이 2개일때부터 실행
			if(pzCnt > 1){
				tidPz = setTimeout('changePz()', 1000);
			}
		},
		error: function(result, stat){
			alert('error');	
		}
	});

});
</script>
<!-- 까지 팝업존 스크립트 -->


<a href="" onclick="clearCookie(); return false;">쿠키삭제</a><br/>

<a href="popList.do" onclick="history.go(-1); return false;" onkeypress="history.go(-1); return false;" style="font-size:100px;">목록으로 돌아가기</a>
<br/>


<div id="pz_wrapper">
	<div id="pz_elements" style="height:250px;"></div>
	<div id="pz_buttons"></div>
	<div id="pz_control">
		<a href="" onclick="stopPz(false); return false;">■</a>
		<a href="" onclick="startPz(); return false;">▶</a>
	</div>
</div>
