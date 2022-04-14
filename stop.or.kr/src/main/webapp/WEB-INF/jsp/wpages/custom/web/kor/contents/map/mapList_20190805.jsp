<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>

<form:form name="map_form" id="map_form" method="get" action="${pageContext.request.contextPath}/map/mapListSearch.do" commandName="mapVO">
	<input type="hidden" name="srch_menu_nix" value="${param.srch_menu_nix}"/>
	<input type="hidden" name="srch_mu_site" value="<c:if test='${empty param.srch_mu_site}'>CDIDX00002</c:if><c:if test='${!empty param.srch_mu_site}'>${param.srch_mu_site}</c:if>"/>
	<div class="area">
		<div class="map" id="map">
			<div class="item">
				
			</div>
		</div>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1297fc5bb0e1ff32cb69466d4f99c2e7"></script>
		<div class="search">
			<form:select path="sido" name="sido" id="sido" title="지역">
				<form:option value="">지역을 선택하세요</form:option>
				<c:forEach var="result" items="${sidolist}" varStatus="status">
					<form:option value="${result.sido}">${result.sido}</form:option>
				</c:forEach>
			</form:select>
			

			<form:select path="gugun" name="gugun" id="gugun" title="시/군/구">
				<form:option value="">시/군/구를 선택하세요</form:option>
				<c:forEach var="result" items="${gugunlist}" varStatus="status">
					<form:option value="${result.gugun}">${result.gugun}</form:option>
				</c:forEach>
			</form:select>
				
			<p class="form">
				<form:input path="name" placeholder="주소나 센터명을 입력하세요. 예)여성인권진흥원" />
				<!-- <input type="text" name="name" placeholder="주소나 센터명을 입력하세요. 예)여성인권진흥원" /> -->
				<input type="submit" class="btn" value="검색">
				<!-- <a href="" class="btn">검색</a> -->
			</p>
			
			<p class="txt">지역을 선택 안 해도 검색어만으로 검색하실 수 있습니다.</p>
		</div>
		
		<ul class="tabmenu">
			<li class="<c:if test="${param.category eq '여성긴급전화' }">active</c:if>"><a href="#none" id="map_category">여성긴급전화1366</a></li>
			<li class="<c:if test="${param.category eq '해바라기센터' }">active</c:if>"><a href="#none" id="map_category">해바라기센터</a></li>
			<li class="<c:if test="${param.category eq '성폭력상담소' }">active</c:if>"><a href="#none" id="map_category">성폭력피해상담소</a></li>
			<li class="<c:if test="${param.category eq '가정폭력상담소'}">active</c:if>"><a href="#none" id="map_category">가정폭력상담소</a></li>
			<li class="<c:if test="${param.category eq '성매매피해지원기관' }">active</c:if>"><a href="#none" id="map_category">성매매피해상담소</a></li>
			<li class="<c:if test="${empty param.category}">active</c:if>"><a href="#none" id="map_category">전체</a></li>
			
			<%-- <li class="<c:if test="${param.category eq '가정폭력상담소'}">active</c:if>"><a href="#none" id="map_category">가정폭력상담소</a></li>
			<li class="<c:if test="${param.category eq '성매매피해지원기관' }">active</c:if>"><a href="#none" id="map_category">성매매피해지원기관</a></li>
			<li class="<c:if test="${param.category eq '성폭력상담소' }">active</c:if>"><a href="#none" id="map_category">성폭력상담소</a></li>
			<li class="<c:if test="${param.category eq '여성긴급전화' }">active</c:if>"><a href="#none" id="map_category">여성긴급전화</a></li>
			<li class="<c:if test="${param.category eq '해바라기센터' }">active</c:if>"><a href="#none" id="map_category">해바라기센터</a></li>
			<li class="<c:if test="${empty param.category}">active</c:if>"><a href="#none" id="map_category">전체</a></li> --%>
		</ul>
		
		<article class="result">
			<div class="title" id="cnt">
				<h2>
					<strong>"${mapVO.name}"</strong>
					총 <span>${totcnt}</span>건이 검색되었습니다.
				</h2>
				
			</div>
			
			<div class="item">
				<ul class="list" id="j_list">
					<c:choose>
						<c:when test="${!empty maplist}">
							<c:forEach var="result" items="${maplist}" varStatus="status">
								<li>
									<a href="#none" id="map_result" data-id="${result.map_idx}">
										<div>
											<span class="icon1 type<c:if test="${result.category eq '가정폭력상담소' }">2</c:if><c:if test="${result.category eq '성매매피해지원기관' }">5</c:if><c:if test="${result.category eq '성폭력상담소' }">1</c:if><c:if test="${result.category eq '여성긴급전화' }">4</c:if><c:if test="${result.category eq '해바라기센터' }">3</c:if>">${result.category}</span>
											<h3>${result.name }</h3>
											
										</div>
										<p>우) ${result.addr }<br />${result.tel } </p>
									</a>
								</li>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<li>등록된 데이터가 없습니다.</li>
						</c:otherwise>
					</c:choose>
					
				</ul>
			</div>
		</article>
	</div>
</form:form>
<script>
var mu_site = "${param.srch_mu_site}";
if(!mu_site) mu_site = "CDIDX00002";

;jQuery(document).ready(function($)
{
	load_map('${json_maplist}');
});

$('select#sido').change(function() {
	//alert($(this).val());
	if($(this).val()!="")
	{
		$.ajax({
	        url 		: "${pageContext.request.contextPath}/map/mapSearchGugunList.do?srch_menu_nix=${param.srch_menu_nix}&srch_mu_site="+mu_site,
	        type  		: "post",
	        data 		: $('form#map_form').serialize(),
	        datatype	: "json",
			async 		: false,	        
	        success 	: function(data){
	        	$("select#gugun option").remove();
	        	$("select#gugun").append("<option value=''>시/군/구를 선택하세요</option>");
	        	$.each(data,function(key,value) {
	        		//console.log(value.gugun);
	        		if(value.gugun)
	        			$("select#gugun").append('<option value="'+value.gugun+'">'+value.gugun+'</option>');
	        			//$("select#gugun").append("<option value="+value.gugun+">"+value.gugun+"</option>");
	
	        	});
	
	        },
	        error: function(xhr, err){
	            
	        	alert("에러가 발생했습니다.");
	        }
	    }); 
	} else {
		$("select#gugun option").remove();
    	$("select#gugun").append("<option value=''>시/군/구를 선택하세요</option>");
	}
});


/*category click*/
$("a#map_category").click(function() {
	
	$(this).parent().addClass('active').siblings().removeClass('active');
	
	var j_data = "";
	var ct = "";
	
	if($(this).html()!='전체') 
	{
		if($(this).html() == '여성긴급전화1366')
		{
			ct = '여성긴급전화'; 
		}
		else if($(this).html() == '성폭력피해상담소')
		{
			ct = '성폭력상담소';
		}
		else if($(this).html() == '성매매피해상담소')
		{
			ct = '성매매피해지원기관';
		}
		else
		{
			ct = $(this).html(); 
		}
		
	}
	
	$.ajax({
        url 		: "${pageContext.request.contextPath}/map/mapListSearch.do?srch_menu_nix=${param.srch_menu_nix}&srch_mu_site="+mu_site,
        type  		: "post",
        data 		: {"category": ct,"sido":$('select#sido option:checked').val(),"gugun":$('select#gugun option:checked').val(),"name":$('input#name').val()},
        datatype	: "json",
		async 		: false,	        
        success 	: function(data){

        	j_data = JSON.parse(data);
        	
        	if(j_data.length > 0) 
        		load_map(data); 

        	$('div#cnt h2 strong').html('"'+$('input#name').val()+'"');
        	$('div#cnt span').html(j_data.length);
        	
        	$("ul#j_list li").remove();
        	
        	if(j_data.length > 0)
       		{
        		$.each(j_data,function(key,value) {
        			
        			if(value.category == "가정폭력상담소") {
        				cate = "2";
        			} else if(value.category == "성매매피해지원기관") {
        				cate = "5";
        			} else if(value.category == "성폭력상담소") {
        				cate = "1";
        			} else if(value.category == "여성긴급전화") {
        				cate = "4";
        			} else if(value.category == "해바라기센터") {
        				cate = "3";
        			}
        		
        			$("ul#j_list").append("<li><a href='#none' id='map_result' data-id="+value.map_idx+"><div><span class='icon1 type"+cate+"'>"+value.category+"</span><h3>"+value.name+"</h3></div><p>우) "+value.addr+"<br />"+value.tel+"</p></li>");
        		});
       		}
        	else
       		{
        		
        		$("ul#j_list").append("<li>등록된 데이터가 없습니다.</li>");
       		};        
       		
        },
        error: function(xhr, err){
            
        	alert("에러가 발생했습니다.");
        }
        
   
    }); 
	
    return false;
});

/*click*/
$("ul#j_list").on("click","a#map_result",function()
{
	var m_id = $(this).attr('data-id');

	$.ajax({
        url 		: "${pageContext.request.contextPath}/map/mapListSearch.do?srch_menu_nix=${param.srch_menu_nix}&srch_mu_site="+mu_site+"&map_idx="+m_id,
        datatype	: "json",
		async 		: false,	        
        success 	: function(data){

        	load_map(data);        
        },
        error: function(xhr, err){
            
        	alert("에러가 발생했습니다.");
        }
    }); 
	
	return false;
	
});

/*form sumbmit*/
$( "#map_form" ).submit(function( event ) {
	
	event.preventDefault();
	
	var j_data = "";
	var cate = "";
	
	$.ajax({
        url 		: "${pageContext.request.contextPath}/map/mapListSearch.do?srch_menu_nix=${param.srch_menu_nix}&srch_mu_site="+mu_site,
        type  		: "post",
        data 		: $('form#map_form').serialize(),
        datatype	: "json",
		async 		: false,	        
        success 	: function(data){

        	j_data = JSON.parse(data);
        	
        	if(j_data.length > 0) 
        		load_map(data); 
        	
        	$('div#cnt h2 strong').html('"'+$('input#name').val()+'"');
        	$('div#cnt span').html(j_data.length);
        	
        	$("ul#j_list li").remove();
        	
        	if(j_data.length > 0)
       		{
        		$.each(j_data,function(key,value) {
        			
        			if(value.category == "가정폭력상담소") {
        				cate = "2";
        			} else if(value.category == "성매매피해지원기관") {
        				cate = "5";
        			} else if(value.category == "성폭력상담소") {
        				cate = "1";
        			} else if(value.category == "여성긴급전화") {
        				cate = "4";
        			} else if(value.category == "해바라기센터") {
        				cate = "3";
        			}
        		
        			$("ul#j_list").append("<li><a href='#none' id='map_result' data-id="+value.map_idx+"><div><span class='icon1 type"+cate+"'>"+value.category+"</span><h3>"+value.name+"</h3></div><p>우) "+value.addr+"<br />"+value.tel+"</p></li>");
        		});
       		}
        	else
       		{
        		
        		$("ul#j_list").append("<li>등록된 데이터가 없습니다.</li>");
       		}
        	console.log($("a#map_category").last());
        	$("a#map_category").parent().removeClass('active');
        	$("a#map_category").last().parent().addClass('active');
        
        },
        error: function(xhr, err){
            
        	alert("에러가 발생했습니다.");
        }
    }); 
	
	return false;
});

function load_map(data) {

	var maplist = JSON.parse(data);
	
	//console.log(maplist);
	//console.log(maplist.length);

	//var maplist = JSON.parse('${json_maplist}');
	
	var positions = [];
	var content = [];
	 
	positions['content']={};
	positions['latlng']={};
	
	if(maplist.length >= 1)
	{
		$.each(maplist,function(key,value) {
			positions.push({content:value.name,latlng: new daum.maps.LatLng(value.urlx, value.urly)});
		});
	} else{
		//console.log(maplist);
		positions.push({content:maplist.name,latlng: new daum.maps.LatLng(maplist.urlx, maplist.urly)});
	}
	
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
		center : new daum.maps.LatLng(positions[0].latlng.jb, positions[0].latlng.ib), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

	var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

	for (var i = 0; i < positions.length; i ++) {
	    // 마커를 생성합니다
	    var marker = new daum.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: positions[i].latlng // 마커의 위치
	    });
		

	    // 마커에 표시할 인포윈도우를 생성합니다 
	    var infowindow = new daum.maps.InfoWindow({
	        content: '<div class="info"><div class="title">'+positions[i].content+'</div></div>' // 인포윈도우에 표시할 내용
	        //content: '하이하이하이' // 인포윈도우에 표시할 내용
	    });

	    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
	    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
	    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
	    daum.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
	    daum.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
	}

	// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
	function makeOverListener(map, marker, infowindow) {
	    return function() {
		    infowindow.open(map, marker);	    		
	    };
	}

	// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
	function makeOutListener(infowindow) {
	    return function() {
	        infowindow.close();
	    };
	}
	
}
</script>

