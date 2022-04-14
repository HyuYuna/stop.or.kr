/*----------------------------------------------------------------------------
 * Plugin	: jquery-plani.image_over.js
 * ---------------------------------------------------------------------------
 * Author	: (주)플랜아이 http://plani.co.kr
 * -------------------------------------------------------------------------*/
;(function($)
{
	/*----------------------------------------------------------------------------
	 * Image Over
	 * ---------------------------------------------------------------------------
	 * History
	 * ---------------------------------------------------------------------------
	 * 2014-06-25 (pigcos)	: 최초작성
	 * 2014-08-13 (pigcos)	: 코드 재작성
	 * -------------------------------------------------------------------------*/
	$.fn.ImageOver	= function (options)
	{
		return this.each(function ()
		{
			// img 태그 체크
			if (this.tagName.toLowerCase()!='img') { return; }

			var settings	= $.extend
			(
				{
					type		: 'on',	// on, off
					text_on		: '_on',
					text_off	: '',
					regexp		: '\.[a-z]{3,}$'
				},
				options
			);

			// type 체크
			if ($.inArray(settings.type, ['on', 'off'])==-1) { return false;}

			var src		= $(this).attr('src');
			var ext		= src.match(new RegExp(settings.regexp, 'i'));

			if (settings.type=='on')
			{
				if (src.match(new RegExp(settings.text_on + settings.regexp, 'i'))==null)
				{
					src	= src.replace(settings.text_off + ext, settings.text_on + ext);
				}
			}

			if (settings.type=='off')
			{
				if (src.match(new RegExp(settings.text_on + settings.regexp, 'i'))!=null)
				{
					src	= src.replace(settings.text_on + ext, settings.text_off + ext);
				}
			}

			$(this).attr('src', src);
		});
	};

	/*----------------------------------------------------------------------------
	 * Image Mouse Roll Over
	 * ---------------------------------------------------------------------------
	 * History
	 * ---------------------------------------------------------------------------
	 * 2012-01-29 (pigcos)	: 최초작성
	 * 2014-08-13 (pigcos)	: 코드 재작성
	 * -------------------------------------------------------------------------*/
	$.fn.ImageRollOver	= function (options)
	{
		return this.each(function ()
		{
			if (this.tagName.toLowerCase()!='a') { return false; }

			var settings	= $.extend
			(
				{
					text_on		: '_on',
					text_off	: '',
				},
				options
			);

			$selector	= $(this);
			$image		= $(this).find('img');

			if ($selector.length<1) { return false; }

			$selector.bind('mouseover mouseout focus blur', function (e)
			{
				if ($.inArray(e.type, ['mouseover', 'focus'])!=-1)
				{
					$image.ImageOver({type:'on', text_on:settings.text_on, text_off:settings.text_off});
				}
				
				if ($.inArray(e.type, ['mouseout', 'blur'])!=-1)
				{
					$image.ImageOver({type:'off', text_on:settings.text_on, text_off:settings.text_off});
				}
			});
		});
	};

})(jQuery);
