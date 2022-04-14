/*----------------------------------------------------------------------------
 * common.js
 * ---------------------------------------------------------------------------
 * Author	: (주)플랜아이 http://plani.co.kr
 * ---------------------------------------------------------------------------
 * History
 * ---------------------------------------------------------------------------
 * 2012-07-5(pigcos)	: 최초작성
 * -------------------------------------------------------------------------*/

 //조직도 content
var curr_visualnum = 1;
$(document).ready(function() {
	$(".org_wrap").hide();
	$(".org_img_area li:first").show();
	$(".org_wrap:first").show();
	$(".org_img_area li").click(function() {
	
		$(".org_wrap").hide();
		var activeTab = $(this).find("a").attr("href");
		$(activeTab).fadeIn();
		return false;
	});
	
	//fn_egov_tabctrl_init();

	//visual 좌 / 우 클릭시 이미지 변경하기
	jQuery(".btn_left", ".visual_control").on("click", function(){
		fn_egov_move_left($(this));
		return false;
	});
	jQuery(".btn_right", ".visual_control").on("click", function(){
		fn_egov_move_right($(this));
		return false;
	});
	
	fn_egov_mobile_facilities_init();
	
});

//.facilities_list .facilities_pic

function fn_egov_tabctrl_init()
{
	$(".tab_content, .facilities_pic").hide();
	
	//$(".tab_menu li:first, .airview_list li:first, .facilities_list li:first, .tab_menu_depth li:first, .tab_menu_depth .depth2 li:first").addClass("on").show();

	$(".tab_content:first, .facilities_pic:first").show();
	$(".tab_menu > li, .airview_list li, .facilities_list li, .tab_menu_depth > li").click(function(){
		
		// 선택된 1차 메뉴 처리
		$(".tab_menu > li, .airview_list li, .facilities_list li, .tab_menu_depth > li").removeClass("on");
		
		// 선택된 2차 메뉴 처리
		$('.depth2 > li').removeClass('on');
		$(this).addClass("on").find('.depth2 > li:first').addClass('on');

		// 선택된 메뉴에 따른 컨텐츠 처리
		$(".tab_content, .facilities_pic").hide();
		var activeTab = $(this).find("a").attr("href");
		$(activeTab).fadeIn();
		
		// 컨텐츠 이미지 인덱스 초기화
		curr_visualnum = 1;
		jQuery(".visual_number > img").each(function(){
			if($(this).attr("alt") == '1')
			{
				var src = $(this).attr("src");
				src = src.replace(/.png/, "");
				src = src.replace(/_on/, "");
				src += "_on.png"; 
				$(this).attr("src", src);
			}
			else
			{
				var src = $(this).attr("src");
				src = src.replace(/_on/, "");
				$(this).attr("src", src);
			}
		});
		
		return false;
	});

	$(".tab_menu_depth .depth2 li").click(function() {
		$(".tab_menu_depth .depth2 li").removeClass("on");
		$(this).addClass("on");

		$(".tab_content").hide();
		var activeTab = $(this).find("a").attr("href");
		$(activeTab).fadeIn();
		return false;
	});

}

//visual 좌 클릭시 이미지 변경하기
function fn_egov_move_left(target){
	
	var parobj = target.parent().parent();
	var imgcnt = parobj.find("ul > li").length;

	curr_visualnum = curr_visualnum - 1 < 1 ? imgcnt : curr_visualnum - 1; 
	var imgidx = curr_visualnum - 1;
	parobj.find("ul > li").hide();
	parobj.find("ul > li:eq(" + imgidx + ")").fadeIn('slow');

	var opncnt = 0;
	parobj.find(".visual_number > img").each(function(){
		var src = $(this).attr("src");
		src = src.replace(/.png/, "");
		src = src.replace(/_on/, "");
		if(opncnt == imgidx)
			src += "_on.png"; 
		else
			src += ".png";
		
		$(this).attr("src", src);	

		opncnt ++;
		
	});
}

//visual 우 클릭시 이미지 변경하기
function fn_egov_move_right(target){

	var parobj = target.parent().parent();
	var imgcnt = parobj.find("ul > li").length;
	curr_visualnum = curr_visualnum + 1 > imgcnt ? 1 : curr_visualnum + 1; 
	var imgidx = curr_visualnum - 1;
	parobj.find("ul > li").hide();
	parobj.find("ul > li:eq(" + imgidx + ")").fadeIn('slow');
	
	var opncnt = 0;
	parobj.find(".visual_number > img").each(function(){
		var src = $(this).attr("src");
		src = src.replace(/.png/, "");
		src = src.replace(/_on/, "");
		if(opncnt == imgidx)
			src += "_on.png"; 
		else
			src += ".png";
		
		$(this).attr("src", src);	

		opncnt ++;
		
	});
}

function fn_egov_mobile_facilities_init() {
	
	jQuery('map[name=inner_map] > area, map[name=out_map] > area').click(function(){
		// 이미지 인덱스 초기화
		curr_visualnum = 1;
		
		jQuery('.facilities_visual > article').each(function(){
			jQuery(this).hide();
		});
		
		var target = jQuery(jQuery(this).attr('href'));
		
		target.show();
		target.find("ul > li").hide();
		target.find("ul > li:first").fadeIn('slow');
		
		target.find(".visual_number > img").each(function(){
			var src = $(this).attr("src");
			src = src.replace(/.png/, "");
			src = src.replace(/_on/, "");
			
			if($(this).attr("alt") == 1)
				src += "_on.png"; 
			else
				src += ".png";
			
			$(this).attr("src", src);	
		});
	});
}

/* 조직도 */
function group(div){
	$(".hidden_content").slideUp(200);
	$(div).slideDown('slow');					
}

/* 전시 관람포인트 */
$(function(){
	
	$('.viewPoint a').click(function(){
		$('.viewPoint_detail').fadeOut();
		$(this).prev().fadeIn();		
	});
	$('.viewPoint_detail').click(function(){		
		$(this).fadeOut();		
	});
	
});	

/* 시설  */
$(function(){
	
	$('.dotLine_style h3').click(function(){
		var disp = $(this).next().css("display");
		var slide_speed = 200;
		if(disp == "none"){
			$(".hidden_content").slideUp(slide_speed);
			$(this).next().slideDown(slide_speed);
			$('h3').removeClass('on');
			$(this).addClass('on');
		}else{
			$(this).next().slideUp(slide_speed);
			$(this).removeClass('on');
		}
	});
	
});	

/* 경영공시 */
$(function(){
	
	$('.standard_detail > li > a').click(function(){
		var disp = $(this).next().css("display");
		var slide_speed = 200;
		if(disp == "none"){
			$(".hidden_content").slideUp(slide_speed);
			$(this).next().slideDown(slide_speed);
			$(this).addClass('on');
		}else{
			$(this).next().slideUp(slide_speed);
			$(this).removeClass('on');
		}						
	});
	
});	

/* 전시 하단 관련사진 슬라이드 */
$(window).load(function(){ //$(window).load() must be used instead of $(document).ready() because of Webkit compatibility				

	
	// Slideshow > Carousel
	$(".slideshow-carousel").sliderkit({
		panelfx:"fading",
		shownavitems:9,
		autospeed:3000,
		mousewheel:false,
		circular:true
	});
	
	
});

/* 추천코스 -3시간 */
function course(div){
		$('.hours3Tab > li > a').removeClass('on');
		$('.'+div).addClass('on');
		$('.hours3_con').hide();
		$('#'+div).fadeIn();
}
function course4(div){
	$('.hours4Tab > li > a').removeClass('on');
	$('.'+div).addClass('on');
	$('.hours4_con').hide();
	$('#'+div).fadeIn();
}
function course_day(div){
	$('.dayTab > li > a').removeClass('on');
	$('.'+div).addClass('on');
	$('.day_con').hide();
	$('#'+div).fadeIn();
}
