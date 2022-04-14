<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header_zoomin.jsp">
	<jsp:param name="snb" value="zoomin.jsp" />
	<jsp:param name="cont_txt" value="5월 한달, 여성폭력 피해지원 현황" />
	<jsp:param name="path" value="여성폭력 Zoom-in" />
	<jsp:param name="path" value="여성폭력동향" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<h3 class="title1">본 원에서 중앙지원단·중앙지원센터 사업으로 운영하고 있는 여성긴급전화1366(18), 해바라기센터(38),성매매방지시설(95)의 통계</h3>
<div class="table-wrap"><table>
	<caption>구분, 총계, 피해유형(성폭력, 가정폭력, 성매매, 데이트폭력, 스토킹, 디지털성범죄, 기타)</caption>
	<thead>
		<tr>
		  <th scope="col" colspan="2" rowspan="2"> 구분 </th>
		  <th scope="col" rowspan="2"> 총계 </th>
		  <th scope="col" colspan="7">피해유형</th>
		</tr>
		<tr>
		  <th scope="col"> 성폭력 </th>
		  <th scope="col"> 가정폭력 </th>
		  <th scope="col"> 성매매 </th>
		  <th scope="col"> 데이트폭력 </th>
		  <th scope="col"> 스토킹 </th>
		  <th scope="col"> 디지털성범죄 </th>
		  <th scope="col"> 기타 </th>
		</tr>
	</thead>
	<tbody>
		<tr>
		  <td rowspan="2" class="txt2">여성긴급전화 <br />1366</td>
		  <td class="point1">지원(건)</td>
		  <td><p class="point6">216,032</p>(100%)</td>
		  <td><p class="point1">17,165</p>(7.9%)</td>
		  <td><p class="point1">120,587</p>(55.8%)</td>
		  <td><p class="point1">1,855</p>(0.9%)</td>
		  <td><p class="point1">8,698</p>(4%)</td>
		  <td><p class="point1">552</p>(0.3%)</td>
		  <td><p class="point1">1,204</p>(0.6%)</td>
		  <td><p class="point1">65,971</p>(30.5%)</td>
		</tr>
		<tr>
		  <td class="point1">상담(건)</td>
		  <td><p class="point6">176,684</p>(100%)</td>
		  <td><p class="point1">13,354</p>(7.6%)</td>
		  <td><p class="point1">92,040</p>(52.1%)</td>
		  <td><p class="point1">1,585</p>(0.9%)</td>
		  <td><p class="point1">6,303</p>(3.6%)</td>
		  <td><p class="point1">411</p>(0.2%)</td>
		  <td><p class="point1">863</p>(0.5%)</td>
		  <td><p class="point1">62,128</p>(35.2%)</td>
		</tr>
		<tr>
		  <td rowspan="2" class="txt2"> 해바라기센터 </td>
		  <td class="point1">지원(건)</td>
		  <td><p class="point7">192,679</p>(100%) </td>
		  <td><p class="point1">163,711</p>(85.0%) </td>
		  <td><p class="point1">17,108</p>(8.9%) </td>
		  <td><p class="point1">735</p>(0.4%) </td>
		  <td> - </td>
		  <td> - </td>
		  <td><p class="point1">4,594</p>(2.4%) </td>
		  <td><p class="point1">6,531</p>(3.4%) </td>
		</tr>
		<tr>
		  <td class="point1"> 이용자(명) </td>
		  <td><p class="point7">14,209</p>(100%) </td>
		  <td><p class="point1">10,222</p>(71.9%) </td>
		  <td><p class="point1">2,130</p>(15.0%) </td>
		  <td><p class="point1">86</p>(0.6%) </td>
		  <td> *</td>
		  <td> - </td>
		  <td><p class="point1">416</p>(2.9%) </td>
		  <td><p class="point1">1,355</p>(9.5%) </td>
		</tr>
		<tr>
		  <td rowspan="2" class="txt2"> 성매매<br />
		    방지시설 </td>
		  <td class="point1">지원(건)</td>
		  <td><p class="point8">62,329</p>(100%) </td>
		  <td> - </td>
		  <td> - </td>
		  <td><p class="point1">62,329</p>(100%) </td>
		  <td> - </td>
		  <td> - </td>
		  <td> - </td>
		  <td> - </td>
		</tr>
		<tr>
		  <td class="point1"> 이용자(명) </td>
		  <td><p class="point8">4,657</p>(100%)</td>
		  <td> - </td>
		  <td> - </td>
		  <td><p class="point1">4,657</p>(100%) </td>
		  <td> - </td>
		  <td> - </td>
		  <td> - </td>
		  <td> - </td>
		</tr>
		<tr>
		  <td class="point1" rowspan="2">1366 중앙센터</td>
		  <td class="point1">지원(건)</td>
		  <td><p class="point9">30,278</p>(100%)</td>
		  <td><p class="point1">4,480</p>(14.8%)</td>
		  <td><p class="point1">13,900</p>(45.9%)</td>
		  <td><p class="point1">260</p>(0.9%)</td>
		  <td><p class="point1">2,814</p>(9.3%)</td>
		  <td><p class="point1">175</p>(0.6%)</td>
		  <td><p class="point1">542</p>(1.8%)</td>
		  <td><p class="point1">8,107</p>(26.8%)</td>
		</tr>
		<tr>
		  <td class="point1">상담(건)</td>
		  <td><p class="point9">25,228</p>(100%)</td>
		  <td><p class="point1">3,590</p>(14.2%)</td>
		  <td><p class="point1">10,949</p>(43.4%)</td>
		  <td><p class="point1">233</p>(0.9%)</td>
		  <td><p class="point1">2,099</p>(8.3%)</td>
		  <td><p class="point1">133</p>(0.5%)</td>
		  <td><p class="point1">390</p>(1.5%)</td>
		  <td><p class="point1">7,834</p>(31.1%)</td>
		</tr>
	</tbody>
	</table>
</div>
	
<h3 class="title1">본 원이 직접 지원하는 센터의 통계</h3>
<div class="table-wrap point1"><table>
<caption>직장내 성희롱 성폭력 신고센터, 디지털성범죄 피해자 지원센터</caption>
	<colgroup>
		<col width="150px" />
		<col />
		<col />
		<col />
		<col />
		<col width="150px" />
		<col />
		<col />
		<col />
		<col />
	</colgroup>
	<tbody>
	<tr>
	  <th scope="row" rowspan="6" class="txt2"> 직장내<br />
	    성희롱성폭력<br />
	    신고센터</th>
	  <td rowspan="2"> 이용자(명) </td>
	  <td class="bg"> 계 </td>
	  <td class="bg"> 신고</td>
	  <td class="bg"> 비신고 </td>
	  <td class="bg">&nbsp;</td>
	  <td class="bg">&nbsp;</td>
	  <td class="bg">&nbsp;</td>
	  <td class="bg">&nbsp;</td>
	  <td class="bg">&nbsp;</td>
	  </tr>
	<tr>
	  <td><span class="point9">1,048</span>(100%) </td>
	  <td>262(25.0%) </td>
	  <td>786(75.0 %) </td>
	  <td>&nbsp;</td>
	  <td>&nbsp;</td>
	  <td>&nbsp;</td>
	  <td>&nbsp;</td>
	  <td>&nbsp;</td>
	  </tr>
	<tr>
	  <td rowspan="2"> 피해유형(건) </td>
	  <td class="bg"> 계 </td>
	  <td class="bg">성희롱 </td>
	  <td class="bg">성폭력 </td>
	  <td class="bg">2차 피해</td>
	  <td class="bg">기타</td>
	  <td class="bg">&nbsp;</td>
	  <td class="bg">&nbsp;</td>
	  <td class="bg">&nbsp;</td>
      </tr>
	<tr>
	  <td><span class="point9">1,638</span>(100%) </td>
	  <td>356 (21.7%)</td>
	  <td>443(27.0 %) </td>
	  <td>204(12.5%) </td>
	  <td>635(38.8%)</td>
	  <td>&nbsp;</td>
	  <td>&nbsp;</td>
	  <td>&nbsp;</td>
      </tr>
	<tr>
	  <td rowspan="2">지원(건)</td>
	  <td class="bg"> 계 </td>
	  <td class="bg"> 상담</td>
	  <td class="bg">법률</td>
	  <td class="bg"> 의료</td>
	  <td class="bg"> 기타 </td>
	  <td class="bg">&nbsp;</td>
	  <td class="bg">&nbsp;</td>
	  <td class="bg">&nbsp;</td>
      </tr>
	<tr>
	  <td><span class="point9">2,203</span>(100%) </td>
	  <td>2022(91.8%)</td>
	  <td>73(3.3%) </td>
	  <td>14(0.6%) </td>
	  <td>94(4.3%) </td>
	  <td>&nbsp;</td>
	  <td>&nbsp;</td>
	  <td>&nbsp;</td>
      </tr>
	<tr>
	  <th scope="row" rowspan="5" class="txt2"> 디지털성범죄 <br />
	    피해자지원센터</th>
	  <td> 이용자(명) </td>
	  <td colspan="8"><span class="point9">631 </span>     </td>
      </tr>
	<tr>
	  <td rowspan="2"> 피해유형(건) </td>
	  <td class="bg"> 계 </td>
	  <td class="bg"> 유포 </td>
	  <td class="bg"> 불법촬영 </td>
	  <td class="bg"> 사이버
	    괴롭힘 </td>
	  <td class="bg"> 몸캠 및 해킹</td>
	  <td class="bg"> 유포불안 </td>
	  <td class="bg"> 기타 </td>
	  <td class="bg">&nbsp;</td>
	  </tr>
	<tr>
	  <td><span class="point9">1,295</span>(100%) </td>
	  <td>585(45.2%) </td>
	  <td>444(34.3%) </td>
	  <td>47(3.6%) </td>
	  <td>22(1.7%) </td>
	  <td>12(0.9%) </td>
	  <td>185(14.3%) </td>
	  <td>&nbsp;</td>
	  </tr>
	<tr>
	  <td rowspan="2">지원(건)</td>
	  <td class="bg"> 계 </td>
	  <td class="bg"> 상담지원 </td>
	  <td class="bg"> 삭제지원 </td>
	  <td class="bg"> 수사 및 법률지원 </td>
	  <td class="bg"> 심리치료 연계 </td>
	  <td class="bg">&nbsp;</td>
	  <td class="bg">&nbsp;</td>
	  <td class="bg">&nbsp;</td>
	  </tr>
	<tr>
	  <td><span class="point9">4,170</span>(100%) </td>
	  <td>1,138(27.3%) </td>
	  <td>3,014(72.3%) </td>
	  <td> 8(0.2%) </td>
	  <td>10(0.2%) </td>
	  <td>&nbsp;</td>
	  <td>&nbsp;</td>
	  <td>&nbsp;</td>
	  </tr>
	
    <tr>
      <th scope="row" rowspan="4" class="txt2">1366 중앙센터 <br />사이버상담</th>
      <td rowspan="2">채널유형(건)</td>
      <td class="bg"> 계 </td>
      <td class="bg"> 채팅
        사이트 </td>
      <td class="bg"> 카카오톡 </td>
      <td class="bg"> 게시판 </td>
      <td class="bg"> 이메일 </td>
      <td class="bg"> 기타 </td>
      <td class="bg">&nbsp;</td>
      <td class="bg">&nbsp;</td>
      </tr>
    <tr>
      <td><span class="point9">5,148</span>(100%) </td>
      <td>3,398(66.0%) </td>
      <td>1,071(20.8%) </td>
      <td>426(8.3%) </td>
      <td>17(0.3%) </td>
      <td>236(4.6%)</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      </tr>
    <tr>
      <td rowspan="2">피해유형(건)</td>
      <td class="bg"> 계 </td>
      <td class="bg"> 성폭력 </td>
      <td class="bg"> 가정폭력 </td>
      <td class="bg"> 성매매 </td>
      <td class="bg"> 데이트
        폭력 </td>
      <td class="bg"> 스토킹 </td>
      <td class="bg">디지털
        성범죄 </td>
      <td class="bg"> 기타 </td>
    </tr>
    <tr>
      <td><span class="point9">5,148</span>(100%) </td>
      <td>1,309(25.4%)</td>
      <td>2,063(40.1%)</td>
      <td>68(1.3%)</td>
      <td>1,149(22.3%)</td>
      <td>53(1.0%)</td>
      <td>238(4.6%)</td>
      <td>268(5.2%)</td>
    </tr>
    </tbody>
  </table>
	</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>