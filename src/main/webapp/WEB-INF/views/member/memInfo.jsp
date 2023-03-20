<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../layout/header.jsp" %>
    <%@include file="../layout/adminMenu.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
	<div class="jumbotron">
		<h2>회원관리</h2>
	</div>
	<div class="contatiner">
		<div class="my-3">
				<form class="form-inline searchForm">
					<select name="type" class="form-control mr-2 cate">
						<option>선택해주세요</option>
						<option value="N" ${cri.type == 'N' ? 'selected':''}>이름</option>
						<option value="G" ${cri.type == 'G' ? 'selected':''}>성별</option>
						<option value="ID" ${cri.type == 'ID' ? 'selected':''}>아이디</option>			
					</select>
					<div class="form-group mr-2">
						<input type="search" class="form-control" name="keyword" value="${cri.keyword}">
					</div>
					<div class="form-group mr-2">
						<button class="btn btn-primary">검색</button>
					</div>
					<div class="form-group mr-2">
						<a href="${contextPath}/hope/requestList"  class="btn btn-info">새로고침</a>
					</div>
				</form>		
			</div>
		<table class="table">
			<tr>
				<th>프로필</th>			
				<th>회원번호</th>
				<th>아이디</th>
				<th>이메일</th>
				<th>이름</th>
				<th>성별</th>	
			</tr>
			<c:forEach items="${memInfo }" var="m">
			<tr>
				<td>${m.profile }</td>
				<td>${m.mno }</td>
				<td>${m.id }</td>
				<td>${m.email }</td>
				<td>${m.name }</td>
				<td>${m.gender }</td>
			</tr>
			</c:forEach>	
		</table>
		<ul class="pagination">
			<c:if test="${p.prev}">
				<li class="page-item">
					<a class="page-link" href="${p.startPage-1}">이전</a>
				</li>
			</c:if>
			<c:forEach begin="${p.startPage }" end="${p.endPage}" var="pageNum">
				<li class="page-item ${cri.page == pageNum ? 'active':''}">
					<a class="page-link" href="${pageNum}">${pageNum}</a>
				</li>		
			</c:forEach>
			<c:if test="${p.next}">
				<li class="page-item">
					<a class="page-link" href="${p.endPage+1 }">다음</a>
				</li>		
			</c:if>
		</ul>					
		
	</div>
</div>
</body>
</html>
<%@include file="../layout/footer.jsp" %>