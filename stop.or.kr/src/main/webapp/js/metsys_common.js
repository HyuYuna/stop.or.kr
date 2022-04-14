var SetTime = 3600;

;jQuery(document).ready(function($)
{
	
	try
	{
		$("#reset_time").click(function()
		{
			SetTime = 3600;
		});
		
		/*
//		setInterval(function() {
//			$.ajax({
//			        url 		: g_context+"/metsys/sessionCheck.do",
//			        type  		: "post",
//			        datatype	: "json",
//					async 		: false,	        
//			        success 	: function(data){
//			        	//console.log(data);
//			        	if(data != false)
//		        		{
//			        		alert("세션이 끊겼습니다1.");
//			        		location.reload();
//		        		}
//			        }
//				});
//			}, 60000); //1분간격
		*/
		window.onload = function TimerStart(){ tid=setInterval('msg_time()',1000) };
		
	}
	catch(e)
	{
		console.log(e);
//		$.debug(e);
	}
	
	
});



function msg_time() {	// 1초씩 카운트
	
	
	m = Math.floor(SetTime / 60) + "분 " + (SetTime % 60) + "초";	// 남은 시간 계산
	
	var msg = "자동 로그아웃까지 <font color='red'>" + m + "</font> 남았습니다.";
	
	//document.all.ViewTimer.innerHTML = msg;		// div 영역에 보여줌 
	$(".auto_logout_time").html();
	$(".auto_logout_time").html(msg);

	
	
	SetTime--;					// 1초씩 감소
	
	if (SetTime < 0) {			// 시간이 종료 되었으면..
		
		alert("장시간 미사용하여 로그아웃되었습니다.");
		document.location.href = g_context+"/metsys/metsysLogout.do";
		
	}
	
}

