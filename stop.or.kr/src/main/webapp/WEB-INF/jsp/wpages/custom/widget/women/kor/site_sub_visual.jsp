<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<!-- 뎁스마다 spot4 넘버 변경해주세여 spot1, spot2 이로케 -->
<div id="spot" class="spot${path.get(0).menu_ord}">
	<strong>${nowMenuVO.menu_nm}</strong>
	<p>여성폭력 예방과 근절, 폭력 피해자에 대한 지원을 위해 <br />전문성과 경험을 바탕으로 최선을 다할 것입니다.</p>
</div>