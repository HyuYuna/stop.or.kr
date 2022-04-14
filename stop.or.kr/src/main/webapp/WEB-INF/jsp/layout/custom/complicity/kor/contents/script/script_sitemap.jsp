<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!--
	사이트맵 페이지 스크립트
	2013.04.16 bhhan
-->	
<script type="text/javascript">


function fn_egov_init_sitemap(){
	alert("a");
	if(cmmfn_exist_object("ulSitemapLnb") == false)
		return;
	
	// DB에서 설정을 읽어와서 메뉴를 구성한다. 
	$.ajax({
	    url: g_context + '/menuctgry/mainmenuList.do',
	    dataType: 'json',
	    cache : false,
	    async : false,
	    success: function(data) {
	
	    	var lnbobj = jQuery("#ulSitemapLnb");
			
	    	var lastaddLv = "";
			var lv1_cnt = 0;
			var addobjLv1 = "";
			var addobjLv2 = "";
			var parentMenuID = "";
			
	    	for(var i = 0; i < data.length; i++)
	    	{
	    		var link = data[i].menu_link;
	    		var lv = data[i].menu_lv;
	    		
	    		if(lv == 1)
	    		{
	        		if(data[i].auth_yn == 'N')
	        		{
	        			link = "javascript:fn_egov_unauth_pageerr()";		
	        		}
	        		else if(! link == "" && (link.indexOf(".do") > -1 || link.indexOf(".stpg") > -1 || link.indexOf(".jsp") > -1))
	        		{
		    			link = "${pageContext.request.contextPath}" + link;
	        		}
	    			
	    			lv1_cnt ++;
	    			var liclsnm = "";
	    			
	    			if(lv1_cnt % 3 == 0)
	    				liclsnm = 'class="last"';
	    			
	    			var addobj = '<li id="liLnb' + lv1_cnt + '" ' + liclsnm + '">';
	    			addobj += '<a id="aLnb' + lv1_cnt + '" href="' + link + '" ><img src="' + g_context + data[i].sitemap_img_path +  '" alt="' + data[i].menu_nm + '" /></a>';
	    			addobj += "</li>";
	    			lnbobj.append(addobj);
	    			
	    			addobjLv1 = jQuery("#liLnb" + lv1_cnt, lnbobj);
	    			lastaddLv = 1;
	    			parentMenuID = "aLnb" + lv1_cnt;
	    		}
	    		else if(lv == 2)
	    		{
	    			
	        		if(data[i].auth_yn == 'N')
	        		{
	        			link = "javascript:fn_egov_unauth_pageerr()";		
	        		}
	        		else if(! link == "" && (link.indexOf(".do") > -1 || link.indexOf(".stpg") > -1 || link.indexOf(".jsp") > -1))
	        		{
		    			link = "${pageContext.request.contextPath}" + link;
		    			link += link.indexOf("?") < 0 ? "?" : "&";
		    			link += ("srch_menu_nix=" + data[i].menu_nix);
	        		}
	    			
	    			if(lastaddLv == 1)
	    			{
	    				// 부분 메뉴의 서브메뉴 생성
	    				addobj = '<ul class="sub-menu" id="ulSubmenu' + lv1_cnt + '">';
	    				addobj += '</ul>';
	    				addobjLv1.append(addobj);
	    				
	    				addobjLv2 = jQuery("#ulSubmenu" + lv1_cnt, lnbobj);
	    				addobj = '<li><a href="' + link + '" >' + data[i].menu_nm + '</a></li>';
	    				addobjLv2.append(addobj);
	    				
	    				//최상위 메뉴의 링크는 첫번째 서브메뉴와 같게 한다.. 
	    				jQuery("#" + parentMenuID).prop("href", link);
	    			}
	    			else if(lastaddLv == 2)
	    			{
	    				addobj = '<li><a href="' + link + '" >' + data[i].menu_nm + '</a></li>';
	    				addobjLv2.append(addobj);
	    			}
	    			
	    			lastaddLv = 2;
	    			
	    		}
	
	    	}
	    	
	    	/*
	    	jQuery("li[id^='liLnb']", jQuery("#lnb")).mouseover("bind", fn_menu_mover);
	    	jQuery("li[id^='liLnb']", jQuery("#lnb")).mouseout("bind", fn_menu_mout);
	    	*/
	
	    },
	    error : function(xhr, err){
	    	
	    }
	});

	/*
	jQuery("#btnMenuAllView", jQuery("#lnb")).toggle(
		function(){
			is_allmenu_open = true;
			jQuery("#menu-all-view").removeClass("hidden");
			jQuery("#lnb-wrap").addClass("subbg");
			$(this).html("<img src=\"" + g_context + "/images/custom/layout/lnb/btn_allmenu_close.gif\" alt=\"전체메뉴닫기\" />");
		},
		function(){
			is_allmenu_open = false;
			jQuery("#menu-all-view").addClass("hidden");
			jQuery("#lnb-wrap").removeClass("subbg");
			$(this).html("<img src=\"" + g_context + "/images/custom/layout/lnb/btn_allmenu.gif\" alt=\"전체메뉴\" />");
		}
	);
	*/
} 



</script>