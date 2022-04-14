/*-------------------------------------------------
Author : ㅈㅁㅈ
Create date : 2018-06-21
-------------------------------------------------*/

$(function()
{
	// 로드될 때
	setTimeout(function()
	{
		$('html, body').scrollTop(0);
		$('body').addClass('active');

	}, 200);

	// 비주얼
	$('#visual ul').bxSlider
	({
		auto			: true, 
		autoHover		: true,
		mode			: 'fade',	
		speed			: 1000,
		pause			: 3000,
		responsive		: true,
		pager			: false,
		autoControls	: true,
		controls		: true,
		onSliderLoad	: function(currentIndex)
		{
			$('#visual .paging').find('span').text( $('#visual').find('li').length );
		},
		onSlideBefore 	: function($slideElement, oldIndex, newIndex)
		{
			$('#visual .paging').find('strong').text( (newIndex +1) );
		}
	});

	// 비주얼 텍스트
	$('#visual .desc p').lettering();
	$('#visual .paging p').text(' ');

	// 비주얼 활성화
	setTimeout(function()
	{
		$('#visual').addClass('active');

	}, 1500);

	// 비주얼 can not buy
	setTimeout(function()
	{
		$('#visual .paging p').typed
		({
			strings		: ["Cannot <br />Buy"],
			typeSpeed	: 50,
			backDelay	: 5000,
			loop		: true
		});

	}, 2000);

	// 이야기하기
	$('.story .desc a').on('click', function()
	{
		$('body').addClass('overflow');
		$(this.hash).addClass('active');

		$(this.hash).find('.step li').removeClass('active');
		$(this.hash).find('.step li').eq(0).addClass('active');

		$(this.hash).find('.group').removeClass('active');
		$(this.hash).find('.step').next('.group').addClass('active');

		return false;
	});

	// 이야기하기 버튼
	$('.story .btns a').on('click', function()
	{
		if ( $(this).hasClass('btn2') == true )
		{
			// 계속하기
			if ( $(this).parents('.group').next('.group').length == 0 )
			{
				$('body').removeClass('overflow');
				$(this).parents('#story').removeClass('active');
			}
			else
			{
				var inx = $(this).parents('.view').find('.step .active').index();

				$(this).parents('.view').find('.step li').removeClass('active');
				$(this).parents('.view').find('.step li').eq(inx + 1).addClass('active');

				$(this).parents('.group').removeClass('active');
				$(this).parents('.group').next('.group').addClass('active');
			}
		}
		else
		{
			// 그만하기
			$('body').removeClass('overflow');
			$(this).parents('#story').removeClass('active');
		}

		return false;
	});

	// 진흥원소식
	$('.news ul').bxSlider
	({
		auto			: true, 
		autoHover		: true,
		mode			: 'vertical',	
		speed			: 1000,
		pause			: 8000,
		responsive		: true,
		pager			: false,
		autoControls	: false,
		controls		: true
	});

	// 뉴스
	$('.latest').Tab
	({
		selector_title	: '.group h2',
	});

	// 오늘의 일정
	$('.schedule .item').bxSlider
	({
		auto			: false, 
		autoHover		: false,
		speed			: 1000,
		pause			: 8000,
		responsive		: true,
		pager			: false,
		autoControls	: false,
		controls		: true
	});

	// 팝업존
	$('.popupzone ul').bxSlider
	({	
		auto			: true, 
		autoHover		: true,
		mode			: 'fade',
		speed			: 1000,
		pause			: 3000,
		responsive		: true,
		pager			: true,
		autoControls	: true,
		controls		: false
	});

	// 링크
	$('.link').Slider
	({
		auto			: false,
		selector_item	: 'ul',
		direction		: 'left'
	});
});