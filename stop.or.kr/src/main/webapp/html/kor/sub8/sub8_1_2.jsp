<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header_zoomin.jsp">
	<jsp:param name="snb" value="zoomin1.jsp" />
	<jsp:param name="cont_txt" value="가정폭력" />
	<jsp:param name="path" value="여성폭력 Zoom-in" />
	<jsp:param name="path" value="여성폭력바로알기" />
	<jsp:param name="path" value="스토킹·데이트폭력" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<div class="knowing">
	<article class="group">
		<h2>스토킹과 데이트폭력이란 무엇인가요?</h2>
		<div class="item">
			<h3 class="title1">데이트 폭력이란</h3>
			<p>
				데이트폭력은 데이트관계에서 발생하는 <span class="point1">언어적•정서적•경제적</span>•성적•신체적 폭력을 말합니다.<br />
				헤어지자는 연인의 요청을 거부하거나, 이별하더라도 집요하게 스토킹으로 이어지는 경우도 많은데, 이 역시 명백한 데이트 폭력에 속합니다.
				<br /><br />
				데이트폭력은 아내폭력과 마찬가지로 단 한 번의 폭력으로 끝나지 않고 오랜 기간 폭력에 노출되는 경우가 많습니다. 때리면서도 사랑한다고 말하는 가해자의 반복적 행동은 사랑하기 때문에 때리는 것이고, 집착하는 것이라고 믿게 만듭니다. 그래서 피해자들은 ‘때리는 거 하나만 빼면 참 괜찮은 사람’이라는 생각을 갖고, 이런 믿음은 폭력으로부터 벗어나는데 어려움을 주기도 합니다.
			</p>
			<p class="box1">출처: 한국여성의전화, 데이트폭력 대응을 위한 안내서</p>
			
			<h3 class="title1">스토킹이란</h3>
			<p>
				스토킹이란 상대의 의사에 반하여 지속적 또는 반복적으로 괴롭히는 행위를 말합니다.<br />
				계속 만날 것을 강요하거나, 성관계 사실을 공개, 행동 제한 및 생활공간을 침범하는 행위 등이 있습니다.<br />
				<span class="point3">* 가해자: 데이트 상대>(전)남편/ 아는 사람>모르는 사람</span>
			</p>
			<p class="box1">출처: 손문숙, 2018년 여성폭력 관련시설 종사자 보수교육 교재 발췌</p>
			
			<h3 class="title1">법에서 정의하는 데이트폭력은?</h3>
			<p>데이트 폭력과 관련하여 별도의 법제도가 현재 마련되어 있지 않습니다. 다만 가해자에 대하여 형법, 성폭력처벌법, 경범죄처벌법, 기타 특별 형법에 따른 처벌만 가능합니다.</p>
			
			<h3 class="title1">관련법</h3>
			<ul class="bul1">
				<li><a href="http://www.law.go.kr/%EB%B2%95%EB%A0%B9/%EA%B2%BD%EB%B2%94%EC%A3%84%EC%B2%98%EB%B2%8C%EB%B2%95" target="_blank">경범죄처벌법</a> </li>
			</ul>
		</div>
	</article>
	
	<article class="group">
		<h2>어떤 것이 데이트폭력인가요?</h2>
		<div class="item">
			<div class="chart7">
				<p>데이트관계란 좁게는 데이트 또는 연애를 목적으로 만나고 있거나 만난 적이 있는 관계와 넓게는 맞선, 부킹, 소개팅, 채팅 등을 통해 그 가능성을 인정하고 만나는 관계까지 포괄하며 사귀는 것은 아니나 호감을 갖고 있는 상태, ‘썸 타는 관계’까지 포함합니다.</p>
				
				<h3>데이트폭력</h3>
				
				<ul class="list">
					<li class="type1">
						<p><strong>통제</strong></p>
						<ul class="bul1">
							<li>누구와 함께 있는지 항상 확인</li>
							<li>옷차림을 제한</li>
							<li>내가 하는 일이 자신의 마음에 들지 않으면 그만두게 함</li>
							<li>일정을 통제하고 간섭</li>
							<li>휴대폰, 이메일, SNS 등을 자주 점검</li>
						</ul>
					</li>
					<li class="type2">
						<p><strong>언어적 &middot; 정서적 &middot; 경제적</strong></p>
						<ul class="bul1">
							<li>욕을 하거나 모욕적인 말</li>
							<li>위협을 느낄 정도로 소리 지르기</li>
							<li>안 좋은 일이 있을 때 ‘너 때문이야’라는 말</li>
							<li>나를 괴롭히기 위해 악의에 찬 말</li>
							<li>내가 형편없는 사람이라고 느낄 정도로 비난 </li>
						</ul>
					</li>
					<li class="type3">
						<p><strong>신체적</strong></p>
						<ul class="bul1">
							<li>팔목이나 몸을 힘껏 움켜쥠</li>
							<li>세게 밀침</li>
							<li>팔을 비틀거나 머리채를 잡음</li>
							<li>폭행으로 삐거나 살짝 멍/상처가 생김</li>
							<li>뺨을 때림</li>
						</ul>
					</li>
					<li class="type4">
						<p><strong>성적</strong></p>
						<ul class="bul1">
							<li>나의 의사에 상관없이 가슴/엉덩이/성기를 만짐</li>
							<li>내가 원하지 않는데 몸을 만짐</li>
							<li>내가 원하지 않는데 애무를 함</li>
							<li>나의 기분에 상관없이 키스</li>
							<li>내가 원하지 않는데 섹스를 강요 </li>
						</ul>
					</li>
				</ul>
				
				<p class="box1 type1">출처: 한국여성의전화, 데이트폭력 대응을 위한 안내서</p>
			</div>
		</div>
	</article>
	
	<article class="group">
		<h2>스토킹, 데이트폭력이 발생했을 때, 어떻게 해야 할까요?</h2>
		<div class="item">
			<ul class="chart2">
				<li>
					<img src="../../../images/kor/zoomin/chart2_8.gif" alt="" />
					<p><span>위험신호 알아차리기/ 지지자원 모색하기</span></p>
				</li>
				<li>
					<img src="../../../images/kor/zoomin/chart2_9.gif" alt="" />
					<p><span>증거수집, 폭력의 흔적 남기기</span></p>
				</li>
				<li>
					<img src="../../../images/kor/zoomin/chart2_1.gif" alt="" />
					<p><span>안전한 장소</span></p>
				</li>
			</ul>
			
			<ul class="list3">
				<li>자신을 지지해주고 도와줄 수 있는 사람을 찾아요.</li>
				<li>도움을 요청할 수 있는 상담소에 가서 상담을 받을 수 있어요.</li>
				<li>지금 당장 사법제도를 이용하지 않더라도 나중을 위해서라도 증거를 모아두세요.</li>
				<li>상대방이 폭력(언어적 정서적 성적 신체적)을 행사한 날짜, 시간, 장소, 가해자의 행동, 상황 및 구체적인 피해내용을 6하 원칙에 따라 자세히 기록해 두세요.</li>
				<li>몸에 멍이나 상처가 있는 경우 사진을 찍으세요. 병원에 가서 데이트폭력으로 생긴 상처임을 반드시 밝히고 필요시 상해 진단서를 발급받을 수 있도록 하여 진료기록을 남깁니다. </li>
				<li>폭력의 흔적(상처, 부서진 물건 등)을 찍은 사진, 동영상, 문자나 메일, 통화 및 대화 녹음, 연락기록, 메신저 기록 등을 저장해 두세요.</li>
				<li>CCTV 영상은 삭제될 수도 있으니 빠른 시일 내에 확보해 두는 게 필요해요.</li>
				<li>주변인에게 폭력피해를 호소한 기록도 증거로 사용될 수 있어요.</li>
				<li>안전을 위협하는 상황이라면 반드시 112에 신고하고 상담소에 도움을 청하세요. 상담기록과 신고기록은 피해를 입증하는 증거자료로 활용될 수 있어요.</li>
			</ul>
			
			<p class="box1 type1">출처: 한국여성의전화, 데이트폭력 대응을 위한 안내서</p>
		</div>
	</article>
	
	<article class="group">
		<h2>어떤 지원을 받을 수 있나요? </h2>
		<div class="item">
			<h3 class="title1">스토킹, 데이트폭력 피해자를 위한 어떤 지원제도가 있나요?</h3>
			<div class="table-wrap">
				<table>
					<caption>스토킹, 데이트폭력 피해자 지원제도 - 경찰 112, 여성긴급전화 1366</caption>
					<colgroup>
						<col width="150px">
						<col width="">
					</colgroup>
					<tbody>
						<tr>
							<th scope="row" rowspan="3">경찰 112</th>
							<td class="txt-left">
								<span class="icon4">1</span>
								<span class="point1">긴급상황에서는 112에 신고하고 초동조치를 요구하세요</span>
							</td>
						</tr>
						<tr>
							<td class="txt-left">
								<span class="icon4">2</span>
								<span class="point1">신변에 위협을 느낀다면 경찰에 신변보호조치를 요청하세요</span>
								<p class="txt1">
									신변경호 / 보호시설 연계 / 주거지 순찰 강화 / 112 긴급신변보호대상자등록 / 
									위치추적장치 제공 : 스마트워치(웨어러블기기)지급 / CCTV 설치 / 사후 모니터링 / 신원정보 변경<br />
									<small>&lt;출처 : 경찰청, ‘여성폭력근절 100일 계획 추진’ 보도자료, 2017. 7. 24&gt;</small>
								</p>
							</td>
						</tr>
						<tr>
							<td class="txt-left">
								<span class="icon4">3</span>
								<span class="point1">신변보호조치가 충분하지 않다면, 법원에 접근금지가처분을 신청할 수 있어요.</span>
								<div class="txt1">
									<p class="box1 txt-left">
										접근금지가처분이란?<br />
										특정인으로부터 정서적·신체적 폭력, 모욕적 언사, 주거지나 직장 등으로의 접근, 전화 &middot; 문자 등 연락 및 접촉을 방지
										하여 평온한 사생활을 추구할 권리를 보전하기 위한 법적 절차·인격적 침해금지를 핵심으로 하므로 접근금지가처분 
										결정을 받기 위해서는 특정인으로부터 생활의 안정과 평온을 침해받고 있다는 사실관계를 충분히 소명해야하며, 
										접근금지가처분 위반 시 재산상 강제수단이 사용되거나 형사상 제재를 받을 수 있다. 
									</p>
									<p>
										신변보호조치는 정확한 피해내용, 상해여부, 상습성 등을 검토하여 진행되니, 피해와 관련된 증거자료를 제시하면 경찰의 협조를 이끌어내는 데 도움이 됩니다.<br />
										<small>&lt;출처: 한국여성의전화, 데이트폭력 대응을 위한 안내서&gt;</small>
									</p>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row" rowspan="4">여성긴급전화 1366</th>
							<td class="txt-left point1">
								전화상담 : 국번없이1366
							</td>
						</tr>
						<tr>
							<td class="txt-left">
								<span class="point1">온라인상담 </span>
								<ul class="bul1 txt1">
									<li>여성폭력 사이버 상담(www.women1366.kr) : 실시간 채팅상담, 게시판상담</li>
									<li>카카오톡 플러스친구 ID : 여성폭력 사이버 상담</li>
								</ul>
							</td>
						</tr>
						<tr>
							<td class="txt-left">
								<span class="point1">내방상담(전국 여성긴급전화1366센터)</span>
								<ul class="bul1 txt1">
									<li>365일 24시간 긴급 상담 및 초기지원</li>
									<li>긴급피난처운영 : 30일 이내 긴급보호 (피해자 또는 피해자 동반가족)</li>
									<li>관련 기관 연계 (쉼터, 법류, 의료 등) </li>
								</ul>
							</td>
						</tr>
						<tr>
							<td class="txt-left point1">성폭력상담소 연계: 상담, 법률지원 등</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</article>
	
	<article class="group">
		<h2>데이트폭력 통념깨기 </h2>
		<div class="item">
			<ul class="list4">
				<li class="type1">
					<p class="q">
						<span>당신의 생각은?</span>
						<strong>오죽하면 연애기간에 때릴까? 맞을 짓을 했겠지.</strong>
					</p>
					<p class="a">
						<strong>아닙니다<em>!</em></strong>
						<span>갈등의 이유가 무엇이든 소리를 지르거나 폭력적으로 해결하는 것은 잘못된 방법입니다. 폭력은 어떠한 이유로도 정당화 될 수 없고, 어떠한 폭력도 허용해선 안 됩니다.<br />데이트 폭력 가해자는 폭력을 행사할 수 밖에 없는 원인을 피해자에게 돌리기 때문에 피해자는 ‘나만 잘 하면 가해자가, 관계가 달라질 수 있다’고 생각하게끔 만들고 폭력이 지속되게 합니다.</span>
					</p>
				</li>
				<li class="type1">
					<p class="q">
						<span>당신의 생각은?</span>
						<strong>때리지만 않으면 정말 괜찮은 사람인데요.</strong>
					</p>
					<p class="a">
						<strong>아닙니다<em>!</em></strong>
						<span>싸울 때마다 애인이 폭력을 행사하는 게 습관이 되지 않도록, 더 이상 폭력이 일어나지 않도록 단호하게 대해야 합니다. 사랑이라고 말하지만 폭력을 쓴다면 그것은 사랑이 아니라 폭력입니다. </span>
					</p>
				</li>
				<li class="type2">
					<p class="q">
						<span>당신의 생각은?</span>
						<strong>그래도 좋으니까 계속 만나는 거겠지! </strong>
					</p>
					<p class="a">
						<strong>아닙니다<em>!</em></strong>
						<span>데이트폭력을 사소한 문제로 보는 시선, 심리사회적 고립, 일상화된 폭력 등이 적극적 대항을 어렵게 하기 때문입니다. 이것이 친밀한 관계의 폭력이 가진 특징입니다. 헤어진 이후 보복에 대한 두려움으로 인해 이별을 통보하지 못하는 경우도 많습니다. 데이트폭력 피해자는 ‘좋게 헤어지는 것’이 가능하다고 믿거나 두려움으로 스스로를 자책하면서 관계를 지속하게 되므로 주변의 지지와 도움이 필요합니다.</span>
					</p>
				</li>
			</ul>
		</div>
	</article>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>