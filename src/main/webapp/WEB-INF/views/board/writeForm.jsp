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
		<h1>글쓰기</h1>	
	</div>
	<div class="container">
		<form action="${contextPath }/board/write" method="post" enctype="multipart/form-data">
			<div class="form-group row">
				<div class="col-9">
				제목 : <input type="text" class="form-control" name="title">
				</div>
				<div class="col-3">
					<div>
				  분류 :<select name="tid" class="">		
							<option value="notice">공지사항</option>
							<option value="question">문의</option>
							<option value="review">도서리뷰</option>
							<option value="etc">기타</option>
						</select>
					</div>
					<div class="form-check">
					  <label class="form-check-label">
					    <input type="checkbox" class="form-check-input" value="">배송
					  </label>
					  <label class="form-check-label">
					    <input type="checkbox" class="form-check-input" value="">교환/환불
					  </label>
					</div>
				</div>
			</div>
			<div class="form-group">
				내용 : <textarea rows="10" class="form-control" name="content"></textarea>
			</div>
			<div class="form-group">
				작성자 : <input type="text" class="form-control" name="writer" >
			</div>
			<div class="form-group">
				첨부파일 : <input type="file" class="form-control" name="attachFile">
			</div>
			<button class="btn btn-primary">글작성하기</button>
		</form>
	</div>
	<div class="preview"></div>
</div>
</body>
</html>
<%@include file="../layout/footer.jsp" %>