/*-------------------------------------------------
Author : ㅈㅁㅈ
Create date : 2018-06-14
-------------------------------------------------*/

$(function()
{
	function web_navi()
	{
		// 주메뉴 오버
		$('#gnb').find('a').on('mouseenter focusin', function()
		{
			if ( $(this).next('.depth2').length > 0 )
			{
				if ($(this).parents('.depth2').length == 0)
				{
					$('#header').addClass('active');
					$(this).parent('li').addClass('active');
					$(this).parent('li').siblings('li').removeClass('active');
				}
			}
		});

		// 주메뉴 아웃
		$(document).on('mousemove', function(e)
		{
			cursorY = e.pageY;
			
			if ( $('#gnb').find('.active').length > 0 )
			{
				if (cursorY > ($('#gnb').find('.depth2').offset().top) + parseInt($('#gnb').find('.active .depth2').css('height')) )
				{
					setTimeout(function()
					{
						$('#header').removeClass('active');
						$('#gnb').find('li').removeClass('active');
					}, 200);
				}
			}
		});

		// 탭 아웃
		$('#gnb').find('a:last').on('keydown', function(e) 
		{
			if(e.keyCode === 9) 
			{
				setTimeout(function()
				{
					$('#header').removeClass('active');
					$('#gnb').find('li').removeClass('active');
				}, 200);
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
				if ($(this).next('.depth2').length > 0)
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
				
				$(document).off('mousemove');
				$('#gnb').find('a').off();
				$('#gnb').find('li').removeClass('active');
			}
			else
			{
				$('#header').removeClass('active');
				$(this.hash).hide();
				$(this).removeClass('close');
				
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
	$('#bannerzone ul').bxSlider
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
	});
	
	// 레이어팝업
	if ( $('.layerpopup').length > 0 )
	{
		// 열기
		$('.btn-layerpopup').on('click', function()
		{
			$(this.hash).fadeIn();
			
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