/*-------------------------------------------------
Author : ㅈㅁㅈ
Create date : 2018-06-14
-------------------------------------------------*/

$(function()
{
	function web_navi()
	{	
		$(".main2020 #header.active nav").css({"height":$("#gnb").height()});
		$(".depth2 li:has(ul)").addClass('plus-bg');
		// 주메뉴 오버
		$('#gnb').find('a').on('mouseenter focusin', function()
		{
			$(this).parent('li').siblings('li').removeClass('active');
			$(".main2020 #header nav").css({"height":$("#gnb").height()})
			if ( $(this).next('.depth2').length > 0 )
			{
				if ($(this).parents('.depth2').length == 0)
				{
					$('#header').addClass('active');
					$(this).parent('li').addClass('active');
				}
			}
		});
		
		$('.depth2 ul li').on('mouseenter focusin', function(){
			$(this).parent().parent().parent().siblings().children().children().children().children().next().hide();
			$(this).siblings().children().next().hide();
			if ($(this).children().next("ul").length > 0) {
				$(this).children().next().show();
				$(".main2020 #header nav").css({"height":$("#gnb").height()})
			}else{
				$(".main2020 #header nav").css({"height":$("#gnb").height()})	
			}
		});

		$(".depth2 ul").on('mouseenter focusin', function(){
			$(this).parent().parent('li').addClass("active").siblings('li').removeClass('active');
		});

		// 주메뉴 아웃
		 $(document).on('mousemove', function(e)
		 {
		 	cursorY = e.pageY;
			
		 	if ( $('#gnb').find('.active').length > 0 )
		 	{
		 		if (cursorY > ($('#gnb').find('.depth2').offset().top + 60) + parseInt($('#gnb').find('.active .depth2').css('height')) )
		 		{
		 			//setTimeout(function()
		 			//{
		 			//	$('#header').removeClass('active');
		 			//	$('#gnb').find('li').removeClass('active');
		 		//	}, 0);
					$('#header').removeClass('active');
		 			$('#gnb').find('li').removeClass('active');
					$(".main2020 #header nav").css({"height":""});
		 		}
		 	}
		 });

		// 탭 아웃
		$('#gnb').find('a:last').on('keydown', function(e) 
		{
			if(e.keyCode === 9) 
			{
				//setTimeout(function()
				//{
				//	$('#header').removeClass('active');
				//	$('#gnb').find('li').removeClass('active');
				//}, 200);
					$('#header').removeClass('active');
		 			$('#gnb').find('li').removeClass('active');
					$(".main2020 #header nav").css({"height":"auto"})
			}
		});
	}
	
	$(window).on('resize', function()
	{
		// 주메뉴 이벤트 해제
		$(document).off('mousemove');
		$('#gnb').find('a').off();
		$('#gnb').find('a:last').off();

		// 웹일 때
		if ( $(window).width() >= 1025 )
		{		
			web_navi();
		}
		else
		{
			// 주메뉴 오버
			$('#gnb').find('a').on('click', function()
			{
				if ($(this).next('.depth2').find('li').length > 0)
				{
					if ( $(this).parent('li').hasClass('active') == false )
					{
						$(this).parent('li').addClass('active');
					}
					else
					{
						$(this).parent('li').removeClass('active');
					}

					return false;
				}
			});
			$(".main2020 #header nav").css({"height":""})
		}
	}).resize();
	
	// 전체메뉴 탭 아웃
	$('.allmenu').find('a:last').on('keydown', function(e) 
	{
		if ( $(window).width() >= 1025 )
		{
			if(e.keyCode === 9) 
			{
				$('.allmenu').find('a').blur(function()
				{
					$('.all-menu').focus();
				});
			}
		}
	});
	
	// 검색
	$('.util .search').find('.control').on('click', function()
	{
		if ( $(this).parent('.search').hasClass('active') == false )
		{
			$(this).parent('.search').addClass('active');
		}
		else
		{
			$(this).parent('.search').removeClass('active');
		}
		
		return false;
	});

	// 전체메뉴
	$('.all-menu').on('click', function()
	{
		// 웹일 때
		if ( $(window).width() >= 1025 )
		{
			if ( $(this.hash).css('display') == 'none' )
			{
				$('#header').addClass('active');
				$(this.hash).fadeIn();
				$(this).addClass('close');
				$("#gnb").addClass("allmenu-on");
				
				$(document).off('mousemove');
				$('#gnb').find('a').off();
				$('#gnb').find('li').removeClass('active');
			}
			else
			{
				$('#header').removeClass('active');
				$(this.hash).hide();
				$(this).removeClass('close');
				$("#gnb").removeClass("allmenu-on");
				
				web_navi();
			}
			/*
			if ( $('#spot').length == 1 )
			{
				$('#gnb > li').each(function(i)
				{
					if ( $(this).find('>a').text() ==  $('#spot').find('strong').text() )
					{
						if ( $('#gnb > li').eq(i).hasClass('active') == false )
						{
							$('#gnb').find('li').removeClass('active');
							$('#header').addClass('active');

							$('#gnb > li').eq(i).addClass('active');
							$('#gnb > li').eq(i).find('a:first').focus();
						}
						else
						{
							$('#gnb').find('li').removeClass('active');
							$('#header').removeClass('active');
						}
					}
				});
			}
			else
			{
				if ( $('#gnb > li').eq(0).hasClass('active') == false )
				{
					$('#gnb').find('li').removeClass('active');
					$('#header').addClass('active');

					$('#gnb > li').eq(0).addClass('active');
					$('#gnb > li').eq(0).find('a:first').focus();
				}
				else
				{
					$('#gnb').find('li').removeClass('active');
					$('#header').removeClass('active');
				}
			}
			*/
		}
		else
		{
			// 모바일일 때
			if ( $('#header').hasClass('active') == false )
			{
				$('#header').addClass('active');
			}
			else
			{
				$('#header').removeClass('active');
			}

			// 검색을 닫어라
			if ( $('.util .search').hasClass('active') == true )
			{
				$('.util .search').removeClass('active');
			}
		}

		return false;
	});

	// 배너존
	/*$('#bannerzone ul').bxSlider
	({
		auto			: true, 
		autoHover		: true,
		speed			: 1000,
		pause			: 3000,
		mode			: 'horizontal',	
		maxSlides		: 7,
		moveSlides		: 1,
		slideWidth		: 130,
		slideMargin		: 40,
		responsive		: true,
		pager			: false,
		autoControls	: true,
		controls		: true
	});*/
	
	// 레이어팝업
	if ( $('.layerpopup').length > 0 )
	{
		// 열기
		$('.btn-layerpopup2').on('click', function()
		{
			$(this.hash).fadeIn();
			
			$("input#nemail").val($('#nmail').val())
			
			return false;
		});
		
		// 닫기
		$('.layerpopup').find('.close').on('click', function()
		{
			$(this.hash).fadeOut();
			
			return false;
		});
	}
});

//롤링배너
function stateScrollObj(param,obj,btn,interval,speed,viewSize,moreSize,dir,data,auto,hover,method,op1){
	var param = $(param);
	var btn = $(btn);
	var obj = param.find(obj);
	
	var elem = 0;
	var objYScale = obj.eq(elem).outerHeight(true);
	var objXScale = obj.eq(elem).outerWidth(true);
	var str;
	var returnNodes;

	var playdir = data;
	var data = data; // 0:default, 1:prev

	var play = btn.find("[data-type=play]");
	var stop = btn.find("[data-type=stop]");
	
	if(auto == true) play.hide(); else stop.hide(); 
	if(op1 == true) obj.not(elem).css({opacity:0}).eq(elem).css({opacity:1});
	
	function movement(){
		
		switch(data){
			case 0:
				if(dir == "x"){
					obj.parent().stop(true,true).animate({left:-objXScale},{duration:speed,easing:method,complete:
						function(){
							obj.parent().css("left",0);
							str = obj.eq(elem).detach();
							obj.parent().append(str);
							if(elem == obj.size()-1){
								elem = 0;
							}else{
								elem++;
							}
							objXScale = obj.eq(elem).outerWidth(true);
						}
					});
				}else{ 
					obj.parent().stop(true,true).animate({top:-objYScale},{duration:speed,easing:method,complete:
						function(){
							obj.parent().css("top",0);
							str = obj.eq(elem).detach();
							obj.parent().append(str);
							if(elem == obj.size()-1){
								elem = 0;
							}else{
								elem++;
							}
							objYScale = obj.eq(elem).outerHeight(true);
						}
					});
				}

				if(op1 == true){
					obj.eq(elem).stop(true,true).animate({opacity:0},{duration:speed,easing:method});
					obj.eq(elem).next().stop(true,true).animate({opacity:1},{duration:speed,easing:method});
					//obj.eq(elem).stop(true,true).fadeOut(speed);
					//obj.eq(elem).next().stop(true,true).fadeIn(speed);
					//obj.eq(elem).css({"z-index":"0"});
					//obj.eq(elem).next().css({"z-index":"1"});
				}
			break;
			
			case 1:
				if(dir == "x"){
					if(elem == 0){
						elem = obj.size()-1;
					}else{
						elem--;
					}
					objXScale = obj.eq(elem).outerWidth(true);
					obj.parent().css("left",-objXScale);
					str = obj.eq(elem).detach();
					obj.parent().prepend(str);
					obj.parent().stop(true,false).animate({left:0},{duration:speed,easing:method});
				}else{
					if(elem == 0){
						elem = obj.size()-1;
					}else{
						elem--;
					}
					objYScale = obj.eq(elem).outerHeight(true);
					obj.parent().css("top",-objYScale);
					str = obj.eq(elem).detach();
					obj.parent().prepend(str);
					obj.parent().stop(true,false).animate({top:0},{duration:speed,easing:method});
				}

				if(op1 == true){
					obj.eq(elem).stop(true,false).animate({opacity:1},{duration:speed,easing:method});
					obj.eq(elem).next().stop(true,false).animate({opacity:0},{duration:speed,easing:method});
					//obj.eq(elem).stop(true,false).fadeIn(speed);
					//obj.eq(elem).next().stop(true,false).fadeOut(speed);
					//obj.eq(elem).css({"z-index":"1"});
					//obj.eq(elem).next().css({"z-index":"0"});
				}
			break;
			
			default: alert("warning, 0:default, 1:prev, data:"+data);
		}
	}

	function rotate(){
		clearInterval(returnNodes);
		returnNodes = setInterval(function(){
			movement();
		},interval);
	}

	if(obj.size() <= viewSize) return false;

	obj.find("a").bind("focusin",function(){
		clearInterval(returnNodes);
	});

	btn.find("a[data-type=play]").bind("click",function(event){
		data = playdir;
		play.hide();
		stop.show();
		rotate();
		return false;
	});

	btn.find("a[data-type=stop]").bind("click",function(event){
		clearInterval(returnNodes);
		param.find(":animated").stop();
		stop.hide();
		play.show();
		return false;
	});

	btn.find("a[data-type=prev]").bind("click",function(event){
		if(obj.parent().find(":animated").size()) return false;
		clearInterval(returnNodes);
		data = 1;
		movement();
		// add
		stop.hide();
		play.show();
		return false;
	});

	btn.find("a[data-type=next]").bind("click",function(event){
		if(obj.parent().find(":animated").size()) return false;
		clearInterval(returnNodes);
		data = 0;
		movement();
		// add
		stop.hide();
		play.show();
		return false;
	});

	if(hover == true){
		obj.hover(function(){
			clearInterval(returnNodes);
		},function(){
			rotate();
		});
	}

	if(auto == true) rotate();

	// 터치 이벤트  플리킹 구현
	var xStartpoint,xEndpoint;

	function docSTART(event){
		if(event.originalEvent.changedTouches != undefined){
			xStartpoint = Math.floor(event.originalEvent.changedTouches[0].clientX - $(this).offset().left);
		}
	}

	function docEND(event){
		if(event.originalEvent.changedTouches != undefined){
			xEndpoint = Math.floor(event.originalEvent.changedTouches[0].clientX - $(this).offset().left) - xStartpoint;
		
			if(xEndpoint < -50){ 
				data = 0;
			}else if(xEndpoint > 50){
				data = 1;
			}else{
				return true;
			} 

			clearInterval(returnNodes);

			stop.hide();
			play.show();

			movement();

			event.preventDefault();
		}
	}

	param.on("touchstart",docSTART);
	param.on("touchend",docEND);
}