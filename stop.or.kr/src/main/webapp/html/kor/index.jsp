<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	<title>한국여성인권진흥원</title>
	<link rel="stylesheet" type="text/css" href="../../css/common.css" />
	<link rel="stylesheet" type="text/css" href="../../css/kor/main.css" />
	<link rel="stylesheet" type="text/css" href="../../css/kor/respond/main.css" />
</head>

<body>
<!-- Accessibility -->
<a id="uppermost" href="#contents" class="skip-to">본문 바로가기</a>
<div id="wrap">
	<%@ include file="include/header.jsp" %>	
	<main id="main">
	  <div id="visual">
	    <div class="paging">
			<strong>1</strong>
			<span>3</span>
			<!--
			<p>Cannot <br />Buy</p>
			-->
		</div>
		<!--
		<div class="desc">
			<p>세상에는 거래할 수 없는 것이 있습니다.</p>
			<span>남녀사이의 사랑, 인간의 존엄성, 생명, 가족의 사랑, 자유<br />소중한 자연, 개인의 꿈, 마음의 휴식...</span>
			<strong>인간의 성(性)은 거래 대상이 될 수 없습니다</strong>
		</div>
		-->
		<ul>
			<li><img src="../../images/kor/main/visual_img1.jpg" alt="" /></span></li>
			<li><img src="../../images/kor/main/visual_img2.jpg" alt="" /></span></li>
			<li><img src="../../images/kor/main/visual_img3.jpg" alt="" /></span></li>
		</ul>
	  </div>

	  <!-- 이야기 하기 -->
	<div class="story">
		<article class="list">
			<h2>나는 오늘 <span>공백</span><span>공백</span><span>공백</span>을 겪었습니다.</h2>
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
							<img src="../../images/kor/main/story1.gif" alt="" />
							<span>가정폭력</span>
						</label>
					</li>
					<li>
						<input type="checkbox" id="check2" />
						<label for="check2">
							<img src="../../images/kor/main/story2.gif" alt="" />
							<span>성폭력</span>
						</label>
					</li>
					<li>
						<input type="checkbox" id="check3" />
						<label for="check3">
							<img src="../../images/kor/main/story3.gif" alt="" />
							<span>성매매</span>
						</label>
					</li>
					<li>
						<input type="checkbox" id="check4" />
						<label for="check4">
							<img src="../../images/kor/main/story4.gif" alt="" />
							<span>데이트폭력</span>
						</label>
					</li>
					<li>
						<input type="checkbox" id="check5" />
						<label for="check5">
							<img src="../../images/kor/main/story5.gif" alt="" />
							<span>성희롱</span>
						</label>
					</li>
					<li>
						<input type="checkbox" id="check6" />
						<label for="check6">
							<img src="../../images/kor/main/story6.gif" alt="" />
							<span>불법촬영피해</span>
						</label>
					</li>
					<li>
						<input type="checkbox" id="check7" />
						<label for="check7">
							<img src="../../images/kor/main/story7.gif" alt="" />
							<span>그리고</span>
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
							<a href="">
								<span class="icon"><img src="../../images/kor/main/icon1.gif" alt="" /></span>
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
							<a href="">
								<span class="icon"><img src="../../images/kor/main/icon2.gif" alt="" /></span>
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
							<a href="">
								<span class="icon"><img src="../../images/kor/main/icon3.gif" alt="" /></span>
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
					<a href="">가까운 여성폭력 지원 기관 찾기</a>
					<!-- //20180822 추가 -->
				</p>
				
				<p class="btns">
					<a href="" class="btn1">그만하기</a>
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
			<ul>
				<li>
					<div class="title">
						<p>
							<em>진흥원소식</em>
							<strong>3.8 여성의 날! 미투할 수 있는 용기, 당신과 함께합니다</strong>
							<span><img src="../../images/kor/main/news.jpg" alt="" /></span>
						</p>
					</div>
					<p class="txt">
						여성노동운동으로 시작되었던 여성의 날이 110회 
						만에 우리나라의 법정 기념일로 지정된 것은  의미가 
						있습니다. 여성에게 행해지는 차별과 폭력이 개인의 
						문제가 아닌 사회구조적인 문제이며, 온 국민의  ..
					</p>
					<a href="" class="btn">자세히 보기</a>
				</li>
				<li>
					<div class="title">
						<p>
							<em>진흥원소식</em>
							<strong>3.8 여성의 날! 미투할 수 있는 용기, 당신과 함께합니다</strong>
							<span><img src="../../images/kor/main/news.jpg" alt="" /></span>
						</p>
					</div>
					<p class="txt">
						여성노동운동으로 시작되었던 여성의 날이 110회 
						만에 우리나라의 법정 기념일로 지정된 것은  의미가 
						있습니다. 여성에게 행해지는 차별과 폭력이 개인의 
						문제가 아닌 사회구조적인 문제이며, 온 국민의  ..
					</p>
					<a href="" class="btn">자세히 보기</a>
				</li>
			</ul>
		</div>

		<div class="latest">
			<article class="group active">
				<h2><a href="">공지사항</a></h2>
				<p class="category">
					<a href="" class="active">전체</a>
					<a href="">진흥원활동</a>
					<a href="">현장네트워크</a>
				</p>
				<div class="list">
					<div class="spot">
						<strong>2018 제 1차 성매매방지 정책토론회(제 4회 이후포럼) 개최 안내(4.24.(화)14시, 서울글로벌센터 9층 국제회..</strong>
						<p>오는 4월 24일(화) 오후 2시 서울글로벌센터 9층 국제회의장에서 2018 제 1차 성매매방지 정책토론회(제4회 이후포럼)을 개최합니다.  '폭력, 인권, 젠더' 등과 관련된 여성폭력 사건 ..</p>
						<span>경영기획본부 대외홍보팀</span>
						<span>2018-04-16</span>
					</div>

					<ul>
						<li><a href="">2018년 일본군 위안부 피해자 기림의 날 행사 용역 입찰 공고</a></li>
						<li><a href="">2018 제 1차 성매매방지 정책토론회(제 4회 이후포럼) 개최 ..</a></li>
						<li><a href="">제3회 이후포럼 개최 안내(3.27.(화)16시, 진흥원 대교육장) </a></li>
						<li><a href="">「2018년 제1기 성매매방지 상담원 등 양성교육」실시 안내 </a></li>
						<li><a href="">한국여성인권진흥원 위드유 서포터즈를 모집합니다. </a></li>
						<li><a href="">「2018년 제1기 성매매방지 상담원 등 양성교육」실시 안내 </a></li>
					</ul>
				</div>
				<a href="" class="more">더보기</a>
			</article>

			<article class="group">
				<h2><a href="">채용소식</a></h2>
				<div class="list">
					<div class="spot">
						<strong>[채용] 2018 제 1차 성매매방지 정책토론회(제 4회 이후포럼) 개최 안내(4.24.(화)14시, 서울글로벌센터 9층 국제회..</strong>
						<p>오는 4월 24일(화) 오후 2시 서울글로벌센터 9층 국제회의장에서 2018 제 1차 성매매방지 정책토론회(제4회 이후포럼)을 개최합니다.  '폭력, 인권, 젠더' 등과 관련된 여성폭력 사건 ..</p>
						<span>경영기획본부 대외홍보팀</span>
						<span>2018-04-16</span>
					</div>

					<ul>
						<li><a href="">[채용] 2018년 일본군 위안부 피해자 기림의 날 행사 용역 입찰 공고</a></li>
						<li><a href="">[채용] 2018 제 1차 성매매방지 정책토론회(제 4회 이후포럼) 개최 ..</a></li>
						<li><a href="">[채용] 제3회 이후포럼 개최 안내(3.27.(화)16시, 진흥원 대교육장) </a></li>
						<li><a href="">[채용] 「2018년 제1기 성매매방지 상담원 등 양성교육」실시 안내 </a></li>
						<li><a href="">[채용] 한국여성인권진흥원 위드유 서포터즈를 모집합니다. </a></li>
						<li><a href="">[채용] 「2018년 제1기 성매매방지 상담원 등 양성교육」실시 안내 </a></li>
					</ul>
				</div>
				<a href="" class="more">더보기</a>
			</article>
			
			<article class="trend">
				<h2><a href="">채용소식</a></h2>
				<div class="list">
					<div class="spot">
						<strong>[채용] 2018 제 1차 성매매방지 정책토론회(제 4회 이후포럼) 개최 안내(4.24.(화)14시, 서울글로벌센터 9층 국제회..</strong>
						<p>오는 4월 24일(화) 오후 2시 서울글로벌센터 9층 국제회의장에서 2018 제 1차 성매매방지 정책토론회(제4회 이후포럼)을 개최합니다.  '폭력, 인권, 젠더' 등과 관련된 여성폭력 사건 ..</p>
						<span>경영기획본부 대외홍보팀</span>
						<span>2018-04-16</span>
					</div>

					<ul>
						<li><a href="">[채용] 2018년 일본군 위안부 피해자 기림의 날 행사 용역 입찰 공고</a></li>
						<li><a href="">[채용] 2018 제 1차 성매매방지 정책토론회(제 4회 이후포럼) 개최 ..</a></li>
						<li><a href="">[채용] 제3회 이후포럼 개최 안내(3.27.(화)16시, 진흥원 대교육장) </a></li>
						<li><a href="">[채용] 「2018년 제1기 성매매방지 상담원 등 양성교육」실시 안내 </a></li>
						<li><a href="">[채용] 한국여성인권진흥원 위드유 서포터즈를 모집합니다. </a></li>
						<li><a href="">[채용] 「2018년 제1기 성매매방지 상담원 등 양성교육」실시 안내 </a></li>
					</ul>
				</div>
				<a href="" class="more">더보기</a>
			</article>
		</div>

		<!-- 오늘의 일정 -->
		<article class="schedule">
			<h2>오늘의 일정</h2>

			<ul class="item">
				<li>
					<p class="date">
						<strong>23</strong>
						수요일<br />
						05, 2018
					</p>
					
					<ul class="bul1">
						<li>2018 제 1차 성매매방지 정책토론회</li>
						<li>2018 제 1차 성매매방지 정책토론회</li>
					</ul>

					<!--  
					<ul class="list">
						<li>
							<p>
								<span class="icon icon1">국내</span>
								2018 제 1차 성매매방지 정책토론회
							</p>
							<span>서울글로벌센터 9층</span>
						</li>
						<li>
							<p>
								<span class="icon icon2">국외</span>
								2018 제 1차 성매매방지 정책토론회
							</p>
							<span>서울글로벌센터 9층</span>
						</li>
					</ul>
					-->
				</li>
				<li>
					<p class="date">
						<strong>24</strong>
						목요일<br />
						05, 2018
					</p>

					<ul class="list">
						<li>
							<p>
								<span class="icon icon1">국내</span>
								2018 제 1차 성매매방지 정책토론회 2
							</p>
							<span>서울글로벌센터 9층</span>
						</li>
						<li>
							<p>
								<span class="icon icon2">국외</span>
								2018 제 1차 성매매방지 정책토론회 2
							</p>
							<span>서울글로벌센터 9층</span>
						</li>
					</ul>
				</li>
			</ul>
			
			<!-- 20180816 더보기 버튼 추가 -->
			<a href="" class="more">더보기</a>
			<!-- //20180816 더보기 버튼 추가 -->
		</article>
		<!-- //오늘의 일정 -->

		<div class="popupzone">
			<ul>
				<li><a href=""><img src="../../images/kor/main/popupzone1.jpg" alt="" /></a></li>
				<li><a href=""><img src="../../images/kor/main/popupzone2.jpg" alt="" /></a></li>
			</ul>
		</div>

		<div class="link">
			<div class="item">
				<ul>
					<li>
						<a href="">
							<span>
								<img src="../../images/kor/main/link1.png" alt="" />
							</span>
							<strong>여성폭력<br />사이버 상담</strong>
						</a>
					</li>
					<li>
						<a href="">
							<span>
								<img src="../../images/kor/main/link2.png" alt="" />
							</span>
							<strong>직장 내 성희롱·<br />성폭력 특별신고센터</strong>
						</a>
					</li>
					<li>
						<a href="">
							<span>
								<img src="../../images/kor/main/link3.png" alt="" />
							</span>
							<strong>디지털 성범죄<br />피해자 지원센터</strong>
						</a>
					</li>
					<li>
						<a href="">
							<span>
								<img src="../../images/kor/main/link4.png" alt="" />
							</span>
							<strong>브리핑룸</strong>
						</a>
					</li>
					<li>
						<a href="">
							<span>
								<img src="../../images/kor/main/link5.png" alt="" />
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
				<input type="text" title="이메일" />
				<a href="#newsletter" class="btn btn-layerpopup">신청</a>
			</p>
		</article>
		
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
									<td>뉴스레터 해지시까지</td>
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
						<a href="" class="btn-l btn1">확인</a>
						<a href="#newsletter" class="btn-l btn2 close">취소</a>
					</p>
				</div>
			</div>
		</article>
		<!-- //개인정보수집 팝업 -->
	  </div>
	</main>
	<%@ include file="include/footer.jsp" %>	
</div>
<script type="text/javascript" src="../../js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="../../js/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="../../js/jquery.lettering.js"></script>
<script type="text/javascript" src="../../js/typed.js"></script>
<script type="text/javascript" src="../../js/jquery-plani.tab.js"></script>
<script type="text/javascript" src="../../js/jquery-plani.slider.js"></script>
<script type="text/javascript" src="../../js/kor/layout.js"></script>
<script type="text/javascript" src="../../js/kor/main.js"></script>
</body>
</html>
