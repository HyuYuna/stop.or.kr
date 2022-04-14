/*----------------------------------------------------------------------------
 * Plugin	: jquery-plani.util.js
 * ---------------------------------------------------------------------------
 * jQuery 함수 라이브러리
 * ---------------------------------------------------------------------------
 * Author	: (주)플랜아이 http://plani.co.kr
 * -------------------------------------------------------------------------*/
;(function($)
{
	/*----------------------------------------------------------------------------
	 * Debug (Console OutPut)
	 * ---------------------------------------------------------------------------
	 * History
	 * ---------------------------------------------------------------------------
	 * 2012-01-29 (pigcos)	: window.console 함수를 지원하는 브라우져에만 보고, 최초작성
	 * -------------------------------------------------------------------------*/
	$.debug	= function (message, trace)
	{
		try
		{
			if (typeof window.console!='undefined' && typeof window.console.log!='undefined')
			{
				message	= '[DEBUG]' + message;
				console.log(message);
				if (trace==true) { console.trace(message); }
			}
		}
		catch (e)
		{
		}		
	};

	/*----------------------------------------------------------------------------
	 * RETURN URL INFO
	 * ---------------------------------------------------------------------------
	 * History
	 * ---------------------------------------------------------------------------
	 * 2012-01-29 (pigcos)	: 최초작성
	 * 2014-05-26 (pigcos)	: 도메인 정보 리턴 추가
	 * -------------------------------------------------------------------------*/
	$.getDomain	= function (type)
	{
		var url			= location.href;
		var args_url	= url.split('//');
		
		switch (type)
		{
			case 'protocol'	:	// http | https
								return args_url[0];
			
			case 'domain'	:
								// plani.co.kr
								return args_url[1].substr(0, args_url[1].indexOf('/'));

			default			:	// http://plani.co.kr
								return args_url[0] + '//' + args_url[1].substr(0, args_url[1].indexOf('/'));
		}
	};

	/*----------------------------------------------------------------------------
	 * RETURN Date INFO
	 * ---------------------------------------------------------------------------
	 * History
	 * ---------------------------------------------------------------------------
	 * 2014-05-26 (pigcos)	: 최초작성
	 * -------------------------------------------------------------------------*/
	$.date	=
	{
		// Return current Unix timestamp
		'time'	: function ()
		{
			return Math.floor(new Date().getTime()/1000);
		}
	};

	/*----------------------------------------------------------------------------
	 * Cookie
	 * ---------------------------------------------------------------------------
	 * History
	 * ---------------------------------------------------------------------------
	 * 2012-01-29 (pigcos)	: 최초작성
	 * -------------------------------------------------------------------------*/
	$.cookie	= function (name, value, options)
	{
		if (typeof(value)!='undefined') 
		{
			// name and value given, set cookie
			options	= options || {};

			if (value===null)
			{
				value	= '';
				options.expires	= -1;
			}

			var expires	= '';
			
			if (options.expires && (typeof(options.expires)=='number' || options.expires.toUTCString))
			{
				var date;
				
				if (typeof(options.expires)=='number')
				{
					date	= new Date();
					date.setTime(date.getTime() + (options.expires*24*60*60*1000));
				}
				else
				{
					date	= options.expires;
				}

				expires	= '; expires=' + date.toUTCString(); // use expires attribute, max-age is not supported by IE
			}

			var path	= options.path ? '; path=' + options.path : '';
			var domain	= options.domain ? '; domain=' + options.domain : '';
			var secure	= options.secure ? '; secure' : '';

			document.cookie	= [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');
		}
		else
		{
			// only name given, get cookie
			var cookieValue = null;

			if (document.cookie && document.cookie!='')
			{
				var cookies = document.cookie.split(';');

				for (var i=0; i<cookies.length; i++)
				{
					var cookie	= $.trim(cookies[i]);

					// Does this cookie string begin with the name we want?
					if (cookie.substring(0, name.length+1)==(name+'='))
					{
						cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
						break;
					}
				}
			}

			return cookieValue;
		}
	};

})(jQuery);