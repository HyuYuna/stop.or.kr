<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb3.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="정보공개" />
	<jsp:param name="path" value="경영공시" />
	<jsp:param name="path" value="정보공개목록" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<ul class="tabmenu">
	<li><a href="sub3_2.jsp">정보공개 제도</a></li>
	<li><a href="sub3_2_1_2.jsp">정보공개 제도 주요내용</a></li>
	<li><a href="sub3_2_1_3.jsp">정보공개 청구 절차</a></li>
	<li class="active"><a href="sub3_2_1_4.jsp">불복구제 절차 및 방법</a></li>
	<li><a href="sub3_2_1_5.jsp">비공개 대상 세부기준</a></li>
</ul>

<h2 class="title1">불복 구제 절차 및 방법</h2>

<div class="table-wrap board-write txt-left">
	<table>
		<caption>불복 구제 절차 및 방법 - 이의 신청, 행정심판, 행정소송</caption>
		<colgroup>
			<col width="20%" />
			<col />
		</colgroup>
		<tbody>
		<tr>
			<th scope="row">01. 이의 신청</th>
			<td class="txt-left">
				<ul class="bul1">
					<li>
						<em class="point1">청구인의 이의신청</em>
						<div>
							<ul>
								<li>청구인은 공공기관의 비공개 또는 부분공개결정에 대하여 불복이 있는 때에는 공개여부의 결정통지를 받은 날 또는 비공개의 결정이 있는 것으로 보는 날부터 "30일" 이내에 공공기관에 이의신청을 할 수 있습니다. </li>
							</ul>
						</div>
					</li>
					<li>
						<em class="point1">이의신청방법</em>
						<div>
							<ul>
								<li>이의신청서를 작성하여 제출하면 됩니다. (인터넷으로도 가능)</li>
								<li>신청인의 이름 · 주소 및 연락처, 정보공개여부결정의 내용, 이의신청의 취지 및 이유 등을 기재합니다.</li>
							</ul>
						</div>
					</li>
					<li>
						<em class="point1">이의신청에 대한 결정</em>
						<div>
							<ul>
								<li>공공기관은 이의신청을 받은 날부터 "7일" 이내에 결정하여야 하며, 부득이한 경우 7일 이내의 범위에서 결정기간을 연장할 수 있습니다.</li>
								<li>각하 또는 기각결정을 하는 경우 행정심판 또는 행정소송을 제기할 수 있으며, 공공기관은 이를 고지하여야 합니다.</li>
							</ul>
						</div>
					</li>
					<li>
						<em class="point1">제3자의 이의신청 및 권리보호</em>
						<div>
							<ul>
								<li>제3자로부터 비공개요청을 받은 공공기관이 공개결정을 하는 경우 제3자는 공개통지를 받은 날부터 "7일" 이내에 공공기관에 이의신청을 할 수 있습니다.</li>
								<li>이 경우 공공기관은 공개결정일과 공개실시일 사이에 최소한 30일의 간격을 두어야 하며, 제3자는 이 기간 내에 행정심판 소송제기와 동시에 집행정지를 신청하여 공개실시에 대항할 수 있습니다.</li>
							</ul>
						</div>
					</li>
				</ul>	
			</td>
		</tr>
		<tr class="even">
			<th scope="row">02. 행정심판</th>
			<td class="txt-left">
				<ul class="bul1">
					<li>
						<em class="point1">심판청구</em>
						<div>
							<ul>
								<li>청구인이 정보공개와 관련한 공공기관의 결정에 대하여 불복이 있는 때에는 이의신청절차를 거치지 아니하고 청구할 수 있습니다.</li>
								<li>심판청구서는 피청구인인 행정청 또는 위원회에 제출하여야 합니다.</li>
								<li>다만, 국가기관이나 지방자치단체 외의 공공기관의 결정에 대한 감독행정기관은 관계 중앙행정기관의 장이나 지방자치단체의 장으로 하게 됩니다.</li>
							</ul>
						</div>
					</li>
					<li>
						<em class="point1">심판청구기간</em>
						<div>
							<ul>
								<li>정보공개와 관련한 공공기관의 결정이 있음을 안 날부터 "90일" 이내에 제기하여야 합니다.</li>
								<li>정당한 사유가 없는 한 공공기관의 결정이 있는 날부터 "180일"을 넘겨서는 아니됩니다.</li>
							</ul>
						</div>
					</li>
					<li>
						<em class="point1">재결</em>
						<div>
							<ul>
								<li>재결은 피청구인인 행정청 또는 위원회가 심판청구서를 받은 날부터 "60일" 이내에 하여야 하며, 부득이한 사정이 있는 때에는 1차에 한하여 "30일"의 범위내에서 기간을 연장할 수 있습니다.</li>
							</ul>
						</div>
					</li>
				</ul>	
			</td>
		</tr>
		<tr>
			<th scope="row">03. 행정소송</th>
			<td class="txt-left">
				<ul class="bul1">
					<li>
						<em class="point1">소송제기</em>
						<div>
							<ul>
								<li>청구인이 정보공개와 관련한 공공기관의 결정에 대하여 불복이 있는 때에는 이의신청 · <br>행정심판절차를 거치지 아니하고 행정소송법이 정하는 바에 따라 행정소송을 제기할 수 있습니다.</li>
							</ul>
						</div>
					</li>
					<li>
						<em class="point1">제소기간</em>
						<div>
							<ul>
								<li>공공기관의 결정이 있은 날 또는 행정심판을 거친 경우 재결서 정본의 송달을 받은 날부터 90일 이내에 제기하여야 합니다.</li>
								<li>공공기관의 결정이 있은 날 또는 재결이 있은 날부터 1년이 지나면 제기할 수 없습니다.</li>
							</ul>
						</div>
					</li>
				</ul>	
			</td>
		</tr>
	</tbody>
	</table>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>