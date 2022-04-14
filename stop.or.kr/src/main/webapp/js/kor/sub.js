/*-------------------------------------------------
Author : ㅈㅁㅈ
Create date : 2018-06-18
-------------------------------------------------*/

$(function()
{
	// 패쓰
	$('.path').find('.label a').on('click', function()
	{
		if ($(this).parents('.group').hasClass('active') == false)
		{
			$(this).parents('.group').addClass('active');
		}
		else
		{
			$(this).parents('.group').removeClass('active');
		}

		return false;
	});
	
	// 3뎁스 서브메뉴
	$('#snb').find('.depth2 .active a').on('click', function()
	{
		if ( $(window).width() < 1251 )
		{
			if ( $(this).parents('.depth2').hasClass('active') == false )
			{
				$(this).parents('.depth2').addClass('active');
			}
			else
			{
				$(this).parents('.depth2').removeClass('active');
			}
			
			return false;
		}
	});
	
	// 공유하기
	$(window).on('resize', function()
	{
		if ( $(window).width() < 1025 )
		{		
			if ( $('.cont-util').find('.control').length == 0 )
			{
				$('.cont-util').find('.sns').before('<a href="" class="control">공유하기</a>');
			}
		}
		else
		{
			$('.cont-util').find('.control').remove();
		}
	}).resize();
	
	$('.cont-util').find('.control').on('click', function()
	{
		if ( $(this).next('.sns').hasClass('active') == false )
		{
			$(this).next('.sns').addClass('active');
		}
		else
		{
			$(this).next('.sns').removeClass('active');
		}
		
		return false;
	});

	// 카드뉴스
	if ( $('.board-news').find('.card').length == 1 )
	{
		$('.board-news .card').find('.count span').text( $('.board-news .card').find('li').length );
		
		// 내용
		if ( $('.board-news').find('.card').hasClass('webtoon') == false )
		{
			$('.board-news').find('.card ul').bxSlider
			({
				auto			: false, 
				autoHover		: true,
				speed			: 1000,
				pause			: 3000,
				responsive		: true,
				pager			: false,
				autoControls	: true,
				controls		: true,
				onSlideBefore 	: function($slideElement, oldIndex, newIndex)
				{
					$('.board-news .card').find('.count strong').text( newIndex + 1 );
				}
			});
		}

		// 리스트
		$('.board-card ul').bxSlider
		({
			auto			: false, 
			autoHover		: true,
			speed			: 1000,
			pause			: 3000,
			maxSlides		: 5,
			moveSlides		: 1,
			slideWidth		: 149,
			slideMargin		: 20,
			responsive		: true,
			pager			: false,
			autoControls	: true,
			controls		: true
		});
	}

	// 북마크 있을 때
	if ( $('.bookmark').length > 0 )
	{
		$('.bookmark').find('a').on('click', function()
		{
			$('html, body').animate({ scrollTop : $(this.hash).offset().top });

			return false;
		});
	}
	
	// 서브메뉴 상단 고정 (줌인이랑 공모전)
	if ( $('#snb').length > 0 )
	{
		if ( $('#snb').hasClass('fixed') == false )
		{
			$(window).on('resize', function()
			{
				var snboffset = $('#snb').offset().top;
				
				//console.log(snboffset);
				
				$(window).on('scroll', function()
				{
					if ( $(window).scrollTop() >= snboffset )
					{
						$('#snb').addClass('fixed');
					}
					else
					{
						$('#snb').removeClass('fixed');
					}
				});
				
			}).resize();
		}
	}
	
	/*클릭시 다운로드 레이어 팝업 ajax*/
/*	$('.btn-layerpopup').on('click', function()
	{
		$.ajax({
	        url 		: $(this).attr('data-url'),
	        type  		: "get",
	        datatype	: "html",
			async 		: false,	        
	        success 	: function(data){
	        	$('div#contents').after(data);
	        	$('article#downlode').show();
	        }
		});
		
	});*/
	
	// 팝업 닫기 (개발페이지에서 직접사용중)
//	$('.layerpopup').find('.close').on('click', function()
//	{
//		$(this).parents('.layerpopup').fadeOut();
//		
//		return false;
//	});
	
	/* 탭메뉴 - 2018.08.10 JYC */
	$(".tabmenu li a").click(function() {
		$(this).parent().addClass('active').siblings().removeClass('active');
		$(".tab-con").hide();

		var activeTab = $(this).attr("href");
		$(activeTab).fadeIn();

		return false;
	});
	
	/* 조직도 눌렀을 때 */
	$('.org').find('a.label').on('click', function()
	{
		/*var orgTarget = $(this).attr("href");
		
		$(".tab-con").hide();
		$(this.hash).show();
		$('html,body').animate({scrollTop:$('.tabmenu').offset().top});
		
		$('.tabmenu li').removeClass('active');
		$('.tabmenu li').each(function(i)
		{
			if ( orgTarget == $(this).find('a').attr('href') )
			{
				$(this).addClass('active');
			}
		});
		
		return false;	*/	
	});
	
	/* 조직도 스크립트 YCH*/
	$('a#org_btn').click(function(e)
	{
		$('div#tab1').show();
		$('div#tab2').show();
		$('div#tab3').show();
		$('div#tab4').show();
		$('table > tbody > tr > td').removeClass('point3');
		
		var temp = $("table > tbody > tr > td:contains('" + $(this).parent().find('input').val() + "')");
		
		$.each(temp, function(index) {
			temp.eq(index).addClass('point3');
        });
		
		var offset = $(temp.eq(0)).offset();

        $('html,body').animate({scrollTop : offset.top}, 400);



		return false;
		
	});
	
	$('a#exc_btn').click(function(e)
	{
		$('div#tab8').show();
		$('table > tbody > tr > td').removeClass('point3');
		
		var temp = $("table > tbody > tr > td:contains('" + $(this).parent().find('input').val() + "')");
		
		$.each(temp, function(index) {
			temp.eq(index).addClass('point3');
        });
		
		var offset = $(temp.eq(0)).offset();

        $('html,body').animate({scrollTop : offset.top}, 400);



		return false;
		
	});

	if($('#ucont_id').val() == 'CTX000020' && $('#a_em1').parent().attr('class') == 'active'){
		 var pcDevice = "win16|win32|win64|mac|macintel";

	    if ( navigator.platform ) {
	        if ( pcDevice.indexOf(navigator.platform.toLowerCase()) < 0 ) {
	           $('#emtagM1').show();
	           $('#emtagP1').hide();
	        } else {
	           $('#emtagP1').show();
	           $('#emtagM1').hide();
	        }
	    }
	}
	
	$('#a_em1').click(function(e)
	{
	    var pcDevice = "win16|win32|win64|mac|macintel";

	    if ( navigator.platform ) {
	        if ( pcDevice.indexOf(navigator.platform.toLowerCase()) < 0 ) {
	           $('#emtagM1').show();
	           $('#emtagP1').hide();
	        } else {
	           $('#emtagP1').show();
	           $('#emtagM1').hide();
	        }
	    }
	});
	
	$('#a_em2').click(function(e)
	{
	    var pcDevice = "win16|win32|win64|mac|macintel";

	    if ( navigator.platform ) {
	        if ( pcDevice.indexOf(navigator.platform.toLowerCase()) < 0 ) {
	           $('#emtagM2').show();
	           $('#emtagM3').show();
	           $('#emtagP2').hide();
	           $('#emtagP3').hide();
	        } else {
	           $('#emtagP2').show();
	           $('#emtagP3').show();
	           $('#emtagM2').hide();
	           $('#emtagM3').hide();
	        }
	    }
	});
	
	//
	/*
	if ( $('.tabmenu').length == 0 )
	{
		if ( $('#snb').find('.active .depth2').length > 0 )
		{
			$('#main').addClass('respond');
		}
	}
	*/
});