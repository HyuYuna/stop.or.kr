/*----------------------------------------------------------------------------
 * Plugin	: jquery-plani.ajax_form_submit.js
 * ---------------------------------------------------------------------------
 * Author	: (주)플랜아이 http://plani.co.kr
 * ---------------------------------------------------------------------------
 * History
 * ---------------------------------------------------------------------------
 * 2014-05-26 (pigcos)	: 최초작성 (jQuery Form Plugin 랩핑)
 * -------------------------------------------------------------------------*/
;(function($) {
	$.fn.AjaxFormSubmit	= function (options, confirmMessage, beforeSubmitCallBack, successCallBack) {
		return this.each(function () {
			if (!$.fn.ajaxForm) { return false; }
			var $selector	= $(this);
			var $form;
			var settings	= $.extend({
					'type'			: 'post',
					'dataType'		: 'json',
					'beforeSubmit'	: function (arr, form, options) {
						$form = form;
					},
					'success'	: function (result, status, xhr) {
						console.log(result);
						if (result.messages) {
							var type = typeof(result.messages);
							if (type.toLowerCase() == "string") {
								alert(result.messages);
							} else {
//								console.log(result.messages);
								var field = "";
								var tagName = "";
								var beforeKey = "";
								var messages = new Array();
								$form.find(":input").each(function () {
									var key = $(this).attr('name');
									try {
										var key_ = key.replace('validation-', '');
										if (result.messages[key_]) {
											key = key_;
										}
									} catch (e) {
										
									}
									if (result.messages[key] && beforeKey != key) {
//										console.log(result.messages[key]);
										for(var i=0; i<Object.keys(result.messages[key]).length; i++) {
											messages.push(result.messages[key][i]);
										}
										if (!field) {
											field = key;
											tagName = $(this)[0].tagName;
										}
										beforeKey = key;
									}
								});
								if (messages.length > 0) {
									alert(messages[0]);	// 에러메세지 1개 적용
//									alert(messages.join('\n'));	// 에러메세지 여러개 적용
								}
								if (field) {
									try{
										$selector.find(tagName+"[name='" + field + "']")[0].focus();
									} catch (e) {
										$('#validation-'+field).focus();
									}
								}
							}
						}
						if (typeof(successCallBack) == 'function') {
							successCallBack(result);
						} else {
							if (result.url) {
								location.replace(result.url);
							}
						}
					},
					error	: function (xhr, e, status) {
						var html = $.parseHTML(xhr.responseText);
						var message = $(html).find('#error-message').html();
						if (message && message.length > 0) {
							alert(message);
						} else {
							alert("error");
							//location.reload();
						}
					}
				},
				options
			);
			$selector
			.submit(function () {
				if (confirmMessage && confirmMessage != "") {
					if (confirm(confirmMessage) == false) {
						return false;
					}
				}
				if (typeof(beforeSubmitCallBack) == 'function') {
					beforeSubmitCallBack();
				}
			})
			.ajaxForm(settings);

		});		
	};

})(jQuery);
