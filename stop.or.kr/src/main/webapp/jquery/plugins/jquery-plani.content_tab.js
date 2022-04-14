/*----------------------------------------------------------------------------
 * Plugin	: jquery-plani.content_tab.js
 * ---------------------------------------------------------------------------
 * Author	: (주)플랜아이 http://plani.co.kr
 * ---------------------------------------------------------------------------
 * History
 * ---------------------------------------------------------------------------
 * 2014-08-18 (pigcos)	: 재작성
 * -------------------------------------------------------------------------*/
;(function($)
{
	$.fn.ContentTab	= function (options)
	{
		return this.each(function ()
		{
			var settings	= $.extend
			(
				{

					'selector_tab_group'	: '.tabmenu-2depth',
					'selector_tab_items'	: '.department-administration-content'
				},
				options
			);

			var $selector		= $(this);

			try
			{

				$selector.find(settings.selector_tab_group).children().each(function (i)
				{

					var target	= $(this).find('a:first').attr('href');

					if (target.match(new RegExp('\^#', 'i'))==null)
					{
						target	= '';
					}

					if (i==0)
					{
						$(this).addClass('on');

						if (target)
						{
							$selector.find(target).show();
						}
					}
					else
					{
						$(this).removeClass('on');

						if (target)
						{
							$selector.find(target).hide();
						}
					}

					$(this).find('a:first').click(function ()
					{

						if ($(this).attr('href').match(new RegExp('\^#', 'i'))!=null)
						{
							$selector.find(settings.selector_tab_items).hide();
							$selector.find(settings.selector_tab_group).children().removeClass('on');

							$(this).parent().addClass('on');

							$selector.find($(this).attr('href')).show();
							return false;
						}
					});
				});

			}
			catch (e)
			{
				$.debug(e);
			}
		});
	};

})(jQuery);
