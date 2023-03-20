<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
	<div class="jumbotron">
		<h1 class="title">비치희망도서 신청현황</h1>
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
			<div class="my-3">
				<form class="form-inline searchForm">
					<select name="type" class="form-control mr-2 cate">
						<option>선택해주세요</option>
						<option value="ID" ${cri.type == 'ID' ? 'selected':''}>아이디</option>
						<option value="BN" ${cri.type == 'BN' ? 'selected':''}>책제목</option>
						<option value="BW" ${cri.type == 'BW' ? 'selected':''}>책저자</option>			
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
			<div class="container">
				<table class="table text-center">
					<tr>
						<th>신청번호</th>
						<th>책제목</th>
						<th>저자</th>
						<th>출판사</th>
						<th>신청인</th>
						<th>결과</th>
						<th>비고</th>
					</tr>
					<c:forEach items="${requestList }" var="r">
					<tr>
						<td>${r.rno }</td>
						<td>${r.nbookName }</td>
						<td>${r.nbookWriter }</td>
						<td>${r.npublisher }</td>
						<td>${r.id }</td>
						<td>
							<p class="${r.result=='승인'? 'bg-info':
									 r.result=='승인대기'? 'bg-secondary':
									 r.result=='거절'? 'bg-danger': ''} text-light text-center">${r.result }</p>
						</td>
						<th>${r.etc }</th>
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
$(function(){
	let typeValue = getSearchParam('type');
	let keywordValue = getSearchParam('keyword');

	//페이징처리
	$('.pagination a').on('click',function(e){
		e.preventDefault();
		let pageForm = $('<form>');
		pageForm.empty();
		
		pageForm.attr('method','get')
			.attr('action',`${contextPath}/hope/requestList`)
			.append(getInputHiddenTag('page',$(this).attr('href')))
		if(typeValue !=null && keywordValue != null){
			pageForm.append(getInputHiddenTag('type',typeValue))
				.append(getInputHiddenTag('keyword',keywordValue))
		}
		pageForm.appendTo('body')
			.submit();

	});	//페이징처리

})
</script>
