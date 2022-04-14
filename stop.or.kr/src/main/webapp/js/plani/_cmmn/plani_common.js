/**
 * 현재 프로젝트에서 jquery를 사용함에 있어 공통적으로 사용되는 기능
 * jQuery Version 1.6 이상
 * author : Bhhan
 * date : 2011.06.25
 * ## TPCODE : TPAGE0017 : 사이트 공통기능처리 스크립트 ##
 */


var g_editor = null;
var g_usable_uploader = true;
var g_context = "";
var oEditors = null;

/**
 * 페이지 내의 모든(또는 특정 DIV 내에 있는) input value를 post data에 추가하여 반환한다..
 * @param {Object} divId : 특정 DIV 내에 있는것만 가져올때 사용한다. 입력하지 않아도 됨.
 * bhhan 2011.09.11
 */


function cmmfn_get_post_data(divId)
{
	var postData = new Object();
	
	var scope = (divId == '' || divId == undefined) ? document : jQuery('#' + divId);
	
	jQuery(":input, textarea", scope).each(function(){
	
		var sval = $(this).val() + "";
		
			if(sval != null && sval != undefined)
			{
				sval = sval.replace(/\"/g, "&quot;");
				sval = sval.replace(/'/g, "&apos;");
				sval = sval.replace(/<!--/g, "&lt;!--");
				sval = sval.replace(/-->/g, "--&gt;");
				sval = sval.replace(/</g, "&lt;");
				sval = sval.replace(/>/g, "&gt;");
				sval = sval.replace(/\r\n/gi, "&lt;BR/&gt;");
				sval = sval.replace(/\r/gi, "&lt;BR/&gt;");
				sval = sval.replace(/\n/gi, "&lt;BR/&gt;");
				sval = sval.replace(/<o:p><\/o:p>/gi, "&lt;br/&gt;");
				
				if( $(this).prop("id") != '')
				{
					try{
					
						if ($(this).prop('type') == 'checkbox')
						{
							eval("postData." + $(this).prop("id") + " = \"" + ($(this).prop('checked') == true ? "Y" : "N") + "\"");
						}
			
						else if ($(this).prop('type') == 'radio')
						{
							if ($(this).prop('checked') == true)
								eval("postData." + $(this).prop("name") + " = \"" + sval + "\"");
						}
			
						else if($(this).prop('type') ==  'text' || $(this).prop('type') ==  'hidden' || $(this).prop('type') ==  'password')
						{
							eval("postData." + $(this).prop("id") + " = \"" + sval + "\"");
						}
						else if($(this).is('select'))
						{
							eval("postData." + $(this).prop("id") + " = \"" + sval + "\"");
						}
						else if($(this).is('textarea'))
						{
							eval("postData." + $(this).prop("id") + " = \"" + sval + "\"");
						}
						
					} catch(err){
						//alert(err);
					}
				}
			}
			
	});
	
	
	return postData;
}

function cmmfn_xss_removeobj(obj)
{
	obj.each(function(){
		if($(this).attr("type") != "file")
		{
			var val = $(this).val();
			val = cmmfn_xss_remove(val);
			$(this).val(val);
		}
	});
}

function cmmfn_xss_remove(sval)
{
	sval = sval.replace(/\"/g, "&quot;");
	sval = sval.replace(/'/g, "&apos;");
	sval = sval.replace(/<!--/g, "&lt;!--");
	sval = sval.replace(/-->/g, "--&gt;");
	sval = sval.replace(/</g, "&lt;");
	sval = sval.replace(/>/g, "&gt;");
	
	return sval;
}

/**
 * 기준 날짜에 연, 월, 일을 더한 날짜를 구한다.
 * @param {Date} date : 기준 일자
 * @param {Number} y : 더할 연 수
 * @param {Number} m : 더할 개월 수
 * @param {Number} d : 더할 날짜 수
 * bhhan 2012.12.11
 */
function cmmfn_get_shift_time(date, y, m, d) {
	var retdt = new Date(date.getFullYear() + y, date.getMonth() + m, date.getDate() + d);
	
	//alert(date.getMonth() + m + " | " +  retdt + " | " + m);
    return retdt;
}


/**
 * Date를 String으로 변환한다.
 * @param {Date} date : 변환할 날짜
 * @param {String} depth : 표시할 레벨 (YY | MM | DD)
 * @param {String} delm : 연월일을 구분할 문자 (- or / ...) 
 * bhhan 2012.12.11
 */
function cmmfn_date_to_string(date, depth, delm) {

	var year  = date.getFullYear();
    var month = date.getMonth() + 1; // 1월=0,12월=11이므로 1 더함
    var day   = date.getDate();

    if (("" + month).length == 1) { month = "0" + month; }
    if (("" + day).length   == 1) { day   = "0" + day;   }

    var pdelm = (delm == undefined || delm == null) ? "" : delm; 
    
    var ret = "";
    
    if(depth == "YY")
    	ret = year;
    else if(depth == "MM")
    	ret = year + pdelm + month;
    else if(depth == "DD")
    	ret = year + pdelm + month + pdelm + day;
    
    return ret;
}

/**
 * String을 Date로 변환한다.
 * @param {String} strdate : 변환할 날짜 (yyyymmdd)
 * bhhan 2012.12.11
 */
function cmmfn_string_to_date(strdate) {

	if(strdate.length != 8)
		strdate = strdate.replace(/\-/g, "");

	
	if(strdate.length !=8)
		alert("날짜 형식에 맞지 않습니다.");

	var yr = strdate.substr(0, 4);
	var mm = strdate.substr(4, 2);
	var dd = strdate.substr(6, 2);
	
	//alert(yr + " " + mm + " " + dd);
	return new Date(parseInt(yr), parseInt(mm) - 1, parseInt(dd));
}

/**
 * 두 날짜간의 차이를 날짜수로 계산한다..
 * @param dt_1 
 * @param dt_2
 * bhhan 2012.12.11
 */

function cmmfn_date_diff(dt_1, dt_2) {
	
	var getDiffTime = dt_1.getTime() - dt_2.getTime();
    return Math.floor(getDiffTime / (1000 * 60 * 60 * 24));
}

/**
 * 주어진 날짜의 요일을 구한다.
 * @param {Date} date : 변환할 날짜
 * bhhan 2015.07.20
 */
function cmmfn_date_to_dowstr(date) {

	var week = new Array('일', '월', '화', '수', '목', '금', '토');
    return week[date.getDay()];
}


/**
 * 숫자를 원하는 자릿수 만큼 0으로 채운다.
 * @param {Number} num : 원래 숫자
 * @param {Number} len : 채울 자릿수
 * bhhan 2012.12.11
 */
function cmmfn_get_zerofill_string(num, len)
{
	if(isNaN(num))
	{
		alert("적절한 숫자 형식이 아닙니다.");
		return
	}
	
	var ret_ = num + "";
	for(var i = ret_.length; i < len; i++)
	{
		ret_ = "0" + ret_;
	}
	
	return ret_;	
}

/**
 * 파비콘을 설정한다..
 * @param {String} context: 페이지 컨텍스트
 * bhhan 2013.04.11
 */
function cmmfn_set_favicon(context)
{

	// 접속 핸드폰 정보
	var userAgent = navigator.userAgent.toLowerCase();
	alert(userAgent);
	// 모바일 홈페이지 바로가기 링크 생성
	if(userAgent.match('iphone')) {
		jQuery("head").append('<link rel="apple-touch-icon" href="' + context +'/images/custom/mobile/apple-touch-icon.png" />');
	} else if(userAgent.match('ipad')) {
		jQuery("head").append('<link rel="apple-touch-icon" sizes="72*72" href="' + context +'/images/custom/mobile/apple-touch-icon-ipad.png" />');
	} else if(userAgent.match('android')) {
		jQuery("head").append('<link rel="shortcut icon" href="' + context +'/main/utils/fileupload/jquery_file_upload-7.4.1/server/gae-python/static/favicon.ico" />'); 
	} else {
		jQuery("head").append('<link rel="shortcut icon" href="' + context +'/main/utils/fileupload/jquery_file_upload-7.4.1/server/gae-python/static/favicon.ico" />');
	}
	
}

function favoritemark(title,url) 
{
	if (window.sidebar) // firefox 
		window.sidebar.addPanel(title, url, ""); 
	else if(window.opera && window.print)
	{ // opera 
		var elem = document.createElement('a'); 
		elem.setAttribute('href',url); 
		elem.setAttribute('title',title); 
		elem.setAttribute('rel','sidebar'); 
		elem.click(); 
	} 
	else if(document.all) // ie
		window.external.AddFavorite(url, title); 
	} 

/**
 * 쿠키 값을 설정한다..
 * @param {String} ckname: 쿠키 명
 * @param {String} ckvalue: 쿠키 값
 * @param {Number} exday: 유효기간 (일)
 * bhhan 2013.04.11
 */
function cmmfn_set_cookie(ckname, ckvalue, exday){

	var expire = new Date();
    expire.setDate(expire.getDate() + exday);
    cookies = ckname + '=' + escape(ckvalue) + '; path=/ '; // 한글 깨짐을 막기위해 escape(cValue)를 합니다.
    if(typeof exday != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
    document.cookie = cookies;    
}

/**
 * 쿠키 값을 가져온다..
 * @param {String} ckname: 쿠키 명
 * bhhan 2013.04.11
 */
function cmmfn_get_cookie(ckname) 
{
	ckname = ckname + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(ckname);
    var cValue = "";
    
    
    if(start != -1)
    {
         start += ckname.length;
         var end = cookieData.indexOf(';', start);
         if(end == -1)end = cookieData.length;
         cValue = cookieData.substring(start, end);
         cValue = unescape(cValue); 
    }
    
    if(cValue == "undefined")
    	cValue = "";
    
    return cValue;
}



/**
 * 앞뒤 공백 제거 
 * @param {Object} value : Src 문자열
 * by bhhan
 */
function cmmfn_str_trim(value) 
{ 
	if(value == null || value == undefined)
		return "";		
		
	return value.replace(/^\s+|\s+$/g, ""); 
} 

String.prototype.startsWith = function(str) {return (this.match("^"+str)==str);};
String.prototype.endsWith = function(str) {return (this.match(str+"$")==str);};

jQuery.fn.layercenter = function () {
    this.css("position","absolute");
    this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
    this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
    return this;
};


/**
 * text상자에 데이트피커를 적용한다.
 * @param {Object} selobjs : 셀렉터 String
 * @param {Object} format : 날짜 포맷 (yy-mm-dd)
 * by Bhhan
*/
function cmmfn_set_datepicker(contextPath, selobjs, format)
{
	//var dateform = (format == null || format == undefined) ? 'yy-mm-dd' : format;
	var dateform = (format == null || format == undefined) ? "%Y-%m-%d" : format;
	
	selobjs.each(function(){
		
		var pickobj = $(this);
		
		if(pickobj.prop('type') == "text")
		{
		/*
		var objcl = $(this).prop("class");
		
		// 동적으로 추가된 datepicker에 이벤트를 걸어줄때 필요...
		if(objcl == "hasDatepicker")
		{
			$(this).parent().find(".ui-datepicker-trigger").remove();
			$(this)
				.removeClass('hasDatepicker')
				.datepicker( "destroy" );
		}
		
		pickobj
			.datepicker({
				changeMonth: true,
				changeYear: true,
				showButtonPanel: true,
				dateFormat:dateform, //yy-mm-dd
				showOn: 'button' ,
				buttonImage: contextPath + '/images/template/cmm/calendar.gif',
				buttonImageOnly:true,
				showButtonPanel:true,
				showAnim : 'fold',
				showMonthAfterYear: true,
				currentText : 'Today',
				yearRange: "1970:2030",
				closeText : '닫기',
				dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],
				monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12']})
			.css({"font-size":"11px","width":"65px","height":"16px","text-align":"center", "z-index":"11", "vertical-align" : "middle"})
			.prop("readonly", true);
		*/
		
		did = pickobj.attr("id");

		eval("datePickerController.destroyDatePicker(\"" + did + "\")");
		eval("\
				datePickerController.createDatePicker({\
					formElements:{\"" + did +"\" :\"%Y-%m-%d\"},\
				});\
			");
		
		pickobj
			.css({"font-size":"11px","width":"65px","height":"14px","text-align":"center", "z-index":"11", "vertical-align" : "middle"})
			.prop("placeholder", cmmfn_date_to_string(new Date(), "DD", "-"));
		}
		
	});
	
	//jQuery(".ui-datepicker-trigger").css("vertical-align", "middle");
	
}


function cmmfn_get_valignopt()
{
	var valign = '0px';
	bw = cmmfn_str_trim(cmmfn_get_browserinfo());
	switch(bw)
	{
		case "IE 12"	: valign = '3px'; break;
		case "IE 11"	: valign = '3px'; break;
		case "IE 10"	: valign = '3px'; break;
		case "IE 9"	: valign = '3px'; break;
		case "IE 8"	: valign = '4px'; break;
		case "IE 7"	: valign = '4px'; break;
		case "Netscape 5"	: valign = '5px'; break;
		default : valign = '-2px';
	}
	
	return valign;
}


/**
 * 브라우저 버전 찾기..
 * IE : <IE 8; IE 7; ...>
 * etc : <Netscape 5; ...> 
 */
function cmmfn_get_browserinfo()
{
	var appver = navigator.appVersion;
	var mvsNavigatorName = "" + navigator.appName;
	
	var ret = '';
	
	if(mvsNavigatorName == 'Netscape')
	{
	   ret = navigator.appName + " " + parseFloat(appver);
	   
	   if(navigator.userAgent.search('Trident') != -1)
		   ret = "IE 11";   
	}
	else if(navigator.appName == 'Microsoft Internet Explorer')
	{
	    if(parseInt(navigator.appVersion)<4)
	    {
	        ret = 'IE ' + parseInt(appver);
	    }
	    else
	    {
	        mvsVer = parseFloat(appver.substring(21));
	        ret = 'IE ' + mvsVer;
	    }
	}
	else
	{
	    ret = navigator.appName + " " + navigator.appVersion;
	}
	
	return ret;
	
}

/**
 * 문자열의 맨 앞자리만 대문자로 바꾼다.
 */
function cmmfn_get_Upper1stChar(inp)
{
	var str = inp.toLowerCase();
	var ret = str.charAt(0).toUpperCase();
	ret += str.substr(1, str.length);
	return ret;	
}


/**
 * 문자열 치환 (regexpr 사용)
 * @param html
 * @returns
 */
function cmmfn_regexpr_replace(sfrom, sto)
{
	var regexp = new RegExp(sfrom, "gi");
	return txt.replace(regexp, sto);
}

/**
 * html 텍스트로부터 dom 오브젝트를 반환
 * @param html
 * @returns
 */
function cmmfn_dom_fromhtml(html)
{
	var dom = jQuery("<div/>").html(html).contents();
	return dom;
}


/**
 * 선택된 요소의 태그 항목들을 처리한다. (XSS관련)
 * 2012.03.24 bhhan
 */
function cmmfn_remove_scrtag(obj)
{
	obj.each(function(){
		
		var val = $(this).html();	
		
		if($(this).is("textarea"))
		{
			val = cmmfn_replacetag_textarea(val);
			if(val.indexOf("?xml") >= 0)
			{
				alert("해당 컨텐츠가 xml문서를 포함하고 있으므로\n'html보기'에서 편집하실것을 권장합니다.");
			}
			val = cmmfn_revision_url(val);
			$(this).val(val);
		}
		else
		{
			if(val == undefined || val == null || val == "")
			{
				val = $(this).val();
				if(val == null || val == undefined)
					return;
				
				val = val.replace(/&amp;/gi, "&");
				val = val.replace(/&quot;/gi, "\"");
				val = val.replace(/&apos;/gi, "'");

				val = val.replace(/&lt;/gi, "<");
				val = val.replace(/&gt;/gi, ">");
				val = cmmfn_revision_url(val);
				$(this).val(val);
			}
			else
			{
				val = cmmfn_revision_url(val);
				val = cmmfn_replacetag_div(val);
				$(this).html(val);
			}
		}
	});
	
}

/**
 * String 내에서 태그 항목들을 처리한다. (XSS관련)
 * 2012.03.24 bhhan
 */
function cmmfn_replacetag_div(val)
{
	val = cmmfn_str_trim(val);
	val = val.replace(/&amp;/gi, "&");
	val = val.replace(/&quot;/gi, "\"");
	val = val.replace(/&apos;/gi, "'");
/*	val = val.replace(/&amp;nbsp;/gi, " ");
	val = val.replace(/&nbsp;/gi, " ");
	val = val.replace(/&amp;nbsp/gi, " ");
	val = val.replace(/&nbsp/gi, " ");
*/
//	val = val.replace(/&lt;BR\/&gt;/g, "\n");
//	val = val.replace(/&lt;BR&gt;/g, "\n");
	
	val = val.replace(/&lt;/gi, "<");
	val = val.replace(/&gt;/gi, ">");
	val = val.replace(/#CONTEXTPATH#/gi, g_context);

	//다음항목들로 시작하지 않는 태그는 html로 보여주지 않는다. 
	val = val.replace(/<(\/*)(\b(?!p|a|b|span|div|strong|img|font|o:p|table|tbody|tfoot|th|tr|td|h1|h2|h3|h4|h5|ul|li|em|ol|hr|input|object|dd|dl|dt|caption|center|section|col|label))([^>]*)>/gi, "&lt;$1$2$3&gt;");
	//val = val.replace(/<(\/*)(\b(?!br))([^>]*)>/g, "&lt;$1$2$3&gt;");
	return val;
}

/**
 * String 내에서 태그 항목들을 처리한다. (XSS관련)
 * 2012.03.24 bhhan
 */
function cmmfn_replacetag_textarea(val)
{
	val = cmmfn_str_trim(val);
	val = val.replace(/&amp;/gi, "&");
	val = val.replace(/&quot;/gi, "\"");
	val = val.replace(/&apos;/gi, "'");
	
	val = val.replace(/&lt;BR\/&gt;/g, "\r\n");
	val = val.replace(/&lt;BR&gt;/g, "\r\n");
	
	val = val.replace(/&lt;/gi, "<");
	val = val.replace(/&gt;/gi, ">");
	val = val.replace(/#CONTEXTPATH#/gi, g_context);

	//val = val.replace(/&amp;nbsp;/gi, " ");
	//다음항목들로 시작하지 않는 태그는 html로 보여주지 않는다. 
	val = val.replace(/<(\/*)(\b(?!p|a|b|span|div|strong|img|font|o:p|table|tbody|tfoot|th|tr|td|h1|h2|h3|h4|h5|ul|li|em|ol|hr|input|object|dd|dl|dt|caption|section|col|label))([^>]*)>/gi, "&lt;$1$2$3&gt;");
	return val;
}

/**
 * Uploadify 를 초기화한다.
 * @param objid : file object id
 * @param context : contextpath ( ${pageContext.request.contextPath} )
 * @param maxuploadlimit : 최대 업로드 가능 개수
 * @param uploadcount : 이미 업로드된 파일 개수
 * @param filesizelimit : 업로드 가능한 파일 크기 제한
 * @param filetype : 업로드 가능한 파일 타입 [*.* : 모든파일 / GNR : 일반적인 파일 / IMG : 이미지파일 / DOC : 문서파일]
 * @param callback : 파일전송이 완료되고 실행할 javascript 함수
 * 2013.05.12 bhhan
 */
function cmmfn_init_uploadify(objid, context, maxuploadlimit, uploadcount, filesizelimit, filetype, callback)
{

	var fileTypeDesc = "";
	var fileTypeExts = "";
	
	switch(filetype)
	{
		/*
		 				보안문제로 써서는 안됨...
		case "*.*" :	fileTypeDesc = "All files";
						fileTypeExts = "*.*";
						break;
		*/
		case "GNR" :	fileTypeDesc = "General files";
						fileTypeExts = "*.gif;*.jpg;*.png;*.bmp;*.zip;*.xls;*.xlsx;*.ppt;*.pptx;*.doc;*.docx;*.txt;*.hwp;*.pdf";
						break;
		case "IMG" :	fileTypeDesc = "Image files";
						fileTypeExts = "*.gif;*.jpg;*.png;*.bmp"; 
						break;
		case "DOC" : 	fileTypeDesc = "Document files";
						fileTypeExts = "*.xls;*.xlsx;*.ppt;*.pptx;*.doc;*.docx;*.txt;*.hwp;*.pdf"; 
						break;
		case "PDF" : 	fileTypeDesc = "PDF file";
						fileTypeExts = "*.pdf"; 
						break;
		case "PDF&HWP" : 	
						fileTypeDesc = "PDF & HPW file";
						fileTypeExts = "*.pdf;*.hwp"; 
						break;
		case "IMG&PDF&HWP" : 
						fileTypeDesc = "Image & PDF & HPW file";
						fileTypeExts = "*.gif;*.jpg;*.png;*.bmp;*.pdf;*.hwp"; 
						break;
		case "IMG&PDF&ZIP" : 
						fileTypeDesc = "Image & PDF & ZIP file";
						fileTypeExts = "*.gif;*.jpg;*.png;*.bmp;*.pdf;*.zip"; 
						break;
		default : 		fileTypeDesc = "General files";
						fileTypeExts = "*.gif;*.jpg;*.png;*.bmp;*.zip;*.xls;*.xlsx;*.ppt;*.pptx;*.doc;*.docx;*.txt;*.hwp;*.pdf"; 
	}
	
	var uploadLimit = maxuploadlimit;
	
	var maxLimit = maxuploadlimit;
	if(uploadLimit == 0)
	{
		uploadLimit = 9999;
		maxLimit = 9999;
	}
	else
	{
		uploadLimit = uploadLimit - uploadcount;
		if(uploadLimit <= 0 )
			uploadLimit = 0;
	}
	
	/*
	$("#" + objid).uploadify({
        'height'      	: 24,
        'width'        	: 69,
        'auto'     		: false,
        'formData'      : {
	        		'UPLOAD_KEY_1' : '', 
	        		'UPLOAD_KEY_2' : '',
        			'UPLOAD_KEY_3' : '',
       				'UPLOAD_KEY_4' : ''        
       	},
        'queueSizeLimit': uploadLimit,
        'uploadLimit': uploadLimit,
        'totalUploadLimit' : maxLimit,
        'removeCompleted' : false,
        'buttonImage' 	: context + '/images/template/cmm/btn_file.gif',
        'buttonText' 	: '파일첨부',
        'fileSizeLimit' : filesizelimit + 'mb',
        'fileTypeDesc' : fileTypeDesc,
        'fileTypeExts' 	: fileTypeExts,
        'swf'      		: context + '/utils/fileupload/uploadify/uploadify.swf',
        'uploader'      : context + '/utils/fileupload/uploadify/fileuploader.jsp',
		'itemTemplate' 	: '<div id="@{fileID}" class="uploadify-queue-item">\
								<div class="cancel">\
									<a href="javascript:$(\'#@{instanceID}\').uploadify(\'cancel\', \'@{fileID}\')">X</a>\
								</div>\
								<div class="file_area">\
									<span class="fileName">\
										<img src="' + context + '/images/template/exticos/@{fileExt}.gif" width="16" height="16" alt="htp"/>\@{fileName} (@{fileSize})\
									</span>\
									<span class="data"> - 0%</span>\
								</div>\
								<div class="uploadify-progress">\
									<div class="uploadify-progress-bar"><!--Progress Bar--></div>\
								</div>\
							</div>',
		//'upload_disable' : uploadlimit == 0 ? true : false,
		'onUploadError' : function(file) {
		},
		'onUploadStart' : function(file) {
			
        },
        'onFallback' : function(file) {
        	if(confirm("현재 브라우저가 파일첨부 플러그인을 구동하기 위한 Flash Player를\n제한하고 있어 파일첨부 기능을 사용할 수 없습니다.\n\n브라우저별 활성화 방법을 확인하시겠습니까?") == true)
        	{
        		window.open("https://helpx.adobe.com/kr/flash-player.html");
        	}
        },
		'onQueueComplete'  : function(file)
		{
			if(typeof(callback) == "function")
			{
				callback();
			}
		},
		'onUploadComplete' : function(file, data, response) {
			
			if(jQuery("#file_upload2").length > 0)
			{
//				$('#file_upload2')
//				.uploadify('upload', '*');
			}
			
			
        }
    });*/
	
	$("#" + objid).uploadify({
		'auto'             : false,
		'checkScript'      : false,
		'buttonClass'     : 'uploadify',
		'fileType'         : '*.*',
		'formData'         : {
    		'UPLOAD_KEY_1' : '', 
    		'UPLOAD_KEY_2' : '',
			'UPLOAD_KEY_3' : '',
			'UPLOAD_KEY_4' : ''        
		    },
	     //'queueID'          : 'divSelectFileArea',
	     'method'       : 'post',
		'uploadScript'     : context + '/utils/fileupload/uploadify/fileuploader.jsp',
		'onUploadComplete' : function(file, data) { console.log(data); }
	});
	
	// 더이상 업로드할 수 있는 여유가 없으면 업로드 버튼을 숨긴다.
	if(uploadLimit == 0)
	{
		jQuery("#" + objid).hide();
		g_usable_uploader = false;
	}
	
}


/**
 * DB에 등록하기 위한 키값(나중에 첨부된 파일을 조회할때 쓸 키값)을 설정한다.
 * 반드시 복합키로 등록해야 한다.
 * @param objid : file object id
 * @param key1 : string
 * @param key2 : string
 * @param key3 : string
 * @param key4 : 업로드 구분 [GNR : 일반, THM : 썸네일]
 * 2013.05.12 bhhan
 */
function cmmfn_set_uploadifykeys(objid, key1, key2, key3, key4)
{
	if(! g_usable_uploader)
		return;	
	
	//jQuery('#' + objid).uploadify('settings', 'formData',  {'UPLOAD_KEY_1' : key1, 'UPLOAD_KEY_2' : key2, 'UPLOAD_KEY_3' : key3, 'UPLOAD_KEY_4' : key4});
	$('#' + objid).data('uploadify').settings.formData =
    {
       'UPLOAD_KEY_1' : key1,
       'UPLOAD_KEY_2' : key2,
       'UPLOAD_KEY_3' : key3,
       'UPLOAD_KEY_4' : key4
    }
}


/**
 * 첨부파일을 업로드 한다.
 * 업로드하면서 DB 저장도 같이 처리된다.
 * @param objid : file object id
 * 2013.05.12 bhhan
 */
function cmmfn_upload_uploadify(objid, callback)
{
	if(! g_usable_uploader)
	{
		callback();
		return false;
	}
	
	var queueLength = cmmfn_get_uploadify_queuelength(objid);
	
	if(queueLength == 0)
	{
		if(typeof(callback) == "function")
		{
			callback();	
		}
	}
	
	else
	{
		//$('#' + objid).uploadify('upload', '*');
		$('#' + objid).uploadify('upload');
	}
	alert('저장되었습니다.');
	document.location.reload();	
	//return true;
}

/**
 * 현재 업로드 큐에 등록된 첨부파일의 개수를 구한다.
 * 업로드하면서 DB 저장도 같이 처리된다.
 * @param objid : file object id
 * 2013.05.12 bhhan
 */
function cmmfn_get_uploadify_queuelength(objid)
{
	
	//var queue = $('#' + objid).data('uploadify').queueData;
	//var queue = $('#' + objid).data('uploadify').fileID;
	var queue = $('#' + objid).data('uploadify').queue;
	//var queueLength = (queue == null || queue == undefined) ? 0 : queue.length;
	var queueLength = (queue == null || queue == undefined) ? 0 : queue.count;
	
	return queueLength;
}

/**
 * 선택한 파일 하나만 삭제한다..
 * @param context : 위와 동일
 * @param key1 : 위와 동일
 * @param key2 : 위와 동일
 * @param key3 : 위와 동일
 * @param key4 : 위와 동일
 * @param callback : 삭제완료 후 실행할 함수
 * 2013.05.23 bhhan
 */
function cmmfn_delete_onefile(context, atckey_1st, atckey_2nd, atckey_3rd, atckey_4th, vchkcode, callback)
{
	if(confirm("첨부된 파일을 삭제하시겠습니까?") == false)
		return;
	
	var data = new Object();
	data.atckey_1st = atckey_1st;
	data.atckey_2nd = atckey_2nd;
	data.atckey_3rd = atckey_3rd;
	data.atckey_4th = atckey_4th;
	data.vchkcode = vchkcode;
	data.is_thumb = jQuery("#is_thumb").val();
	
    $.ajax({
        url 		: context + '/atchfile/rmvAtchOnefile.do',
        type  		: "post",
        data 		: data,
        datatype	: "json",
		async 		: false,	        
        success 	: function(){        	
			
    		alert("삭제되었습니다.");
    		/*
    		jQuery("#divAtcharea_" + key3)
    			.delay(1000 + 100 * 1)
    			.fadeOut(500, function() {
				$(this).remove();
			});
			*/
    		
    		if(typeof(callback) == "function")
    			callback();
        },
        error: function(xhr, err){
            
        	alert("삭제도중 에러가 발생했습니다.");
        }
    });
}

/**
 * 선택한 파일 하나만 삭제한다..
 * @param context : 위와 동일
 * @param key1 : 위와 동일
 * @param key2 : 위와 동일
 * @param key3 : 위와 동일
 * @param key4 : 위와 동일
 * @param callback : 삭제완료 후 실행할 함수
 * 2013.05.23 bhhan
 */
function cmmfn_delete_onefile(context, vchkcode, callback)
{
	if(confirm("첨부된 파일을 삭제하시겠습니까?") == false)
		return;
	
	var data = new Object();
	data.vchkcode = vchkcode;
	data.is_thumb = jQuery("#is_thumb").val();
	
	$.ajax({
		url 		: context + '/atchfile/rmvAtchOnefile.do',
		type  		: "post",
		data 		: data,
		datatype	: "json",
		async 		: false,	        
		success 	: function(){        	
			
			alert("삭제되었습니다.");
			/*
    		jQuery("#divAtcharea_" + key3)
    			.delay(1000 + 100 * 1)
    			.fadeOut(500, function() {
				$(this).remove();
			});
			 */
			
			if(typeof(callback) == "function")
				callback();
			else
				location.reload();
		},
		error: function(xhr, err){
			
			alert("삭제도중 에러가 발생했습니다.");
		}
	});
}


/**
 * 에디터를 초기화한다.
 * @param objid
 * 2013.05.12 bhhan
 */
function cmmfn_init_editor(objid, type, user_h)
{
	if(cmmfn_exist_object(objid) == false)
		return;	
	
	var height = "400";
	
	// cleditor 초기화
	if(type == "A")
	{
		var orgval = jQuery("#" + objid).val();
		
		
		orgval = orgval.toLowerCase();
		
		var linecnt = (cmmfn_get_matchcount(orgval, "<p>") * 35);
		linecnt += (cmmfn_get_matchcount(orgval, "<div>") * 20);
		linecnt += (cmmfn_get_matchcount(orgval, "<br/>") * 30);
		linecnt += (cmmfn_get_matchcount(orgval, "<br>") * 40);
		linecnt += (cmmfn_get_matchcount(orgval, "<tr>") * 80);

		var editor_min_h = 400;
		height = linecnt < editor_min_h ? editor_min_h : linecnt;
		
		var options	= { 
				width: '100%', // width not including margins, borders or padding          
				height: (user_h == null) ? height + "px" : (user_h + 100) + "px" // height not including margins, borders or padding    
		};
		
		g_editor = $("textarea[id='" + objid + "']").cleditor(options)[0];
	}
	
	// tinymce 초기화
	else if(type == "B")
	{
		var orgval = jQuery("#" + objid).val();
		orgval = orgval.toLowerCase();
		
		var linecnt = (cmmfn_get_matchcount(orgval, "<p>") * 35);
		linecnt += (cmmfn_get_matchcount(orgval, "<div>") * 20);
		linecnt += (cmmfn_get_matchcount(orgval, "<br/>") * 30);
		linecnt += (cmmfn_get_matchcount(orgval, "<br>") * 40);
		linecnt += (cmmfn_get_matchcount(orgval, "<tr>") * 40);
		
		var editor_min_h = 400;
		height = linecnt < editor_min_h ? editor_min_h : linecnt;
		
		tinymce.init({    
			selector: "textarea#" + objid,    
			theme: "modern",    
			width: "100%",    
			height: (user_h == null) ? height : user_h,    
			language : 'ko_KR',
			force_p_newlines : true,
			plugins: [
			          "advlist autolink link image lists charmap print preview hr anchor pagebreak spellchecker",         
			          "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",         
			          "save table contextmenu directionality emoticons template paste textcolor"   ],   
			content_css: "css/content.css",   
			menubar: "file edit insert view format table tools",
			toolbar: "insertfile undo redo | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image  media fullpage | print forecolor backcolor emoticons preview code",    
			style_formats: [        
			          {title: 'Bold text', inline: 'b'},        
			          {title: 'Red text', inline: 'span', styles: {color: '#ff0000'}},        
			          {title: 'Red header', block: 'h1', styles: {color: '#ff0000'}},        
			          {title: 'Example 1', inline: 'span', classes: 'example1'},        
			          {title: 'Example 2', inline: 'span', classes: 'example2'},        
			          {title: 'Table styles'},        
			          {title: 'Table row 1', selector: 'tr', classes: 'tablerow1'}    
			         ] 
		}); 
		
	}
	
	// ckeditor 초기화
	else if(type == "C")
	{
		jQuery("#" + objid).addClass("ckeditor");
		CKEDITOR.replace( objid, {
			language: 'ko',
			height : (user_h == null) ? height : user_h
		} );
	}
	else if(type == "D")
	{
		InitToolBarJS(objid);
	}
	else if(type == "E")
	{
		document.getElementById("twe").HtmlValue = jQuery("#"+objid).val();
	}
	else if(type == "F")
	{
		// 스마트 에디터
		oEditors = [];
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: objid,
			sSkinURI: g_context + "/utils/editor/smarteditor/SmartEditor2Skin.html",	
			htParams : {
				bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
				fOnBeforeUnload : function(){
					//alert("완료!");
				}
			}, //boolean
			fOnAppLoad : function(){
				//예제 코드
				//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
			},
			fCreator: "createSEditor2"
		});
		
	}
	else if(type == "G")
	{
		
		// 다음에디터 설정
		 $.ajax({
	            url : g_context + "/utils/editor/daumeditor-7.4.27/editor.html",
	            success : function(data){
					
	            	data = data.replace(/images\/icon\/editor\/skin\/01\/btn_drag01.gif/g, g_context + "/utils/editor/daumeditor-7.4.27/images/icon/editor/skin/01/btn_drag01.gif");
	            	data = data.replace(/images\/icon\/editor\/loading2.png/g, g_context + "/utils/editor/daumeditor-7.4.27/images/icon/editor/loading2.png");
	            	data = data.replace(/images\/icon\/editor\/pn_preview.gif/g, g_context + "/utils/editor/daumeditor-7.4.27/images/icon/editor/pn_preview.gif");
					
	            	$("#editor_frame").html(data);
	                
	                var config = {
	                		txHost: '', /* 런타임 시 리소스들을 로딩할 때 필요한 부분으로, 경로가 변경되면 이 부분 수정이 필요. ex) http://xxx.xxx.com */
	                		txPath: '', /* 런타임 시 리소스들을 로딩할 때 필요한 부분으로, 경로가 변경되면 이 부분 수정이 필요. ex) /xxx/xxx/ */
	                		txService: 'sample', /* 수정필요없음. */
	                		txProject: 'sample', /* 수정필요없음. 프로젝트가 여러개일 경우만 수정한다. */
	                		initializedId: "", /* 대부분의 경우에 빈문자열 */
	                		wrapper: "tx_trex_container", /* 에디터를 둘러싸고 있는 레이어 이름(에디터 컨테이너) */
	                		form: 'tx_editor_form'+"", /* 등록하기 위한 Form 이름 */
	                		txIconPath: g_context + "/utils/editor/daumeditor-7.4.27/images/icon/editor/", /*에디터에 사용되는 이미지 디렉터리, 필요에 따라 수정한다. */
	                		txDecoPath: "images/deco/contents/", /*본문에 사용되는 이미지 디렉터리, 서비스에서 사용할 때는 완성된 컨텐츠로 배포되기 위해 절대경로로 수정한다. */
	                		canvas: {
	                            exitEditor:{
	                                /*
	                                desc:'빠져 나오시려면 shift+b를 누르세요.',
	                                hotKey: {
	                                    shiftKey:true,
	                                    keyCode:66
	                                },
	                                nextElement: document.getElementsByTagName('button')[0]
	                                */
	                            },
	                			styles: {
	                				color: "#123456", /* 기본 글자색 */
	                				fontFamily: "굴림", /* 기본 글자체 */
	                				fontSize: "9pt", /* 기본 글자크기 */
	                				backgroundColor: "#fff", /*기본 배경색 */
	                				lineHeight: "1.5", /*기본 줄간격 */
	                				padding: "10px" /* 위지윅 영역의 여백 */
	                			},
	                			showGuideArea: false
	                		},
	                		events: {
	                			preventUnload: false
	                		},
	                		sidebar: {
	                			attachbox: {
	                				show: true,
	                				confirmForDeleteAll: true
	                			},
	                			capacity: {
	                				available : 1024 * 1024 * 10, /* 첨부 용량 제한 */
	                				maximum: 1024 * 1024 * 10     /* 첨부 용량 제한 */
	                			}
	                		},
	                		size: {
	                			//contentWidth: 670 /* 지정된 본문영역의 넓이가 있을 경우에 설정 */
	                		}
	                	};

	                	EditorJSLoader.ready(function(Editor) {
	                		var editor = new Editor(config);
	                		Editor.getCanvas().setCanvasSize({height:250});
	                		
	                		Editor.modify({
	                            "content": document.getElementById(objid) /* 내용 문자열, 주어진 필드(textarea) 엘리먼트 */
	                        });
	                		
	                	});
	            }
	        });
	         
	         
	}
	else if(type == "Z")
	{
		var orgval = jQuery("#" + objid).val();
		orgval = orgval.toLowerCase();
		
		var linecnt = (cmmfn_get_matchcount(orgval, "<p>") * 35);
		linecnt += (cmmfn_get_matchcount(orgval, "<div>") * 20);
		linecnt += (cmmfn_get_matchcount(orgval, "<br/>") * 30);
		linecnt += (cmmfn_get_matchcount(orgval, "<br>") * 40);
		linecnt += (cmmfn_get_matchcount(orgval, "<tr>") * 40);
		
		var editor_min_h = 400;
		height = linecnt < editor_min_h ? editor_min_h : linecnt;
		
		jQuery("#" + objid)
		.css("width", "100%")
		.css("height", (user_h == null) ? height : (user_h + 100));
	}
}

/**
 * cleditor의 disable 모드를 설정한다.
 * @param disable : true/false
 * 2013.05.12 bhhan
 */
function cmmfn_cleditor_disable(disable)
{
	if(g_editor != null)
		g_editor.disable(disable);
}

/**
 * editor에 focus를 설정한다.
 * @param disable : true/false
 * 2013.05.12 bhhan
 */
function cmmfn_editor_focus(editor_gb)
{
	if(g_editor != null)
		g_editor.focus();
	
	Editor.focus();
}

function cmmfn_get_matchcount(org, srch)
{
	var rx = new RegExp(srch, "g");
	var rsarr = org.match(rx);
	
	return rsarr == null ? 0 : rsarr.length;
}

/**
 * 첨부된 파일을 다운로드 한다.
 * @param context
 * @param brd_id
 * @param cont_idx
 * @param atch_idx
 * 2013.05.12 bhhan
 */
function cmmfn_download_atchfile(context, atckey_1st, atckey_2nd, atckey_3rd, atckey_4th, vchkcode)
{
	var $form = $('<form></form>');
	$form.attr('action', context + '/atchfile/downloadAtchfile.do?atckey_1st=' + atckey_1st + '&atckey_2nd=' + atckey_2nd + '&atckey_3rd=' + atckey_3rd + '&atckey_4th=' + atckey_4th + '&vchkcode=' + vchkcode);
    $form.attr('method', 'post');
    $form.appendTo('body');
    $form.submit();
    
    /*
	var form = document.atchfileForm;
	 
	form.action = context + '/atchfile/downloadAtchfile.do?atckey_1st=' + atckey_1st + '&atckey_2nd=' + atckey_2nd + '&atckey_3rd=' + atckey_3rd + '&atckey_4th=' + atckey_4th + '&vchkcode=' + vchkcode;
	form.submit();
	*/
}

/**
 * vchkcode만으로 첨부된 파일을 다운로드 한다. (vchkcode를 알 수 있는 경우만 사용)
 * @param context
 * @param brd_id
 * @param cont_idx
 * @param atch_idx
 * 2014.08.19 bhhan
 */
function cmmfn_download_atchfile(context, vchkcode)
{
	var $form = $('<form></form>');
	$form.attr('action', context + '/atchfile/downloadAtchfile.do?vchkcode=' + vchkcode);
    $form.attr('method', 'post');
    $form.appendTo('body');
    $form.submit();
    
	/*
	var form = document.atchfileForm;
	 
	form.action = context + '/atchfile/downloadAtchfile.do?vchkcode=' + vchkcode;
	form.submit();
	*/
}


/**
 * 첨부된 파일을 다운로드 한다. (리스트)
 * @param context
 * @param brd_id
 * @param cont_idx
 * @param atch_idx
 * 2013.05.12 bhhan
 */
function cmmfn_download_atchfile_list(context, atckey_1st, atckey_2nd, atckey_3rd, atckey_4th, vchkcode)
{
	var $form = $('<form></form>');
	$form.attr('action', context + '/atchfile/downloadAtchfile.do?atckey_1st=' + atckey_1st + '&atckey_2nd=' + atckey_2nd + '&atckey_3rd=' + atckey_3rd + '&atckey_4th=' + atckey_4th + '&vchkcode=' + vchkcode);
    $form.attr('method', 'post');
    $form.appendTo('body');
    $form.submit();
    
	/*
	var form = document.atchfileForm;
	 
	form.action = context + '/atchfile/downloadAtchfile.do?atckey_1st=' + atckey_1st + '&atckey_2nd=' + atckey_2nd + '&atckey_3rd=' + atckey_3rd + '&atckey_4th=' + atckey_4th + '&vchkcode=' + vchkcode;
	form.submit();
	*/
	
}

/**
 * 엑셀 파일을 다운로드 한다.
 * @param context
 * @param acturl
 * 2013.05.12 bhhan
 */
function cmmfn_download_xlsfile(context, acturl)
{
	
	 ///////////////////////////////////////////////////////////////////////////////
	 /* 이부분은 사용시 주의해야 한다..
	 * serialize() 대상 폼요소가 너무 많은 경우에는 
	 * 익스플로러에서 엑셀 다운이 받아지지 않는 오류가 발생할 수 있다..
	 * 따라서 필요한 파라미터는 가급적 직접 붙여주도록 한다..
	 *
	var queryText = jQuery("form[name='reqForm']").serialize();
	
	if(acturl.indexOf("?") >= 0)
		acturl += "&" + queryText;
	else
		acturl += "?" + queryText;
	*/
	///////////////////////////////////////////////////////////////////////////////	
	
	
	if(acturl.indexOf("9afxGvI7") >= 0 || acturl.indexOf("3pDGzrP5") >= 0 || acturl.indexOf("Ap778PvY") >= 0 || acturl.indexOf("iI9hxA9k") >= 0) //접속자 통계, 폐이지별 통계, 로그관리추가(20200702)
	{
		
		var date_choice = jQuery("form[name='reqForm']").find("input[name='date_choice']:checked").val();
		
		var srchFromDT = jQuery("form[name='reqForm']").find("input[name='srchFromDT']").val();
		srchFromDT = srchFromDT.replace(/-/gi,"");

		var srchToDT = jQuery("form[name='reqForm']").find("input[name='srchToDT']").val();
		srchToDT = srchToDT.replace(/-/gi,"");
			
		var srch_mu_site = jQuery("form[name='reqForm']").find("input[name='srch_mu_site']").val();
			
		var srch_mu_lang = jQuery("form[name='reqForm']").find("input[name='srch_mu_lang']").val();
		
		if(date_choice == 'YY')
		{
			srchFromDT = srchFromDT.substring(0,4);
			srchToDT = srchToDT.substring(0,4);
		}	
		else if(date_choice == 'MM')
		{
			srchFromDT = srchFromDT.substring(0,6);
			srchToDT = srchToDT.substring(0,6);
		}
			
		var queryText = "date_choice="+date_choice+"&srchFromDT="+srchFromDT+"&srchToDT="+srchToDT+"&srch_mu_site="+srch_mu_site+"&srch_mu_lang="+srch_mu_lang;
		
		if(acturl.indexOf("?") >= 0)
			acturl += "&" + queryText;
		else
			acturl += "?" + queryText;
		
		//console.log('###'+acturl);return false;
	}
	
	var $form = $('<form></form>');
	$form.attr('action', context + acturl);
    $form.attr('method', 'post');
    $form.appendTo('body');
    $form.submit();
	
	/*
	var form = document.xlsForm;
	form.action = context + acturl;
	form.submit();
	*/
}


/**
 * 셀렉터로 선택된 값들을 구분자로 붙인 스트링을 구한다.
 * @param objs : 선택된 개체
 * @param delm : 구분자
 */
function cmmfn_concat_selector(objs, delm)
{
	return objs.map(function (){
		return $(this).val();                 
	}).get().join(delm);	
}


/**
 * 코드테이블을 조회하여 셀렉트박스를 설정한다.
 * @param context : contextpath
 * @param up_code_idx : 상위 코드 ID
 * @param objid : 셀렉트박스 ID
 */
function cmmfn_init_codeselectbox(context, up_code_idx, objid)
{
	var data = new Object();
	data.up_code_idx = up_code_idx;
	
	$.ajax({
		url 		: context + '/menuctgry/syscodeJsonList.do',
		type  		: "post",
		data 		: data,
		datatype	: "json",
		async 		: false,	        
	    success 	: function(data){        	

	     	jQuery("#" + objid + " option").remove();
			for(var i = 0; i < data.length; i++)
			{
				jQuery("#" + objid).append("<option value='" + data[i].code_idx + "'>" + data[i].code_nm + "</option>");
			}
	
		},
	    error: function(xhr, err){
	         
	     	alert("코드 항목 정보를 가져오는 도중 오류가 발생했습니다.\n");
	    }
	});
	
}


/**
 * 입력값이 null인지 체크하고 null인경우 해당 input box에 포커스를 준다.
 * @param objs : 체크할 input 선택자(목록)
 */
function cmmfn_check_inputnull(objs)
{
	var addcontinue = true;
	objs.each(function(){
		if($(this).val() == "")
		{
			alert($(this).attr("title") + " 은/는 반드시 입력해주십시오.");
			$(this).focus();
			addcontinue = false;
			return false;
		}
	});
	
	return addcontinue;
}

/**
 * 세자리 숫자마다 , 표시 (금액표시)
 * @param num
 * @returns
 */
function cmmfn_get_moneyformat(num) {
	var pattern = /(-?[0-9]+)([0-9]{3})/;
	while(pattern.test(num)) 
	{
		num = num.replace(pattern,"$1,$2");
	}
	return num;
}
	 

/**
 * ID 유효성 체크
 * @param num
 * @returns
 */
function cmmfn_check_validid(val) {
	var pattern_1 = /^[a-zA-Z0-9]{6,15}$/;
	var pattern_2 = /^[a-z]/gi;
	if(! (pattern_1.test(val))) 
	{
		alert("ID는 영문과 숫자 조합 6~15 자리로 입력해주십시오.");
		return false;
	}
	else if(! (pattern_2.test(val))) 
	{
		alert("ID는 영문으로 시작해야 합니다.");
		return false;
	}
	
	return true;
}

/**
 * PWD 유효성 체크
 * @param num
 * @returns
 */
function cmmfn_check_validpwd(val) {
	var pattern_1 = /^[a-zA-Z0-9!@#$%\^&\*]{8,20}$/;
	var pattern_2 = /^[a-z]/gi;
	if(! (pattern_1.test(val))) 
	{
		alert("패스워드는 영문과 숫자, 특수문자( !@#$%^&* ) 조합\n8~20자리로 입력해주십시오.");
		return false;
	}
	else if(! (pattern_2.test(val))) 
	{
		alert("패스워드는 영문으로 시작해야 합니다.");
		return false;
	}
	
	return true;
}


/**
 * Email 유효성 체크
 * @param num
 * @returns
 */
function cmmfn_check_validemail(val) {
	
	var pattern_1 = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,3}$/;
	//var pattern_1 = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/; 
	if(! (pattern_1.test(val))) 
	{
		alert("이메일 형식에 맞지 않습니다.");
		return false;
	}
	return true;
}


/**
 * ( * ) 를 포함한 IP주소 유효성 체크
 * @param val
 * @returns
 */
function cmmfn_check_validip(val) {
    
	if(val.indexOf("*") >= 0)
	{
		if(val == "*")
			return true;
		else
		{
			val = val.substr(0, val.indexOf("*") - 1);
			
			var spval = val.split(".");
			if(spval > 3)
				return false;
			
			for(var i = 0; i < spval.length; i++)
			{
				var dec = spval[i];
				
				if(isNaN(dec) == true)
					return false;
				
				dec = parseInt(dec);
				
				if(dec >= 0 && dec <= 255)
					return true;
				else
					return false;
				
			}
		}
	}
	else
	{
		var expUrl = /^(1|2)?\d?\d([.](1|2)?\d?\d){3}$/;
	    return expUrl.test(val);
	}
	
}



/**
 * 주민등록번호 유효성 체크
 * @param pbl1 : 앞6자리
 * @param pbl2 : 뒤7자리
 * @returns 유효성 여부
 */
function cmmfn_check_pblno(pbl1, pbl2) 
{ 

	var jumin= pbl1 + pbl2;

	//주민등록 번호 13자리를 검사한다.
	var fmt = /^\d{6}[1234]\d{6}$/; 
	if(!fmt.test(jumin)) 
	{
		return false;
	}

	// 생년월일 검사
	var birthYear = (jumin.charAt(6) <= "2") ? "19" : "20";
	birthYear += jumin.substr(0, 2);
	var birthMonth = jumin.substr(2, 2) - 1;
	var birthDate = jumin.substr(4, 2);
	var birth = new Date(birthYear, birthMonth, birthDate);

	if(birth.getYear() % 100 != jumin.substr(0, 2) ||
       birth.getMonth() != birthMonth ||
       birth.getDate() != birthDate) 
	{
		return false;
	}

	//	Check Sum 코드의 유효성 검사
	var buf = new Array(13);
	for (var i = 0; i < 13; i++) buf[i] = parseInt(jumin.charAt(i));

	multipliers = [2,3,4,5,6,7,8,9,2,3,4,5];
	for (var sum = 0, i = 0; i < 12; i++) 
		sum += (buf[i] *= multipliers[i]);

	if ((11 - (sum % 11)) % 10 != buf[12]) 
	{
		return false;
	}
	return true;
	
}

/**
 * 모달 다이럴로그 창 띄우기
 * @param url
 * @param width
 * @param height
 * @param scroll
 * @param paramObj
 */
function cmmfn_open_modaldialog(url, width, height, scroll, paramObj)
{
	if(paramObj == null || paramObj == undefined)
		paramObj = new Object();
	
	var reWidth = width;
	var reHeight = height;
	
	var opt = 'dialogWidth:' + reWidth + 'px;dialogHeight:' + reHeight + 'px;scroll:' + scroll + ';resizable:No;Center:Yes;status:No;help:No';
	paramObj.window = window;
	popupwnd = window.showModalDialog(url, paramObj, opt);
}

/**
 * 개체가 실제로 존재하는지 여부를 검사한다..
 * @param objid : 검사할 개체 ID
 */
function cmmfn_exist_object(objid)
{
	return (jQuery("#" + objid).length > 0) ? true : false; 
}

function cmmfn_check_fext(objs, type)
{
	var retval = true;
	var ext = "";
	
	objs.each(function(){
		var fpath = $(this).val();
		if(fpath.length > 0)
		{
			ext = fpath.substr(fpath.lastIndexOf(".") + 1, fpath.length);
			ext = ext.toLowerCase();
			
			if(type == "IMG")
			{
				var allows = "jpg|png|bmp|gif";
				if(allows.indexOf(ext) < 0)
				{
					alert("허용되지 않는 파일이거나 목적에 맞지 않는 파일입니다.\n이미지 파일을 등록해주십시오.\n현재 파일 종류 : " + ext);
					retval = false;
					$(this).focus();
				}
			}
			else if(type == "DOC")
			{
				var allows = "doc|docx|xls|xlsx|ppt|pptx|pdf|hwp|txt";
				if(allows.indexOf(ext) < 0)
				{
					alert("허용되지 않는 파일이거나 목적에 맞지 않는 파일입니다.\n문서 파일을 등록해주십시오.\n현재 파일 종류 : " + ext);
					retval = false;
					$(this).focus();
				}
			}
			else if(type == "GNR")
			{
				var allows = "jpg|png|bmp|gif|doc|docx|xls|xlsx|ppt|pptx|pdf|hwp|txt|zip";
				if(allows.indexOf(ext) < 0)
				{
					alert("허용되지 않는 파일이거나 목적에 맞지 않는 파일입니다.\n파일 종류 : " + ext);
					retval = false;
					$(this).focus();
				}
			}
		}
	});
	
	return retval;
	
}


/**
 * 방문 기록을 저장하기 위환 50자리 랜덤키를 만듬
 */
function createLogKey(){
	var key = "", tmp, charCode;;
	
	//a-z (97 ~ 122)
	//0-9 (48 ~ 57)
	for(var i=0; i<50; i++){
		tmp = Math.floor(Math.random() * 10) % 3;
		if(tmp == 0){	//숫자
			charCode = String.fromCharCode(Math.floor(Math.random() * 10) + 48);
		}
		else{	//영문
			if(tmp == 1){	//소문자
				charCode = String.fromCharCode(Math.floor(Math.random() * 1000 % 26) + 97);	
			}
			else{	//대문자
				charCode = String.fromCharCode(Math.floor(Math.random() * 1000 % 26) + 97).toUpperCase();
			}
		}
		key += charCode;
	}
	
	return key;
}

/**
 * 쿠키 없으면 방문 기록을 남김
 */
function doVisitLog(){
	var cKey = 'ckLogKey';
	var ckLogKey;
	if(document.cookie.indexOf(cKey) >= 0){
		ckLogKey = document.cookie.substring(document.cookie.indexOf(cKey) + cKey.length, document.cookie.indexOf(';', document.cookie.indexOf(cKey)));
		return false;
	}
	else{
		var ref = document.referrer;
		var vst_key = createLogKey();
		var dt = new Date();
		dt.setTime(dt.getMinutes() + 10);	//10분 이내에 다시 로그를 쓰지 않음

		$.ajax({
			type: 'POST',
			dataType: 'text',
			url: '/modest/visit.do',
			data: 'vst_refer_url=' + ref + '&vst_key=' + vst_key,
			success: function(result, stat){
				var logKey = createLogKey();
				//alert('쿠키 만든다');
				document.cookie = cKey + escape('ok') + '; expire=' + dt.toGMTString();
			},
			error: function(result, stat){alert('오류 발생');}
		});
	}
}

/**
 * 쿠키 저장
 * @param cknm : 쿠키명
 * @param ckvalue : 쿠키값
 * @param expiredays : 기간
 */
function cmmfn_set_cookie(cknm, ckvalue, expiredays)
{
	var day = new Date();
	day.setDate(day.getDate() + expiredays);
	document.cookie = cknm + "=" + escape(ckvalue) + ";path=/;expires=" + day.toGMTString() + ";";
}


/**
 * 유니코드 이스케이프 스트링
 * @param cknm : 쿠키명
 * @param ckvalue : 쿠키값
 * @param expiredays : 기간
 */
function cmmfn_get_escapestr(src)
{
	var unicodestr = escape(src);
	unicodestr = unicodestr.replace(/%u/g, "\\");
	unicodestr = unicodestr.replace(/%20/g, " ");
	unicodestr = unicodestr.replace(/%28/g, "(");
	unicodestr = unicodestr.replace(/%29/g, ")");
	unicodestr = unicodestr.replace(/%B7/g, "·");
	unicodestr = unicodestr.replace(/%2C/g, ",");
	unicodestr = unicodestr.replace(/%3C/g, "&lt;");
	unicodestr = unicodestr.replace(/%3E/g, "&gt;");
	return unicodestr;
}

/**
 * 관리자페이지에서 적용된 사이트 메인 팝업창 띄우기
 * 아래와 같이 사용
 * 
 	popobj = new Object();
	popobj.pop_x = 0;
	popobj.pop_y = 0;
	popobj.pop_w = 400;
	popobj.pop_h = 500;
	popobj.atckey_2nd = jQuery("#atckey_2nd").val();
	popobj.atckey_3rd = jQuery("#atckey_3rd").val();
	popobj.atckey_4th = jQuery("#atckey_4th").val();
	popobj.vchkcode = jQuery("#vchkcode").val();
	popobj.pop_link = "";
	popobj.pop_target = "";
	popobj.pop_title = "팝업미리보기";
	cmmfn_show_popview(popobj);
 * 
 * @param popobj
 */
function cmmfn_show_popview(popobj)
{
	var opt = "left=" + popobj.pop_x + ",top=" + popobj.pop_y + ",width=" + popobj.pop_w + ",height=" + popobj.pop_h +",scrollbars=0,toolbar=no,menubar=no,location=no";
	
	var param = "atckey_1st=POPUP" +  
				"&atckey_2nd=" + popobj.atckey_2nd + 
				"&atckey_3rd=" + popobj.atckey_3rd + 
				"&atckey_4th=" + popobj.atckey_4th + 
				"&vchkcode=" + popobj.vchkcode + 
				"&pop_w=" + popobj.pop_w + 
				"&pop_h=" + popobj.pop_h + 
				"&pop_link=" + popobj.pop_link + 
				"&pop_target=" + popobj.pop_target + 
				"&pop_title=" + encodeURIComponent(popobj.pop_title);

	popupwnd = window.open(encodeURI(g_context + "/template/metsys/pp/mainpopup.stpg?" + param), "_blank", opt);
}

/**
 * 트위터로 퍼가기 기능
 * @param snsgb
 */
function cmmfn_sns_send(snsgb, title, url, port)
{

	//var sns_title = encodeURIComponent(title);
	var sns_title = "여성인권진흥원- "+encodeURIComponent(title);
	var sns_url = url.startsWith("http://") ? url : (location.protocol + "//" + document.domain + ( port == 80 ? "" : ":" + port ) + url);
	sns_url += "&edomweivgp=R";
	//console.log(sns_url);
	sns_url = encodeURIComponent(sns_url);
	//console.log(sns_url);
	if(snsgb == "twitter")
	{
		url = "https://twitter.com/intent/tweet?text="+sns_title+"&url="+sns_url
		//url = "http://twitter.com/home?status=" + sns_title + ":" + sns_url;
	}
	else if(snsgb == "facebook")
	{
		url = "http://www.facebook.com/sharer.php?u=" + sns_url;
	}
	else if(snsgb == "kakaostory")
	{
		url = "https://story.kakao.com/share?url=" + sns_url;
	}
	else if(snsgb == "naver")
	{
		url = "https://share.naver.com/web/shareView.nhn?url=" + sns_url + "&title=" + sns_title;
	}
	
	window.open(url);
}


function cmmfn_atch_notfound()
{
	alert("첨부된 파일이 존재하지 않습니다.")
}

/**
 * html의 링크 주소를 보정
 * @param val
 * @returns
 */
function cmmfn_revision_url(val){
	var baseUrl = "http://" + document.domain + "/";
	if(g_context != ""){
		baseUrl + g_context + "/"; 
	}

	val = val.replace(/src="\/\/www/gi, 'src="http://www');
	val = val.replace(/src="\//gi, 'src="' + baseUrl);
	return val;
}


/**
 * 글상자 내용 클립보드 복사
 * input type = hidden 안됨, display:none 안됨
 * <input type= text style = "opacity:0"/> 으로만 됨
 * @param object id
 * @returns void
 */
function cmmfn_cpy_clipboard(objid)
{
	jQuery("#" + objid).select(); 
	document.execCommand('copy');
	alert("복사되었습니다");
}



var Base64 = {

	// private property
	_keyStr : "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",

	// public method for encoding
	encode : function (input) {
		var output = "";
		var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
		var i = 0;

		while (i < input.length) {

		  chr1 = input.charCodeAt(i++);
		  chr2 = input.charCodeAt(i++);
		  chr3 = input.charCodeAt(i++);

		  enc1 = chr1 >> 2;
		  enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
		  enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
		  enc4 = chr3 & 63;

		  if (isNaN(chr2)) {
			  enc3 = enc4 = 64;
		  } else if (isNaN(chr3)) {
			  enc4 = 64;
		  }

		  output = output +
			  this._keyStr.charAt(enc1) + this._keyStr.charAt(enc2) +
			  this._keyStr.charAt(enc3) + this._keyStr.charAt(enc4);

		}

		return output;
	},

	// public method for decoding
	decode : function (input)
	{
	    var output = "";
	    var chr1, chr2, chr3;
	    var enc1, enc2, enc3, enc4;
	    var i = 0;

	    input = input.replace(/[^A-Za-z0-9+/=]/g, "");

	    while (i < input.length)
	    {
	        enc1 = this._keyStr.indexOf(input.charAt(i++));
	        enc2 = this._keyStr.indexOf(input.charAt(i++));
	        enc3 = this._keyStr.indexOf(input.charAt(i++));
	        enc4 = this._keyStr.indexOf(input.charAt(i++));

	        chr1 = (enc1 << 2) | (enc2 >> 4);
	        chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
	        chr3 = ((enc3 & 3) << 6) | enc4;

	        output = output + String.fromCharCode(chr1);

	        if (enc3 != 64) {
	            output = output + String.fromCharCode(chr2);
	        }
	        if (enc4 != 64) {
	            output = output + String.fromCharCode(chr3);
	        }
	    }

	    return output;
	}
}




