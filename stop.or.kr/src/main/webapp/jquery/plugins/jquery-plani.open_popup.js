/*----------------------------------------------------------------------------
 * Plugin	: jquery-plani.open_popup.js
 * ---------------------------------------------------------------------------
 * Author	: (주)플랜아이 http://plani.co.kr
 * ---------------------------------------------------------------------------
 * History
 * ---------------------------------------------------------------------------
 * 2012-01-29 (pigcos)	: 최초작성
 * 2012-05-26 (pigcos)	: 팝업창 중앙에 띄우기, 재작성
 * -------------------------------------------------------------------------*/
;(function($)
{
	$.fn.OpenPopup	= function ()
	{
		return this.each(function ()
		{
			var $selector	= $(this);

			// a 태그만
			if ($selector.get(0).tagName.toLowerCase()!='a') { return true; }

			var str_target		= $selector.attr('target');
			var args_options	= str_target.split(':');

			// 옵션 (창이름:넓이:높이:스크롤:가운데정렬)
			// 필수 (창이름:넓이:높이)
			if (args_options.length<3) { return true; }

			var option_str	= new Array();
				option_str.push('width=' + args_options[1]);
				option_str.push('height=' + args_options[2]);

			if (typeof(args_options[3])!='undefined')
			{
				option_str.push('scrollbars=' + (args_options[3]==1 ? 'yes' : 'no'));
			}

			if (typeof(args_options[4])!='undefined' && args_options[4]==1)
			{
				option_str.push('top=' + ((screen.availHeight-args_options[2])/2));
				option_str.push('left=' + ((screen.availWidth-args_options[1])/2));
			}

			$selector
			.click(function()
			{
				var win	= window.open($(this).attr('href'), args_options[0], option_str.join(', '));
					win.focus();
				
				return false;
			});
		});
	};

})(jQuery);
