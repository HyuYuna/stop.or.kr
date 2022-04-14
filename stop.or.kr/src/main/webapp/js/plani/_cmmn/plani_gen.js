/**
 * 메뉴 / 사이드메뉴 / 사이트맵 / 사이트 배너 등을 동적 생성한다
 * jQuery Version 1.6 이상
 * author : Bhhan
 * date : 2014.3.25
 */
function initSiteTools()
{
	// 상단 메뉴 초기화
	//initSiteMenu();		
	
	// 레프트 메뉴 초기화
	if(lg_srch_menu_nix != "")
		initSideMenu(lg_srch_menu_nix);
	
	// 사이트맵 생성
	//fn_egov_init_sitemap();

	// 배너정보 가져오기
	//initBottomBanner();
	
}


//////////////////////////////////////
// 메인메뉴 생성
//////////////////////////////////////
var lg_mu_site = "CDIDX00002";
var lg_mu_lang = "CDIDX00022";
function initSiteMenu(){
	
	//  ## TPCODE : TPAGE0004 : 메인메뉴 구성 스크립트 ## 
	
	// 메뉴의 링크 새창열기 기능이 있고, 클래스가 정의되어있는 경우 해당 클래스명 설정
	var gnav_openlink_cls = "gnavigation_openlink";
	
	// Level 1 메뉴의 li class 명 > 프로젝트마다 다름 
	var lv1_li_cls = "gnavigation_menu0";
	
	// Level 2 메뉴의 ul class 명 > 프로젝트마다 다름
	var lv2_ul_cls = "gnavigation_sub";
	
	// Level 3 메뉴의 ul class 명 > 프로젝트마다 다름
	var lv3_ul_cls = "display_none";
	
	
	var lnbobj = jQuery("#gnavigation > ul");
	
	if(lnbobj.length == 0)
		return;
	
	// DB에서 설정을 읽어와서 메뉴를 구성한다. 
    $.ajax({
        url: g_context + '/menuctgry/mainmenuList.do',
        data : {
        	srch_mu_gub : 'USR',
        	srch_mu_site : lg_mu_site,
        	srch_mu_lang : lg_mu_lang
        },
        dataType: 'json',
        cache : true,
        async : false,
        success: function(data) {


        	// 일반메뉴
        	lnbobj.html("");
        	
        	var lastaddLv = "";
    		var lv1_cnt = 0;
    		var lv2_cnt = 0;
    		var lv3_cnt = 0;
    		var lv4_cnt = 0;

    		var lv1sub_cnt = 0;
    		var lv2sub_cnt = 0;
    		var lv3sub_cnt = 0;
    		var lv4sub_cnt = 0;
			
    		// 추가된 일반 메뉴 오브젝트
    		var addobjType1Lv1 = "";
			var addobjType1Lv2 = "";
			var addobjType1Lv3 = "";
			
			// 메뉴 경로 설정을 위한 변수
			var lv1_menu_path = "";
			var lv2_menu_path = "";
			var lv3_menu_path = "";
			var lv4_menu_path = "";	
			var all_menu_path = "";
			var selmenuobj = null;
			
			var addLiLv1 = "";
			var addLiLv2 = "";
			var addLiLv3 = "";
			var addLiLv4 = "";

			var addUlLv2 = "";
			var addUlLv3 = "";
			var addUlLv4 = "";
						
			var parentLv1MenuID = "";
			var parentLv2MenuID = "";
			var parentLv3MenuID = "";
			
			var lv2_tabmenu_yn = "";
			var lv3_tabmenu_yn = "";
			var lv4_tabmenu_yn = "";
			var title_img_src = "";			
			var top_menu_title = "";
			

        	for(var i = 0; i < data.length; i++)
        	{
        		var link = data[i].menu_link;
        		var lv = data[i].menu_lv;
        		var blank = (data[i].blank_yn == "Y") ? " target=\"_blank\" title=\"새창으로 열림\" class=\"" + gnav_openlink_cls + "\"" : "";
        		var img_src = data[i].menu_img_path;


        		// 메뉴 권한 없는 경우 에러메시지
        		if(data[i].auth_yn == 'N')
        		{
        			link = "javascript:fn_egov_unauth_pageerr()";		
        		}
        		
        		else
	     		{
		     		// 메뉴 구성중
	        		if(link == "UNDER_CONSTRUCT")
	        		{
	        			link = "javascript:fn_egov_under_construct()";		
	        		}
    			
	        		// 메뉴권한 있는 경우
	        		else if(! link == "" && (link.indexOf(".do") > -1 || link.indexOf(".stpg") > -1 || link.indexOf(".jsp") > -1))
	        		{
	        			
	        			if(link.startsWith("http://") == false && link.startsWith("https://") == false)
	        			{
	    					link = g_context + link;
	    					
	            			if(link.indexOf("srch_menu_nix=") < 0)
	            			{
	        	    			link += link.indexOf("?") < 0 ? "?" : "&";
	        	    			link += ("srch_menu_nix=" + data[i].menu_nix);
	            			}
	            			
	            			if(lg_mu_site != "CDIDX00002")
	            			{
	    		    			link += link.indexOf("?") < 0 ? "?" : "&";
	        	    			link += ("srch_mu_site=" + lg_mu_site);
	            			}
	            			
	            			if(lg_mu_lang != "CDIDX00022")
	            			{
	    		    			link += link.indexOf("?") < 0 ? "?" : "&";
	        	    			link += ("srch_mu_lang=" + lg_mu_lang);
	            			}
	
	        			}
	    					
	        		}
	     		}
        		
        		// 1 depth 메뉴 처리
        		if(lv == 1)
        		{
        			if(data[i].memmenu_yn == "N")
        			{
	        			// 탑메뉴 타이틀 이미지 설정
	            		title_img_src = (data[i].title_img_path == null || data[i].title_img_path == "") ? title_img_src : data[i].title_img_path;
	        			// 탑메뉴 명 설정
	            		top_menu_title = data[i].menu_nm;
	            		
	        			lv1_cnt ++;
	
	       				var addobj = '<li id="liLnbLv1_' + lv1_cnt + '" class="' + lv1_li_cls + '">';
	        			// 메뉴 이미지가 지정되지 않은 경우 텍스트로 표시한다.
	        			if(img_src == null || img_src == "")
	       					addobj += '<a class="th1_lnk" id="aLnbLv1_' + lv1_cnt + '" href="' + link + '" ' + blank + '>' + data[i].menu_nm + '</a>';
	       				else
	        				addobj += '<a class="th1_lnk" id="aLnbLv1_' + lv1_cnt + '" href="' + link + '" ' + blank + '><img src="' + g_context + img_src +  '" alt="' + data[i].menu_nm + '" /></a>';
	
	       				addobj += "</li>";
	        			lnbobj.append(addobj);
	        			addLiLv1 = jQuery("#liLnbLv1_" + lv1_cnt, lnbobj);
						        			
	        			lastaddLv = 1;
	        			parentLv1MenuID = "aLnb" + lv1_cnt;
        			}
        			
        			lv1_menu_path = data[i].menu_nm;
        			if(lg_srch_menu_nix == data[i].menu_nix)
        			{
        				all_menu_path = lv1_menu_path;
        				selmenuobj = addLiLv1;
        			}
        			
        		}
        		
        		
        		// 2 depth 메뉴 처리
        		else if(lv == 2)
        		{
        			if(data[i].memmenu_yn == "N")
        			{
	    				lv2_cnt ++;
	    				lv2sub_cnt ++;
	    				lv2_tabmenu_yn = data[i].tabmenu_yn;
	    				
	            		// 2 depth 메뉴의 첫번째 메뉴인 경우
	        			if(lastaddLv == 1)
	        			{
	        				// 부분 메뉴의 서브메뉴 생성
	        				var addobj = '<ul class="' + lv2_ul_cls + '" id="ulSubmenuLv2_' + lv1_cnt + '">';
	        				addobj += '</ul>';
	        				addLiLv1.append(addobj);
	        				addUlLv2 = jQuery("#ulSubmenuLv2_" + lv1_cnt, lnbobj);
	        				lv2sub_cnt = 1;
	        			}
	
	       				if(img_src == null || img_src == "")
	 	    				addobj = "<li id='liLnbLv2_" + lv2_cnt + "'><a id='aLnbLv2_" + lv2_cnt + "' href='" + link + "' " + blank + ">" + data[i].menu_nm + "</a></li>";
	   					else
	 	    				addobj = "<li id='liLnbLv2_" + lv2_cnt + "'><a id='aLnbLv2_" + lv2_cnt + "' href='" + link + "' " + blank + "><img src='" + g_context + img_src +  "' alt='" + data[i].menu_nm + "' /></a></li>";
	 	    				
	    				addUlLv2.append(addobj);
	        			lastaddLv = 2;
	        			
	        			addLiLv2 = jQuery("#liLnbLv2_" + lv2_cnt);
	        			parentLv2MenuID = "aLnbLv2_" + lv2_cnt;
        			}
        			
        			lv2_menu_path = data[i].menu_nm;
        			if(lg_srch_menu_nix == data[i].menu_nix)
        			{
        				all_menu_path = lv1_menu_path + "##" + lv2_menu_path;
        				selmenuobj = addLiLv2;
        			}
        			
        		}
        		
        		
        		// 3 depth 메뉴 처리
        		else if(lv == 3)
        		{
        			if(data[i].memmenu_yn == "N")
        			{
	        			lv3_cnt ++;
	        			lv3_tabmenu_yn = data[i].tabmenu_yn;
	        			
	            		// 3 depth 메뉴의 첫번째 메뉴인 경우
	        			if(lastaddLv == 2)
	        			{
	        				// 부분 메뉴의 서브메뉴 생성
	        				var addobj = '<ul class="' + lv3_ul_cls + '" id="ulSubmenuLv3_' +  lv2_cnt + '">';
	        				addobj += '</ul>';
	        				addLiLv2.append(addobj);
	        				addUlLv3 = jQuery("#ulSubmenuLv3_" + lv2_cnt, lnbobj);
	        				
	        			}
	
	       				if(img_src == null || img_src == "")
	 	    				addobj = "<li id='liLnbLv3_" + lv3_cnt + "'><a id='aLnbLv3_" + lv3_cnt + "' href='" + link + "' " + blank + ">" + data[i].menu_nm + "</a></li>";
	   					else
	 	    				addobj = "<li id='liLnbLv3_" + lv3_cnt + "'><a id='aLnbLv3_" + lv3_cnt + "' href='" + link + "' " + blank + "><img src='" + g_context + img_src +  "' alt='" + data[i].menu_nm + "' /></a></li>";
	  	    				
	    				addUlLv3.append(addobj);
	        			lastaddLv = 3;
	        			
	        			addLiLv3 = jQuery("#liLnbLv3_" + lv3_cnt);
	        			parentLv3MenuID = "aLnbLv3_" + lv3_cnt;
        			}

        			lv3_menu_path = data[i].menu_nm;
        			if(lg_srch_menu_nix == data[i].menu_nix)
        			{
        				all_menu_path = lv1_menu_path + "##" + lv2_menu_path + "##" + lv3_menu_path;
        				selmenuobj = addLiLv3;
        			}
        		}
 				        		
        	}

        	/*
			현재 메뉴가 속한 서브메뉴를 선택되도록 한다.
 			if(cmmfn_exist_object("ulSubmenu" + selmenuIdx)){
 				
 				jQuery("#liLnb" + selmenuIdx).attr("class","on");
 				jQuery("#aLnbLv"+selmenuIdx + selmenuIdx2).parent().attr("class","on");
 				jQuery("#ulSubmenu" + selmenuIdx).show();
 				jQuery("#ulSubmenu" + selmenuIdx).css("display","block");
 				
 				lastMenuID=selmenuIdx;
 			}
			
			*/

			//fn_egov_set_menupath(all_menu_path);

			/*
			if(selmenuobj != undefined && selmenuobj != null)
			{
				// 현재 선택된 메뉴의 상위 메뉴를 쭉 따라가면서 on 처리 한다.
				selmenuobj.parentsUntil(jQuery("ul[id^='gnavigation']")).each(function(){
					var id = $(this).prop("id");
					if(id.startsWith("ulSubmenuLv2_") == true)
						$(this).show();
					
					else if(id.startsWith("liLnbLv1_") == true)
					{
						var lv1imgobj = jQuery("#" +  $(this).prop("id") + " > a > img");
						if(lv1imgobj.length > 0)
						{
							var src = lv1imgobj.attr("src");
							src = src.replace(/_on.png/gi, "");
							src = src.replace(/.png/gi, "");
							src += "_on";
							src += ".png";
							lv1imgobj.attr("src", src);
						}
					}
					
					else if(id.startsWith("ulSubmenuLv4_") == true)
					{
						$(this).show();	
						$(this).siblings().each(function(){
							if($(this).prop("id").startsWith("aLnbLv3"))
							{
								var href = $(this).prop("href");
								href = href.replace(/_open_/g, "_close_");
								$(this).prop("href", href);
								$(this).removeClass("plus").addClass("minus");	
							}
						})
					}
					
				});
			}
			*/
			
			/*
        	// 1차 서브메뉴 보이기 효과
        	jQuery("li[id^='liLnbLv1_']").mouseenter(function(){
        		
        		fn_egov_lv1_menuevt($(this));

        	}).focusin(function(){
    		
        		fn_egov_lv1_menuevt($(this));
    		});
			*/
			
			
			//////////////////////////////////////////////////////
			// 전체메뉴 스크립트
			/*
			var allobj = jQuery("#allnavigation");
			allobj.append(jQuery("#gnavigation").html());

			allobj.find("a, ul, li").each(function(){
				
				if($(this).attr("class") == "display_none")
					$(this).hide();

				if($(this).attr("class") == "th1")
				{
					var id = $(this).attr("id");
					id = id.replace(/liLnbLv1_/g, "");
					$(this).attr("class", "th1 no" + id);
				}
				
				$(this).attr("id", ""); 
			});
			allobj.find("span").remove();
			*/
			// 전체메뉴 스크립트
			//////////////////////////////////////////////////////
			cmmfn_menuefct_init();
        },
        error : function(xhr, err){
        	
        }
    });
	
} 

//////////////////////////////////////
// 관리자 메뉴 조회
//////////////////////////////////////
function initSiteManagerMenu(){
	
	var lnbobj = jQuery("#manMenu > ul");
	if(lnbobj.length == 0)
		return;
	
	//  ## TPCODE : TPAGE0005 : 관리자 메뉴 구성 스크립트 ##
	
	// DB에서 설정을 읽어와서 메뉴를 구성한다. 
	 $.ajax({
	     url: g_context + '/menuctgry/managemenuList.do?srch_menu_nix=' + lg_srch_menu_nix,
	     data : {
	        	srch_mu_gub : 'MAN',
	        	srch_mu_site : lg_mu_site,
	        	srch_mu_lang : lg_mu_lang
	        },
	     dataType: 'json',
	     cache : false,
	     async : false,
	     success: function(data) {
	    	 
	     	// 일반메뉴
	     	lnbobj.html("");
	     	
	     	var lastaddLv = "";
	 		var lv1_cnt = 0;
	 		var lv2_cnt = 0;
	 		var lv3_cnt = 0;
	 		var lv4_cnt = 0;
				
	 		// 추가된 일반 메뉴 오브젝트
	 		var addobjType1Lv1 = "";
				var addobjType1Lv2 = "";
				var addobjType1Lv3 = "";
				
				// 메뉴 경로 설정을 위한 변수
				var lv1_menu_path = "";
				var lv2_menu_path = "";
				var lv3_menu_path = "";
				var lv4_menu_path = "";	
				var all_menu_path = "";
				var selmenuobj = null;
				
				var addLiLv1 = "";
				var addLiLv2 = "";
				var addLiLv3 = "";
				var addLiLv4 = "";
	
				var addUlLv2 = "";
				var addUlLv3 = "";
				var addUlLv4 = "";
							
				var parentLv1MenuID = "";
				var parentLv2MenuID = "";
				var parentLv3MenuID = "";
				
				var lv2_tabmenu_yn = "";
				var lv3_tabmenu_yn = "";
				var lv4_tabmenu_yn = "";
				
	     	for(var i = 0; i < data.length; i++)
	     	{
	     		var link = data[i].menu_link;
	     		var lv = data[i].menu_lv;
	     		var blank = (data[i].blank_yn == "Y") ? " target=\"_blank\" title=\"새창으로 열림\"" : "";
	     		var img_src = data[i].menu_img_path;
	     		
	     		// 메뉴 권한 없는 경우 에러메시지
	     		if(data[i].auth_yn == 'N')
	     		{
	     			link = "javascript:fn_egov_unauth_pageerr()";		
	     		}
	     		else
	     		{
		     		// 메뉴 구성중
	        		if(link == "UNDER_CONSTRUCT")
	        		{
	        			link = "javascript:fn_egov_under_construct()";		
	        		}
	 			
	        		// 메뉴권한 있는 경우
		     		else if(! link == "" && (link.indexOf(".do") > -1 || link.indexOf(".stpg") > -1 || link.indexOf(".jsp") > -1))
		     		{
		     			if(link.startsWith("http://") == false && link.startsWith("https://") == false)
			  			{
							link = g_context + link;
								
			      			if(link.indexOf("srch_menu_nix=") < 0)
			      			{
			  	    			link += link.indexOf("?") < 0 ? "?" : "&";
			  	    			link += ("srch_menu_nix=" + data[i].menu_nix);
			      			}
	
	          			if(cmmfn_exist_object("srch_mu_site") == true && jQuery("#srch_mu_site").val() != "CDIDX00002")
	          			{
	  		    			link += link.indexOf("?") < 0 ? "?" : "&";
	      	    			link += ("srch_mu_site=" + jQuery("#srch_mu_site").val());
	          			}
	          			
	          			if(lg_mu_lang != "CDIDX00022")
	          			{
	  		    			link += link.indexOf("?") < 0 ? "?" : "&";
	      	    			link += ("srch_mu_lang=" + lg_mu_lang);
	          			}
			  			}
		     		}
	     		}
	     		
	     		// 1 depth 메뉴 처리
	     		if(lv == 1)
	     		{
	     			lv1_cnt ++;
	
	    				var addobj = '<li class="th1 no' + lv1_cnt + '" id="liMetsysMenu_' + data[i].menu_nix + '">';
	     			// 메뉴 이미지가 지정되지 않은 경우 텍스트로 표시한다.
					addobj += "<a class=\"th1_lnk\" href='" + link + "' " + blank + ">" + data[i].menu_nm + "</a>";
	
	    				addobj += "</li>";
	     			lnbobj.append(addobj);
	     			addLiLv1 = jQuery("#liMetsysMenu_" + data[i].menu_nix, lnbobj);
						        			
	     			lastaddLv = 1;
	     			parentLv1MenuID = "liMetsysMenu_" + data[i].menu_nix;
	     			
	     			lv1_menu_path = data[i].menu_nm;
	     			if(lg_srch_menu_nix == data[i].menu_nix)
	     			{
	     				all_menu_path = lv1_menu_path;
	     				selmenuobj = addLiLv1;
	     			}
	     			
	     		}
	     		
	     		// 2 depth 메뉴 처리
	     		else if(lv == 2)
	     		{
	 				lv2_cnt ++;
	 				lv2_tabmenu_yn = data[i].tabmenu_yn;
	 				
	         		// 2 depth 메뉴의 첫번째 메뉴인 경우
	     			if(lastaddLv == 1)
	     			{
	     				// 부분 메뉴의 서브메뉴 생성
	     				var addobj = '<ul class="depth2" id="ulMetsysSubmenu_' + data[i].menu_nix  + '">';
	     				addobj += '</ul>';
	     				addLiLv1.append(addobj);
	     				addUlLv2 = jQuery("#ulMetsysSubmenu_" + data[i].menu_nix , lnbobj);
	     				
	     			}
	
					addobj = "<li id='liMetsysSubmenu_" + data[i].menu_nix + "'><a id='aLnbSitemapLv2_" + lv2_cnt + "' href='" + link + "' " + blank + ">" + data[i].menu_nm + "</a></li>";
		    				
	 				addUlLv2.append(addobj);
	     			lastaddLv = 2;
	     			
	     			addLiLv2 = jQuery("#liMetsysSubmenu_" + data[i].menu_nix);
	     			parentLv2MenuID = "liMetsysSubmenu_" + data[i].menu_nix;
	
	     			
	     			lv2_menu_path = data[i].menu_nm;
	     			if(lg_srch_menu_nix == data[i].menu_nix)
	     			{
	     				all_menu_path = lv1_menu_path + "##" + lv2_menu_path;
	     				selmenuobj = addLiLv2;
	     			}
	     			
	     		}
	     		
	     		/*
	     		// 3 depth 메뉴 처리
	     		else if(lv == 3)
	     		{
	     			lv3_cnt ++;
	     			lv3_tabmenu_yn = data[i].tabmenu_yn;
	     			
	     			// 상위메뉴가 tabmenu인 경우 서브메뉴를 만들지 않는다.
	     			if(lv2_tabmenu_yn == 'Y')
	 					continue;
	     			
	         		// 3 depth 메뉴의 첫번째 메뉴인 경우
	     			if(lastaddLv == 2)
	     			{
	     				// 부분 메뉴의 서브메뉴 생성
	     				var addobj = '<ul class="depth3" id="ulSitemapMenuLv3_' +  lv2_cnt + '">';
	     				addobj += '</ul>';
	     				addLiLv2.append(addobj);
	     				addUlLv3 = jQuery("#ulSitemapMenuLv3_" + lv2_cnt, lnbobj);
	     				
	     			}
	
					addobj = "<li id='liLnbSitemapLv3_" + lv3_cnt + "'><a id='aLnbSitemapLv3_" + lv3_cnt + "' href='" + link + "' " + blank + ">" + data[i].menu_nm + "</a></li>";
		    				
	 				addUlLv3.append(addobj);
	     			lastaddLv = 3;
	     			
	     			addLiLv3 = jQuery("#liLnbSitemapLv3_" + lv3_cnt);
	     			parentLv3MenuID = "aLnbSitemapLv3_" + lv3_cnt;
	
	     			lv3_menu_path = data[i].menu_nm;
	     			if(lg_srch_menu_nix == data[i].menu_nix)
	     			{
	     				all_menu_path = lv1_menu_path + "##" + lv2_menu_path + "##" + lv3_menu_path;
	     				selmenuobj = addLiLv3;
	     			}
	     		}
				*/
	     		
	     	}
	     	fn_egov_set_man_menupath(all_menu_path)
	     	
	     },
	     error : function(xhr, err){
	     	
	     }
	 });
	
} 

// 사용자 메뉴 네비게이션 설정
function fn_egov_set_menupath(all_menu_path)
{
	
	// ## TPCODE : TPAGE0024 : 사용자페이지 메뉴네비게이션 처리 ##
	
	if(all_menu_path == null || all_menu_path == "")
		return;
	
	var arrpath = all_menu_path.split("##");
	var agt = "<a href=\"" + g_context + "/contents/siteMain.do\">" +
	    "<span class=\"path_home\"><img src=\"" + g_context + "/images/custom/web/kor/common/path_home.gif\" alt=\"홈\" /></span>" + 
	    "</a>";
	    
	//var agt = "<a class=\"home\" href=\"" + g_context +  "/contents/siteMain.do\">" + (lg_mu_lang == "CDIDX00022" ? "홈" : "Home") + "</a>"; 
	
	for(var i = 0; i < arrpath.length; i++)
	{
		var addval = arrpath[i];
		
		if(i + 1 == arrpath.length)
		{
			addval = "<span class=\"path_current\">" + addval + "</span>";	
		}
		else
			addval = "<span>" + addval + "</span>";
		
		agt += addval;
	}
	jQuery("#pLinemenu").html(agt);

	// 페이지 타이틀 설정
	initTitle(all_menu_path);
}


//관리자 메뉴 네비게이션 설정
function fn_egov_set_man_menupath(all_menu_path)
{
	if(all_menu_path == null || all_menu_path == "")
		return;
	
	var arrpath = all_menu_path.split("##");
	var agt = "Home &gt; ";
	
	//var agt = "<a class=\"home\" href=\"" + g_context +  "/contents/siteMain.do\">" + (lg_mu_lang == "CDIDX00022" ? "홈" : "Home") + "</a>"; 
	
	var title = "";
	
	for(var i = 0; i < arrpath.length; i++)
	{
		var addval = arrpath[i];
		
		if(i + 1 == arrpath.length)
		{
			addval = "<strong>" + addval + "</strong> ";
			title = addval;
		}
		else
			addval = "<strong>" + addval + "</strong> &gt; ";
		
		agt += addval;
		
	}
	
	jQuery("#pLinemenu").html(agt);
	jQuery("#h1title").html(title);
}


//1depth 메뉴 이벤트 처리
function fn_egov_lv1_menuevt(obj)
{
	
	var id = obj.attr("id");
	id = id.replace(/liLnbLv1_/gi, "");
	
	var subcnt = obj.find("ul").length;
	if(subcnt == 0)
	{
		fn_egov_close_menubar();
		return;
	}
	
	// 국문일 경우
	if(lg_mu_lang == "CDIDX00022")
	{
		
		if(lastMenuIDLv1 == "" || id != lastMenuIDLv1)
		{
			jQuery("ul[id^='ulSubmenuLv2_']").hide();
			jQuery("#ulSubmenuLv2_" + id).fadeIn('slow');
			
			obj.siblings().each(function(){
				
				$(this).removeClass("on");
			});
			
			obj.addClass("on");
			
		}
		
		lastMenuIDLv1 = id;
		
	}
	else if(lg_mu_lang == "CDIDX00023")
	{
		if(lastMenuIDLv1 == "" || id != lastMenuIDLv1)
		{
			/*
			영문일때 동작 없음
			jQuery("ul[id^='ulSubmenuLv2_']").each(function(){
				$(this).fadeOut("slow").removeClass("on");
			});
				
			jQuery("#ulSubmenuLv2_" + id).addClass("on").fadeIn("slow");
			*/			
		}
		
		lastMenuIDLv1 = id;
	}

}

function fn_egov_close_menubar()
{
	lastMenuIDLv1 = "";
	
	if(lg_mu_lang == "CDIDX00022")
	{
		jQuery("ul.gnavigation_sub").fadeOut("slow");		
	}
	else if(lg_mu_lang == "CDIDX00023")
	{
		jQuery("ul.gnavigation_sub").fadeOut("slow");		
	}
		
}



//////////////////////////////////////
// 사이드메뉴 생성
//////////////////////////////////////
function initSideMenu(srch_menu_nix)
{
	var snavobj = jQuery("#snavigation > nav > ul"); 
	if(snavobj.length == 0)
		return;
	
	snavobj.empty();
	
	var menu_lv = 0;
	var menu_nix = "";
	var last_lv = 0;	
	
	var lv1_add_cnt = 0;
	var lv2_add_cnt = 0;
	var lv3_add_cnt = 0;
	
	var selmenuobj = null;
	
	// DB에서 설정을 읽어와서 메뉴를 구성한다. 
	 $.ajax({
	     url: g_context + '/menuctgry/leftmenuList.do?srch_menu_nix=' + srch_menu_nix,
	     data : {
	     	srch_mu_gub : 'USR',
	     	srch_mu_site : lg_mu_site,
	     	srch_mu_lang : lg_mu_lang
	     },
	     dataType: 'json',
	     cache : false,
	     async : false,
	     success: function(data) {

	    	 for(var i = 0; i < data.length; i++)
				{
	     		var link = data[i].menu_link;
	     		var blank = (data[i].blank_yn == "Y") ? " target=\"_blank\" title=\"새창으로 열림\" class=\"snavigation_openlink\"" : "";
	
	     		// 메뉴 권한 없는 경우 에러메시지
	     		if(data[i].auth_yn == 'N')
	     		{
	     			link = "javascript:fn_egov_unauth_pageerr()";		
	     		}
	     		else
	     		{
		     		// 메뉴 구성중
	        		if(link == "UNDER_CONSTRUCT")
	        		{
	        			link = "javascript:fn_egov_under_construct()";		
	        		}
		     		
		 			// 메뉴권한 있는 경우
		     		else if(! link == "" && (link.indexOf(".do") > -1 || link.indexOf(".stpg") > -1 || link.indexOf(".jsp") > -1))
		     		{
		     			
		     			if(link.startsWith("http://") == false && link.startsWith("https://") == false)
		     			{
		 					link = g_context + link;
		 					
		         			if(link.indexOf("srch_menu_nix=") < 0)
		         			{
		     	    			link += link.indexOf("?") < 0 ? "?" : "&";
		     	    			link += ("srch_menu_nix=" + data[i].menu_nix);
		         			}
		
		         			if(lg_mu_site != "CDIDX00002")
		         			{
		 		    			link += link.indexOf("?") < 0 ? "?" : "&";
		     	    			link += ("srch_mu_site=" + lg_mu_site);
		         			}
		         			
		         			if(lg_mu_lang != "CDIDX00022")
		         			{
		 		    			link += link.indexOf("?") < 0 ? "?" : "&";
		     	    			link += ("srch_mu_lang=" + lg_mu_lang);
		         			}
		
		         			if(data[i].tabmenu_yn == "Y")
		         			{
		 		    			link += link.indexOf("?") < 0 ? "?" : "&";
		     	    			link += ("seltab_idx=" + (data[i].menu_ord - 1));
		         			}
		     			}
		 					
		     		}
	     		}
				
				menu_lv = data[i].menu_lv;
				menu_nix = data[i].menu_nix;
				
				if(menu_lv == 1)
				{
					if(lg_mu_lang == "CDIDX00022")
					{
						//var left_img_path = data[i].left_img_path;
						//jQuery("#snavigation > h2 > img").prop("src", g_context + left_img_path);
						//jQuery(".lnbwrap > h2").html(data[i].menu_nm);
					}
					else if(lg_mu_lang == "CDIDX00023")
					{
						//jQuery("#snavigation > h2").html(data[i].menu_nm);
					}
				}
				
				if(menu_lv == 2)
				{
					lv1_add_cnt ++;
					var addobj = "<li id=\"liSnavLv1_" + lv1_add_cnt + "\"><a href=\"" + link + "\" " + blank + ">" + data[i].menu_nm + "</a></li>";
					snavobj.append(addobj);
					
					if(srch_menu_nix == menu_nix)
						selmenuobj = jQuery("#liSnavLv1_" + lv1_add_cnt);
				}
				
				else if(menu_lv == 3)
				{
					if(last_lv == 2)
					{
						var liobj = jQuery("#liSnavLv1_" + lv1_add_cnt);
						liobj.append("<ul id=\"ulSnavLv1_" + lv1_add_cnt + "\" class=\"snavigation_sub\"></ul>");
						liobj.find("a").prop("href", "javascript:fn_egov_open_sidemenu(" + lv1_add_cnt + ")");
						lv2_add_cnt = 0;
					}
					
					lv2_add_cnt ++;
					var ulobj = jQuery("#ulSnavLv1_" + lv1_add_cnt);
					ulobj.append("<li id=\"liSnavLv2_" + lv1_add_cnt + "_" + lv2_add_cnt + "\"><a class=\"link_3th\" href=\"" + link + "\" " + blank + ">" + data[i].menu_nm + "</a></li>");			
					
					if(srch_menu_nix == menu_nix)
						selmenuobj = jQuery("#liSnavLv2_" + lv1_add_cnt + "_" + lv2_add_cnt);
				}
				
				/*

				else if(menu_lv == 4)
				{
					if(last_lv == 3)
					{
						var liobj = jQuery("#liSnavLv2_" + lv1_add_cnt + "_" + lv2_add_cnt);
						liobj.append("<ul id=\"ulSnavLv2_" + lv1_add_cnt + "_" + lv2_add_cnt + "\"></ul>");
						lv3_add_cnt = 0;
					}
					
					lv3_add_cnt ++;
					var ulobj = jQuery("#ulSnavLv2_" + lv1_add_cnt + "_" + lv2_add_cnt);
					ulobj.append("<li id=\"liSnavLv3_" + lv1_add_cnt + "_" + lv2_add_cnt + "_" + lv3_add_cnt + "\" class=\"display_none\">" + data[i].menu_nm + "</li>");			
					
					if(srch_menu_nix == srch_menu_nix)
						selmenuobj = jQuery("#liSnavLv3_" + lv1_add_cnt + "_" + lv2_add_cnt + "_" + lv3_add_cnt);
				}
				*/
				
				last_lv = menu_lv;				
			}
			
			// 선택된 메뉴 표시하기
			if(selmenuobj != undefined && selmenuobj != null)
			{
				// 현재 메뉴 선택 처리
				var selid = selmenuobj.prop("id");
				if(selid.indexOf("liSnavLv1_") >= 0 || selid.indexOf("liSnavLv2_") >= 0)
					selmenuobj.addClass("on");	
				// 현재 선택된 메뉴의 상위 메뉴를 쭉 따라가면서 on 처리 한다.
				selmenuobj.parentsUntil(snavobj).each(function(){
					var id = $(this).prop("id");
					if(id.indexOf("liSnavLv1_") >= 0)
					{
						$(this).addClass("on");
					}

					else if(id.indexOf("ulSnavLv1_") >= 0)
						$(this).show();	
					
				});
			}
			
			// 선택된 메뉴가 없는 경우 : 
			// 이 경우는 선택된 메뉴가 최상위 메뉴일 경우다. 
			// 따라서 좌측메뉴의 첫번째 메뉴와 그 서브메뉴를 선택된 상태로 만든다.
			else
			{
				if(cmmfn_exist_object("liSnavLv1_1") == true)
				{
					jQuery("#liSnavLv1_1").addClass("on");	
				}
				if(cmmfn_exist_object("ulSnavLv1_1") == true)
				{
					jQuery("#ulSnavLv1_1").show();	
				}
				
			}
			
			//jQuery(".display_none").hide();
	     	
	     },
	     error : function(xhr, err){
	     	
	     }
	 });
	
}

function fn_egov_open_sidemenu(idx)
{
	var tgtobj = jQuery("#ulSnavLv1_" + idx);
	if(tgtobj.css("display") == "none"){
		jQuery("ul[id^='ulSnavLv1_']").hide();
		jQuery("li[id^='liSnavLv1_']").removeClass("active");
		jQuery("#ulSnavLv1_" + idx).fadeIn('slow');
		jQuery("#liSnavLv1_" + idx).addClass("active");
	}
}





//////////////////////////////////////
// 사이트맵 생성
//////////////////////////////////////
function fn_egov_init_sitemap()
{

	var lnbobj = jQuery("#ulSiteMap");
	
	if(lnbobj.length == 0)
		return;
	
	// DB에서 설정을 읽어와서 메뉴를 구성한다. 
	 $.ajax({
	     url: g_context + '/menuctgry/mainmenuList.do',
	     data : {
	        	srch_mu_gub : 'USR',
	        	srch_mu_site : lg_mu_site,
	        	srch_mu_lang : lg_mu_lang
	        },
	     dataType: 'json',
	     cache : false,
	     async : false,
	     success: function(data) {
	
	     	// 일반메뉴
	     	lnbobj.html("");
	     	
	     	var lastaddLv = "";
	 		var lv1_cnt = 0;
	 		var lv2_cnt = 0;
	 		var lv3_cnt = 0;
	 		var lv4_cnt = 0;
				
	 		// 추가된 일반 메뉴 오브젝트
	 		var addobjType1Lv1 = "";
				var addobjType1Lv2 = "";
				var addobjType1Lv3 = "";
				
				// 메뉴 경로 설정을 위한 변수
				var lv1_menu_path = "";
				var lv2_menu_path = "";
				var lv3_menu_path = "";
				var lv4_menu_path = "";	
				var all_menu_path = "";
				var selmenuobj = null;
				
				var addLiLv1 = "";
				var addLiLv2 = "";
				var addLiLv3 = "";
				var addLiLv4 = "";
	
				var addUlLv2 = "";
				var addUlLv3 = "";
				var addUlLv4 = "";
							
				var parentLv1MenuID = "";
				var parentLv2MenuID = "";
				var parentLv3MenuID = "";
				
				var lv2_tabmenu_yn = "";
				var lv3_tabmenu_yn = "";
				var lv4_tabmenu_yn = "";
				
	     	for(var i = 0; i < data.length; i++)
	     	{
	     		var link = data[i].menu_link;
	     		var lv = data[i].menu_lv;
	     		var blank = (data[i].blank_yn == "Y") ? " target=\"_blank\" title=\"새창으로 열림\"" : "";
	     		var img_src = data[i].menu_img_path;
	     		
	     		// 메뉴 권한 없는 경우 에러메시지
	     		if(data[i].auth_yn == 'N')
	     		{
	     			link = "javascript:fn_egov_unauth_pageerr()";		
	     		}
	     		else
	     		{
		     		// 메뉴 구성중
	        		if(link == "UNDER_CONSTRUCT")
	        		{
	        			link = "javascript:fn_egov_under_construct()";		
	        		}
	 			
	        		// 메뉴권한 있는 경우
		     		else if(! link == "" && (link.indexOf(".do") > -1 || link.indexOf(".stpg") > -1 || link.indexOf(".jsp") > -1))
		     		{
		     			if(link.startsWith("http://") == false && link.startsWith("https://") == false)
			  			{
							link = g_context + link;
								
			      			if(link.indexOf("srch_menu_nix=") < 0)
			      			{
			  	    			link += link.indexOf("?") < 0 ? "?" : "&";
			  	    			link += ("srch_menu_nix=" + data[i].menu_nix);
			      			}
	
	          			if(lg_mu_site != "CDIDX00002")
	          			{
	  		    			link += link.indexOf("?") < 0 ? "?" : "&";
	      	    			link += ("srch_mu_site=" + lg_mu_site);
	          			}
	          			
	          			if(lg_mu_lang != "CDIDX00022")
	          			{
	  		    			link += link.indexOf("?") < 0 ? "?" : "&";
	      	    			link += ("srch_mu_lang=" + lg_mu_lang);
	          			}
			  			}
		     		}
	     		}
	     		
	     		// 1 depth 메뉴 처리
	     		if(lv == 1)
	     		{
	     			lv1_cnt ++;
	
	    				var addobj = '<li class="th1 no' + lv1_cnt + '" id="liLnbSitemapLv1_' + lv1_cnt + '">';
	     			// 메뉴 이미지가 지정되지 않은 경우 텍스트로 표시한다.
					addobj += "<a class=\"th1_lnk\" href='" + link + "' " + blank + ">" + data[i].menu_nm + "</a>";
	
	    				addobj += "</li>";
	     			lnbobj.append(addobj);
	     			addLiLv1 = jQuery("#liLnbSitemapLv1_" + lv1_cnt, lnbobj);
						        			
	     			lastaddLv = 1;
	     			parentLv1MenuID = "aLnbSitemapLv1_" + lv1_cnt;
	     			
	     			lv1_menu_path = data[i].menu_nm;
	     			if(lg_srch_menu_nix == data[i].menu_nix)
	     			{
	     				all_menu_path = lv1_menu_path;
	     				selmenuobj = addLiLv1;
	     			}
	     			
	     		}
	     		
	     		
	     		// 2 depth 메뉴 처리
	     		else if(lv == 2)
	     		{
	 				lv2_cnt ++;
	 				lv2_tabmenu_yn = data[i].tabmenu_yn;
	 				
	         		// 2 depth 메뉴의 첫번째 메뉴인 경우
	     			if(lastaddLv == 1)
	     			{
	     				// 부분 메뉴의 서브메뉴 생성
	     				var addobj = '<ul class="th2" id="ulSitemapMenuLv2_' + lv1_cnt + '">';
	     				addobj += '</ul>';
	     				addLiLv1.append(addobj);
	     				addUlLv2 = jQuery("#ulSitemapMenuLv2_" + lv1_cnt, lnbobj);
	     				
	     			}
	
					addobj = "<li id='liLnbSitemapLv2_" + lv2_cnt + "'><a id='aLnbSitemapLv2_" + lv2_cnt + "' href='" + link + "' " + blank + ">" + data[i].menu_nm + "</a></li>";
		    				
	 				addUlLv2.append(addobj);
	     			lastaddLv = 2;
	     			
	     			addLiLv2 = jQuery("#liLnbSitemapLv2_" + lv2_cnt);
	     			parentLv2MenuID = "aLnbSitemapLv2_" + lv2_cnt;
	
	     			
	     			lv2_menu_path = data[i].menu_nm;
	     			if(lg_srch_menu_nix == data[i].menu_nix)
	     			{
	     				all_menu_path = lv1_menu_path + "##" + lv2_menu_path;
	     				selmenuobj = addLiLv2;
	     			}
	     			
	     		}
	     		
	     		/*
	     		// 3 depth 메뉴 처리
	     		else if(lv == 3)
	     		{
	     			lv3_cnt ++;
	     			lv3_tabmenu_yn = data[i].tabmenu_yn;
	     			
	     			// 상위메뉴가 tabmenu인 경우 서브메뉴를 만들지 않는다.
	     			if(lv2_tabmenu_yn == 'Y')
	 					continue;
	     			
	         		// 3 depth 메뉴의 첫번째 메뉴인 경우
	     			if(lastaddLv == 2)
	     			{
	     				// 부분 메뉴의 서브메뉴 생성
	     				var addobj = '<ul class="sitemap_3depth" id="ulSitemapMenuLv3_' +  lv2_cnt + '">';
	     				addobj += '</ul>';
	     				addLiLv2.append(addobj);
	     				addUlLv3 = jQuery("#ulSitemapMenuLv3_" + lv2_cnt, lnbobj);
	     				
	     			}
	
					addobj = "<li id='liLnbSitemapLv3_" + lv3_cnt + "'><a id='aLnbSitemapLv3_" + lv3_cnt + "' href='" + link + "' " + blank + ">" + data[i].menu_nm + "</a></li>";
		    				
	 				addUlLv3.append(addobj);
	     			lastaddLv = 3;
	     			
	     			addLiLv3 = jQuery("#liLnbSitemapLv3_" + lv3_cnt);
	     			parentLv3MenuID = "aLnbSitemapLv3_" + lv3_cnt;
	
	     			lv3_menu_path = data[i].menu_nm;
	     			if(lg_srch_menu_nix == data[i].menu_nix)
	     			{
	     				all_menu_path = lv1_menu_path + "##" + lv2_menu_path + "##" + lv3_menu_path;
	     				selmenuobj = addLiLv3;
	     			}
	     		}
				*/
	     	}
	     	
	     },
	     error : function(xhr, err){
	     	
	     }
	 });
	
} 


//////////////////////////////////////
// 배너 생성
//////////////////////////////////////
function initBottomBanner()
{
	
	var bannerobj = jQuery(".banner_lst > ul"); 
	if(bannerobj.length == 0)
		return;
	
	bannerobj.empty();
	
	var data = "";
	
	// DB에서 배너을 읽어와서 구성한다. 
	$.ajax({
	    url: g_context + '/menuctgry/bannerList.do?srch_menu_nix=${param.srch_menu_nix}',
	    data 		: data,
	    dataType: 'json',
	    cache : false,
	    async : false,
	    success: function(data) {
	   	 for(var i = 0; i < data.length; i++){
	   		 if(data[i].pop_link!=null){
	   			 bannerobj.append("<li><a href='"+data[i].pop_link+"' target="+data[i].pop_target+"><img src='"+g_context+"/atchfile/imageAtchfile.do?vchkcode="+data[i].vchkcode+"' alt='"+data[i].pop_alt+"'/></a></li>");
	   		 }else{
	   			 bannerobj.append("<li><img src='"+g_context+"/atchfile/imageAtchfile.do?vchkcode="+data[i].vchkcode+"' alt='"+data[i].pop_alt+"'/></li>");
	   		 }
	     }
 	 
	   	 
	    },
	    error : function(xhr, err){
	    	
	    }
	});
	
}



//////////////////////////////////////
//타이틀 설정
//////////////////////////////////////
function initTitle(all_menu_path)
{
	var sitename_kor = " - OASIS 전통의학정보포털";
	var sitename_eng = "";
	
	var arrmenu = all_menu_path.split("##");
	nmenu_nm = arrmenu[(arrmenu.length - 1)];
	
	try{
		// 타이틀 설정
		switch(lg_mu_lang)
		{
			case "CDIDX00022" : jQuery("title").html(nmenu_nm + sitename_kor); break; 
			case "CDIDX00023" : jQuery("title").html(nmenu_nm + sitename_eng); break; 
		}
	}catch(err){
		// jQuery("title") IE 8 not working !!
		switch(lg_mu_lang)
		{
			case "CDIDX00022" : document.title = nmenu_nm + sitename_kor; break; 
			case "CDIDX00023" : document.title = nmenu_nm + sitename_eng; break; 
		}
	}
	
}



function fn_menu_mover()
{
	if(is_allmenu_open == false)
	{	
		jQuery("div[id^='sub']", jQuery("#lnb")).addClass("hidden");
		var id = $(this).attr("id");
		id = id.replace(/liLnb/g, "");

		// 서브메뉴 개수에 맞게 팝업 메뉴 높이를 조절한다.
		var submenu_cnt = $("#liLnb" + id).find("li").length;
		var new_h = 10 + (19 * submenu_cnt) + 10;
		jQuery("#ulSubmenu" + id, jQuery("#lnb")).css("height", new_h + "px");
		$("#sub" + id, jQuery("#lnb")).removeClass("hidden");
	}
}

function fn_menu_mout()
{
	var id = $(this).attr("id");
	id = id.replace(/liLnb/g, "");
	$("#sub" + id, jQuery("#lnb")).addClass("hidden");	
}

function fn_egov_open_depth4(lv3cnt)
{
	jQuery("#aLnbLv3_" + lv3cnt)
		.removeClass("plus")
		.addClass("minus")
		.prop("href", "javascript:fn_egov_close_depth4(" + lv3cnt + ")");
	
	jQuery("#ulSubmenuLv4_" + lv3cnt).fadeIn('slow');
}

function fn_egov_close_depth4(lv3cnt)
{
	jQuery("#aLnbLv3_" + lv3cnt)
		.removeClass("minus")
		.addClass("plus")
		.prop("href", "javascript:fn_egov_open_depth4(" + lv3cnt + ")");
	
	jQuery("#ulSubmenuLv4_" + lv3cnt).fadeOut('slow');
}




