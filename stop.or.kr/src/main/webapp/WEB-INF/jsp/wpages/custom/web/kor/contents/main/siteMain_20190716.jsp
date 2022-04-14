<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style type="text/css">
.story.circle .desc{background:url(../../images/kor/main/talk-circle-bg.png) no-repeat 100% 20px;}
.story.circle .desc a{border:none;font-size:31px;font-weight:bold;color:#ffc421;top:38%;right:42px;margin:0;}
.story.circle .desc a:before{content:"";position:absolute;bottom:8px;left:14px;width:144px;height:17px;z-index:-1;background:#000;}
.story.circle .desc a:after{content:"";background:url(../../images/kor/main/talk-arrow.png);width:30px;height:21px;right:-19px;top:24%;margin:0;}
.story.circle .desc a .dot1{position:absolute;top:-9px;left:27px;width:6px;height:6px;border-radius:4px;background:#ffc421;}
.story.circle .desc a .dot2{position:absolute;top:-9px;left:53px;width:6px;height:6px;border-radius:4px;background:#ffc421;}
.story.circle .desc a .dot3{position:absolute;top:-9px;left:79px;width:6px;height:6px;border-radius:4px;background:#ffc421;}
#contents.new-type{min-width:1280px;}
#contents.new-type .news.txt-none, #contents.new-type .news.txt-none .title{height:258px;}
#contents.new-type .news.txt-none .txt{display:none;}
#contents.new-type .news.txt-none a em{margin:35px auto 0;}
#contents.new-type .bg-white:before{content:"";position:relative;background:#fff;width:100%;}
#contents.new-type .latest .group:nth-child(4) h2 a{left:258px;}
#contents.new-type:before{height:400px;}
#contents.new-type{padding:70px 0 35px 0}
#contents.new-type .latest{padding:40px 0 15px 0;float:left;min-width:404px;}
#contents.new-type .latest .more{right:0;}
#contents.new-type .news.txt-none{position:relative;top:inherit;left:inherit;margin:0 60px 0 0;}
#contents.new-type .newsletter{clear:both;float:left;margin-top:92px;width:406px;padding:32px 30px;}
#contents.new-type .quick-box{float:right;width:394px;}
#contents.new-type .quick-box ul li{float:left;text-align:center;width:50%;min-height:137px;}
#contents.new-type .quick-box ul li a p{display:table;height:37px;margin:0 auto;}
#contents.new-type .quick-box ul li a span{display:table-cell;vertical-align:middle;font-size:16px;line-height:20px;color:#94979a;}
#contents.new-type .quick-box ul li .img{display:block;overflow:hidden;height:70px;width:70px;margin:0 auto 9px;}
#contents.new-type .quick-box ul li .img img{margin-top:0px;}
#contents.new-type .quick-box ul li:hover .img img{margin-top:-70px;}
#contents.new-type .quick-box ul li:hover a span{color:#000;}
#contents.new-type .quick-box ul li:nth-child(1),#contents.new-type .quick-box ul li:nth-child(2){padding-bottom:13px;}
#contents.new-type .quick-box ul li:nth-child(3),#contents.new-type .quick-box ul li:nth-child(4){padding-top:13px;border-top:1px solid #e0e2e3;}
#contents.new-type .quick-box ul li:nth-child(2),#contents.new-type .quick-box ul li:nth-child(4){border-left:1px solid #e0e2e3;}
#contents.new-type .board-etc{position:relative;float:left;width:400px;margin:92px 0 0 39px;}
#contents.new-type .board-etc .tit{background:#3f4370 url(../../images/kor/main/board-etc-bg.jpg) no-repeat 0 0;font-size:18px;color:#fff;line-height:50px;padding:0 20px;}
#contents.new-type .board-etc .bg{overflow:hidden;display:block;background:#f3f3f3;padding:24px 20px;}
#contents.new-type .board-etc .bg .img{float:left;margin:0 25px 0 0;width:30%;}
#contents.new-type .board-etc .bg .img img{width:100%;}
#contents.new-type .board-etc .bg .text-area{float:left;width:calc(100% - 40%);}
#contents.new-type .board-etc .bg .text-area .title{font-size:16px;line-height:24px;color:#000;height:68px;}
#contents.new-type .board-etc .bg .text-area .date{font-size:14px;color:#8f918f;}
#contents.new-type .board-etc .bx-controls{position:absolute;overflow:hidden;top:10px;right:10px;}
#contents.new-type .board-etc .bx-controls-direction a {float:left;display:inline; overflow:hidden; position:relative; width:24px; height:50%; color:transparent; white-space:nowrap;}
#contents.new-type .board-etc .bx-controls-direction a:before {position:absolute;left:50%;top:50%;width:10px;height:10px;margin:-5px 0 0 -5px;border-bottom:2px solid #9fa1b8;border-right:2px solid #9fa1b8;content:'';transform:rotate(135deg);-webkit-transform:rotate(135deg);transition:all .2s;-webkit-transition:all .2s;}
#contents.new-type .board-etc .bx-controls-direction a.bx-next:before {border-top:2px solid #9fa1b8;border-bottom:none;border-right:none;border-left:2px solid #9fa1b8;}
#contents.new-type .board-etc .bx-controls-direction a:hover:before,
#contents.new-type .board-etc .bx-controls-direction a:focus:before,
#contents.new-type .board-etc .bx-controls-direction a:active:before {border-color:#fff;}
#contents.new-type .board-etc .bx-controls-direction .bx-next:before {border:0 none; border-bottom:2px solid #9fa1b8; border-right:2px solid #9fa1b8;}
#contents.new-type .popupzone{float:right;margin:92px 0 0 0;width:394px;}
@media screen and (max-width:1300px){
	#contents.new-type .board-etc{margin:92px 1% 0 1%;}
	#contents.new-type .popupzone{float:left;}
	#contents.new-type .quick-box{float:left;width:335px;}
	
}
@media screen and (max-width:1280px){
	#contents.new-type{min-width:inherit;}
	#contents.new-type .popupzone{width:48%;float:right;margin:20px 0 0 0;position:relative;left:auto;top:auto;}
	#contents.new-type .board-etc{width:48%;float:left;margin:20px 0 0 0;}
	#contents.new-type .newsletter{width:100%;margin:20px 0 0 0;}
	#contents.new-type .quick-box{float:left;width:320px;}
	
}
@media screen and (max-width:1250px){
	#contents.new-type{min-width:inherit;}
	#contents.new-type .popupzone{width:48%;float:right;margin:20px 0 0 0;position:relative;left:auto;top:auto;}
	#contents.new-type .board-etc{width:48%;float:left;margin:20px 0 0 0;}
	#contents.new-type .newsletter{width:100%;margin:20px 0 0 0;}
	#contents.new-type .quick-box{float:right;width:250px;}
	#contents.new-type .quick-box ul li a span{font-size:14px;}
	
}
@media screen and (max-width:1190px){
	#contents.new-type .latest{width:calc(100% - 450px);margin-left:0;min-width:inherit}
	#contents.new-type .quick-box{clear:both;width:100%;margin:30px 0 0 0;}
	#contents.new-type .quick-box ul li{width:25%;}
	#contents.new-type .quick-box ul li:nth-child(3),#contents.new-type .quick-box ul li:nth-child(4){border-top:none;}
	#contents.new-type .quick-box ul li:nth-child(2),#contents.new-type .quick-box ul li:nth-child(4){border-left:none;}
	#contents.new-type .quick-box ul li:nth-child(2),#contents.new-type .quick-box ul li:nth-child(3),#contents.new-type .quick-box ul li:nth-child(4){border-left:1px solid #e0e2e3;}
}
@media screen and (max-width: 1150px){
	#contents.new-type{padding:35px 0 15px;}
	#contents.new-type:before{height:510px;}
	.story.circle .desc a {top:35px;right:10px;}
}
@media screen and (max-width:1024px){
	.story.circle .desc a {top:80px;}
	#contents.new-type .latest .group:nth-child(4) h2 a{left:204px;}
	#contents.new-type .latest .group h2 a{max-width:110px;}
}
@media screen and (max-width:830px){
	#contents.new-type .popupzone{width:100%;margin:20px 0 0 0;}
	#contents.new-type .board-etc{width:100%;margin:20px 0 0 0;}
	#contents.new-type .latest .group:nth-child(4) h2 a{left:215px;}
	#contents.new-type .latest{width:100%;}
	#contents.new-type:before{height:880px;}
	#contents.new-type .board-etc .bg .text-area .title{font-size:14px;}
	#contents.new-type .board-etc .bg .text-area .date{font-size:13px;}
}
@media screen and (max-width: 768px){
	.story.circle .desc{background:url(../../images/kor/main/talk-circle-bg.png) no-repeat 100% 2px;}
	.story.circle .desc a {width:175px;padding-left:15px;line-height:inherit;height:59px;top:50px;}
	.story.circle .desc a:after{top:28%;}
	#contents.new-type .quick-box ul li{width:50%;}
	#contents.new-type .quick-box ul li:nth-child(3),#contents.new-type .quick-box ul li:nth-child(4){padding-top:13px;border-top:1px solid #e0e2e3;}
	#contents.new-type .quick-box ul li:nth-child(2),#contents.new-type .quick-box ul li:nth-child(4){border-left:1px solid #e0e2e3;}
	#contents.new-type .quick-box ul li:nth-child(3){border-left:none;}
	#contents.new-type .latest .group:nth-child(4) h2 a{left:180px;}
	
}
@media screen and (max-width: 525px){
	.story.circle .desc a {right:-19px;top:56px;height:48px;background:none;font-size:18px;width:130px;}
	.story.circle .desc a:before{bottom:13px;width:84px;}
	.story.circle .desc a:after{right:0;top:14%;}
	#contents.new-type .board-etc .bg .text-area{width:calc(100% - 40%);}
}
</style>
<div id="visual">
	
	<c:import url="/widgets/visual.do" >
		<c:param name="visual_cnt" value="3" />
	</c:import>
					
</div>

 <!-- 이야기 하기 -->
<div class="story circle">
	<article class="list">
		<h2>폭력을 겪었나요? 우리가 도울게요 </h2>
		<p class="desc">
			<strong>쉽게 꺼낼 수 없는 말...</strong>
			<span>얘기 해주세요. 당신 곁에서 귀 기울일게요.<br />지금, 우리가 이야기를 시작하는 것이 필요합니다.</span>
			<a href="#story">이야기하기<span class="dot1"></span><span class="dot2"></span><span class="dot3"></span></a>
		</p>
	</article>

	<div class="view" id="story">
		<ul class="step">
			<li class="active">01</li>
			<li>02</li>
		</ul>

		<article class="group active">
			<h2>
				<strong>01</strong>
				<span>어떤 일이 있었나요?</span>
			</h2>

			<ul class="list1">
				<li>
					<input type="checkbox" id="check1" />
					<label for="check1">
						<img src="${pageContext.request.contextPath}/images/kor/main/story1.gif" alt="" />
						<span>가정폭력</span>
					</label>
				</li>
				<li>
					<input type="checkbox" id="check2" />
					<label for="check2">
						<img src="${pageContext.request.contextPath}/images/kor/main/story2.gif" alt="" />
						<span>성폭력</span>
					</label>
				</li>
				<li>
					<input type="checkbox" id="check3" />
					<label for="check3">
						<img src="${pageContext.request.contextPath}/images/kor/main/story3.gif" alt="" />
						<span>성매매</span>
					</label>
				</li>
				<li>
					<input type="checkbox" id="check4" />
					<label for="check4">
						<img src="${pageContext.request.contextPath}/images/kor/main/story4.gif" alt="" />
						<span>데이트폭력</span>
					</label>
				</li>
				<li>
					<input type="checkbox" id="check5" />
					<label for="check5">
						<img src="${pageContext.request.contextPath}/images/kor/main/story5.gif" alt="" />
						<span>성희롱</span>
					</label>
				</li>
				<li>
					<input type="checkbox" id="check6" />
					<label for="check6">
						<img src="${pageContext.request.contextPath}/images/kor/main/story6.gif" alt="" />
						<span>불법촬영피해</span>
					</label>
				</li>
				<li>
					<input type="checkbox" id="check7" />
					<label for="check7">
						<img src="${pageContext.request.contextPath}/images/kor/main/story7.gif" alt="" />
						<span>기타</span>
					</label>
				</li>
			</ul>

			<p class="btns">
				<a href="" class="btn1">그만하기</a>
				<a href="" class="btn2">계속하기</a>
			</p>
		</article>
		
		<article class="group">
			<h2>
				<strong>02</strong>
				<span>도움이 필요하신가요?</span>
			</h2>

			<ul class="list4">
				<li>
					<p class="banner">
						<a href="https://www.women1366.kr/_main/main.html" target="_blank">
							<span class="icon"><img src="${pageContext.request.contextPath}/images/kor/main/icon1.gif" alt="" /></span>
							<strong>여성폭력 사이버 상담</strong>
							<span>바로가기</span>
						</a>
					</p>
					<p class="txt">
						가정폭력, 성폭력, 성매매, 데이트폭력, 
						디지털성폭력 등 여성폭력 피해에 대해 
						전화상담, 실시간 채팅상담 및 게시판
						상담을 지원합니다.
					</p>
				</li>
				<li>
					<p class="banner">
						<a href="https://www.women1366.kr/stopds/ " target="_blank">
							<span class="icon"><img src="${pageContext.request.contextPath}/images/kor/main/icon2.gif" alt="" /></span>
							<strong>디지털 성범죄 피해자 지원센터</strong>
							<span>바로가기</span>
						</a>
					</p>
					<p class="txt">
						디지털성범죄(불법촬영, 불법촬영물 유포, 
						협박 등) 피해에 대해 전화상담 및 게시판
						상담을 지원합니다.
					</p>
				</li>
				<li>
					<p class="banner">
						<a href="http://www.mogef.go.kr/msv/metooReport.do" target="_blank">
							<span class="icon"><img src="${pageContext.request.contextPath}/images/kor/main/icon3.gif" alt="" /></span>
							<strong>공공부문 직장 내 성희롱·성폭력 신고센터</strong>
							<span>바로가기</span>
						</a>
					</p>
					<p class="txt">
						국가기관, 지방자치단체, 공직유관기관 등 
						직장 내 성희롱·성폭력 피해에 대해 전화
						상담 및 게시판상담을 지원합니다.
					</p>
				</li>
			</ul>

			<p class="guide">
					해당 사이트를 통해 실시간 채팅상담 또는 게시판상담을 받으실 수 있습니다.<br />
					긴급상담이 필요하시다면 국번없이(또는 지역번호) <strong>1366</strong>으로 전화주시기 바랍니다.
					<!-- 20180822 추가 -->
					<a href="${pageContext.request.contextPath}/map/mapList.do?srch_menu_nix=ju1s19zT">가까운 여성폭력 지원 기관 찾기</a>
					<!-- //20180822 추가 -->
			</p>
			
			<p class="btns">
				<a href="" class="btn1">닫기</a>
			</p>
		</article>

</div>
<!-- //이야기 하기 -->

  <div id="contents" class="new-type">
	<div class="news txt-none">
		<c:import url="/widgets/board.do" >
			<c:param name="brd_id" value="BDIDX_mV49maYF8r081nc63vW96G" />
			<c:param name="menu_nix" value="hn8TL907" />
			<c:param name="article_cnt" value="2" />
			<c:param name="type" value="photo"/>
		</c:import>
		
	</div>

	<div class="latest">
		<article class="group active">
			<h2><a href="">공지사항</a></h2>
			<!-- <p class="category">
				<a href="" class="active">전체</a>
				<a href="">진흥원활동</a>
				<a href="">현장네트워크</a>
			</p> -->
			<div class="list">
				<c:import url="/widgets/board.do" >
					<c:param name="brd_id" value="BDIDX_h05m420eN43VOGRM8lOyf7" />
					<c:param name="menu_nix" value="CQv80aU3" />
					<c:param name="article_cnt" value="7" />
				</c:import>
			</div>
			<a href="${pageContext.request.contextPath}/brdartcl/boardarticleList.do?brd_id=BDIDX_h05m420eN43VOGRM8lOyf7&srch_menu_nix=CQv80aU3" class="more">더보기</a>
		</article>
		
		<article class="group">
			<h2><a href="">언론동향</a></h2>
			<div class="list">
				<c:import url="/widgets/board.do" >
					<c:param name="brd_id" value="BDIDX_sW5iy9OU2S4458jRL9e2nR" />
					<c:param name="menu_nix" value="qa061Y4n" />
					<c:param name="article_cnt" value="7" />
				</c:import>
			</div>
			<a href="${pageContext.request.contextPath}/brdartcl/boardarticleList.do?brd_id=BDIDX_sW5iy9OU2S4458jRL9e2nR&srch_menu_nix=qa061Y4n" class="more">더보기</a>
		</article>
		
		<article class="group">
			<h2><a href="">국외동향</a></h2>
			<div class="list">
				<c:import url="/widgets/board.do" >
					<c:param name="brd_id" value="BDIDX_Y7Y7uWGG9UgPLMvyYTACEE" />
					<c:param name="menu_nix" value="5DS3dRgR" />
					<c:param name="article_cnt" value="7" />
				</c:import>
			</div>
			<a href="${pageContext.request.contextPath}/brdartcl/boardarticleList.do?brd_id=BDIDX_Y7Y7uWGG9UgPLMvyYTACEE&srch_menu_nix=5DS3dRgR" class="more">더보기</a>
		</article>

		<article class="group">
			<h2><a href="">이슈포커스</a></h2>
			<div class="list">
				<c:import url="/widgets/board.do" >
					<c:param name="brd_id" value="BDIDX_XT6VIl0uVe85YF6xBlG2pS" />
					<c:param name="menu_nix" value="5B296kJ7" />
					<c:param name="article_cnt" value="7" />
				</c:import>
			</div>
			<a href="${pageContext.request.contextPath}/brdartcl/boardarticleList.do?brd_id=BDIDX_XT6VIl0uVe85YF6xBlG2pS&srch_menu_nix=5B296kJ7" class="more">더보기</a>
		</article>
		
	</div>

	<!-- quick -->
	<article class="quick-box">
		<ul>
			<li><a href="https://www.women1366.kr/_main/main.html" target="_blank"><span class="img"><img src="${pageContext.request.contextPath}/images/kor/main/quick-img01.png" alt="" /></span><span class="text"><span>여성폭력 사이버 상담</span></span></a></li>
			<li><a href="http://www.mogef.go.kr/msv/metooReport.do" target="_blank"><span class="img"><img src="${pageContext.request.contextPath}/images/kor/main/quick-img02.png" alt="" /></span><span class="text"><span>직장 내 성희롱· <br />성폭력 특별신고센터</span></span></a></li>
			<li><a href="https://www.women1366.kr/stopds/" target="_blank"><span class="img"><img src="${pageContext.request.contextPath}/images/kor/main/quick-img03.png" alt="" /></span><span class="text"><span>디지털 성범죄<br />피해자 지원센터</span></span></a></li>
			<li><a href="/modedg/contentsView.do?ucont_id=CTX000090&srch_menu_nix=l3vdU8Xo"><span class="img"><img src="${pageContext.request.contextPath}/images/kor/main/quick-img04.png" alt="" /></span><span class="text"><span>전국 지원기관 바로가기</span></span></a></li>
		</ul>
	</article>
	<!--// quick -->

	<article class="newsletter">
		<h2>한국여성인권진흥원 뉴스레터</h2>
		<span>진흥원 소식을 이메일로 보내드립니다.</span>
		<p>
			<input type="text" class="email" id="nmail" title="이메일" />
			<a href="#newsletter" class="btn btn-layerpopup">신청</a>
		</p>
	</article>
	<form:form name="news_form" action="${pageContext.request.contextPath}/newsletter/newsletterFormAdd.do" method="post" class="ajax-form-submit">
	<input type="hidden" name="email" id="nemail"/>
	<!-- 개인정보수집 팝업 -->
	<article class="layerpopup" id="newsletter">
		<div class="group">
			<h2>개인정보 수집 및 이용안내</h2>
			<div class="item">
				<h3 class="title4">개인정보 수집 및 이용 목적</h3>
				<p>한국여성인권진흥원은 다음의 목적을 위하여 개인정보를 수집 및 이용합니다.  수집된 개인 정보는 다음의 목적이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 개인 정보 보호법 제 18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 것입니다. </p>
				<ul class="bul1">
					<li>뉴스레터 ‘인권스타’ 및 기관 소식 발송</li>
				</ul>
				
				<div class="table-wrap">
					<table>
						<caption>개인정보 수집 및 이용 목적 - 개인정보 처리 목적, 개인정보 항목, 보유기간</caption>
						<thead>
							<tr>
								<th scope="col">개인정보 처리 목적</th>
								<th scope="col">개인정보 항목</th>
								<th scope="col">보유기간</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>뉴스레터 및 기관 소식 발송</td>
								<td>이메일</td>
								<td>2년</td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<h3 class="title4">개인정보의 보유 및 이용기간</h3>
				<p>한국여성인권진흥원은 법령에 따른 개인정보 보유·이용기간 또는 정보주체로부터 개인정보를 수집 시에 동의 받은 개인정보 보유·이용기간을 2년 이내에서 개인정보를 처리합니다.</p>
				
				<h3 class="title4">동의거부 권리 및 동의거부에 따른 불이익</h3>
				<p>수집하는 개인정보에 대하여 개인정보보호법 제 15조에 따라서 개인정보 수집 및 이용에 동의를 거부할 수 있으며, 동의를 거부하실 경우 뉴스레터 및 홍보메일 서비스를 이용할 수 없습니다.</p>
				
				<p class="box1">
					<span class="form-set form-radio">
						<input type="radio" id="agree1" name="agree" value="Y">
						<label for="agree1">동의함</label>
					</span>
					
					<span class="form-set form-radio">
						<input type="radio" id="agree2" name="agree" value="N">
						<label for="agree2">동의하지 않음</label>
					</span>
				</p>
				
				<p class="btns txt-center">
					<input type="submit" value="확인" class="btn-l btn1"/>
					<!-- <a href="" class="btn-l btn1">확인</a> -->
					<a href="#newsletter" class="btn-l btn2 close">취소</a>
				</p>
			</div>
		</div>
	</article>
	<!-- //개인정보수집 팝업 -->
	</form:form>
	
	<script type="text/javascript">
	$(function(){
	
		$('.board-etc ul').bxSlider({
			auto			: true, 
			autoHover		: true,
			speed			: 1000,
			pause			: 8000,
			responsive		: true,
			pager			: false,
			autoControls	: false,
			controls		: true
		});
	});
	</script>
	<div class="board-etc">
		<p class="tit">여성폭력방지 자료실</p>
		<ul class="">
			<li>
				<%-- <a href="/webtoon/webtoonUsrView.do?srch_menu_nix=0K1X4L4x&seq=26&pageIndex=1&nownm=1&cate=6" class="bg">
					<p class="img"><img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=as8PEfkn8rCu" alt="이것도 데이트폭력이라고?  우리가 모르는 '통제 폭력'" /></p>
					<div class="text-area">
						<p class="title">이것도 데이트폭력이라고?  우리가 모르는 '통제 폭력'</p>
						<p class="date">2018-10-15</p>
					</div>
				</a> --%>
				<c:import url="/widgets/board.do" >
					<c:param name="menu_nix" value="0K1X4L4x" />
					<c:param name="article_cnt" value="1" />
					<c:param name="type" value="webtoon"/>
				</c:import>
			</li>
			<li>
				<%-- <a href="/brdthm/boardthmView.do?brd_id=BDIDX_kRyA7Wv1SwT2piS18zy8P5&srch_menu_nix=iG8cifYK&cont_idx=69" class="bg">
					<p class="img"><img src="${pageContext.request.contextPath}/atchfile/imageAtchfile.do?vchkcode=0866qc1VzwmZ" alt="[한국여성인권진흥원 뉴스레터 vol.70] 혼자 사는 여자들, ‘안전할 권리’를 말하다" /></p>
					<div class="text-area">
						<p class="title">[한국여성인권진흥원 뉴스레터 vol.70] 혼자 사는 여자들, ‘안전할 권리’를 말하다</p>
						<p class="date">2019-06-26</p>
					</div>
				</a> --%>
				<c:import url="/widgets/board.do" >
					<c:param name="brd_id" value="BDIDX_kRyA7Wv1SwT2piS18zy8P5" />
					<c:param name="menu_nix" value="iG8cifYK" />
					<c:param name="article_cnt" value="1" />
					<c:param name="type" value="photo_2"/>
				</c:import>
			</li>
		</ul>
	</div>

	<div class="popupzone">
		<c:import url="/widgets/popupzone.do" >
			<c:param name="popupzone_cnt" value="2" />
		</c:import>
	</div>
	
	
		
  </div>
