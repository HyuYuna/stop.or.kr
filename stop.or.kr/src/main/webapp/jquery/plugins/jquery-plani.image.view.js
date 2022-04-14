/*----------------------------------------------------------------------------
 * Plugin	: jquery-plani.image.view.js
 * ---------------------------------------------------------------------------
 * Author	: (주)플랜아이 http://plani.co.kr
 * ---------------------------------------------------------------------------
 * Usage	:
 * --------------------------------------------------------------------------- 
			
 * ---------------------------------------------------------------------------
 * History
 * ---------------------------------------------------------------------------
 * 2014-11-14(garam)	: 최초작성
 * -------------------------------------------------------------------------*/

(function($)
{
	$.ImagePannelCheck	= function ()
	{
		var backPanel		= null;
		var controllPanel	= null;
		var controllLoad	= null;

		if ($('div#element-image-back-panel').html() == null)
		{
			var controllClose		= $('<span><a href="#" class="element-image-close"><img src="/jquery/plugins/images/image_close.png" alt="close" /></a></span>').css({'position': 'absolute', 'z-index':'10005', 'top': '-10px', 'right':'-10px'});	
			var controllInfo		= $('<div></div>').attr('id', 'element-image').css({'position': 'relative', 'width': '100%'}).append($(controllClose));	

			this.backPanel			= $('<div></div>').attr('id', 'element-image-back-panel').css({'position': 'absolute', 'z-index': '10001', 'display': 'none', 'width': 0, 'height': 0, 'background-color': '#000', 'opacity':'0.6'});
			this.controllPanel		= $('<div></div>').attr('id', 'element-image-controller').css({'position': 'absolute', 'z-index':'10002', 'display': 'none', 'width': '1000px'}).append($(controllInfo));
			this.controllLoad		= $('<div><img src="/jquery/plugins/images/ing.gif" alt="Loading" /></div>').attr('id', 'element-image-load').css({'position': 'absolute', 'z-index':'10002', 'display': 'none', 'width': '16px', 'height': '16px'});	

		
			$('body').prepend(this.controllPanel);
			$('body').prepend(this.controllLoad);
			$('body').prepend(this.backPanel);
		}
		else
		{
			this.backPanel			= $('div#element-image-back-panel');
			this.controllPanel		= $('div#element-image-controller');
			this.controllLoad		= $('div#element-image-load');
		}

		this.backPanel.hide();
		this.controllLoad.hide();
		this.controllPanel.hide();

		return this;
	};


	$.fn.ImageView	= function (option)
	{
		var panel			= $.ImagePannelCheck();
		var element			= $(this);

		if (!$(element).find('img:first').attr('src'))
		{
			return false;
		}

		if (!$(element).eq(0).attr('rel'))
		{
			$(element).each (function ()
			{
				if (!$(this).attr('rel'))
				{
					$(this).attr('rel', $(this).find('img:first').attr('src'))
				}
			});
			//return false;
		}

		var controllerBakePanelPosition	= function (panel)
		{
			var elementWidth	= ($(window).width() < $(document).width()) ? $(document).width() : $(window).width();
			var elementHeight	= ($(window).height() < $(document).height()) ? $(document).height() : $(window).height();
			var scrollTopSize	= $(window).scrollTop();

			$(panel.backPanel).css({'width': elementWidth, 'height': elementHeight});

			var scrollTopSize		= $(window).scrollTop();

			var controllerWidth		= ($(window).width() > $('body').width()) ? $('body').width() : $(window).width();
			var controllerHeight	= ($(window).height() > $('body').height()) ? $('body').height() : $(window).height();

			var halfX				= controllerWidth/2;
			var halfY				= controllerHeight/2;
			
			var elementX			= $(panel.controllLoad).width()/2;
			var elementY			= $(panel.controllLoad).height()/2;
			$(panel.controllLoad).css({'left':halfX-elementX, 'top': halfY-elementY+scrollTopSize, 'opacity':'1'});

			$(panel.controllLoad).show();

			$(panel.backPanel).show();
			$(panel.backPanel).bind('click', function ()
			{
				controllerPanelClose(panel);
			});

		};

		var controllerPanelPosition	= function (panel)
		{
			var scrollTopSize		= $(window).scrollTop();

			var controllerWidth		= ($(window).width() > $('body').width()) ? $('body').width() : $(window).width();
			var controllerHeight	= ($(window).height() > $('body').height()) ? $('body').height() : $(window).height();

			var halfX				= controllerWidth/2;
			var halfY				= controllerHeight/2;
			
			var elementX			= $(panel.controllPanel).width()/2;
			var elementY			= $(panel.controllPanel).height()/2;
			var calHeight			= halfY-elementY+scrollTopSize;
			if (calHeight < 0) calHeight			= 0;

			$(panel.controllPanel).css({'left':halfX-elementX, 'top': calHeight, 'opacity':'1'});

			$(panel.controllLoad).hide();

			$(panel.controllPanel).show();

			$(panel.controllPanel).find('a.element-image-close').bind('click', function ()
			{
				controllerPanelClose(panel);

				return false;
			});
			$(panel.controllPanel).bind('click', function ()
			{
				controllerPanelClose(panel);

				return false;
			});
		};

		var controllerPanelClose	= function (panel)
		{
//			other_event_flag		= true;
			$(panel.controllPanel).find('img.image-original').remove();

			$(panel.controllLoad).hide();
			$(panel.controllPanel).hide();
			$(panel.backPanel).hide();
		};


		$(element).on('click', function ()
		{
//			other_event_flag	= false;
			$(panel.controllPanel).find('img.image-original').remove();

			controllerBakePanelPosition(panel);

			$('<img src="' + $(this).attr('rel') + '" width="1000" />').one('load', function ()
			{
				$(panel.controllPanel).children('div#element-image').append($(this).addClass('image-original'));
				controllerPanelPosition(panel);
			});

			return false;
		});

		$(window).bind('resize', function ()
		{
			try
			{
				if ($('div#element-image-back-panel').is(':visible') == true)
				{
					controllerBakePanelPosition(panel);
					controllerPanelPosition(panel);
				}
			}
			catch (e)
			{
			}
		});
	};
})(jQuery);
