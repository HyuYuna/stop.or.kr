/*----------------------------------------------------------------------------
 * Plugin	: jquery-plani.article_tab.js
 * ---------------------------------------------------------------------------
 * Author	: (주)플랜아이 http://plani.co.kr
 * ---------------------------------------------------------------------------
 * History
 * ---------------------------------------------------------------------------
 * 2012-01-29 (pigcos)	: 최초작성
 * 2014-05-10 (pigcos)	: 재작성
 * -------------------------------------------------------------------------*/
;(function($)
{
	$.fn.ArticleTab	= function (options)
	{
		return this.each(function ()
		{
			var settings	= $.extend
			(
				{
					'selector_tab_group'	: '.tab-item',
					'selector_tab_title'	: '.tab-btn > a:first',
					'selector_tab_items'	: '.tab-item-list',
					'tab_type'				: 'hover',	// hover, click
					'changeTab'				: function ($selector, settings, index)
					{
						$selector.find(settings.selector_tab_group).each(function (i)
						{
							if (index==i)
							{
								$(this).find(settings.selector_tab_items).show();
							}
							else
							{
								$(this).find(settings.selector_tab_items).hide();
							}
						});
					}
				},
				options
			);

			var $selector		= $(this);

			try
			{
				// 탭 갯수 체크
				if ($selector.find(settings.selector_tab_group).size()<2) { return false; }

				// 텝 이벤트 체크
				if ($.inArray(settings.tab_type, ['hover', 'click'])==-1) { return false;}

				$selector.find(settings.selector_tab_group).each(function (index)
				{
					if (index==0) { $(this).find(settings.selector_tab_items).show(); }
					else { $(this).find(settings.selector_tab_items).hide(); }

					if (settings.tab_type=='hover')
					{
						$(this).find(settings.selector_tab_title)
						.hover
						(
							function ()
							{
								settings.changeTab($selector, settings, index);	
							},
							function ()
							{
							}
						)
						.click(function ()
						{
							return false;
						});
					}

					if (settings.tab_type=='click')
					{
						$(this).find(settings.selector_tab_title)
						.click(function ()
						{
							settings.changeTab($selector, settings, index);
							return false;
						});
					}

					$(this).find(settings.selector_tab_title)
					.focus(function ()
					{
						settings.changeTab($selector, settings, index);
					});

				});

				var focusables	= $('a, input, textarea');

				$selector.find(settings.selector_tab_group).each(function (index)
				{
					var $group		= $(this).find(settings.selector_tab_title);

					if (index-1>-1)
					{
						$group
						.keydown(function (event)
						{
							if (event.keyCode==9 && event.shiftKey==true)
							{
								settings.changeTab($selector, settings, index-1);
							}
						});
					}
				});

				// 마지막 포커스 다음 포커스 가능 영역에 키 이벤트 부여
				var last		= $selector.find('a:last');
				var current		= focusables.index(last);
				var next		= focusables.eq(current+1).length ? focusables.eq(current+1) : focusables.eq(0);

				$(next)
				.keydown(function (event)
				{
					if (event.keyCode==9 && event.shiftKey==true)
					{
						settings.changeTab($selector, settings, $selector.find(settings.selector_tab_group).size()-1);
					}
				});

			}
			catch (e)
			{
			}
		});
	};

})(jQuery);
