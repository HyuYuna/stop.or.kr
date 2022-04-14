/*----------------------------------------------------------------------------
 * Plugin	: jquery-plani.slider.js
 * ---------------------------------------------------------------------------
 * Author	: (주)플랜아이 http://plani.co.kr
 * ---------------------------------------------------------------------------
 * Markup
 * ---------------------------------------------------------------------------
<div id="popupzone" style="float:left;">
	<strong class="title">팝업존</strong>
	<div class="page-info-wrap">
		<span class="page-info-total">0</span> / <span class="page-info-current">0</span>
	</div>
	<a class="pause" href="#pause">정지</a>
	<a class="play" href="#play">시작</a>
	<a class="prev" href="#prev">이전</a>
	<a class="next" href="#next">다음</a>
	<ul class="paging">
	<li><a href="#popupzone-01">1</a></li>
	<li><a href="#popupzone-02">2</a></li>
	<li><a href="#popupzone-03">3</a></li>
	<li><a href="#popupzone-04">4</a></li>
	<li><a href="#popupzone-05">5</a></li>
	</ul>
	<div class="item-wrap">
		<ul class="item">
		<li id="popupzone-01">배너1</li>
		<li id="popupzone-02">배너2</li>
		<li id="popupzone-03">배너3</li>
		<li id="popupzone-04">배너4</li>
		<li id="popupzone-05">배너5</li>
		</ul>
	</div>
</div>
 * ---------------------------------------------------------------------------
 * History
 * ---------------------------------------------------------------------------
 * 2015-04-15 (김기관)	: 최초 작성
 * -------------------------------------------------------------------------*/
;(function($)
{
	try
	{
		$.fn.Slider	= function (options)
		{
			return this.each(function (i)
			{
				var settings	= $.extend
				(
					{
						delay	: 4000,	// milliseconds
						auto	: true,
						selector_pause	: '.pause',
						selector_play	: '.play',
						selector_prev	: '.prev',
						selector_next	: '.next',
						selector_paging	: '.paging',
						selector_item	: 'ul.item',
						selector_page_info_wrap	: '.page-info-wrap',		// 페이징 정보 상위
						selector_page_info_total	: '.page-info-total',	// 페이징 정보 전체갯수
						selector_page_info_current	: '.page-info-current',	// 페이징 정보 현재
						direction	: '', // top, bottom, left, right, 공백
						effect	: '',	// fadein, overlap
						duration	: 500,
						view_count : 1,	// 노출 갯수
						paging_class_on	: true,	// 현재페이지 li에 class on 추가,
						play_button_toggle	: false,	// play|pause 버튼 토글
						updateCurrent	: function ($selector, settings)
						{
							if (settings.page.direction=='next')
							{
								settings.page.current++;

								if (settings.page.current>settings.page.total)
								{
									settings.page.current	= 1;
								}
							}
							else
							{
								settings.page.current--;

								if (settings.page.current<1)
								{
									settings.page.current	= settings.page.total;
								}
							}

							// 페이지 정보 기록
							settings.$page_info_current.html(settings.page.current);

						},
						updatePaging	: function ($selector, settings, page)
						{
							settings.$paging.children().each(function (i)
							{
								if (settings.paging_class_on===true)
								{
									if (i==(page-1)) { $(this).addClass('on'); }
									else { $(this).removeClass('on'); }
								}

								// 이미지 on off
								imageOver($(this).find('img:first'), (i==(page-1) ? 'on' : 'off'));
							});

						},
						updateTimeout	: function ($selector, settings, e)
						{
							// 자동
							if (settings.auto===true)
							{
								clearTimeout(interval);

								interval	= setTimeout
								(
									function () { e($selector, settings); },
									settings.delay
								);
							}
						},
						defaultEvent	: function ($selector, settings)
						{
							// set current
							settings.updateCurrent($selector, settings);

							settings.$item.children().hide();
							settings.$item.children().eq((settings.page.current-1)).show();

							// 페이징
							settings.updatePaging($selector, settings, settings.page.current);

							// timeout
							settings.updateTimeout($selector, settings, settings.defaultEvent);
						},
						fadeInEvent	: function ($selector, settings)
						{
							// set current
							settings.updateCurrent($selector, settings);

							settings.$item.children().eq((settings.page.current-1))
							.css('z-index', 10)
							.fadeIn
							(
								settings.duration,
								function ()
								{
									settings.$item.children().each(function (i)
									{
										if (i!=settings.page.current-1) { $(this).css('z-index', 8).hide(); }
										else { $(this).css('z-index', 9); }
									});
								}
							);

							// 페이징
							settings.updatePaging($selector, settings, settings.page.current);

							// timeout
							settings.updateTimeout($selector, settings, settings.fadeInEvent);
						},
						overlapEvent	: function ($selector, settings)
						{
							// set current
							settings.updateCurrent($selector, settings);

							if (settings.page.direction=='next')
							{
								var move_start	= settings.$item.children().eq((settings.page.current-1)).width();
								var move_last	= 0;
							}
							else
							{
								var move_start	= (settings.$item.children().eq((settings.page.current-1)).width())*-1;
								var move_last	= 0;
							}

							settings.$item.children().eq((settings.page.current-1))
							.css({left:move_start, 'z-index':10})
							.show()
							.animate
							(
								{left:move_last},
								{
									duration	: settings.duration,
									complete	: function ()
									{
										settings.$item.children().each(function (i)
										{
											if (i!=settings.page.current-1) { $(this).css('z-index', 8).hide(); }
											else { $(this).css('z-index', 9); }
										});
									}
								}
							);

							// 페이징
							settings.updatePaging($selector, settings, settings.page.current);

							// timeout
							settings.updateTimeout($selector, settings, settings.overlapEvent);
						},
						flowWidthEvent	: function ($selector, settings)
						{
							// set current
							// settings.updateCurrent($selector, settings);

							if (settings.$item.is(':animated')===true) { return; }

							var move	= parseInt(settings.$item.children(':first').outerWidth(), 10)*-1;

							if (settings.page.direction=='next')
							{
								settings.$item.animate
								(
									{'left':move},
									{
										duration	: settings.duration,
										complete	: function ()
										{
											$(this).css({left:0}).append($(this).children(':first'));

											// timeout
											settings.updateTimeout($selector, settings, settings.flowWidthEvent);
										}
									}
								);
							}
							else
							{
								settings.$item.css({left:move});
								settings.$item.children(':first').before(settings.$item.children(':last'));

								settings.$item.animate
								(
									{'left':0},
									{
										duration	: settings.duration,
										complete	: function ()
										{
											// timeout
											settings.updateTimeout($selector, settings, settings.flowWidthEvent);
										}
									}
								);
							}

							// 페이징
							// settings.updatePaging($selector, settings, settings.page.current);
						},
						flowHeightEvent	: function ($selector, settings)
						{
							if (settings.$item.is(':animated')===true) { return; }

							var move	= parseInt(settings.$item.children(':first').outerHeight(), 10)*-1;

							if (settings.page.direction=='next')
							{
								settings.$item.stop()
								.animate
								(
									{'top':move},
									{
										duration	: settings.duration,
										complete	: function ()
										{
											$(this).css({top:0}).append($(this).children(':first'));

											// timeout
											settings.updateTimeout($selector, settings, settings.flowHeightEvent);
										}
									}
								);
							}
							else
							{
								settings.$item.css({top:move});
								settings.$item.children(':first').before(settings.$item.children(':last'));

								settings.$item.stop()
								.animate
								(
									{'top':0},
									{
										duration	: settings.duration,
										complete	: function ()
										{
											// timeout
											settings.updateTimeout($selector, settings, settings.flowHeightEvent);
										}
									}
								);
							}

							// 페이징
							// settings.updatePaging($selector, settings, settings.page.current);
						},
						extendEvent : function ($selector, settings) {}
					},
					options
				);

				var imageOver	= function ($selector, type, options)
				{
					var settings	= $.extend
					(
						{
							over	: '_on',
							out		: '',
							regexp	: '\.[a-z]{3,}$'
						},
						options
					);

					$selector.each(function ()
					{
						var src	= $(this).attr('src');
						var ext	= src.match(new RegExp(settings.regexp, 'i'));

						if (type=='on')
						{
							if (src.match(new RegExp(settings.over + settings.regexp, 'i'))==null)
							{
								$(this).attr('src', src.replace(settings.out + ext, settings.over + ext));
							}
						}

						if (type=='off')
						{
							if (src.match(new RegExp(settings.over + settings.regexp, 'i'))!=null)
							{
								$(this).attr('src', src.replace(settings.over + ext, settings.out + ext));
							}
						}
					});
				};

				var $selector	= $(this);
				var interval	= null;
				var getSelector	= function (selector)
				{
					if (typeof(selector)==='object') { return selector; }
					else if (typeof(selector)=='string' && selector.length>0) { return $selector.find(selector); }
					else { return ''; }
				};

				// html elelemts
				settings.$play		= getSelector(settings.selector_play);
				settings.$pause		= getSelector(settings.selector_pause);
				settings.$prev		= getSelector(settings.selector_prev);
				settings.$next		= getSelector(settings.selector_next);
				settings.$paging	= getSelector(settings.selector_paging);
				settings.$item		= getSelector(settings.selector_item);
				settings.$page_info_wrap	= getSelector(settings.selector_page_info_wrap);
				settings.$page_info_total	= getSelector(settings.selector_page_info_total);
				settings.$page_info_current	= getSelector(settings.selector_page_info_current);

				// Page
				// settings.total	= settings.$item.children().size();
				settings.page	= {};
				settings.page.total	= settings.$item.children().size();
				// settings.page.total	= Math.ceil(settings.total/settings.view_count);
				settings.page.current	= 1;
				settings.page.direction	= 'next';

				if (settings.page.total<2 || settings.page.total<=settings.view_count)
				{
					settings.$play.hide();
					settings.$pause.hide();
					settings.$prev.hide();
					settings.$next.hide();
					settings.$paging.hide();
					settings.$page_info_wrap.hide();
					return true;
				}

				// 자동실행 체크
				if (settings.auto!==true)
				{
					settings.$play.remove();
					settings.$pause.remove();
				}

				// 초기 페이지 셋팅
				settings.updatePaging($selector, settings, settings.page.current);

				var action	= '';

				if ($.inArray(settings.direction, ['left', 'right', 'top', 'bottom'])!=-1)
				{
					// pageing, 페이지 정보 제거
					settings.$paging.remove();
					settings.$page_info_wrap.remove();

					switch (settings.direction)
					{
						case 'right'	:
						case 'bottom'	:

							settings.page.direction	= 'prev';
							break;

						default	:

							settings.page.direction	= 'next';
					}

					if ($.inArray(settings.direction, ['left', 'right'])!=-1)
					{

						var item_width	= 0;
						settings.$item.children().each(function (i)
						{
							$(this).css({float:'left'});
							item_width	+= parseInt($(this).outerWidth(), 10);
						});

						settings.$item.css({position:'absolute', top:0, left:0, width:item_width});
						action	= settings.flowWidthEvent;
					}

					if ($.inArray(settings.direction, ['top', 'bottom'])!=-1)
					{
						settings.$item.css({position:'absolute', top:0, left:0});
						action	= settings.flowHeightEvent;
					}
				}
				else
				{
					if (settings.effect=='fadein')
					{
						settings.$item.children().each(function (i)
						{
							$(this).css({position:'absolute', top:0, left:0});
							if (i>0) { $(this).css({'z-index':8}).hide(); }
							else { $(this).css({'z-index':9}); }
						});

						action	= settings.fadeInEvent;
					}
					else if (settings.effect=='overlap')
					{
						settings.$item.children().each(function (i)
						{
							$(this).css({position:'absolute', top:0, left:0});
							if (i>0) { $(this).css({'z-index':8}).hide(); }
							else { $(this).css({'z-index':9}); }
						});

						action	= settings.overlapEvent;
					}
					else
					{
						settings.$item.children().each(function (i)
						{
							if (i>0) { $(this).hide(); }
						});

						action	= settings.defaultEvent;
					}
				}

				if (typeof(action)==='function')
				{
					// 자동
					if (settings.auto===true)
					{
						interval	= setTimeout
						(
							function () { action($selector, settings); },
							settings.delay
						);
					}
				}

				var pause	= function ()
				{
					clearTimeout(interval);
				};

				var play	= function ()
				{
					if (is_play!==true) { return false; }
					if (is_over===false && is_focus===false)
					{
						settings.updateTimeout($selector, settings, action);
					}
				};

				var is_over		= false;	// mouse over/out
				var is_focus	= false;	// focus in/out
				var is_play		= true;		// animation play/pause

				// 아이템
				settings.$item.children().hover
				(
					function ()
					{
						is_over	= true;
						pause();
					},
					function ()
					{
						is_over	= false;
						play();
					}
				);

				// 아이템 a
				settings.$item.find('a')
				.focus(function ()
				{
					is_focus	= true;
					pause();
				})
				.blur(function ()
				{
					is_focus	= false;
					play();
				});

				// 페이지 정보 기록
				settings.$page_info_total.html(settings.page.total);
				settings.$page_info_current.html(settings.page.current);

				// play, pause 버튼
				if (settings.play_button_toggle===true)
				{
					if (is_play===true)
					{
						settings.$play.hide();
						settings.$pause.show();
					}
					else
					{
						settings.$play.show();
						settings.$pause.hide();
					}
				}

				// play button
				settings.$play.click(function (event)
				{
					if (settings.play_button_toggle===true)
					{
						$(this).hide();
						settings.$pause.show().focus();
					}

					is_play	= true;
					play();

					event.preventDefault();
				});

				// stop button
				settings.$pause.click(function (event)
				{
					if (settings.play_button_toggle===true)
					{
						$(this).hide();
						settings.$play.show().focus();
					}

					is_play	= false;
					pause();

					event.preventDefault();
				});

				// 페이징 이벤트 설정
				settings.$paging.children().each(function (index)
				{
					if ($.inArray(settings.direction, ['left', 'right', 'top', 'bottom'])!=-1)
					{
						$(this).find('a:first').click(function (event)
						{
							event.preventDefault();
						});

						return true;
					}

					$(this).find('a:first')
					.hover
					(
						function ()
						{
							is_over	= true;
							settings.page.current	= settings.page.direction=='next' ? index : (index+2);
							action($selector, settings);
							pause();
						},
						function ()
						{
							is_over	= false;
							play();
						}
					)
					.focus(function ()
					{
						is_focus	= true;
						pause();
					})
					.blur(function ()
					{
						is_focus	= false;
						play();
					})
					.click(function (event)
					{
						settings.page.current	= settings.page.direction=='next' ? index : (index+2);
						action($selector, settings);
						pause();
						event.preventDefault();
					})
					.mousedown(function () { return false; });
				});

				// 이전, 다음 이벤트
				var setMoveButtonEvent	= function ($button, direction)
				{
					$button
					.click(function (event)
					{
						settings.page.direction	= direction;
						action($selector, settings);
						pause();
						event.preventDefault();
					})
					.hover
					(
						function ()
						{
							is_over	= true;
							pause();
						},
						function ()
						{
							is_over	= false;
							play();
						}
					)
					.focus(function ()
					{
						is_focus	= true;
						pause();
					})
					.blur(function ()
					{
						is_focus	= false;
						play();
					});
				};

				// 이전
				setMoveButtonEvent(settings.$prev, 'prev');

				// 다음
				setMoveButtonEvent(settings.$next, 'next');
			});
		};
	}
	catch (e)
	{
		$.exception(e);
	}

})(jQuery);