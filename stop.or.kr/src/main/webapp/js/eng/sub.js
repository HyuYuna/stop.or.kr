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

	// 카드뉴스
	if ( $('.board-news').find('.card').length == 1 )
	{
		$('.board-news .card').find('.count span').text( $('.board-news .card').find('li').length );
		
		// 내용
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
});