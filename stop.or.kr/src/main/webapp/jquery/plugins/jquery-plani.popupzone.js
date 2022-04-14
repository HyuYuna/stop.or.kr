/*----------------------------------------------------------------------------
 * Plugin	: jquery-plani.popupzone.js
 * ---------------------------------------------------------------------------
 * Author	: (주)플랜아이 http://plani.co.kr
 * ---------------------------------------------------------------------------
 * History
 * ---------------------------------------------------------------------------
 * 2012-01-29 (pigcos)	: 최초작성
 * 2014-05-21 (pigcos)	: 기능추가 및 코드 재작성
 * 2014-08-08 (pigcos)	: 코드 재작성 및 포커스 이벤트 추가 작성
 * -------------------------------------------------------------------------*/
;(function($)
{
	$.fn.PopupZone	= function (option)
	{
		var option			= option || {};															/* 옵션 */
		var controlls		= option.controlls || {};												/* 컨트롤러  */
		var navigations		= option.navigations || {};												/* 네비게이션  */
		var delay			= option.delay ? option.delay : 3;										/* 변경 딜레이 */
		var popupzone_name	= option.popupzone_name ? option.popupzone_name : '.popupzone-area';	/* popup obj */
		var popupzone_item	= option.popupzone_item ? option.popupzone_item : '.banner-img';	/* popup item */

		controlls.name		= controlls.name ? controlls.name : '.popupzone-controll';				/* 컨트롤러 영역 obj */
		controlls.play		= controlls.play ? controlls.play : '.play-button';						/* 컨트롤러 시작 버튼명 */
		controlls.pause		= controlls.pause ? controlls.pause : '.pause-button';					/* 컨트롤러 멈춤 버튼명 */
		controlls.used		= controlls.used ? controlls.used : false;											/* 컨트롤러 버튼 사용여부 */

		navigations.name	= navigations.name ? navigations.name : '.popupzone-btns';				/* 네비게이션 영역 obj */
		navigations.on		= navigations.on ? navigations.on : false;								/* 네비게이션 버튼 on */
		navigations.off		= navigations.off ? navigations.off : false;							/* 네비게이션 버튼 off */
		navigations.used	= navigations.used ? navigations.used : false;										/* 네비게이션 버튼 사용여부 */

		delay				= delay * 1000;

		var is_rotate		= true;		
		var element			= $(this);
		var interval		= null;
		var current			= 0;
		var is_focus		= false;

		var controll		= $(element).find(controlls.name);
		var navigation		= $(element).find(navigations.name);
		var popupzone		= $(element).find(popupzone_name);
		try	{ var size		= parseInt($(popupzone).find(popupzone_item).size(), 10);} catch (e) { var size		= 1;}

		if (controlls.used == false)
		{
			$(controlls.name).hide();
		}
		if (navigations.used == false)
		{
			$(navigation).hide();
		}
		else
		{
			$(navigation).find('a:first').find('img:first').attr('src', navigations.on).attr('alt', '선택');
		}

		if (size < 2) { return; }

		$(popupzone).find(popupzone_item).hide();
		$(popupzone).find(popupzone_item).eq(0).show();

		$(navigation).find('img').css('cursor', 'pointer');

//		$(popupzone).find(popupzone_item).each(function (i)
//		{
//			$(this).mouseover(function ()
//			{
//				if (is_rotate == true)
//				{
//					clearTimeout(interval);
//					interval	= null;
//				}
//			});
//			$(this).mouseout(function ()
//			{
//				if (is_rotate == true)
//				{
//					if (is_focus == false)
//					{
//						interval	= null;
//						interval	= setInterval(rotate, delay); 
//					}
//				}
//			});
//		});

		$(popupzone).find(popupzone_item).each(function (i)
		{
			if ($(this).children('a:first').length > 0)
			{
				$(this).find('a:first').live
				(
					'mouseover mouseout focusin focusout',
					function (e)
					{
						if (e.type=='mouseover')
						{
							if (is_rotate == true)
							{
								clearInterval(interval);
								interval	= null;
							}
						}

						if (e.type=='mouseout')
						{
							if (is_rotate == true)
							{
								if (is_focus == false)
								{
									interval	= null;
									interval	= setInterval(rotate, delay); 
								}
							}
						}

						if (e.type=='focusin')
						{
							if (is_rotate == true)
							{
								is_focus	= true;
								clearInterval(interval);
								interval	= null;
							}
						}

						if (e.type=='focusout')
						{
							if (is_rotate == true)
							{
								is_focus	= false;
								clearInterval(interval);
								interval	= null;
								interval	= setInterval(rotate, delay);
							}
						}
					}
			);
			}
			else
			{

				$(this).mouseover(function ()
				{
					if (is_rotate == true)
					{
						clearTimeout(interval);
						interval	= null;
					}
				});
				$(this).mouseout(function ()
				{
					if (is_rotate == true)
					{
						if (is_focus == false)
						{
							interval	= null;
							interval	= setInterval(rotate, delay); 
						}
					}
				});
			}
		});

		if (controlls.used === true)
		{
			$(controll).find(controlls.pause).click(function()
			{
				$(this).hide();
				$(controll).find(controlls.play).show();
				is_rotate	= false;
				clearInterval(interval);
				interval	= null;

				return false;
			});

			$(controll).find(controlls.play).click(function()
			{
				if (is_rotate === false)
				{
					$(this).hide();
					$(controll).find(controlls.pause).show();
					is_focus	= false;
					is_rotate	= true;
					clearInterval(interval);
					interval	= null;
					interval	= setInterval(rotate, delay);
				}
				return false;
			});
		}
		
		if (navigations.used === true)
		{
			$(navigation).find('a').each(function(i)
			{
				$(this).hover
				(
					function ()
					{
						current		= i;
						rotate();
						clearInterval(interval);
						interval	= null;
					},
					function ()
					{
						if (is_rotate === true)
						{
							clearInterval(interval);
							interval	= null;
							interval	= setInterval(rotate, delay);
						}
					}
				)
				.focus
				(
					function() 
					{ 
						current		= i;
						rotate();
						clearInterval(interval);
						interval	= null;
					}
				)
				.click(function()
				{
					current	= i;
					rotate();
					clearInterval(interval);
					interval	= null;
					return false;
				})
				.blur(function() 
				{
					if (is_rotate === true)
					{
						clearInterval(interval);
						interval	= null;
						interval	= setInterval(rotate, delay);
					}
				});
			});
		}

		var rotate	= function ()
		{
			if (navigations.used === true && navigations.on != false && navigations.off != false)
			{
				$(navigation).find('a').find('img:first').attr('src', navigations.off).attr('alt', '미선택');
				$(navigation).find('a').eq(current).find('img:first').attr('src', navigations.on).attr('alt', '선택');
			}

			$(popupzone).find(popupzone_item).hide();
			$(popupzone).find(popupzone_item).find('img:first').hide();

			$(popupzone).find(popupzone_item).eq(current).show();
			$(popupzone).find(popupzone_item).eq(current).find('img:first').show();
			current++;
			if (current >= size) 
			{ 
				current = 0;
			}
		};
		if (is_rotate === true)
		{
			interval	= setInterval(rotate, delay);
		}

		return this;
	};

})(jQuery);
