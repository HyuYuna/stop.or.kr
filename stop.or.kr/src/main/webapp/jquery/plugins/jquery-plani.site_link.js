/*----------------------------------------------------------------------------
 * Plugin	: jquery-plani.site_link.js
 * ---------------------------------------------------------------------------
 * Author	: (주)플랜아이 http://plani.co.kr
 * ---------------------------------------------------------------------------
 * History
 * ---------------------------------------------------------------------------
 * 2014-08-08 (pigcos)	: 최초작성
 * -------------------------------------------------------------------------*/
;(function($)
{
	$.fn.SiteLink	= function (options)
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
			var TimeOut		= null;

			try
			{
				if ($selector.find(settings.label).length<1) { return false; }
				if ($selector.find(settings.items).length<1) { return false; }

				var timerIn	= function ()
				{
					clearTimeout(TimeOut);
					$selector.find(settings.items).show();
				};

				var timerOut	= function ()
				{
					TimeOut	= setTimeout
					(
						function ()
						{
							$selector.find(settings.items).hide();
						},
						settings.interval
					);
				};

				$selector.find(settings.label)
				.click(function ()
				{
					return false;
				})
				.hover
				(
					function () { timerIn(); },
					function () { timerOut(); }
				)
				.focus(function () { timerIn(); })
				.blur(function () { timerOut(); });

				$selector.find(settings.items).hover
				(
					function () { timerIn(); },
					function () { timerOut(); }
				);

				$selector.find(settings.items).find('a').each(function ()
				{
					$(this)
					.focus(function () { timerIn(); })
					.blur(function () { timerOut(); });
				});

				// 메뉴중 마지막 포커스 다음 포커스 가능 영역에 키 이벤트 부여
				var last		= $selector.find('a:last');
				var focusables	= $('a, input, textarea');
				var current		= focusables.index(last);
				var next		= focusables.eq(current+1).length ? focusables.eq(current+1) : focusables.eq(0);

				$(next)
				.keydown(function (event)
				{
					if (event.keyCode==9 && event.shiftKey==true)
					{
						timerIn();
					}
				});
			}
			catch (e)
			{

			}
		});

	};

})(jQuery);
