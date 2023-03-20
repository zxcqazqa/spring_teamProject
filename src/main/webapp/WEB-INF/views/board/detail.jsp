<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../layout/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="container">
	<div class="jumbotron">
		<h1>글상세보기</h1>	
	</div>
	<div class="container form-group">
	<form>
		<table class="table">
			<tr>
				<th>글번호</th>
				<td>${b.bno }</td>
				<th>분류</th>
				<td>
				${b.tid =='notice'?'공지':''}
				${b.tid =='question'?'문의':''}
				${b.tid =='review'?'도서리뷰':''}
				${b.tid =='etc'?'기타':''}
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3">${b.title }</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3"> <textarea rows="10" cols="100" class="form-control" readonly="readonly">${b.content}</textarea> </td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${b.writer}</td>
				<th>작성일</th>
				<td>${b.writeDate }</td>
			</tr>
			<tr>
				<th colspan="3">첨부파일</th>
				<td>
					<c:if test="${empty b.imageFileName}">
						<b>첨부파일이 없습니다.</b>
					</c:if>
					<c:if test="${not empty b.imageFileName and b.fileType eq 'IMAGE'}">
						<img src="${contextPath}/imgDisplay?bno=${b.bno}&imageFileName=${b.imageFileName}">
					</c:if>
					<c:if test="${not empty b.imageFileName and b.fileType eq 'OTHER'}">
						<a href="${contextPath}/download?bno=${b.bno}&imageFileName=${b.imageFileName}">${b.imageFileName}</a> 
					</c:if>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<button class="btn btn-danger delBoard" type="button">삭제</button>
					<a href="${contextPath}/board/modify?bno=${b.bno}" class="btn btn-info">수정</a>
					<a href="${contextPath}/board/list" class="btn btn-info">목록</a>
				</td>
			</tr>		
		</table>
	</form>
	</div>
</div>
</body>
</html>
<%@include file="../layout/footer.jsp" %>

<script>
$(function(){
	$('.delBoard').click(function(){
		let form = $('<form/>')
		form.attr('method','post')
			.attr('action','${contextPath}/board/remove?bno=${b.bno}')
			.appendTo('body')
			.submit();
	})	
})
</script>