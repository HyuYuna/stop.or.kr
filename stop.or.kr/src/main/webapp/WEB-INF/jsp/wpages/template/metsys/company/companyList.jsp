<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld"%>

사용자페이지에서 첨부파일 다운로드 시,레이어팝업으로 물어본 정보에 관한 엑셀다운로드
<br/>
<br/>
<br/>
<a href="javascript:cmmfn_download_xlsfile('${pageContext.request.contextPath}', '/mancompany/xlsCompanyList.do?srch_menu_nix=${param.srch_menu_nix}')"  class="btn_line">XLS</a> 