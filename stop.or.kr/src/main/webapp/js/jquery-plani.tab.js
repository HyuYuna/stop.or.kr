/*----------------------------------------------------------------------------
 * Plugin	: jquery-plani.tab.js
 * ---------------------------------------------------------------------------
 * Author	: (주)플랜아이 http://plani.co.kr
 * ---------------------------------------------------------------------------
 * Markup
 * ---------------------------------------------------------------------------
<div class="notice">
	<div class="group on">
		<h3 class="title"><a href="#">공지사항</a></h3>
		<div class="item">
			<ul>
			<li><a href="#">외국어능력 향상 교육프로그램 사업 공고	</a><span>2015-04-16</span></li>
			<li><a href="#">노후화 스위치 교체 및 무선랜 구축 사업 …</a><span>2015-04-15</span></li>
			<li><a href="#"> 전산시스템 통합유지보수사업 입찰 공고</a> <span>2015-04-15</span></li>
			</ul>
			<p class="more"><a href="#">공지사항 더보기</a></p>
		</div>
	</div>
	<div class="group">
		<h3 class="title"><a href="#">교육/행사</a></h3>
		<div class="item">
			<ul>
			<li><a href="#"> [이벤트]캠퍼스에 찾아온 봄을 스케치 하라</a> <span>2015-04-03</span> </li>
			<li><a href="#"> 광고홍보디자인과 제23회 대전산업디자인…</a> <span>2014-11-25</span> </li>
			<li><a href="#"> 광고홍보디자인과 제1회 ㈜애드맨 &lt;대…</a> <span>2014-10-31</span> </li>
			</ul>
			<p class="more"><a href="#">교육/행사 더보기</a></p>
		</div>
	</div>
	<div class="group">
		<h3 class="title"><a href="#">갤러리</a></h3>
		<div class="item">
			<ul>
			<li><a href="#"> [2015. 4. 9] 대전기능경시대회 김연진 졸…</a> <span>2015-04-13</span> </li>
			<li><a href="#"> [2015. 4. 3] 2015 총장배 족구대회</a> <span>2015-04-03</span> </li>
			<li><a href="#"> [2015. 3.30] 대전과기대, 대전광역시 사…</a> <span>2015-03-30</span> </li>
			</ul>
			<p class="more"><a href="#">갤러리 더보기</a></p>
		</div>
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
		$.fn.Tab	= function (options)
		{
			return this.each(function (i)
			{
				var settings	= $.extend
				(
					{
						selector_group	: '.group',
						selector_title	: '.title',
						selector_item	: '.item',
						play_button_toggle	: false,
						selector_play	: '.play',
						selector_pause	: '.pause',
						auto	: true,
						delay	: 10000,
						tabEvent	: function ($selector, settings, index)
						{
							$selector.find(settings.$group).each(function (i)
							{
								if (index==i)
								{
									$(this).addClass('active');
									// 이미지 on
									imageOver(settings.$title.eq(i).find('img:first'), 'on');
								}
								else
								{
									$(this).removeClass('active');
									// 이미지 off
									imageOver(settings.$title.eq(i).find('img:first'), 'off');
								}
							});
						},
						shiftTabEvent : function ($selector, settings)
						{
							settings.$title.each(function (index)
							{
								if (index-1>-1)
								{
									$(this)
									.keydown(function (event)
									{
										if (event.keyCode==9 && event.shiftKey==true)
										{
											settings.tabEvent($selector, settings, index-1);
										}
									});
								}
							});

							// 마지막 포커스 다음 포커스 가능 영역에 키 이벤트 부여
							var focusables	= $('a, input, select, textarea');
							var last		= $selector.find('a:last');
							var current		= focusables.index(last);
							var next		= focusables.eq(current+1).length ? focusables.eq(current+1) : focusables.eq(0);

							$(next)
							.keydown(function (event)
							{
								if (event.keyCode==9 && event.shiftKey==true)
								{
									settings.tabEvent($selector, settings, settings.$group.size()-1);
								}
							});
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

				var getSelector	= function (selector)
				{
					if (typeof(selector)==='object') { return selector; }
					else if (typeof(selector)=='string' && selector.length>0) { return $selector.find(selector); }
					else { return ''; }
				};

				// html elelemts
				settings.$group	= getSelector(settings.selector_group);
				settings.$title	= getSelector(settings.selector_title);
				settings.$item	= getSelector(settings.selector_item);
				settings.$play	= getSelector(settings.selector_play);
				settings.$pause	= getSelector(settings.selector_pause);

				if (settings.$group.size()<2)
				{
					settings.$play.hide();
					settings.$pause.hide();
					return true;
				}

				// play, pause 버튼
				if (settings.auto!==true)
				{
					settings.$play.remove();
					settings.$pause.remove();
				}
				else
				{
					if (settings.play_button_toggle===true)
					{
						settings.$play.hide();
						settings.$pause.show();
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

					clearTimeout(interval);
					interval	= setInterval(rotate, settings.delay);

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
					clearTimeout(interval);

					event.preventDefault();
				});


				settings.$title.each(function (index)
				{
					$(this)
					.hover
					(
						function ()
						{
							settings.tabEvent($selector, settings, index);

							if (settings.auto===true)
							{
								clearTimeout(interval);
							}
						},
						function ()
						{
							if (settings.auto===true)
							{
								clearTimeout(interval);
								interval	= setInterval(rotate, settings.delay);
							}
						}
					);

					$(this).find('a:first')
					.focus(function ()
					{
						settings.tabEvent($selector, settings, index);

						if (settings.auto===true)
						{
							clearTimeout(interval);
						}
					})
					.blur(function ()
					{
						clearTimeout(interval);
						interval	= setInterval(rotate, settings.delay);
					})
					.click(function (event)
					{
						settings.tabEvent($selector, settings, index);

						if (settings.auto===true)
						{
							clearTimeout(interval);
						}

						event.preventDefault();
					});
				});

				if (settings.auto===true)
				{
					settings.$item
					.hover
					(
						function ()
						{
							clearTimeout(interval);
						},
						function ()
						{
							clearTimeout(interval);
							interval	= setInterval(rotate, settings.delay);
						}
					);

					settings.$item.find('a')
					.focus(function ()
					{
						clearTimeout(interval);
					})
					.blur(function ()
					{
						clearTimeout(interval);
						interval	= setInterval(rotate, settings.delay);
					});
				}

				if (settings.auto===true)
				{
					var interval	= null;
					var index		= 0;
					var is_play		= true;

					var rotate	= function ()
					{
						if (is_play===false)
						{
							clearTimeout(interval);
							return;
						}

						if (index+2>settings.$group.size()) { index = 0 }
						else { index++; }

						settings.tabEvent($selector, settings, index);
					};

					interval	= setInterval(rotate, settings.delay);
				}

				// shift + tab 키 이벤트
				settings.shiftTabEvent($selector, settings);

				// 추가 확장 함수 실행
				settings.extendEvent($selector, settings);
			});
		};
	}
	catch (e)
	{
		$.exception(e);
	}

})(jQuery);