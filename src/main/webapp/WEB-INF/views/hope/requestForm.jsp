<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.list {list-style-type:square;}
.list li{ font-size: 1.5rem;}
</style>
</head>
<body>
<div class="container">
	<div class="jumbotron">
		<h2>신청란</h2>
	</div>
	<div class="row">
		<div class="col-3">
			<ul class="list-group">
				<li class="list-group-item">
					<a href="${contextPath}/hope/requestList">비치희망도서 신청현황</a>
				</li>
				<li class="list-group-item">
					<a href="${contextPath }/hope/requestForm">비치희망도서 신청하기</a>
				</li>
				<li class="list-group-item">
					<a href="${contextPath }/hope/requestMaster">도서신청/대여관리(관리자용)</a>
				</li>
				<li class="list-group-item">
					<a href="${contextPath }/book/takeList">도서대여 현황 및 신청</a>
				</li>
			</ul>
		</div>
		<div class="col-9">
		<div>
			<h2>비치희망도서 신청시에..</h2>
			<ul class="list">
				<li>신청이 불가한 서적 공지</li>
				<li>신청후 입고까지 대략적으로 걸리는 기간</li>
				<li>주의사항 기타</li>
				<li>==========================================</li>
			</ul>
		</div>
		<button data-toggle="collapse" data-target="#demo" class="btn btn-info mb-3">신청하기</button>
		<div id="demo" class="collapse mt-5">
			<form action="${contextPath }/hope/request" method="post">
				<table class="table">

					<tr>
						<th>
							<div class="input-group mb-3">
							    <div class="input-group-prepend">
									<span class="input-group-text">번호</span>
									<input type="text" class="form-control" value="${rno }" readonly="readonly">
							    </div>
							    <div class="input-group-prepend">
							   		<span class="input-group-text">신청인 아이디</span>
							    	<input type="text" class="form-control" placeholder="아이디" name="id" value="${mvo.id}" readonly="readonly">
							  	</div>
							</div>
						</th>
					</tr>
				
					<tr>
						<th>
							<div class="input-group mb-3">
							    <div class="input-group-prepend">
									<span class="input-group-text">책제목</span>
									<input type="text" class="form-control" placeholder="제목" name="nbookName">
							    </div>
						
							    <div class="input-group-prepend">
							   		<span class="input-group-text">책 저자</span>
							    	<input type="text" class="form-control" placeholder="글쓴이" name="nbookWriter">
							  	</div>
							</div>
						</th>
					</tr>
					<tr>
						<th>
						  <div class="input-group mb-3">
						    <div class="input-group-prepend">
						    	<span class="input-group-text">출판사</span>
						   		<input type="text" class="form-control" placeholder="출판사" name="npublisher">
						    </div>
						    <div class="input-group-prepend">
						    	<span class="input-group-text">신청일</span>
						   		<input type="text" class="form-control" placeholder="승인대기" name="result" readonly="readonly">
						    </div>
						  </div>
						  </th>
					</tr>
					<tr>
						<th>
						  <div class="input-group mb-3">
						    <div class="input-group-prepend">
						    	<span class="input-group-text">회원번호</span>
						   		<input type="text" class="form-control" placeholder="" name="mno" value="${mvo.mno}" readonly="readonly">
						    </div>
						    <div class="input-group-prepend">
						    	<span class="input-group-text">회원이름</span>
						   		<input type="text" class="form-control" placeholder="" name="name" value="${mvo.name}" readonly="readonly">
						    </div>
						  </div>
						  </th>
					</tr>
					<tr></tr>
				  </table>
			 <button class="btn btn-info mb-3">접수</button>
			</form>
		</div>
		</div>
	</div>
</div>

</body>
</html>
<%@ include file="../layout/footer.jsp" %>
<script>

</script>
