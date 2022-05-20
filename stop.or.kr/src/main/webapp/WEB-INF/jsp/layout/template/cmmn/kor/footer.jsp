<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--  ## TPCODE : TPAGE0003 : 풋터 ## -->


<div id="bannerzone">
	<div class="bannerzonewrap">
	<ul>
		<li class="item"><a href="http://www.scisoplatform.or.kr/" target="_blank" title="사회문제해결 플랫폼 새창열림"><img src="${pageContext.request.contextPath}/images/kor/layout/banner8.gif" alt="사회문제해결 플랫폼" /></a></li>
		<li class="item"><a href="http://www.mogef.go.kr/cc/wcc/cc_wcc_f001.do" target="_blank" title="여성긴급전화 1366현황 새창열림"><img src="${pageContext.request.contextPath}/images/kor/layout/banner1.gif" alt="여성긴급전화 1366현황" /></a></li>
		<li class="item"><a href="https://shp.mogef.go.kr/shp/front/main.do" target="_blank" title="예방교육통합관리 새창열림"><img src="${pageContext.request.contextPath}/images/kor/layout/banner2.gif" alt="예방교육통합관리" /></a></li>
		<li class="item"><a href="https://www.safetyreport.go.kr/#main" target="_blank" title="안전신문고 새창열림"><img src="${pageContext.request.contextPath}/images/kor/layout/banner3.gif" alt="안전신문고" /></a></li>
		<li class="item"><a href="https://1398.acrc.go.kr/hpg/cmm/min/hpgMain.do" target="_blank" title="청렴신문고 새창열림"><img src="${pageContext.request.contextPath}/images/kor/layout/banner4.gif" alt="청렴신문고" /></a></li>
<%-- 		<li><a href="https://m.blog.naver.com/PostView.nhn?blogId=with_msip&logNo=220453185492&rvid=369CCC16CCC33B10023F9B4AE236E28DA6E2&proxyReferer=http%3A%2F%2Fsearch.naver.com%2Fsearch.naver%3Fsm%3Dtab_hty.top%26where%3Dnexearch%26query%3D%25EC%2584%25B8%25EB%258C%2580%25EB%25B3%2584%2B%25EC%259D%25BC%25EC%259E%2590%25EB%25A6%25AC%2B%25EC%2598%2581%25EC%2583%2581%2B%25EC%259D%25BC%25EC%259D%25B4%2B%25EC%2598%25A4%25EB%2584%2588%25EB%259D%25BC%2521%26oquery%3D%25EC%25B2%25AD%25EB%25A0%25B4%25EC%258B%25A0%25EB%25AC%25B8%25EA%25B3%25A0%26tqi%3DTybJhlpySEhsscF5mjCssssssL4-332907%26url%3Dhttp%253A%252F%252Fm.blog.naver.com%252Fwith_msip%252F220453185492%253Frvid%253D369CCC16CCC33B10023F9B4AE236E28DA6E2%26ucs%3D9FROIAU2Gzdk" target="_blank"><img src="${pageContext.request.contextPath}/images/kor/layout/banner5.gif" alt="세대별 일자리 영상 일이 오너라!" /></a></li> --%>
		<li class="item"><a href="http://www.mogef.go.kr/" target="_blank" title="여성가족부 새창열림"><img src="${pageContext.request.contextPath}/images/kor/layout/banner9.png" alt="여성가족부" /></a></li>
		<li class="item"><a href="https://www.kywa.or.kr/" target="_blank" title="한국청소년활동진흥원 새창열림"><img src="${pageContext.request.contextPath}/images/kor/layout/banner10.png" alt="한국청소년활동진흥원" /></a></li>
		<li class="item" style="display:none;"><a href="https://www.kyci.or.kr/" target="_blank" title="한국청소년상담복지개발원 새창열림"><img src="${pageContext.request.contextPath}/images/kor/layout/banner11.png" alt="한국청소년상담복지개발원" /></a></li>
		<li class="item" style="display:none;"><a href="http://www.kihf.or.kr/" target="_blank" title="한국건강가정진흥원  새창열림"><img src="${pageContext.request.contextPath}/images/kor/layout/banner12.png" alt="한국건강가정진흥원 " /></a></li>
		<li class="item" style="display:none;"><a href="https://www.kigepe.or.kr/kor/index.do" target="_blank" title="한국양성평등교육진흥원 새창열림"><img src="${pageContext.request.contextPath}/images/kor/layout/banner6.gif" alt="한국양성평등교육진흥원" /></a></li>
		<li class="item" style="display:none;"><a href="https://www.kwdi.re.kr/" target="_blank" title="한국여성정책연구원 새창열림"><img src="${pageContext.request.contextPath}/images/kor/layout/banner7.gif" alt="한국여성정책연구원" /></a></li>
	</ul>
	<p class="control">
		<a data-type="prev" href="#" title="이전"><span style="visibility:hidden;">이전</span></a>
		<a data-type="next" href="#" title="다음"><span style="visibility:hidden;">다음</span></a>
		<a data-type="stop" href="#" title="멈춤"><span style="visibility:hidden;">멈춤</span></a>
		<a data-type="play" href="#" title="시작"><span style="visibility:hidden;">시작</span></a>
	</p>
	</div>
</div>
<script>
	$(document).ready(function(){
		var param = "#bannerzone";
		var obj = ".item";
		var btn = param+" .control";
		var interval = 3000;
		var speed = 300;
		var viewSize = 1;
		var moreSize = 0;
		var dir = "x";
		var data = 0;
		var auto = true;
		var hover = false;
		var method = "easeInOutCubic";
		var op1 = false;
		
		stateScrollObj(param,obj,btn,interval,speed,viewSize,moreSize,dir,data,auto,hover,method,op1);
	});
</script>
<!-- <article id="fnb">
	<h2>Follow Us</h2>
	<ul>
		<li><a href="https://www.facebook.com/wrstar" class="facebook" target="_blank">페이스북</a></li>
		<li><a href="https://twitter.com/whrck2009" class="twitter" target="_blank">트위터</a></li>
		<li><a href="https://blog.naver.com/whrck" class="blog" target="_blank">블로그</a></li>
	</ul>
</article> -->

<div id="siteinfo">
	<a class="wa" href="http://kwacc.or.kr/CertificationSite/WA/1402/Detail" target="_blank" title="한국웹접근성평가센터 인증현황 바로가기" style="float:right; padding-right:5px;">
		<img src="../../images/kor/layout/wa.png" width="160px;" alt="국가공인 웹 접근성 품질인증마크">
	</a>
	<p><span><a href="${pageContext.request.contextPath}/modedg/contentsView.do?ucont_id=CTX000056&srch_menu_nix=Ak20GP4Z" style="color:#ffff00;">개인정보처리방침</a></span>
	<span><a href="${pageContext.request.contextPath}/modedg/contentsView.do?ucont_id=CTX000128&srch_menu_nix=9e67SjA6" style="color:#ffff00;">영상정보처리기기</a></span>
	<span><a href="${pageContext.request.contextPath}/newsletter/newsletterForm.do" style="color:#ffff00;" target="_blank" title="새창열림">뉴스레터 수신거부</a></span></p>
	<address>서울특별시 중구 서소문로 50 센트럴플레이스 3층 (04505) </address>
	<span>TEL 02-735-1050</span>
	<span> FAX 02-6363-8493</span>
	<span>상담전화 1366(유료)</span>
	<!-- <span>FAX 02-735-2051</span>
	<span>Email : webmaster@stop.or.kr</span> -->
	<p class="copyright">Copyright 2018 Women's Human Rights Institute of Korea, All right reserved.</p>
</div>

<p class="move-top"><a href="#top"><img src="${contextPath}/images/kor/main/btn-top-move.png" alt="TOP 페이지 상단으로 이동" /></a></p> 

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-140913405-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-140913405-1');
</script>