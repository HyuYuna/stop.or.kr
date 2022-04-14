/****************************************************************
 * 
 * 파일명 : PostZipcode.js
 * 설  명 : 다음 도로명주소 api 커스터마이징 
 * 
 *    수정일      수정자     Version        Function 명
 * ------------    ---------   -------------  ----------------------------
 * 2015.01.22    진효진       1.0             최초생성
 * 2017.10.25    진효진       2.0             신 우편번호 적용
 * 
 * 
 * **************************************************************/

/* Guide
 #####jsp 내에서 도로명주소 호출 방법##### 
<script src="/js/egovframework/dev/cmm/postZipcode.js"></script>
<script type="text/javascript">
//도로명 주소 설정 ID
var _zipconfig = {
		zibun_zipcode : '지번 우편번호의 ID',
		road_zipcode : '도로명 우편번호 1의 ID',
		zibun_addr1 : '지번주소가 들어갈 input ID',
		road_addr1 : '도로명주소가 들어갈 input ID'
};
</script>

#####우편번호찾기 버튼 호출 방법##### 
<input type="button" value="우편번호찾기" onclick="execPostZipcode(_zipconfig);"/>
 */



//다음 도로명주소 js 호출
document.write("<script src='https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js'></script>");


    function execPostZipcode(config, f) {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                // 법정동명이 있을 경우 추가한다.
                if(data.bname !== ''){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있을 경우 추가한다.
                if(data.buildingName !== ''){
                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    //예상되는 도로명 주소에 조합형 주소를 추가한다.
                	fullRoadAddr = data.autoRoadAddress + extraRoadAddr;
                } else if(data.autoJibunAddress) {
                	data.jibunAddress = data.autoJibunAddress;
                }
                
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                //document.getElementById(config["zibun_zipcode"]).value = data.postcode1+"-"+data.postcode2;
                //document.getElementById(config["road_zipcode"]).value = data.postcode1+"-"+data.postcode2;
                
                //구우편번호 -> 신우편번호 변경
                if(typeof(config["zibun_zipcode"]) != "undefined") document.getElementById(config["zibun_zipcode"]).value = data.zonecode;
                if(typeof(config["road_zipcode"]) != "undefined") document.getElementById(config["road_zipcode"]).value = data.zonecode;
                
                if(typeof(config["zibun_addr1"]) != "undefined") document.getElementById(config["zibun_addr1"]).value = data.jibunAddress;
                if(typeof(config["road_addr1"]) != "undefined") document.getElementById(config["road_addr1"]).value = fullRoadAddr;
                
                if(typeof(config["bcode"]) != "undefined" && data.bcode != "" ) document.getElementById(config["bcode"]).value = data.bcode;
                
            }
        
        }).open();
        
    }
    
    /*
    var danjiSelectboxID = "danji_name";
    var buildTypeInputID = "build_type";
    var buildTypeSelectboxID = "build_type_select";
    var scaleData;
    
    function callDanjiList(bcode,f){
    	
    	if(typeof(bcode) == "undefined" || bcode == "" ){
    		alert("필요한 코드값이 없습니다.");
    	}else{
    		var goUrl = "";
    		if(f == "아파트"){
    			goUrl = "https://api.realestate.daum.net/onsum/apartments?bcode="+bcode+"&appkey=d11ec680e8b6c838c7ae1a59c80252e7";
    		}else if(f == "오피스텔"){
    			goUrl = "https://api.realestate.daum.net/onsum/officetels?bcode="+bcode+"&appkey=d11ec680e8b6c838c7ae1a59c80252e7";
    		}
    		$.ajax({
    			//API 변경으로 인한 내용변경
        	    //url: "http://api.realestate.daum.net/api/apartments?bcode="+bcode+"&appkey=d11ec680e8b6c838c7ae1a59c80252e7",
        	    //url: "http://api.realestate.daum.net/onsum/apartments?bcode="+bcode+"&appkey=d11ec680e8b6c838c7ae1a59c80252e7",
    			url : goUrl,
        	    dataType: 'jsonp',
        	    jsonpCallback: "callback",
        	    success: function(data) {
        	    	$("#"+danjiSelectboxID).find('option').remove().end().append("<option value=''>--선택--</option>");
        	    	//$("#"+danjiSelectboxID).show();
    	    	    $.each(data, function (index, entry) {
    	    	    	//API 변경으로 인한 내용변경
    	    	    	//$("#"+danjiSelectboxID).append("<option value='" + entry["aptCode"] + "'>" + entry["aptName"] + "</option>");
    	    	    	var danjiName = entry["danjiName"].replace("Test.","");

    	    	    	//Daum 부동산에서 사용하는것만 표출 - valid : true 
    	    	    	if(entry["valid"] == true || entry["valid"] == "true" ){
    	    	    		$("#"+danjiSelectboxID).append("<option value='" + entry["danjiId"] + "'>"+ danjiName +"</option>");
    	    	    		console.log("OK :::::: danjiId="+entry["danjiId"]+" / danjiName="+entry["danjiName"]+" / valid="+entry["valid"]);
    	    	    	}else{
    	    	    		console.log("NO :::::: danjiId="+entry["danjiId"]+" / danjiName="+entry["danjiName"]+" / valid="+entry["valid"]);
    	    	    	}
    	    	    	
    	  			});
    	    	    $("#"+danjiSelectboxID).append("<option value='00000'>직접입력</option>");
        	    },
        	    error: function(xhr) {
        	    	//alert("목록을 가져오는데 실패하였습니다.\n"+xhr);
        	    	console.log("목록을 가져오는데 실패하였습니다 : callDanjiList");
        	    	console.log(xhr);
        	    }
        	  });
    	}
    }
    
    function callScaleInfo(aptCode, f){
    	if(typeof(aptCode) == "undefined" || aptCode == "" ){
    		alert("필요한 코드값이 없습니다.");
    	}else{
    		if(aptCode=="00000"){
    			if($("#"+buildTypeSelectboxID).css("display")=="inline-block"){
    	    		$("#"+buildTypeSelectboxID).hide();
    	    	}
    			//alert("단지데이터가 없을경우에만 사용해 주시기 바랍니다.");
    			$("#road_addr2").show();
    			$("#road_addr2").focus();
    		}else{
    			var goUrl = "";
        		if(f == "아파트"){
        			goUrl = "https://api.realestate.daum.net/onsum/apartments/"+aptCode+"/scales?appkey=d11ec680e8b6c838c7ae1a59c80252e7";
        		}else if(f == "오피스텔"){
        			goUrl = "https://api.realestate.daum.net/onsum/officetels/"+aptCode+"/scales?appkey=d11ec680e8b6c838c7ae1a59c80252e7";
        		}
    			$.ajax({
    				//API 변경으로 인한 내용변경
    	    	    //url: "http://api.realestate.daum.net/api/apartments/"+aptCode+"/scales?appkey=d11ec680e8b6c838c7ae1a59c80252e7",
    				//url: "http://api.realestate.daum.net/onsum/apartments/"+aptCode+"/scales?appkey=d11ec680e8b6c838c7ae1a59c80252e7",
    				url : goUrl,
    	    	    dataType: 'jsonp',
    	    	    jsonpCallback: "callback",
    	    	    success: function(data) {
    	    	    	scaleData = data;
    	    	    	$("#"+buildTypeSelectboxID).find('option').remove().end().append("<option value=''>--선택--</option>");
    	    	    	$.each(data, function (index, entry) {
    	    	    		//API 변경으로 인한 내용변경
        	    	    	//$("#"+buildTypeSelectboxID).append("<option value=" + entry["scaleCode"] + ">" + entry["scaleName"] +" / " +entry["peung"]+ "평형</option>");
    	    	    		$("#"+buildTypeSelectboxID).append("<option value=" + entry["pcode"] + ">" + entry["ptype"] +" / " +entry["peung"]+ "평형</option>");
        	  			});
    	    	    	$("#daum_aptcode").val(aptCode);
    	    	    	$("#road_addr2").val($("#danji_name option:selected").text());
    	    	    	$("#zibun_addr2").val($("#danji_name option:selected").text());
    	    	    	if($("#"+buildTypeSelectboxID).css("display")=="none"){
    	    	    		$("#"+buildTypeSelectboxID).show();
    	    	    	}
    	    	    },
    	    	    error: function(xhr) {
    	    	    	//alert("목록을 가져오는데 실패하였습니다.\n"+xhr);
    	    	    	console.log("목록을 가져오는데 실패하였습니다 : callScaleInfo");
            	    	console.log(xhr);
    	    	    }
    	    	});
    		}
	    	
    	}
    }
    
    function insertScaleInfo(scaleCode){
    	
    	if(typeof(scaleCode) == "undefined" || scaleCode == "" ){
    		alert("필요한 코드값이 없습니다.");
    	}else{
    		$.each(scaleData, function (index, entry) {
    	    	if(scaleCode == entry["pcode"]){
    	    		$("#build_type").val(entry["peung"]); //평형
    	    		$("#build_area_info_1").val(entry["privSize"]); //전용면적
    	    		$("#build_area_info_2").val(entry["supSize"]); //공급면적
    	    		$("#build_area_info_3").val(entry["contSize"]); //계약면적
    	    		$("#daum_scalecode").val(scaleCode); // 면적코드 입력
    	    	}
  			});
    	}
    	
    }
    */
    
    
    
	