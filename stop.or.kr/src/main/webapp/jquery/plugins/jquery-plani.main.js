/*----------------------------------------------------------------------------
 * Plugin	: jquery-plani.main.js
 * ---------------------------------------------------------------------------
 * 메인화면 스크립트
 * ---------------------------------------------------------------------------
 * Author	: (주)플랜아이 http://plani.co.kr
 * -------------------------------------------------------------------------*/
;(function($)
{
	/*----------------------------------------------------------------------------
	 * Main
	 * ---------------------------------------------------------------------------
	 * History
	 * ---------------------------------------------------------------------------
	 * 2014-08-08 (pigcos)	: 최초작성
	 * -------------------------------------------------------------------------*/
	$.fn.Main	= function (options)
	{
		return this.each(function ()
		{
			var settings	= $.extend
			(
				{
					'interval'	: 200,
					'label'		: '.link-label',
					'items'		: '.link-items'
				},
				options
			);

			var $selector	= $(this);

			try
			{
				$selector.children().each(function (index)
				{
					$(this).find('h2 > a').click(function ()
					{
						return false;
					})
					.hover
					(
						function ()
						{
							$selector.children('div').each(function (i)
							{
								if (i==index)
								{
									$(this).addClass('on');
									$(this).find('h2 > a img:first').ImageOver({type:'on'});
								}
								else
								{
									$(this).removeClass('on');
									$(this).find('h2 > a img:first').ImageOver({type:'off'});
								}
							});
						},
						function ()
						{
						}
					)
					.focus(function ()
					{
						$selector.children('div').each(function (i)
						{
							if (i==index)
							{
								$(this).addClass('on');
								$(this).find('h2 > a img:first').ImageOver({type:'on'});
							}
							else
							{
								$(this).removeClass('on');
								$(this).find('h2 > a img:first').ImageOver({type:'off'});
							}
						});

						// $selector.children('div').removeClass('on');
						// $selector.find($(this).attr('href')).addClass('on');
					});
				});

				// 포커스 요소들
				var focusables	= $('a, input, textarea');

				$selector.children().each(function (index)
				{
					var $group		= $(this).find('h2 > a');

					if (index-1>-1)
					{
						$group
						.keydown(function (event)
						{
							if (event.keyCode==9 && event.shiftKey==true)
							{
								$selector.children('div').removeClass('on');
								$selector.children('div').eq(index-1).addClass('on');
							}
						});
					}
				});

				// 메뉴중 마지막 포커스 다음 포커스 가능 영역에 키 이벤트 부여
				var last		= $selector.find('a:last');
				var current		= focusables.index(last);
				var next		= focusables.eq(current+1).length ? focusables.eq(current+1) : focusables.eq(0);

				$(next)
				.keydown(function (event)
				{
					if (event.keyCode==9 && event.shiftKey==true)
					{
						$selector.children('div').removeClass('on');
						$selector.children('div:last').addClass('on');
					}
				});
			}
			catch (e)
			{

			}
		});

	};

})(jQuery);