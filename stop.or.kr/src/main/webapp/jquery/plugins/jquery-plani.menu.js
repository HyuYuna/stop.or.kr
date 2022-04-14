/*----------------------------------------------------------------------------
 * Plugin	: jquery-plani.menu.js
 * ---------------------------------------------------------------------------
 * Author	: (주)플랜아이 http://plani.co.kr
 * ---------------------------------------------------------------------------
 * History
 * ---------------------------------------------------------------------------
 * 2012-01-29 (pigcos)	: 최초작성
 * 2014-05-10 (pigcos)	: 재작성
 * 2014-08-12 (pigcos)	: 재작성
 * -------------------------------------------------------------------------*/
;(function($)
{
	$.fn.Menu	= function (options)
	{
		return this.each(function ()
		{
			var settings	= $.extend
			(
				{
					// set interval
					'interval'	: 500,
					
					// set selector
					'selector_depth2'	: '.lnb-sub',
					'selector_depth3'	: '.lnb-3depth',
					
					// 초가회 함수
					'init'	: function ($selector, settings)
					{
					},
					'setDefault'	: function ($selector, settings)
					{
					},
					// event : mouseover
					'overDepth1'	: function ($selector, settings, index1)
					{
						$selector.children().each(function (i)
						{
							if ($(this).find(settings.selector_depth2).length>0)
							{
								if (i==index1)
								{
									$(this).find(settings.selector_depth2).show();
								}
								else
								{
									$(this).find(settings.selector_depth2).hide();
								}
							}
						});
					},
					'overDepth2'	: function ($selector, settings, index1, index2)
					{
						// 상위 1depth 이벤트 실행
						settings.overDepth1($selector, settings, index1);

						$selector.children().each(function (i)
						{
							$(this).find(settings.selector_depth2).children().each(function (j)
							{
								if (i==index1 && j==index2)
								{
									$(this).find(settings.selector_depth3).show();
								}
								else
								{
									$(this).find(settings.selector_depth3).hide();
								}
							});
						});
					},
					'overDepth3'	: function ($selector, settings, index1, index2, index3)
					{
						settings.overDepth2($selector, settings, index1, index2);
					},
					
					// event : mouseout
					'outDepth1'	: function ($selector, settings, index1)
					{
						$selector.find(settings.selector_depth2).hide();
						$selector.find(settings.selector_depth3).hide();
					},
					'outDepth2'	: function ($selector, settings, index1, index2)
					{
						settings.outDepth1($selector, settings, index1);
					},
					'outDepth3'	: function ($selector, settings, index1, index2, index3)
					{
						settings.outDepth2($selector, settings, index1, index2);
					},

					// event : extend
					'extend'	: function ($selector, settings)
					{
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
								clearTimeout(settings.TimeOut);

								settings.overDepth3
								(
									$selector,
									settings,
									$selector.children().size()-1,
									$selector.children(':last').find(settings.selector_depth2).children().size()-1,
									$selector.children(':last').find(settings.selector_depth2).children(':last').find(settings.selector_depth3).children().size()-1
								);
							}
						});
					}
				},
				options
			);
		
			try
			{
				var $selector	= $(this);

				// settings 추가
				settings.TimeOut	= null;

				// 초기화 함수 실행
				settings.init($selector, settings);

				var timerIn	= function (func, index1, index2, index3)
				{
					clearTimeout(settings.TimeOut);

					if (typeof(func)=='function')
					{
						func($selector, settings, index1, index2, index3);
					}
				};

				var timerOut	= function (func, index1, index2, index3)
				{
					if (typeof(func)=='function')
					{
						settings.TimeOut	= setTimeout
						(
							function () { func($selector, settings, index1, index2, index3); },
							settings.interval
						);
					}
				};

				$selector.children().each(function (index1)
				{
					// 1Depth
					$(this).find('a:first')
					.hover
					(
						function ()
						{
							timerIn(settings.overDepth1, index1);
						},
						function ()
						{
							timerOut(settings.outDepth1, index1);
						}
					)
					.focus(function()
					{
						timerIn(settings.overDepth1, index1);
					})
					.blur(function()
					{
						timerOut(settings.outDepth1, index1);
					});

					// 2Depth
					$(this).find(settings.selector_depth2).children().each(function (index2)
					{
						$(this).find('a:first')
						.hover
						(
							function ()
							{
								timerIn(settings.overDepth2, index1, index2);
							},
							function ()
							{
								timerOut(settings.outDepth2, index1, index2);
							}
						)
						.focus(function ()
						{
							timerIn(settings.overDepth2, index1, index2);
						})
						.blur(function ()
						{
							timerOut(settings.outDepth2, index1, index2);
						});

						// 3Depth
						$(this).find(settings.selector_depth3).children().each(function (index3)
						{
							$(this).find('a:first')
							.hover
							(
								function ()
								{
									timerIn(settings.overDepth3, index1, index2, index3);
								},
								function ()
								{
									timerOut(settings.outDepth3, index1, index2, index3);
								}
							)
							.focus(function ()
							{
								timerIn(settings.overDepth3, index1, index2, index3);
							})
							.blur(function ()
							{
								timerOut(settings.outDepth3, index1, index2, index3);
							});
						});

					});

				});

				// 추가 확장 함수 실행
				settings.extend($selector, settings);

				// 기본 선택
				settings.setDefault($selector, settings);
			}
			catch (e)
			{
			}
		});
	};

})(jQuery);
