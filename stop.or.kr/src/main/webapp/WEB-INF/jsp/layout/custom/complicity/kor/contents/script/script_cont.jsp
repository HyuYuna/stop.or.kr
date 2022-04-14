<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--
	컨텐츠 페이지 초기화 스크립트
	2013.04.16 bhhan
-->	
<script type="text/javascript">
var curr_visualnum = 1;
jQuery(document).ready(function(){
	
	if(cmmfn_exist_object("divUcont_cont") == true)
	{
		if(cmmfn_exist_object("yr") == true)
		{
			jQuery("#yr").css("height", "35px");
			
			jQuery("#yr").change(function(){
				var form = document.reqForm;
				fn_egov_move_action(form, "/statdata/statdataView.do?srch_stat_cd=${param.srch_stat_cd}&srch_menu_nix=${param.srch_menu_nix}");
			});
			
			
		}
	}

	
	if("${param.ucont_id}" != "")
	{

		if(jQuery("ul > br").length > 0)
			jQuery("ul > br").remove();
		
		$('div.organization').find('div').hide();

		$('ul.organization_chart').find('a').click(function(){
			$('div.organization').find('div').hide();
			$(this.hash).show();
		});
		
		//cmmfn_remove_scrtag(jQuery("#divUcont_cont"));
		
		/*
		//	.show();
		*/
		/*
		<c:if test="${param.srch_menu_nix eq '84PH37AT'}">
			// 네이버 지도 API
			var oDmuseumPoint = new nhn.api.map.LatLng(35.8458932, 128.6379046);
			nhn.api.map.setDefaultPoint('LatLng');
			var oMap = new nhn.api.map.Map(document.getElementById('divNavermap'), {                                                 
				point : oDmuseumPoint,                                                
				zoom : 11,                                                
				enableWheelZoom : true,                                                
				enableDragPan : true,                                                
				enableDblClickZoom : false,                                                
				mapMode : 0,                                                
				activateTrafficMap : false,                                                
				activateBicycleMap : false,                                                
				minMaxLevel : [ 1, 14 ],                                                
				size : new nhn.api.map.Size(700, 400)           
			});                
			
			var oSlider = new nhn.api.map.ZoomControl();                
			oMap.addControl(oSlider);                
			oSlider.setPosition({                        
				top : 10,                        
				left : 10                
			});
			
		   mapTypeChangeButton = new nhn.api.map.MapTypeBtn(); // - 지도 타입 버튼 선언
		   mapTypeChangeButton.setPosition({top:10, left:600}); // - 지도 타입 버튼 위치 지정
		   oMap.addControl(mapTypeChangeButton);
            
			var oSize = new nhn.api.map.Size(28, 37);                
			var oOffset = new nhn.api.map.Size(14, 37);                
			var oIcon = new nhn.api.map.Icon('http://static.naver.com/maps2/icons/pin_spot2.png', oSize, oOffset);                
			var oMarker = new nhn.api.map.Marker(oIcon, {title : '국립대구박물관'});
			oMarker.setPoint(oDmuseumPoint);
			oMap.addOverlay(oMarker);     // - 지도에 추가.        
                    
			var oLabel = new nhn.api.map.MarkerLabel(); // - 마커 라벨 선언.                
			oMap.addOverlay(oLabel); // - 마커 라벨 지도에 추가. 기본은 라벨이 보이지 않는 상태로 추가됨.                
			
			
			oMap.attach('mouseenter', function(oCustomEvent) {                        
				var oTarget = oCustomEvent.target;                        // 마커위에 마우스 올라간거면                       
		
				if (oTarget instanceof nhn.api.map.Marker) {                                
					var oMarker = oTarget;                                
					oLabel.setVisible(true, oMarker); // - 특정 마커를 지정하여 해당 마커의 title을 보여준다.                        
				}                
			});                
		
			oMap.attach('mouseleave', function(oCustomEvent) {                        
				var oTarget = oCustomEvent.target;                        // 마커위에서 마우스 나간거면                        
				if (oTarget instanceof nhn.api.map.Marker) {                                
					oLabel.setVisible(false);                        
					}                
				}); 
			
			
			
			//http://map.naver.com/?dlevel=10&pinType=site&pinId=11620560&x=128.6379046&y=35.8458932&enc=b64
			//http://map.naver.com/?dlevel=10&pinType=site&pinId=11620560&x=128.6379046&y=35.8458932&enc=b64
			/*
			
			var oMapTypeBtn = new nhn.api.map.MapTypeBtn();                
			oMap.addControl(oMapTypeBtn);                
			oMapTypeBtn.setPosition({                        
				bottom : 10,                        
				right : 80                
			});
			
			var oThemeMapBtn = new nhn.api.map.ThemeMapBtn();                
			oThemeMapBtn.setPosition({                        
				bottom : 10,                        
				right : 10                
			});                
			
			oMap.addControl(oThemeMapBtn);                
			var oBicycleGuide = new nhn.api.map.BicycleGuide(); // - 자전거 범례 선언                
			oBicycleGuide.setPosition({                        
				top : 10,                        
				right : 10                
			}); // - 자전거 범례 위치 지정               
			
			oMap.addControl(oBicycleGuide);// - 자전거 범례를 지도에 추가.                
			var oTrafficGuide = new nhn.api.map.TrafficGuide(); // - 교통 범례 선언               
			oTrafficGuide.setPosition({                        
				bottom : 30,                        
				left : 10                
			});  // - 교통 범례 위치 지정.                
			
			oMap.addControl(oTrafficGuide); // - 교통 범례를 지도에 추가.                
			var trafficButton = new nhn.api.map.TrafficMapBtn(); // - 실시간 교통지도 버튼 선언               
			trafficButton.setPosition({                        
				bottom:10,                         
				right:150                
			}); // - 실시간 교통지도 버튼 위치 지정                
		
			oMap.addControl(trafficButton);
			
			var oSize = new nhn.api.map.Size(28, 37);                
			var oOffset = new nhn.api.map.Size(14, 37);                
			var oIcon = new nhn.api.map.Icon('http://static.naver.com/maps2/icons/pin_spot2.png', oSize, oOffset);                

			var oInfoWnd = new nhn.api.map.InfoWindow();                
			oInfoWnd.setVisible(false);                
			oMap.addOverlay(oInfoWnd);                
			oInfoWnd.setPosition({                        
				top : 20,                        
				left :20                
			});
			
			var oLabel = new nhn.api.map.MarkerLabel(); // - 마커 라벨 선언.                
			oMap.addOverlay(oLabel); // - 마커 라벨 지도에 추가. 기본은 라벨이 보이지 않는 상태로 추가됨.                
			oInfoWnd.attach('changeVisible', function(oCustomEvent) {                        
				if (oCustomEvent.visible) {                                
					oLabel.setVisible(false);                        
				}                
			});                                
		
			var oPolyline = new nhn.api.map.Polyline([], {                        
				strokeColor : '#f00', // - 선의 색깔                        
				strokeWidth : 5, // - 선의 두께                       
				strokeOpacity : 0.5 // - 선의 투명도               
			}); // - polyline 선언, 첫번째 인자는 선이 그려질 점의 위치. 현재는 없음.                
			oMap.addOverlay(oPolyline); // - 지도에 선을 추가함.                
		
			oMap.attach('mouseenter', function(oCustomEvent) {                        
				var oTarget = oCustomEvent.target;                        // 마커위에 마우스 올라간거면                       
		
				if (oTarget instanceof nhn.api.map.Marker) {                                
					var oMarker = oTarget;                                
					oLabel.setVisible(true, oMarker); // - 특정 마커를 지정하여 해당 마커의 title을 보여준다.                        
				}                
			});                
		
			oMap.attach('mouseleave', function(oCustomEvent) {                        
				var oTarget = oCustomEvent.target;                        // 마커위에서 마우스 나간거면                        
				if (oTarget instanceof nhn.api.map.Marker) {                                
					oLabel.setVisible(false);                        
					}                
				}); 
						
			oMap.attach('click', function(oCustomEvent) {                        
				var oPoint = oCustomEvent.point;                        
				var oTarget = oCustomEvent.target;                        
				oInfoWnd.setVisible(false);                        // 마커 클릭하면                        
				if (oTarget instanceof nhn.api.map.Marker) {                                // 겹침 마커 클릭한거면                                
					if (oCustomEvent.clickCoveredMarker) {                                        
						return;                                
					} 	// - InfoWindow 에 들어갈 내용은 setContent 로 자유롭게 넣을 수 있습니다. 외부 css를 이용할 수 있으며,                                 
						// - 외부 css에 선언된 class를 이용하면 해당 class의 스타일을 바로 적용할 수 있습니다.                                
						// - 단, DIV 의 position style 은 absolute 가 되면 안되며,                                 
						// - absolute 의 경우 autoPosition 이 동작하지 않습니다.                                 
				oInfoWnd.setContent('<DIV style="border-top:1px solid; border-bottom:2px groove black; border-left:1px solid; border-right:2px groove black;margin-bottom:1px;color:black;background-color:white; width:auto; height:auto;">'+                                        
					'<span style="color: #000000 !important;display: inline-block;font-size: 12px !important;font-weight: bold !important;letter-spacing: -1px !important;white-space: nowrap !important; padding: 2px 5px 2px 2px !important">' +                                         
					'Hello World <br /> ' + 
					oTarget.getPoint()   +
					'<span></div>');                                
					oInfoWnd.setPoint(oTarget.getPoint());                                
					oInfoWnd.setPosition({right : 15, top : 30});                                
					oInfoWnd.setVisible(true);                                
					oInfoWnd.autoPosition();                                
					return;                        
				}                        
		
				var oMarker = new nhn.api.map.Marker(oIcon, { title : '마커 : ' + oPoint.toString() });                        
				oMarker.setPoint(oPoint);                        
				oMap.addOverlay(oMarker);                        
				var aPoints = oPolyline.getPoints(); // - 현재 폴리라인을 이루는 점을 가져와서 배열에 저장.                        
				aPoints.push(oPoint); // - 추가하고자 하는 점을 추가하여 배열로 저장함.                        
				oPolyline.setPoints(aPoints); // - 해당 폴리라인에 배열에 저장된 점을 추가함                
			});
		
		</c:if>
			*/
			
	
	}

	var seltab = "${param.seltab_idx}";
	
	if(seltab != "")
	{
		fn_egov_move_tab(seltab);
	}

	
	//////////////////////////////////////////////////////
	// 통합검색 관련 처리
	/*
	var keyword = jQuery("#searchKeyword").val();
	
	jQuery("ul.result_list > li > a, ul.result_list > li > strong > a").each(function(){
		
		var txt = $(this).html();
		txt = txt.replace(keyword, "<span class='txt_blue'>" + keyword + "</span>");
		$(this).html(txt);
	});
	
	jQuery("ul.result_list > li > p").each(function(){
		
		var txt = $(this).text();
		txt = txt.replace(/&amp;/gi, "&");
		txt = txt.replace(/&lt;/gi, "<");
		txt = txt.replace(/&gt;/gi, ">");
		txt = txt.replace(/&quot;/gi, "\"");
		txt = txt.replace(/&apos;/gi, "'");
		txt = txt.replace(/<[^>]+>/gi, "");
		txt = txt.replace(/src="[*]+>"/gi, "");

		var keyword = jQuery("#searchKeyword").val();
		var idx = txt.lastIndexOf("${param.searchKeyword}");
		var length = txt.length;
		var from = (idx - 110 >= 0) ? idx - 110 : idx; 
		var to = (idx + 110 <= length) ? idx + 110 : length; 
		txt = txt.substr(from, to);
		txt = txt.replace(keyword, "<span class='txt_blue'>" + keyword + "</span>");
		txt = txt + "...";

		$(this).html(txt);
		
		var idx = txt.lastIndexOf('<!-- 컨텐츠영역 -->');
		idx = idx >= 0 ? idx : 0;
		txt = txt.substr(idx, txt.length);

		var idx = txt.lastIndexOf("${param.searchKeyword}");
		var length = txt.length;
		
		var from = (idx - 100 >= 0) ? idx - 100 : idx; 
		var to = (idx + 100 <= length) ? idx + 100 : length; 
		txt = txt.substr(from, to);
		txt = txt.replace(keyword, "<span class='txt_blue'>" + keyword + "</span>");
		$(this).html(txt);
	});
	
	jQuery("ul.result_list").show();
	*/
	
	// 통합검색 관련 처리
	//////////////////////////////////////////////////////
	
	
});

function fn_egov_move_tab(idx)
{
	jQuery("div[id^='divTabCont_']").hide();
	jQuery("#divTabCont_" + idx).fadeIn('slow');
	
	jQuery("li[id^='liTabcont_']").removeClass("on");
	jQuery("#liTabcont_" + idx).addClass("on");
}

</script>