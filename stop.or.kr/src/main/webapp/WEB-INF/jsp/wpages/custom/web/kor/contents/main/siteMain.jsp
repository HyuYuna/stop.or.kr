<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


	  
	<script type="text/javascript">

		$(document).ready(function(){
			
			/* 플로팅배너 닫기_str */
			$("[id^='floatingClose']").on("click", function(){
				var closeId = this.id;
				if(closeId == "floatingClosePc"){
					$(".floating_banner").hide();
				}else{
					$(".floating_banner_mo").hide();
				}
			});
			/* 플로팅배너 닫기_end */
			
			/* 플로팅배너 애니메이션_str */
			$(window).scroll(function(){
				var scrollTop = $(document).scrollTop();
				if (scrollTop < 0) {
					scrollTop = 0;
				}
				$(".Evt_layBox").stop();
				$(".Evt_layBox").animate({"top":scrollTop});
			});
			/* 플로팅배너 애니메이션_end */
			
		});

	</script>

	<!--div class="Evt_layBox">
		<div class="floating_banner">
			<a href="http://www.stopweek.kr/" target="_blank" title="새창열림"><img src="${pageContext.request.contextPath}/images/kor/main/layer-popup-20201112.png" alt="2020 여성폭력 추방주간 사라지는 성폭력 살아나는 인권존중 온라인 캠페인페이지 바로가기 주최 여성가족부, 주관 한국여성인권진흥원 "></a><button type="button" id="floatingClosePc" class="floating_close" title="닫기">닫기</button>
		</div>
	</div>
	<div class="floating_banner_mo">
		<p><a href="http://www.stopweek.kr/"><img src="${pageContext.request.contextPath}/images/kor/main/layer-popup-20201112-mo.png" alt="2020 여성폭력 추방주간 사라지는 성폭력 살아나는 인권존중 온라인 캠페인페이지 바로가기 주최 여성가족부, 주관 한국여성인권진흥원 "></a></p><button type="button" id="floatingCloseMo" class="floating_close_mo" title="닫기">닫기</button>
	</div-->


	  <div class="main-top-wrap">

		  <div id="visual">
			<c:import url="/widgets/visual.do" >
				<c:param name="visual_cnt" value="3" />
			</c:import>
		  </div>
			
			<div class="latest top-board">
			<article class="group active">
				<h2><a href="">공지사항</a></h2>
				<div class="list">
					<c:import url="/widgets/board.do" >
						<c:param name="brd_id" value="BDIDX_h05m420eN43VOGRM8lOyf7" />
						<c:param name="menu_nix" value="CQv80aU3" />
						<c:param name="article_cnt" value="1" />
						<c:param name="is_notice" value="Y" />
					</c:import>
					
					<c:import url="/widgets/board.do" >
						<c:param name="brd_id" value="BDIDX_h05m420eN43VOGRM8lOyf7" />
						<c:param name="menu_nix" value="CQv80aU3" />
						<c:param name="article_cnt" value="5" />
						<c:param name="is_notice" value="N" />
					</c:import>
				</div>
				<a href="${pageContext.request.contextPath}/brdartcl/boardarticleList.do?brd_id=BDIDX_h05m420eN43VOGRM8lOyf7&srch_menu_nix=CQv80aU3" class="more" title="공지사항">더보기</a>
			</article>

			<article class="group">
				<h2><a href="">입찰공고</a></h2>
				<div class="list">
					<c:import url="/widgets/announcement.do" >
						<c:param name="group_id" value="IDX000001" />
						<c:param name="menu_nix" value="hDq176T3" />
						<c:param name="article_cnt" value="6" />
					</c:import>
				</div>
				<a href="${pageContext.request.contextPath}/announcement/list.do?groupId=IDX000001&srch_menu_nix=hDq176T3" class="more" title="입찰공고">더보기</a>
			</article>

			<article class="group ">
				<h2><a href="">채용공고</a></h2>
				<div class="list">
					<c:import url="/widgets/announcement.do" >
						<c:param name="group_id" value="IDX000002" />
						<c:param name="menu_nix" value="C4RpZ121" />
						<c:param name="article_cnt" value="6" />
					</c:import>
				</div>
				<a href="${pageContext.request.contextPath}/announcement/list.do?groupId=IDX000002&srch_menu_nix=C4RpZ121" class="more" title="채용공고">더보기</a>
			</article>
			
		</div>
	  </div>
	  <div class="main-quick-wrap">
		  <div class="main-quick">
			  <div>
				  <a href="https://women1366.kr" target="_blank" title="새창열림">
					  <dl>
						  <dt>여성폭력 사이버 상담</dt>
						  <dd>가정폭력, 성폭력 등<br />여성폭력 피해 초기상담</dd>
					  </dl>
				  </a>
			  </div>
			  <div>
				  <a href="https://d4u.stop.or.kr/" target="_blank" title="새창열림">
					  <dl>
						  <dt>디지털 성범죄 <br />피해자 지원센터<br/>
						  	<span style="font-size: 1.6rem;">(☎ 02-735-8994)</span>
						  </dt>
						  <dd>피해 촬영물 삭제 및 <br />상담ㆍ수사ㆍ법률ㆍ의료 연계지원</dd>
					  </dl>
				  </a>
			  </div>
			  <div>
				  <a href="https://wecan.stop.or.kr" target="_blank" title="새창열림">
					  <dl>
						  <dt>성희롱·성폭력 근절 <br />종합지원센터<br/>
						  	<span style="font-size: 1.6rem;">(☎ 02-735-7544)</span>
						  </dt>
						  <dd>기관장 등 피해자 상담 및 지원 연계,<br />성희롱 방지 조직문화 진단 지원</dd>
					  </dl>
				  </a>
			  </div>
		  </div>
	  </div>	
	  <div id="contents" class="main2020-middle">
		
		<div class="main-board01-wrap">
			<div class="main-board01">
				<div>
					<h2>진흥원 소식</h2>
					<c:import url="/widgets/board.do" >
						<c:param name="brd_id" value="BDIDX_mV49maYF8r081nc63vW96G" />
						<c:param name="menu_nix" value="hn8TL907" />
						<c:param name="article_cnt" value="3" />
						<c:param name="type" value="board_2" />
					</c:import>
					<p class="more"><a href="/brdthm/boardthmList.do?brd_id=BDIDX_mV49maYF8r081nc63vW96G&srch_menu_nix=hn8TL907">진흥원 소식 더보기</a></p>
				</div>
				<div>
					<h2>종사자 교육안내</h2>
					<c:import url="/widgets/board.do" >
						<c:param name="brd_id" value="BDIDX_7t1paiPG2C6foT0Thx26o9" />
						<c:param name="menu_nix" value="8J86Xycp" />
						<c:param name="article_cnt" value="3" />
						<c:param name="type" value="board_3" />
					</c:import>
					<p class="more"><a href="/brdartcl/boardarticleList.do?brd_id=BDIDX_7t1paiPG2C6foT0Thx26o9&srch_menu_nix=8J86Xycp">종사자 교육안내 더보기</a></p>
				</div>
				<div>
					<h2>보도자료</h2>
					<c:import url="/widgets/board.do" >
						<c:param name="brd_id" value="BDIDX_BHfki9u872956bn68r6Qb5" />
						<c:param name="menu_nix" value="3tt2mJYv" />
						<c:param name="article_cnt" value="3" />
						<c:param name="type" value="board_3" />
					</c:import>
					<p class="more"><a href="/brdartcl/boardarticleList.do?brd_id=BDIDX_BHfki9u872956bn68r6Qb5&srch_menu_nix=3tt2mJYv">보도자료 더보기</a></p>
				</div>
			</div>
		</div>
		<div class="main-board02-wrap">
			<div class="main-board02">
				<div>
					<h2>발간자료</h2>
					<c:import url="/widgets/multiCms.do" >
						<c:param name="category" value="pd" />
						<c:param name="language" value="kor" />
					</c:import>
					<p class="more"><a href="/multicms/multiCmsUsrList.do?category=pd&srch_menu_nix=nFog4NJ7">발간자료 더보기</a></p>
				</div>
				<div>
					<h2>카드뉴스</h2>
					<div class="card-type">
						<c:import url="/widgets/board.do" >
							<c:param name="menu_nix" value="czt8k027" />
							<c:param name="article_cnt" value="1" />
							<c:param name="type" value="cardNews" />
						</c:import>
					</div>
					<p class="more"><a href="/cardnews/cardNewsUsrList.do?srch_menu_nix=czt8k027">카드뉴스 더보기</a></p>
				</div>
				<div>
					<h2>영상자료</h2>
					<div class="card-type">
						<c:import url="/widgets/board.do" >
							<c:param name="brd_id" value="BDIDX_3K0Ny2492D27W3273Vb3G2" />
							<c:param name="menu_nix" value="7j6mBDN6" />
							<c:param name="article_cnt" value="1" />
							<c:param name="type" value="photo_3" />
						</c:import>
					</div>
					<p class="more"><a href="/brdthm/boardthmList.do?brd_id=BDIDX_3K0Ny2492D27W3273Vb3G2&srch_menu_nix=7j6mBDN6">영상자료 더보기</a></p>
				</div>
			</div>
		</div>

		<div class="main-quick02-wrap">
			<div class="main-quick02">
				<ul>
					<li><a href="https://edu.stop.or.kr/" target="_blank" title="새창열림">종사자 교육포털</a></li>
					<li><a href="/modedg/contentsView.do?ucont_id=CTX000090&srch_menu_nix=l3vdU8Xo">전국 피해자 지원기관</a></li>
					<li><a href="/modedg/contentsView.do?ucont_id=CTX000064&srch_menu_nix=QIuR8Qcp&srch_mu_site=CDIDX00005">여성폭력 바로알기</a></li>
					<li>
						<dl>
							<dt>SNS 바로가기</dt>
							<dd>
								<ul>
									<li><a href="https://www.facebook.com/wrstar" class="facebook" target="_blank" title="새창열림">페이스북</a></li>
									<li><a href="https://twitter.com/search?q=whrik2009" class="twitter" target="_blank" title="새창열림">트위터</a></li>
									<li><a href="https://blog.naver.com/whrck" class="blog" target="_blank" title="새창열림">블로그</a></li>
									<li><a href="https://www.youtube.com/channel/UCicENtEiT1hcvAOKJqztyYg" class="youtube" target="_blank" title="새창열림">유투브</a></li>
									<li><a href="https://www.instagram.com/whrik/" class="instagram" target="_blank" title="새창열림">인스타그램</a></li>
								</ul>
							</dd>
						</dl>
					</li>
				</ul>
			</div>
		</div>

		<div class="main-bottom-wrap">
			<div class="main-bottom">
<script type="text/javascript">
$(function(){

	$('.board-etc ul').bxSlider({
		auto : true,
		autoHover : true,
		mode: 'fade',
		speed : 1000,
		pause : 3000,
		responsive : true,
		pager : false,
		autoControls	: true,
		controls : true
	});
});
</script>
				<div class="board-etc">
					<p class="tit">여성폭력방지 자료실</p>
					<ul>
						<li style="background-color:#f2718f"><a href="/webtoon/webtoonUsrList.do?srch_menu_nix=0K1X4L4x"><img src="${pageContext.request.contextPath}/images/kor/main/data_01.jpg" alt="#respect #with you 공감UP! 웹툰" /></a></li>
						<li style="background-color:#f5d832"><a href="/multicms/multiCmsUsrList.do?category=pd&srch_menu_nix=nFog4NJ7"><img src="${pageContext.request.contextPath}/images/kor/main/data_02.jpg" alt="#respect #with you 공유UP! 발간자료" /></a></li>
						<li style="background-color:#11bcce"><a href="/brdthm/boardthmList.do?brd_id=BDIDX_wrR6Y75NERer1TjATq005t&srch_menu_nix=da547j6T"><img src="${pageContext.request.contextPath}/images/kor/main/data_03.jpg" alt="#respect #with you 참여UP! 참여마당" /></a></li>
						<li style="background-color:#68489d"><a href="/cardnews/cardNewsUsrList.do?srch_menu_nix=czt8k027"><img src="${pageContext.request.contextPath}/images/kor/main/data_04.jpg" alt="#respect #with you 확산UP! 카드뉴스" /></a></li>
					</ul>
				</div>

				<div class="popupzone">
					<c:import url="/widgets/popupzone.do" >
						<c:param name="popupzone_cnt" value="2" />
					</c:import>
				</div>

				<article class="newsletter">
					<div class="newsletter-inner">
					<h2>한국여성인권진흥원 뉴스레터</h2>
					<span>진흥원 소식을 이메일로 보내드립니다.</span>
					<p>
						<input type="text" id="nmail" class="email" title="이메일"  placeholder="이메일을 입력해주세요"/>
						<a href="#newsletter" class="btn btn-layerpopup2">신청</a>
					</p>
					<div class="more"><a href="/brdthm/boardthmList.do?brd_id=BDIDX_kRyA7Wv1SwT2piS18zy8P5&srch_menu_nix=iG8cifYK">뉴스레터 더보기</a></div>
					</div>
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
									<input type="radio" id="agree1" name="agree">
									<label for="agree1">동의함</label>
								</span>
								
								<span class="form-set form-radio">
									<input type="radio" id="agree2" name="agree">
									<label for="agree2">동의하지 않음</label>
								</span>
							</p>
							
							<p class="btns txt-center">
								<!-- <a href="" class="btn-l btn1">확인</a> -->
								<input type="submit" value="확인" class="btn-l btn1"/>
								<a href="#newsletter" class="btn-l btn2 close">취소</a>
							</p>
						</div>
					</div>
				</article>
				<!-- //개인정보수집 팝업 -->
				</form:form>
			</div>
		</div>

	  </div>


