<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>


<!-- 상세콘텐츠 영역 -->
<form:form id="agree-form" commandName="complicityAgreeVO" enctype="multipart/form-data" class="ajax-form-submit">
<h2 class="title1">개인정보보호를 위한 이용자 동의사항</h2>
<div class="form-agree">
	<div class="item" tabindex="0">
		개인정보보호를 위한 이용자 동의사항
		개인정보 보호법[제정 2011.3.2. 법률 제10465호]에 따라 아래의 개인정보 수집 및 활용 동의절차를 거치셔야 공모전 접수가 가능합니다.
		<br /><br />
		개인정보
		수집ㆍ이용 목적<br />
		본 공모전을 운영하는 한국여성인권진흥원이 수집한 참가자의 개인정보는 공모 접수에 따른 본인 확인 및 개인식별, 질문 등에 대한 답변처리, 개인별 공지사항 전달, 시상, 경품지급 등의 참가자 관리와 공모전 운영을 위한 용도로만 사용됩니다.
		<br /><br />
		수집하는
		개인정보 항목<br />
		성명, 생년월일, 이메일, 연락처(휴대전화), 주소, 소속
		<br /><br />
		개인정보
		취급업무의 위탁<br />
		성매매방지 국민생각 공모전 홈페이지 유지관리(온라인접수 및 관리)를 위해 아래 회사에 위탁 운영하고 있습니다. <br />
		- 업체명 : 인디엔피 / 개인정보 보호책임자 : 김동우 실장 <br />
		- 주소 : 서울특별시 마포구 망원로 96 6층<br />
		- 대표번호 : 02-741-3382 / 팩스번호 : 02-737-0865<br />
		한국여성인권진흥원은 계약서 등을 통하여 개인정보보호 관련 법규의 준수, 개인정보 이용에 따른 비밀 유지, 위탁기간, 이용 종료 후의 개인정보 반환 또는 파기 의무를 부여하고 있으며 이를 준수하도록 관리하고 있습니다.
		<br /><br />
		개인정보
		수집 방법<br />
		홈페이지를 통한 응모 시에 입력된 개인정보를 통하여 관련 정보를 수집하고 있습니다.
		<br /><br />
		개인정보 보유
		및 이용기간<br />
		개인 정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. <br />
		- 보존사유 : 참가자 및 수상자 관리 <br />
		- 보존기간 : 공모전 종료 후 3개월 이내<br />
		권리개인정보 보호법에 의해 개인정보 수집 동의를 거부할 권리가 있으며, 수집 동의 거부 시에는 공모전 참가 신청이 불가능 합니다.
	</div>
	<p class="box1">
		<span class="form-set form-radio">
			<form:radiobutton path="agree1" value="1" label="동의함" />
		</span>
		
		<span class="form-set form-radio">
			<form:radiobutton path="agree1" value="2" label="동의하지 않음" />
		</span>
	</p>
</div>

<h2 class="title1">제3자 제공에 관한 사항</h2>
<div class="form-agree">
	<div class="item" tabindex="0">
		개인정보를
		제공 받는 자<br />
		한국여성인권진흥원 : 주최기관<br /> 
		1-1. 제3자 정보제공 : 인디엔피
		<br /><br />
		수집하는
		개인정보 항목<br />
		- 수집항목 : 수집 이용에 동의한 항목 중 공모전 운영을 위해 필요한 정보
		<br /><br />
		개인정보의 수집
		및 이용목적<br />
		수집한 개인 정보를 다음의 목적을 위해 활용합니다.<br /> 
		- 접수자 관리, 입상자 선정평가 및 관리, 공모전 운영
		<br /><br />
		개인정보 보유
		및 이용기간<br />
		원칙적으로, 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다.<br /> 
		단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존합니다. <br />
		- 보존 항목 : 성명, 휴대번호, e-mail, 주소<br />
		- 보존 근거 : 접수자 관리, 심사 대상자 선정 시 이메일 발송<br />
		- 보존 기간 : 접수 시부터 공모전 운영 종료 후 3개월까지<br />
		권리개인정보 보호법에 의해 개인정보 수집 동의를 거부할 권리가 있으며, 수집 동의 거부 시에는 공모전 접수가 불가합니다.
	</div>
	<p class="box1">
		<span class="form-set form-radio">
			<form:radiobutton path="agree2" value="1" label="동의함" />
		</span>
		
		<span class="form-set form-radio">
			<form:radiobutton path="agree2" value="2" label="동의하지 않음" />
		</span>
	</p>
</div>

<h2 class="title1">저작권 확인 및 동의</h2>
<div class="form-agree">
	<div class="item" tabindex="0">
		1. 국내외 타 공모전 등에 출품되지 않은 순수 창작품이어야 하며, 표절 작품은 심사에서 제외됨 <br />
		1-1. 수상 이후라도 표절 판명 시 수상 취소 <br />
		2. 지적재산권, 초상권, 명예훼손 등 출품작에 대한 분쟁 발생시 책임은 응모자(제작자)에 있음<br />
		3. 응모작품은 반환하지 않으며, 출품작품의 저작권은 출품자에게 귀속되며 주최사는 입상작에 대하여 성매매방지 홍보 등 공익 목적의 필요한 한도 내에서 복제, 배포, 전시 및 전송 등으로 활용(필요시 재가공) 될 수 있음
	</div>
	<p class="box1">
		<span class="form-set form-radio">
			<form:radiobutton path="agree3" value="1" label="동의함" />
		</span>
		
		<span class="form-set form-radio">
			<form:radiobutton path="agree3" value="2" label="동의하지 않음" />
		</span>
	</p>
</div>

<p class="btns txt-center">
	<a href="#" onclick="$('#agree-form').submit(); return false;" class="btn-l btn1">다음</a>
	<a href="${cutil:getUrl('/complicity/', '', true)}" class="btn-l btn2">취소</a>
</p>
<!-- // -->
</form:form>	          