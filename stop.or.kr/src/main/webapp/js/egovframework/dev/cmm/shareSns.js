document.write('<script src=\"https://developers.kakao.com/sdk/js/kakao.min.js\"></script>');

$(function(){
	Kakao.init('fdd5ac391d4880f75ce1a7d1ead515d1');
			
});

function shareSns(type){
	
    var p = getPageInfo();
    var _targetUrl = '';
    
    if (type == 'facebook') {
    	
    	_targetUrl = 'http://www.facebook.com/sharer/sharer.php?u=' + encodeURIComponent(p._url);
    	window.open(_targetUrl);
    	
    } else if (type=='kakaostory') {

    	Kakao.Story.share({
//    		text: p._title,
        	url: p._url
	    });
    	
    } else {
    	alert('지원하지 않는 SNS 입니다.');
    	return false;
    }
    
}

function getPageInfo(){

	var pageUrl = location.href;
	var pageTitle = document.title;
	
	var info = { 
			_url : pageUrl, 					 
			_title : pageTitle,
	};
    
    return info;
    
}





