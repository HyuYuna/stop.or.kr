<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<div id="visual">
	
	<c:import url="/widgets/visual.do" >
		<c:param name="visual_cnt" value="3" />
	</c:import>
					
</div>

 <!-- 이야기 하기 -->
<div class="story">
	<article class="list">
		<h2>나는 오늘 <span>공백</span><span>공백</span>을 말하고 싶습니다</h2>
		<p class="desc">
			<strong>쉽게 꺼낼 수 없는 말...</strong>
			<span>얘기 해주세요. 당신 곁에서 귀 기울일게요.<br />지금, 우리가 이야기를 시작하는 것이 필요합니다.</span>
			<a href="#story">이야기하기</a>
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

		<!--  
		<article class="group">
			<h2>
				<strong>02</strong>
				<span>조금만 더 자세히 알려주세요</span>
			</h2>

			<div class="item">
				<strong>누구인지 알려주세요</strong>
				<ul class="list2">
					<li>
						<input type="checkbox" id="who1" />
						<label for="who1">남편</label>
					</li>
					<li>
						<input type="checkbox" id="who2" />
						<label for="who2">아버지</label>
					</li>
					<li>
						<input type="checkbox" id="who3" />
						<label for="who3">그외</label>
					</li>
				</ul>
			</div>

			<div class="item">
				<strong>어디에서 일어난 일이에요?</strong>
				<ul class="list2">
					<li>
						<input type="checkbox" id="where1" />
						<label for="where1">집안에서</label>
					</li>
					<li>
						<input type="checkbox" id="where2" />
						<label for="where2">집밖에서</label>
					</li>
				</ul>
			</div>

			<div class="item">
				<strong>최근 한달간 얼마나 자주 겪었나요?</strong>
				<ul class="list2">
					<li>
						<input type="checkbox" id="month1" />
						<label for="month1">1~5회</label>
					</li>
					<li>
						<input type="checkbox" id="month2" />
						<label for="month2">6회~10회</label>
					</li>
					<li>
						<input type="checkbox" id="month3" />
						<label for="month3">10회 이상</label>
					</li>
				</ul>
			</div>

			<p class="btns">
				<a href="" class="btn1">그만하기</a>
				<a href="" class="btn2">계속하기</a>
			</p>
		</article>

		<article class="group">
			<h2>
				<strong>03</strong>
				<span>어떤 일이 있었나요?</span>
			</h2>

			<ul class="list3">
				<li>
					<a href="">
						<span class="icon"><img src="../../images/kor/main/icon1.gif" alt="" /></span>
						<strong>여성폭력 사이버 상담</strong>
						<span>바로가기</span>
					</a>
				</li>
				<li>
					<a href="">
						<span class="icon"><img src="../../images/kor/main/icon2.gif" alt="" /></span>
						<strong>디지털 성범죄 피해자 지원센터</strong>
						<span>바로가기</span>
					</a>
				</li>
			</ul>

			<p class="btns">
				<a href="" class="btn1">그만하기</a>
				<a href="" class="btn2">상담완료</a>
			</p>
		</article>
	</div>
	-->
</div>
<!-- //이야기 하기 -->

  <div id="contents">
	<div class="news">
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
			<h2><a href="">채용소식</a></h2>
			<div class="list">
				<c:import url="/widgets/announcement.do" >
					<c:param name="group_id" value="IDX000002" />
					<c:param name="menu_nix" value="C4RpZ121" />
					<c:param name="article_cnt" value="7" />
				</c:import>
			</div>
			<a href="${pageContext.request.contextPath}/announcement/list.do?groupId=IDX000002&srch_menu_nix=C4RpZ121" class="more">더보기</a>
		</article>
		
		<article class="group">
			<h2><a href="">지원기관 채용소식</a></h2>
			<div class="list">
				<c:import url="/widgets/announcement.do" >
					<c:param name="group_id" value="IDX000003" />
					<c:param name="menu_nix" value="3ws7vVD9" />
					<c:param name="article_cnt" value="7" />
				</c:import>
			</div>
			<a href="${pageContext.request.contextPath}/announcement/list.do?groupId=IDX000003&srch_menu_nix=3ws7vVD9" class="more">더보기</a>
		</article>
		
		<article class="trend">
			<h2><a href="">아라의 채비포커스</a></h2>
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

	<!-- 오늘의 일정 -->
	<article class="schedule">
		<h2>오늘의 일정</h2>
		<c:import url="/widgets/schedule.do" />
		<!-- 20180816 더보기 버튼 추가 -->
			<a href="${pageContext.request.contextPath}/sch/schList.do?srch_menu_nix=786v729N" class="more">더보기</a>
		<!-- //20180816 더보기 버튼 추가 -->
	</article>
	<!-- //오늘의 일정 -->

	<div class="popupzone">
		<c:import url="/widgets/popupzone.do" >
			<c:param name="popupzone_cnt" value="2" />
		</c:import>
	</div>

	<div class="link">
		<div class="item">
			<ul>
				<li>
					<a href="https://www.women1366.kr/_main/main.html" target="_blank">
						<span>
							<img src="${pageContext.request.contextPath}/images/kor/main/link1.png" alt="" />
						</span>
						<strong>여성폭력<br />사이버 상담</strong>
					</a>
				</li>
				<li>
					<a href="http://www.mogef.go.kr/msv/metooReport.do" target="_blank">
						<span>
							<img src="${pageContext.request.contextPath}/images/kor/main/link2.png" alt="" />
						</span>
						<strong>직장 내 성희롱·<br />성폭력 신고센터</strong>
					</a>
				</li>
				<li>
					<a href="https://www.women1366.kr/stopds/" target="_blank">
						<span>
							<img src="${pageContext.request.contextPath}/images/kor/main/link3.png" alt="" />
						</span>
						<strong>디지털 성범죄<br />피해자 지원센터</strong>
					</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/brdthm/boardthmList.do?brd_id=BDIDX_kRyA7Wv1SwT2piS18zy8P5&srch_menu_nix=iG8cifYK">
						<span>
							<img src="${pageContext.request.contextPath}/images/kor/main/link4.png" alt="" />
						</span>
						<strong>브리핑룸</strong>
					</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/modedg/contentsView.do?ucont_id=CTX000019&srch_menu_nix=0CuLvH4K">
						<span>
							<img src="${pageContext.request.contextPath}/images/kor/main/link5.png" alt="" />
						</span>
						<strong>오시는 길</strong>
					</a>
				</li>
			</ul>
		</div>

		<p class="control">
			<a href="" class="prev">이전</a>
			<a href="" class="next">다음</a>
		</p>
	</div>
	
	
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
  </div>
