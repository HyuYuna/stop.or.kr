<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>홈페이지 관리</title>
<link type="image/x-icon" rel="shortcut icon" href="/images/favorite.ico" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/metsys/basic.css"  />

</head>
<body>
<div id="accessibility"><a href="#content">콘텐츠 바로가기</a></div>
<div id="wrap">
	<div id="header">
		<div class="hlogin"><span><span class="point">오호호홍</span>님 로그인하였습니다.</span> <span class="btn_log"><a href="#">로그아웃</a></span><span class="guide"><a href="">인쇄</a><a href="">도움말</a></span></div>
		<h1 class="logo"><a href="/"><img src="../../resources/images/ips/common/logo.gif" alt="KOHI"/></a></h1>
		<ul id="gnavigation">
			<li><a href="">menu01</a></li>
			<li><a href="">menu02</a></li>
			<li><a href="">menu03</a></li>
			<li><a href="">menu04</a></li>
			<li><a href="">menu05</a></li>
			<li><a href="">menu06</a></li>
			<li><a href="">menu07</a></li>
			<li class="on divisional"><a href="">사업별관리</a>
				<ul class="depth2">
					<li class="on"><a href="">사업별관리1</a></li>
					<li><a href="">사업별관리2</a></li>
					<li><a href="">사업별관리3</a></li>
					<li><a href="">사업별관리4</a></li>
					<li><a href="">사업별관리5</a></li>
				</ul>			
			</li>
			<li><a href="">menu08</a>
				<ul class="depth2">
					<li><a href="">사업별관리1</a></li>
					<li><a href="">사업별관리2</a></li>
					<li><a href="">사업별관리3</a></li>
					<li><a href="">사업별관리4</a></li>
					<li><a href="">사업별관리5</a></li>
				</ul>
			</li>
		</ul>		
	</div>
	<hr />
	<!-- body area -->
	<div id="body">
        <!-- left menu start -->
   		<div id="side">
			<h2 class="stitle"><img src="/resources/images/ips/navigation/stitle.gif" alt="WEB ADMIN"/></h2>
			<ul id="snavigation">
				<li><a href="/mgr/memberMgr?menuId=MENU00002">관리자 기능</a></li>
				<li><a href="/html/ips/sub.html" target="_blank">디자인 퍼블리셔</a>
					<ul class="depth3">
						<li><a href="/html/ips/sub.html" target="_blank">관리자</a></li>
						<li><a href="/html/kps/main.jsp" target="_blank">포털</a></li>
						<li><a href="/html/gfi/sub.jsp" target="_blank">고령친화</a></li>
						<li><a href="/html/mdi/main.jsp" target="_blank">의료기기산업정보</a></li>
					</ul>
				</li>
				<li><a href="/sample1">디자인 샘플</a></li>
				<li><a href="/sample2">컨트롤 샘플</a>
					<ul class="depth3">
						<li><a href="/sample2" target="_blank">샘플1</a></li>
						<li><a href="/sample3" target="_blank">에디터/파일업로드</a></li>
						<li><a href="/sample4" target="_blank">동적사이트테스트</a></li>
					</ul>
				</li>
			</ul>
		</div>

        <!-- //left menu// -->
		<hr />
        <!-- content area -->
        <div id="content">
			<div id="title_location">
				<p class="location"><span class="home">Home</span> &gt; 관리자 &gt; <span class="current">관리자 메인</span></p>
				<h1>관리자 메인</h1>
            </div>
			<!-- detail content -->
            <div id="content_detail" >
            	<div class="chart_area">
            		<div class="float_wrap chart">
            			<div class="float_left">왼쪽 차트</div>
            			<div class="float_right">오른쪽 차트</div>
            		</div>
            		<div class="full_chart">풀 차트</div>
            		<div class="full_chart">풀 차트</div>
            	</div>
            
            	<dl class="dynamic_step">
            		<dt class="title_hidden">동적사이트관리</dt>
		            <dd class="step02">
		            	<ul>
		            		<li><a href="">01. Header</a></li>
		            		<li><a href="">02. Body</a></li>
		            		<li><a href="">03. Footer</a></li>
		            		<li><a href="">04. Color</a></li>
		            		<li><a href="">05. Content</a></li>
		            	</ul>
	            	</dd>
            	</dl>
				<ul class="tab_menu">
					<li class="on"><a href="">menu01</a></li>
					<li><a href="">menu02</a></li>
					<li><a href="">menu03</a></li>
					<li><a href="">menu04</a></li>
					<li><a href="">menu05</a></li>
					<li><a href="">menu06</a></li>
					<li><a href="">menu07</a></li>
					<li><a href="">menu08</a></li>
					<li><a href="">menu09</a></li>
				</ul>	
				
				<fieldset id="login_field">
					<legend>로그인</legend>
					<dl>
						<dt><label for="uid">아이디</label></dt>
						<dd class="uid">
							<span class="img">1</span>
							<input id="seqs" name="seqs[]" value="8" type="checkbox"  class="login_id" title="전체선택" />
						</dd>

						<dt><label for="upw">비밀번호</label></dt>
						<dd class="upw"><input type="password" id="txtPassword" name="txtPassword" value="" class="login_pwd" /></dd>
					</dl>
				</fieldset>


				<p>※ 현재 접속 사용자 수 : <span class="txt_bold">1</span> 명( 목록 )</p>
				<table class="tstyle_view" summary="관리자 이름, 아이디, 접속시간, 최종접속시간, 총접속횟수, 등록일, 수정일 정보 안내">
					<caption>
						관리자 정보 안내
					</caption>
					<colgroup>
						<col width="150" />
						<col width="*" />
					</colgroup>
					<tr>
						<th scope="row">이름</th>
						<td>관리자</td>
					</tr>
					<tr>
						<th scope="row">아이디</th>
						<td>cndcjd</td>
					</tr>
					<tr>
						<th scope="row">접속시간</th>
						<td>2013-06-24 01:48:24</td>
					</tr>
					<tr>
						<th scope="row">최종 접속시간</th>
						<td>2013-06-24 01:47:23</td>
					</tr>
					<tr>
						<th scope="row">총접속횟수</th>
						<td>5084</td>
					</tr>
					<tr>
						<th scope="row">등록일</th>
						<td>2011-04-01</td>
					</tr>
					<tr>
						<th scope="row">수정일</th>
						<td>2013-06-01</td>
					</tr>
				</table>
				<form id="list_form" name="list_form" action="/gpms.tdf" method="post">
					<fieldset>
						<legend>물품관리 목록</legend>
						<p class="articles"><span class="total">353</span> topics / <span class="current">1</span> of 36 pages </p>
						<div class="list_search_form">
							<select name="basic">
								<option value="name" >작성자</option>
								<option value="subject" >제목</option>
								<option value="content" >내용</option>
				            </select>
							<input type="text" name="searchval" value="" title="검색어입력" />
							<input type="button" value="검색" class="input_smallBlack" />
						</div>
						<table class="tstyle_list" summary="번호, 제목, 내용크기, 글쓴이, 등록일, 조회수, 첨부에 따른 물품관리 목록">
							<caption>
								물품관리 목록
							</caption>
							<thead>
								<tr>
									<th scope="col" class="num"><input id="seqs" name="seqs[]" value="8" type="checkbox" title="전체선택" /></th>
									<th scope="col" class="num">번호</th>
									<th scope="col">제목</th>
									<th scope="col" class="num">내용크기</th>
									<th scope="col" class="date">작성자</th>
									<th scope="col" class="date">등록일</th>
									<th scope="col" class="num">조회수</th>
									<th scope="col" class="num">첨부</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><input id="seqs" name="seqs[]" value="8" type="checkbox" title="선택"/></td>
									<td><span class="red_box">공지</span></td>
									<td class="txt_left"><img src="../../resources/images/ips/icon/icon_replay.gif" alt="답글"/> <a href="">가나다라마바사아</a></td>
									<td>963</td>
									<td>관리자</td>
									<td>2013-06-24</td>
									<td>23480</td>
									<td class="file"><a href=""><img src="../../resources/images/ips/common/icon_file.gif" alt="파일첨부"/></a></td>
								</tr>
								<tr>
									<td><input id="seqs" name="seqs[]" value="8" type="checkbox" title="선택"/></td>
									<td>1</td>
									<td class="txt_left">가나다라마바사아</td>
									<td>963</td>
									<td>관리자</td>
									<td>2013-06-24</td>
									<td>23480</td>									
									<td class="file">
										<a href=""><img src="../../resources/images/ips/common/icon_file.gif" alt="파일첨부"/></a>
										<dl class="attach_file">
											<dt>첨부파일</dt>
											<dd>
												<ul>
													<li><a href=""><img src="../../resources/images/ips/icon/hwp.png" alt="한글문서"/>첨부파일명첨부파일명첨부.hwp<span>내려받기</span></a></li>
													<li><a href=""><img src="../../resources/images/ips/icon/pdf.png" alt="acrobat 문서"/>첨부파일명첨부파일명첨부.pdf<span>내려받기</span></a></li>
												</ul>
											</dd>
										</dl>									
									</td>
								</tr>
							</tbody>
						</table>
						<div class="board_pager">
							<a href="" class="prev"><img src="/resources/images/common/bbs/btn_prev.gif" alt="이전페이지" /></a><span>
								<a href="" class="active">1</a>
								<a href="">2</a> 
								<a href="">3</a> 
								<a href="">4</a> 
								<a href="">5</a>
								<a href="">6</a> 
								<a href="">7</a> 
								<a href="">8</a> 
								<a href="">9</a> 
								<a href="">10</a> 
							</span><a href="" class="next"><img src="/resources/images/common/bbs/btn_next.gif" alt="다음페이지" /></a>
						</div>


						<p> ▼ button type</p>
						<div class="btn_area">
							<span class="float_left">
								<button type="button" class="btn_blue">선택반전</button>
								<button type="button" class="btn_blue">선택삭제</button>
								<button type="button" class="btn_blue">선택이동</button>
								<button type="button" class="btn_blue">선택복사</button>
							</span>
							<span class="float_right">
								<button type="button" class="btn_blue_sky">추천</button>
								<button type="button" class="btn_black">게시물 등록</button>
							</span>
						</div>

						<p style="margin-top: 20px;"> ▼ link type</p>
						<div class="btn_area">
							<span class="float_left">
								<a href="" class="btn_blue">선택반전</a>
								<a href="" class="btn_blue">선택삭제</a>
							</span>
							<span class="float_right">
								<a href="" class="btn_blue_sky">추천</a>
								<a href="" class="btn_black">게시물 등록</a>
							</span>
						</div>
						<p style="margin-top: 20px;"> ▼ input type</p>
						<div class="btn_area">
							<span class="float_left">
								<input type="button" class="btn_blue" value="선택반전" /></input>
							</span>
							<span class="float_right">
								<input type="button" value="추천" class="btn_blue_sky" />
								<input type="button" value="게시물 등록" class="btn_black" />
							</span>
						</div>
					</fieldset>
				</form>
				<p style="padding-top: 30px;">▼ 보기페이지</p>
				<!-- ▼ 보기페이지  -->
				<table class="tstyle_view" summary="등록일, 이름, 이메일, 담당부서, 제목, 내용에 따른 게시물상세 안내">
					<caption>
						게시물상세 안내
					</caption>
					<colgroup>
						<col width="150" />
						<col />
					</colgroup>
					<tr>
						<th scope="row">제목</th>
						<td colspan="3">&lt;빈발질의&gt; 신규업체 입찰참가자격등록 절차 안내자료</td>
					</tr>
					<tr>
						<th scope="row">등록일</th>
						<td>2009-02-18 17:38:57 최종수정일 ( 2013-05-01 09:18:32 ) </td>
						<th scope="row">이름</th>
						<td>관리자 ( IP : 211.42.85.34 ) </td>
					</tr>

					<tr>
						<th scope="row">이메일</th>
						<td>website@pps.go.kr</td>
						<th scope="row">담당부서</th>
						<td>고객지원팀</td>
					</tr>
				</table>
				<div class="view_content">
					<ul class="download">
						<li>첨부파일01: <span><img src="../../resources/images/ips/icon/xls.gif" alt="엑셀" /> <a href="">업종자료.xls</a></span> 8MB / 2</li>
						<li>첨부파일02: <span><img src="../../resources/images/ips/icon/hwp.png" alt="엑셀" /> <a href="">전자입찰참가안내.hwp</a></span> 14MB / 2</li>
						<li></li>
					</ul>
					아래 공인인증기관 중 한 곳을 자율선택 하여 연락 후 전자거래범용기업인증서를 발급받는다. (일반적으로 인증기관을 직접 방문 필요, 인증서는 매년 11만원씩 납부)
					<ul>
						<li>코스콤 (http://www.signkorea.com) (1577-7337)</li>
						<li>한국무역정보통신 (http://g2b.tradesign.net/index.html) (02-2109-8846~7)</li>
						<li>한국전자인증 (http://g2b.crosscert.com) (1566-0566)</li>
						<li>한국정보인증 (http://www.signgate.com) (1577-8787) </li>
					</ul>
					<div class="table_graph">
						<table class="tstyle_list" summary="투표수, 투표평균, 별표에 따른 투표경향분석 표">
							<caption>
							투표경향분석
							</caption>
							<tr>
								<th colspan="2" scope="col">투표경향분석</th>
							</tr>
							<tr>
								<th scope="row">투표수</th>
								<td>42</td>
							</tr>
							<tr>
								<th scope="row">투표평균</th>
								<td>7.86</td>
							</tr>
							<tr>
								<th scope="row">별표</th>
								<td>7.86</td>
							</tr>
						</table>

						<table class="tstyle_list tstyle_graph">
							<tfoot>
								<tr>
									<td>1</td>
									<td>2</td>
									<td>3</td>
									<td>4</td>
									<td>5</td>
									<td>6</td>
									<td>7</td>
									<td>8</td>
									<td>9</td>
									<td>10</td>
								</tr>
							</tfoot>
							<tbody>
								<tr>
									<td><img src="../../resources/images/ips/sub/graph.gif" width="14" height="1"  alt="1%" /></td>
									<td><img src="../../resources/images/ips/sub/graph.gif" width="14" height="20"  alt="20%" /></td>
									<td><img src="../../resources/images/ips/sub/graph.gif" width="14" height="30"  alt="30%" /></td>
									<td><img src="../../resources/images/ips/sub/graph.gif" width="14" height="40"  alt="40%" /></td>
									<td><img src="../../resources/images/ips/sub/graph.gif" width="14" height="50"  alt="50%" /></td>
									<td><img src="../../resources/images/ips/sub/graph.gif" width="14" height="60"  alt="60%" /></td>
									<td><img src="../../resources/images/ips/sub/graph.gif" width="14" height="70"  alt="70%" /></td>
									<td><img src="../../resources/images/ips/sub/graph.gif" width="14" height="80"  alt="80%" /></td>
									<td><img src="../../resources/images/ips/sub/graph.gif" width="14" height="90"  alt="90%" /></td>
									<td><img src="../../resources/images/ips/sub/graph.gif" width="14" height="100"  alt="100%" /></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<!-- ▲ 보기페이지  -->

				<p style="padding: 30px 0;">▼ 등록페이지</p>
				<!-- ▼ 등록페이지  -->
				<form id="write_form" name="write_form" action="/gpms.tdf" method="get">
					<fieldset>
						<legend>상세등록</legend>
						<p><span class="point01">*</span> 필수입력항목 입니다.</p>
						<table class="tstyle_view" summary="등록일, 이름, 이메일, 담당부서, 제목, 내용에 따른 게시물상세 안내">
							<caption>
								게시물상세 안내
							</caption>
							<colgroup>
								<col width="150" />
								<col />
							</colgroup>
							<tr>
								<th scope="row"><span class="point01">*</span> <label for="subject">제목</label></th>
								<td colspan="3"><input type="text" id="subject" name="subject"  class="input_long" title="제목입력" /></td>
							</tr>
							<tr>
								<th scope="row"><label for="name">이름</label></th>
								<td><input type="text" name="name" id="name" value="관리자" maxlength="30" title="이름 입력"/> <input type="button" class="input_smallBlack" value="검색"></td>
								<th scope="row"><label for="temp_ocode">담당부서</label></th>
								<td>
									<select name="temp_ocode" id="temp_ocode" title="담당부서 선택">
										<option value="0000,조달청">조달청</option>
										<option value="000,조달청">조달청</option>
										<option value="0001,청장실">청장실</option>
										<option value="011,청장실">청장실</option>
										<option value="0002,차장실">차장실</option>
										<option value="021,차장실">차장실</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><span class="point01">*</span> <label for="TEL">전화번호</label></th>
								<td colspan="3"><input type="text" name="TEL" id="TEL" value="" maxlength="20" class="input_mid02" title="전화번호 입력"/></td>
							</tr>
							<tr>
								<th scope="row"><span class="point01">*</span> <label for="email">이메일</label></th>
								<td colspan="3"><input type="text" name="email" id="email" class="input_long" value="website@pps.go.kr" title="이메일 입력"/></td>
							</tr>
							<tr>
								<th scope="row">토론 종료여부</th>
								<td colspan="3">
									<input name="end_yn" id="end_n" value="Y" type="radio" title="토론기간 종료 선택"/>
									<label for="end_n">종료</label>
									<input name="end_yn" id="end_y" value="N" type="radio" title="토론기간 진행 선택" />
									<label for="end_y">진행</label>
								</td>
							</tr>
							<tr>
								<th scope="row">토론기간</th>
								<td colspan="3">
									<input name="TERM_YN" id="TERM_Y" value="Y" type="radio" title="토론기간 사용 선택"/>
									<label for="TERM_Y">사용</label>
									<input name="TERM_YN" id="TERM_N" value="N" type="radio" title="토론기간 미사용 선택" />
									<label for="TERM_N">미사용</label>
									<div>
										<input id="dp" name="sEndDt1" value="20130524" maxlength="200"/>
										<img src="../../resources/images/ips/sub/icon_calendar.gif" alt="답변일자초기화"  class="vertical_mid"  /> ~
										<input id="dp" name="sEndDt2" value="20130624" maxlength="200" />
										<img src="../../resources/images/ips/sub/icon_calendar.gif" alt="답변일자초기화"  class="vertical_mid" />
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="viewtxt">내용</label></th>
								<td colspan="3"><textarea name="viewtxt" id="viewtxt" cols="45" rows="5" class="txtarea" title="본문내용 입력"></textarea></td>
							</tr>
							<tr>
								<th scope="row">첨부파일 / 사진</th>
								<td colspan="3">
									<p class="point01">※ 최대 80 MB.  이미지 첨부파일란에는 이미지파일만 업로드 하세요.</p>
									<ul class="upfile">
										<li><input type="file" name="upfile1"/></li>
										<li><input type="file" name="upfile2"/></li>
										<li><input type="file" name="upfile3"/></li>
										<li><input type="file" name="upfile4"/></li>
										<li><input type="file" name="upfile5"/></li>
										<li><input type="file" name="upfile6"/></li>
										<li><input type="file" name="upfile7"/></li>
									</ul>
								</td>
							</tr>
							<tr>
								<th scope="row"><span class="point01">*</span> <label for="pwd">비밀번호</label></th>
								<td colspan="3">
									<p class="point01">※ 글 수정, 삭제시 필요합니다. </p>
									<input type="password" id="pwd" name="pwd" value="" maxlength="20" class="input_small"/>
								</td>
							</tr>
						</table>
					<fieldset>
				</form>
				<!-- ▲ 등록페이지  -->

				<!-- 캘린더 -->
				<h2 class="title_hidden">청장 일정</h2>
				<!-- 일일 일정 -->
				<div class="schedule_area">
					<div class="schedule_calendar">
						<div class="date_select"><a href=""><img src="../../resources/images/ips/sub/left_arrow.gif" alt="이전 년도 이동" /></a> <select id="yearSelect" name="select">
									<option value="2012">2012년</option>
									<option value="2013" selected="selected">2013년</option>
									<option value="2014">2014년</option>
								</select> <a href=""><img src="../../resources/images/ips/sub/right_arrow.gif" alt="다음 년도 이동" /></a>
								<a href=""><img src="../../resources/images/ips/sub/left_arrow.gif" alt="이전 달 이동" /></a> <select id="monthSelect" name="select">
									<option value="9">9월</option>
									<option value="10" selected="selected">10월</option>
									<option value="11">11월</option>
								</select> <a href=""><img src="../../resources/images/ips/sub/right_arrow.gif" alt="다음 달 이동" /></a>
						</div>
						<table class="mini_calendar">
							<caption>미니 달력</caption>
							<thead>
								<tr>
									<th scope="col" class="sun">일</th>
									<th scope="col">월</th>
									<th scope="col">화</th>
									<th scope="col">수</th>
									<th scope="col">목</th>
									<th scope="col">금</th>
									<th scope="col" class="sat">토</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="sun">&nbsp;</td>
									<td>&nbsp;</td>
									<td><a href="">1</a></td>
									<td><a href="">2</a></td>
									<td class="point01"><a href="">3</a></td>
									<td><a href="">4</a></td>
									<td class="sat"><a href="">5</a></td>
								</tr>
								<tr>
									<td class="sun"><a href="">6</a></td>
									<td><a href="">7</a></td>
									<td><a href="">8</a></td>
									<td class="point01"><a href="">9</a></td>
									<td><a href="">10</a></td>
									<td><a href="">11</a></td>
									<td class="sat"><a href="">12</a></td>
								</tr>
								<tr>
									<td class="sun"><a href="">13</a></td>
									<td><a href="">14</a></td>
									<td><a href="">15</a></td>
									<td><a href="">16</a></td>
									<td><a href="">17</a></td>
									<td><a href="" class="today">18</a></td>
									<td class="sat"><a href="">19</a></td>
								</tr>
								<tr>
									<td class="sun"><a href="">20</a></td>
									<td><a href="">21</a></td>
									<td><a href="">22</a></td>
									<td><a href="">23</a></td>
									<td><a href="">24</a></td>
									<td><a href="">25</a></td>
									<td class="sat"><a href="">26</a></td>
								</tr>
								<tr>
									<td class="sun"><a href="">27</a></td>
									<td><a href="">28</a></td>
									<td><a href="">29</a></td>
									<td><a href="">30</a></td>
									<td><a href="">31</a></td>
									<td>&nbsp;</td>
									<td class="sat">&nbsp;</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="schedule_list">
						<div class="float_wrap">
							<h3 class="schedule_title">주간 일정 │ <span class="week_date">2013.10.14<span class="week">(월)</span>  ~ 2013.10.18<span class="week">(금)</span></span></h3>
							<div class="schedule_type"><a href="">월별</a><a href="">1주</a><a href="">2주</a><a href="" class="on">3주</a><a href="">4주</a><a href="">5주</a></div>
						</div>
						<table class="tstyle_view" summary="일정별 시간, 목적, 장소 안내">
							<caption>
							일정 목록
							</caption>
							<colgroup>
								<col width="90" />
								<col width="*" />
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">10월 21일(월) </th>
									<td><ul>
											<li>
												<span class="time">10:00~11:00</span>
												<span class="txt">서울 공급관리 컨퍼런스 및 추계학술발표 대회 <span class="place">│ 서울시청</span></span>
												<span class="modify_delete"><a href="/"><img src="../../resources/images/ips/common/btn_modify.gif" alt="수정" /></a><a href="/"><img src="../../resources/images/ips/common/btn_delete.gif" alt="삭제" /></a></span>
											</li>
											<li><span class="time">13:00~14:00</span>
												<span class="txt">안전하고 행복한 대전 만들기 MOU체결 <span class="place">│ 대전지방경찰청</span></span>
												<span class="modify_delete"><a href="/"><img src="../../resources/images/ips/common/btn_modify.gif" alt="수정" /></a><a href="/"><img src="../../resources/images/ips/common/btn_delete.gif" alt="삭제" /></a></span>
											</li>
										</ul>
									</td>
								</tr>
								<tr>
									<th scope="row">10월 22일(화) </th>
									<td><ul>
											<li>
												<span class="time">09:30~</span>
												<span class="txt">국정과제 및 조달행정 혁신과제 이행 점검회의 <span class="place">│ 서울시청</span></span>
												<span class="modify_delete"><a href="/"><img src="../../resources/images/ips/common/btn_modify.gif" alt="수정" /></a><a href="/"><img src="../../resources/images/ips/common/btn_delete.gif" alt="삭제" /></a></span>
											</li>
											<li>
												<span class="time">11:00~</span>
												<span class="txt">제주지방조달청 방문 <span class="place"></span></span>

												<span class="modify_delete"><a href="/"><img src="../../resources/images/ips/common/btn_modify.gif" alt="수정" /></a><a href="/"><img src="../../resources/images/ips/common/btn_delete.gif" alt="삭제" /></a></span>
											</li>
											<li>
												<span class="time">13:30~</span>
												<span class="txt">조달우수기업 방문 <span class="place"></span></span>
												<span class="modify_delete"><a href="/"><img src="../../resources/images/ips/common/btn_modify.gif" alt="수정" /></a><a href="/"><img src="../../resources/images/ips/common/btn_delete.gif" alt="삭제" /></a></span>
											</li>
											<li><span class="time">15:00~</span>
												<span class="txt">제주도지사 예방 <span class="place"></span></span>
												<span class="modify_delete"><a href="/"><img src="../../resources/images/ips/common/btn_modify.gif" alt="수정" /></a><a href="/"><img src="../../resources/images/ips/common/btn_delete.gif" alt="삭제" /></a></span>
											</li>
										</ul>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<!-- 한달 일정 -->
				<div class="calendar_date">
					<span class="today_date">2013.10</span>
					<span class="yearDay_select">
						<select name="scdYear" id="scdYear" title="년도선택">
							<option value="2013" selected="">2013</option>
							<option value="2012">2012</option>
							<option value="2011">2011</option>
						</select>
						<select name="scdMonth" id="scdMonth" title="월선택">
							<option value="10" selected="">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
						</select>
					</span>
				</div>
				<table class="tstyle_diary_visit">
					<caption>청차장 일정 달력</caption>
					<thead>
						<tr>
							<th scope="col" class="sun">SUNDAY</th>
							<th scope="col">MONDAY</th>
							<th scope="col">TUESDAY</th>
							<th scope="col">WEDNESDAY</th>
							<th scope="col">THURSDAY</th>
							<th scope="col">FRIDAY</th>
							<th scope="col" class="sat">SATUREDAY</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="sun">&nbsp;</td>
							<td></td>
							<td>1</td>
							<td>2</td>
							<td class="point01">3</td>
							<td>4</td>
							<td class="sat">5</td>
						</tr>
						<tr>
							<td class="sun">6</td>
							<td>7</td>
							<td>8</td>
							<td class="point01">9</td>
							<td>10</td>
							<td>11</td>
							<td class="sat">12</td>
						</tr>
						<tr>
							<td class="sun">13</td>
							<td>14</td>
							<td>15</td>
							<td>16</td>
							<td>17</td>
							<td>18</td>
							<td class="sat">19</td>
						</tr>
						<tr>
							<td class="sun">20</td>
							<td class="today">21
								<ul class="schedule">
									<li><a href="">서울 공급관리 컨퍼런스 및 추계학술발표 대회</a></li>
									<li><a href="">비축기업 정책현장 방문</a></li>
								</ul>
							</td>
							<td>22</td>
							<td>23</td>
							<td>24</td>
							<td>25</td>
							<td class="sat">26</td>
						</tr>
						<tr>
							<td class="sun">27</td>
							<td>28</td>
							<td>29</td>
							<td>30</td>
							<td>31</td>
							<td>&nbsp;</td>
							<td class="sat">&nbsp;</td>
						</tr>
					</tbody>
				</table>
				<!-- //캘린더 -->
				<!-- 디렉토리 메뉴 구조 -->
				<p style="padding: 30px 0;">▼ left 디렉토리 메뉴</p>
				<div class="treeMenu_area">
					<div class="tree_nav">
						<h2>부서관리</h2>
						<ul id="browser" class="filetree">
							<li><span class="folder">조달청</span>
								<ul>
									<li><span class="folder">조달청</span>
										<ul>
											<li><span class="folder">File 2.1.1</span>
												<ul>
													<li><span class="file">File 2.1.1.1</span></li>
													<li><span class="file">File 2.1.1.2</span></li>
												</ul>
											</li>
											<li><span class="folder">File 2.1.2</span>
												<ul>
													<li><span class="file">File 2.1.2.1</span></li>
													<li><span class="file">File 2.1.2.2</span></li>
												</ul>
											</li>
										</ul>
									</li>
									<li><span class="file">File 2.2</span></li>
								</ul>
							</li>
							<li><span class="folder">청장실</span>
								<ul>
									<li><span class="file">청장실</span></li>
								</ul>
							</li>
							<li><span class="folder">차장실</span>
								<ul>
									<li><span class="file">차장실</span></li>
									<li><span class="file">해외조달시장진출진흥TF팀</span></li>
								</ul>
							</li>
							<li class="closed"><span class="folder">대변인</span>
								<ul>
									<li><span class="file">대변인</span></li>
								</ul>
							</li>
							<li><span class="folder">차장실</span>
								<ul>
									<li><span class="file">차장실</span></li>
									<li><span class="file">해외조달시장진출진흥TF팀</span></li>
								</ul>
							</li>
							<li class="closed"><span class="folder">대변인</span>
								<ul>
									<li><span class="file">대변인</span></li>
								</ul>
							</li>

							<li><span class="folder">차장실</span>
								<ul>
									<li><span class="file">차장실</span></li>
									<li><span class="file">해외조달시장진출진흥TF팀</span></li>
								</ul>
							</li>
							<li class="closed"><span class="folder">대변인</span>
								<ul>
									<li><span class="file">대변인</span></li>
								</ul>
							</li>

						</ul>
					</div>
					<div class="tree_list">
						<h2>조직 관리 / 부서 구성원 목록</h2>
						<p class="articles">(전체 : <span class="total">8</span>) <span class="current">1</span> of 36 pages </p>
						<div class="list_search_form">
							<span class="txt_bold"><label for="">이름</label></span>
							<input type="text" name="searchval" value="" title="검색어입력" />
							<input type="button" value="검색" class="input_smallBlack" />
						</div>
						<table class="tstyle_list" summary="번호, 제목, 내용크기, 글쓴이, 등록일, 조회수, 첨부에 따른 물품관리 목록">
							<caption>
								물품관리 목록
							</caption>
							<thead>
								<tr>
									<th scope="col" class="num">번호</th>
									<th scope="col">이름</th>
									<th scope="col">아이디</th>
									<th scope="col">직급</th>
									<th scope="col">전화</th>
									<th scope="col">이메일</th>
									<th scope="col">휴대폰</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>민형종</td>
									<td>860645</td>
									<td>조달청장</td>
									<td>070-4056-7100</td>
									<td>hjmin@korea.kr</td>
									<td>010-9630-1234</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>


				<p style="padding: 20px 0;">▼ 운영자 관리</p>

				<div class="treeMenu_area">
					<div class="tree_nav">
						<h2>운영자 그룹 관리</h2>
						<ul id="browser" class="filetree">
							<li><span class="folder">조달청</span>
								<ul>
									<li><span class="file">외부운영자</span></li>
									<li class="last"><span class="file">내부운영자</span></li>
								</ul>
							</li>
						</ul>
					</div>
					<!-- 오른쪽 목록 -->
					<div class="tree_list">
						<h2>그룹 관리 / 그룹 구성원 목록</h2>
						<p class="articles">(전체 : <span class="total">8</span>) <span class="current">1</span> of 36 pages </p>
						<div class="list_search_form">
							<select name="basic">
								<option value="USER_NAME">이름</option>
								<option value="USER_ID" >아이디</option>
								<option value="MENUS" >메뉴</option>
								<option value="OCODE" >부서명</option>
				            </select>
							<input type="text" name="searchval" value="" title="검색어입력" />
							<input type="submit" value="검색" class="input_smallBlack" />
							<span><button type="button" class="btn_basic_small">전체보기</button> <button type="button" class="btn_basic_small">운영자 메뉴관리</button></span>
						</div>
						<div class="tree_tScroll">
							<table class="tstyle_list" summary="번호, 제목, 내용크기, 글쓴이, 등록일, 조회수, 첨부에 따른 물품관리 목록">
								<caption>
									물품관리 목록
								</caption>
								<colgroup>
									<col width="30" />
									<col width="*" span="5" />
									<col width="40" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">기관명</th>
										<th scope="col">과명</th>
										<th scope="col">아이디</th>
										<th scope="col">이름</th>
										<th scope="col">이메일</th>
										<th scope="col">접속수</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td>구매사업국</td>
										<td>우수제품과</td>
										<td>860645</td>
										<td>박세래</td>
										<td>hjmin@korea.kr</td>
										<td>3</td>
									</tr>
									<tr>
										<td>1</td>
										<td>구매사업국</td>
										<td>우수제품과</td>
										<td>860645</td>
										<td>박세래</td>
										<td>hjmin@korea.kr</td>
										<td>3</td>
									</tr>
									<tr>
										<td>1</td>
										<td>구매사업국</td>
										<td>우수제품과</td>
										<td>860645</td>
										<td>박세래</td>
										<td>hjmin@korea.kr</td>
										<td>3</td>
									</tr>
									<tr>
										<td>1</td>
										<td>구매사업국</td>
										<td>우수제품과</td>
										<td>860645</td>
										<td>박세래</td>
										<td>hjmin@korea.kr</td>
										<td>3</td>
									</tr>
									<tr>
										<td>1</td>
										<td>구매사업국</td>
										<td>우수제품과</td>
										<td>860645</td>
										<td>박세래</td>
										<td>hjmin@korea.kr</td>
										<td>3</td>
									</tr>
									<tr>
										<td>1</td>
										<td>구매사업국</td>
										<td>우수제품과</td>
										<td>860645</td>
										<td>박세래</td>
										<td>hjmin@korea.kr</td>
										<td>3</td>
									</tr>
									<tr>
										<td>1</td>
										<td>구매사업국</td>
										<td>우수제품과</td>
										<td>860645</td>
										<td>박세래</td>
										<td>hjmin@korea.kr</td>
										<td>3</td>
									</tr>
									<tr>
										<td>1</td>
										<td>구매사업국</td>
										<td>우수제품과</td>
										<td>860645</td>
										<td>박세래</td>
										<td>hjmin@korea.kr</td>
										<td>3</td>
									</tr>
								</tbody>
							</table>
						</div>

						<h2 class="depth2_title02">운영자 관리 / 운영자 상세</h2>
						<div class="list_search_form">
							<button type="button" class="btn_basic_small">운영자 메뉴관리</button>
							<button type="button" class="btn_basic_small">그룹이동</button>
							<button type="button" class="btn_basic_small">등록</button>
							<button type="button" class="btn_basic_small">수정</button>
							<button type="button" class="btn_basic_small">삭제</button>
						</div>
						<table class="tstyle_view" summary="f">
							<caption>
							f
							</caption>
							<colgroup>
								<col width="150" />
								<col width="*" />
							</colgroup>
							<tbody>
								<tr>
									<th> 권한 그룹</th>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<th scope="row"> 부서</th>
									<td>운영지원과</td>
								</tr>
								<tr>
									<th scope="row"> 사원</th>
									<td>민현미 - </td>
								</tr>
								<tr>
									<th scope="row"> 아이디</th>
									<td>130025</td>
								</tr>
								<tr>
									<th scope="row"> 이름</th>
									<td>민현미</td>
								</tr>
								<tr>
									<th scope="row"> 아이피</th>
									<td></td>
								</tr>
								<tr>
									<th scope="row"> 이메일</th>
									<td>dalkis0313@korea.kr</td>
								</tr>
								<tr>
									<th scope="row"> 주민번호</th>
									<td></td>
								</tr>
								<tr>
									<th scope="row"> 등록일</th>
									<td>13/06/03</td>
								</tr>
								<tr>
									<th scope="row"> 정보 수정일</th>
									<td>0000-00-00 00:00:00</td>
								</tr>
								<tr>
									<th scope="row"> 최근 로그인 일시</th>
									<td>2013-06-03 13:08:38</td>
								</tr>
								<tr>
									<th scope="row"> 최근 로그아웃 일시</th>
									<td>2013-06-03 11:12:58</td>
								</tr>
								<tr>
									<th scope="row"> 접속 회수</th>
									<td>2</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- //오른쪽 목록 -->
				</div>

				<!-- //디렉토리 메뉴 구조 -->
			</div>
			<!-- //detail content -->
		</div>
	</div>
	<hr />
	<div id="footer">
		<address>
			copyright 2013 pps. all rights reserved. <span class="txt_bold">tel: 070-4056-7148</span>
		</address>
	</div>

</div>
</body>
</html>
