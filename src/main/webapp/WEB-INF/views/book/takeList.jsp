<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../layout/header.jsp" %>
    <%@include file="modal.jsp" %>
    <script src="${contextPath }/resources/js/takeList.js"></script>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
	<div class="jumbotron">
		<h2>대여하기</h2>
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
					<a href="${contextPath }/book/takeList">도서대여 현황</a>
				</li>
			</ul>
		</div>
		<div class="col-9">
			<div class="my-3">
				<form class="form-inline searchForm">
					<select name="type" class="form-control mr-2 cate">
						<option>선택해주세요</option>
						<option value="BN" ${cri.type == 'BN' ? 'selected':''}>책제목</option>
						<option value="AT" ${cri.type == 'AT' ? 'selected':''}>저자</option>
						<option value="PS" ${cri.type == 'PS' ? 'selected':''}>출판사</option>	
						<option value="TR" ${cri.type == 'TR' ? 'selected':''}>대여상태</option>		
					</select>
					<div class="form-group mr-2">
						<input type="search" class="form-control" name="keyword" value="${cri.keyword}">
					</div>
					<div class="form-group mr-2">
						<button class="btn btn-primary">검색</button>
					</div>
					<div class="form-group mr-2">
						<a href="${contextPath}/book/takeList"  class="btn btn-info">새로고침</a>
					</div>
				</form>		
			</div>
			<div>
				<table class="table">
					<tr>
						<th>책번호</th>
						<th>분류</th>
						<th>제목</th>
						<th>저자</th>
						<th>출판사</th>
						<th>대여여부</th>
					</tr>
					<c:forEach items="${takeList }" var="t">
					<tr>
						<td>${t.bookNo }</td>
						<td>${t.cate_id }</td>
						<td>${t.bookName }</td>
						<td>${t.author }</td>
						<td>${t.publisher }</td>
						<td>
							<c:if test="${empty mvo}">
								로그인하세요
							</c:if>
							<c:if test="${!empty mvo}">
								<a href="${t.bookName }" class="${t.take =='대여'? 'btn btn-info':
																t.take =='신청대기'? 'btn btn-warning':
																t.take =='대여중'? 'btn btn-success':
																t.take =='거절'? 'btn btn-danger':''} thisTitle" 
																data-target="#addTake" id="${t.take }" title="${t.reason }" target="${t.returnDate }">${t.take }</a>
								<input type="hidden" class="take" id="take" value="${t.take }"> 
								<input type="hidden" class="returnDate" value="${t.returnDate }">
								<input type="hidden" class="takePrice" value="${t.takePrice }">	
								<input type="hidden" name="bookNo" value="${t.bookNo }">
							</c:if>						
						</td>
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
	</div>
</div>




</body>
</html>
<%@ include file="../layout/footer.jsp" %>
<script>



</script>