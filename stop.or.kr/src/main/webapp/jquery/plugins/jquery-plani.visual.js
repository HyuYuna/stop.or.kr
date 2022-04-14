/*----------------------------------------------------------------------------
 * Plugin	: jquery-plani.visual.js
 * ---------------------------------------------------------------------------
 * Author	: (주)플랜아이 http://plani.co.kr
 * ---------------------------------------------------------------------------
 * History
 * ---------------------------------------------------------------------------
 * 2014-11-05 (garam)	: 최초작성
 * -------------------------------------------------------------------------*/

(function($)
{

	$.fn.MainVisual	= function (option)
	{
		var option			= option || {};															/* 옵션 */
		var controlls		= option.controlls || {};												/* 컨트롤러  */
		var navigations		= option.navigations || {};												/* 네비게이션  */
		var delay			= option.delay ? option.delay : 3;										/* 변경 딜레이 */
		var visual_name		= option.visual_name ? option.visual_name : '.visual-zone';

		navigations.name	= navigations.name ? navigations.name : '.navigation-zone';				/* 네비게이션 영역 obj */
		navigations.on		= navigations.on ? navigations.on : false;								/* 네비게이션 버튼 on */
		navigations.off		= navigations.off ? navigations.off : false;							/* 네비게이션 버튼 off */
		navigations.use		= navigations.use ? true : false;										/* 네비게이션 버튼 사용여부 */

		delay				= delay * 1000;

		$(this).each(function ()
		{
			var is_rotate		= true;	
			var is_action		= true;		
			var element			= $(this);
			var interval		= null;
			var current			= 1;

			var navigation		= $(element).find(navigations.name);
			var visual			= $(element).children(visual_name);

			try	{ var size		= parseInt($(visual).children().size(), 10);} catch (e) { var size		= 1;}

			if (controlls.use == false)
			{
				$(element).find(controlls.next).hide();
				$(element).find(controlls.prev).hide();
				$(element).find(controlls.play).hide();
				$(element).find(controlls.pause).hide();
			}
			if (navigations.use == false)
			{
				$(navigation).hide();
			}
			else $(navigation).children().find('img').css('cursor', 'pointer')

			$(visual).css('background', "url('" + $(visual).children('li:first').find('img:first').attr('src') + "')");

			$(visual).children(':not(:nth-child(1))').hide();
			$(visual).children(':nth-child(1)').show();

			if (navigations.use === true)
			{
				$(navigation).children().each(function(i)
				{
					$(this).find('a:first').click(function()
					{
						current	= i;
						rotate();
						clearInterval(interval);
						interval	= null;
						if (is_rotate === true)
						{
							interval	= setInterval(rotate, delay);
						}
						return false;
					});
				});
			}

			var rotate	= function ()
			{
				current++;
				if (current > size) 
				{ 
					current = 1;
				}
				if (current <= 0) 
				{ 
					current = size;
				}
				if (navigations.use === true && navigations.on != false && navigations.off != false)
				{
					$(navigation).children(':not(:nth-child('+current+'))').find('img:first').attr('src', navigations.off).attr('alt', '미선택');
					$(navigation).children(':nth-child('+current+')').find('img:first').attr('src', navigations.on).attr('alt', '선택');
				}
				$(visual).css('background', "url('" + $(visual).children(':visible').find('img:first').attr('src') + "')");
				$(visual).children(':visible').hide();
				$(visual).children(':nth-child('+(current)+')').find('img:first').css({'opacity':1});
				$(visual).children(':nth-child('+(current)+')').find('img:first').hide();
				$(visual).children(':nth-child('+current+')').show();
				$(visual).children(':nth-child('+(current)+')').find('img:first').stop().fadeIn(Math.ceil(1000), function(){});
			};
			if (is_rotate === true)
			{
				interval	= setInterval(rotate, delay);
			}
		});

		return this;
	};
})(jQuery);