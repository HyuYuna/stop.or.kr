<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
	<ul>
		<c:choose>
			<c:when test="${loginInfo.memGroupCd eq 'wiset' }">
			<li>신청폼 업무의 경우, 폼 개발에 디자인-HTML코딩 완료 후 2~3일의 시간이 소요되므로 HTML 파일 컨펌을 기준으로 완료요청일을 지정해 주세요.</li>
			<li>최종 업무 요청 사항이 신청폼(신청페이지)인 경우, 작업 요청 작성 시 점검 항목은 '디자인'이 아닌 '신청폼'으로 선택하여 작성해 주십시오.</li>
			</c:when>
			<c:otherwise></c:otherwise>
		</c:choose>
		
		<li>※ 처리구분?<br>
			* 접수: 업무요청사항 확인 상태<br>
			- 업무 처리 담당자가 배정되어 담당자가 해당 업무를 파악한 상태<br>
			- 정확한 요청사항 파악 및 일정 조율을 위해 담당자간 협의가 진행되는 단계<br>
			* 처리중: 업무 진행 상태<br>
			* 보류: 요청사항 관련 내부 정책 및 처리 방침 검토 단계<br>
			* 완료: 요청사항 완수 단계 (업무요청자의 확인/검토 완료)</li>
	</ul>