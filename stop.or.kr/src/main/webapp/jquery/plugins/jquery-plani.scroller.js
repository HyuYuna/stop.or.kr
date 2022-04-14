/*----------------------------------------------------------------------------
 * Plugin	: jquery-plani.article_tab.js
 * ---------------------------------------------------------------------------
 * Author	: (주)플랜아이 http://plani.co.kr
 * ---------------------------------------------------------------------------
 * History
 * ---------------------------------------------------------------------------
 * 2014-08-08 (pigcos)	: 최초작성
 * -------------------------------------------------------------------------*/
;(function($)
{
	$.fn.Scroller	= function (options)
	{
		return this.each(function ()
		{
			var settings	= $.extend
			(
				{
					'delay'		: 1,	// 딜레이 : 초
					'start'		: 0,	// 스크롤 위치 시작 포지션 top px
					'animate'	: true	// 에니메이션 사용(true), 미사용(false)
				},
				options
			);

			try
			{
				var $selector	= $(this);	

				// Check position absolute
				if ($selector.css('position')!='absolute') { return false; }
				
				var start	= settings.start;
				var top		= parseInt($selector.css('top'), 10);
				var delay	= settings.delay*1000;

				$(window).scroll(function()
				{
					var current = $(window).scrollTop();

					if (current>start)
					{
						if (settings.animate==true)
						{
							$selector.stop().animate({'top':parseInt(current+top-start, 10)}, delay);
						}
						else
						{
							$selector.css('top', parseInt(current+top-start, 10));
						}
					}
					else
					{
						if (settings.animate==true)
						{
							$selector.stop().animate({'top':parseInt(top, 10)}, delay);
						}
						else
						{
							$selector.css('top', parseInt(top, 10));							
						}
					}
				});

			}
			catch (e) {}
		});
	};

})(jQuery);
