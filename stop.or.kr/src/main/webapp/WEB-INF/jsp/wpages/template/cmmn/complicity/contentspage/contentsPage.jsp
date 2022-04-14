<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/egov_elfunc.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!--   ## TPCODE : TPAGE0020: 컨텐츠 페이지 ## --> 

<form name="reqForm" method="post">
	
	<div id="detail_content">
		<div id="divUcont_cont">
			${elfunc:removeScrtag(contentsmanVO.ucont_cont)}
		</div>
	</div>

</form>
