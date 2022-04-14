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
		pause			: 5000,
		responsive		: true,
		pager			: false,
		autoControls	: false,
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
});