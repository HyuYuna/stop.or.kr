<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="../include/sub_header.jsp">	
	<jsp:param name="snb" value="snb2.jsp" />
	<jsp:param name="tabmenu" value="" />
	<jsp:param name="path" value="알림마당" />
	<jsp:param name="path" value="공지/공고" />
	<jsp:param name="path" value="공지사항" />
</jsp:include>
	        
<!-- 상세콘텐츠 영역 -->
<ul class="tabmenu">
	<li class="active"><a href="sub4_2.jsp">공지사항</a></li>
	<li><a href="sub4_2_2.jsp">사업/입찰공고</a></li>
	<li><a href="sub4_2_3.jsp">채용공고</a></li>
	<li><a href="sub4_2_4.jsp">현장기관 채용공고</a></li>
</ul>

<div class="table-wrap board-write">
	<table>
		<caption>글쓰기 - 제목, 요약글, 첨부파일</caption>
		<colgroup>
			<col class="part" />
			<col />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><label for="subject">제목</label></th>
				<td class="txt-left"><input id="subject" type="text"></td>
			</tr>
			<tr>
				<th scope="row"><label for="summary">요약글</label></th>
				<td class="txt-left"><textarea id="summary"></textarea></td>
			</tr>
			<tr>
				<td colspan="2">에디터</td>
			</tr>
			<tr class="download-list">
				<th scope="row" rowspan="2">첨부파일</th>
				<td class="txt-left">
					<a href="#"><i class="xi-attachment icon-pdf"><span class="sr-only">파일다운로드</span></i> 게시글 첨부파일.pdf</a>
					<a href="" class="del">첨부 삭제</a>
				</td>
			</tr>
			<tr class="download-list">
				<td class="txt-left">
					<a href="#"><i class="xi-attachment"><span class="sr-only">파일다운로드</span></i> 게시글 첨부파일.pdf</a>
					<a href="" class="del">첨부 삭제</a>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<!-- // -->
	          
<jsp:include page="../include/sub_footer.jsp"></jsp:include>