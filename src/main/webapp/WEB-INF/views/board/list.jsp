<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>

<input type="hidden" value="${tid}" class="tid">
<div class="container">
	<div class="jumbotron">
		<h1 class="title">전체게시판</h1>
	</div>
	<div class="row">
		<div class="col-3">
			<ul class="list-group">
				<li class="list-group-item">
					<a href="${contextPath}/board/list">전체</a>
				</li>
				<li class="list-group-item">
					<a href="${contextPath}/board/list/notice">공지사항</a>
				</li>
				<li class="list-group-item">
					<a href="${contextPath}/board/list/review">도서리뷰</a>
				</li>
				<li class="list-group-item">
					<a href="${contextPath}/board/list/question">문의</a>
				</li>
				<li class="list-group-item">
					<a href="${contextPath}/board/list/etc">기타게시판</a>
				</li>
			</ul>
		</div>
		<div class="col-9">
			<div class="my-3">
				<form class="form-inline searchForm">
					<select class="tid form-control mr-2">
						<option value="${tid }">====전체=====</option>
						<option value="notice" ${tid =='notice' ? 'selected':'' }>공지사항</option>
						<option value="review" ${tid =='review' ? 'selected':'' }>도서리뷰</option>
						<option value="etc" ${tid =='etc' ? 'selected':'' }>기타게시판</option>
						<option value="question" ${tid =='question' ? 'selected':'' }>문의</option>			
					</select>
					<select name="type" class="form-control mr-2">
						<option value="T" ${cri.type == 'T' ? 'selected':''}>제목</option>
						<option value="C" ${cri.type == 'C' ? 'selected':''}>내용</option>
						<option value="W" ${cri.type == 'W' ? 'selected':''}>작성자</option>			
					</select>
					<div class="form-group mr-2">
						<input type="search" class="form-control" name="keyword" value="${cri.keyword}">
					</div>
					<div class="form-group mr-2">
						<button type="button" class="btn btn-primary">검색</button>
					</div>
					<div class="form-group mr-2">
						<a href="${contextPath}/board/list"  class="btn btn-info">새로고침</a>
					</div>
					<a href="${contextPath }/board/writeForm" class="btn btn-info form-control">글쓰기</a>
				</form>		
			</div>
			<table class="table">
				<tr>
					<th>번호</th>
					<th>분류</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
				</tr>
				<c:choose>
					<c:when test="${empty list}">
						<tr>
							<td colspan="5">
								<b>게시물이 존재하지 않습니다.</b>
							</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="b" items="${list}">
						<tr>
							<td>${b.bno }</td>
							<td>
							${b.tid =='notice'?'공지':''}
							${b.tid =='question'?'문의':''}
							${b.tid =='review'?'도서리뷰':''}
							${b.tid =='etc'?'기타':''}
							</td>
							<td>
							<a href="${contextPath}/board/detail?bno=${b.bno}">${b.title}</a>
							</td>
							<td>${b.writer }</td>
							<td class="date">${b.writeDate }</td>
						</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
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
<%@ include file="../layout/footer.jsp" %>
<script>
$(function(){
	let typeValue = getSearchParam('type');
	let keywordValue = getSearchParam('keyword');
	let tid = $('.tid').val();
	
	//검색기능
	//검색을 눌렀을때 내 검색어의 카테고리 페이지로 이동
	$('.searchForm button').on('click',function(){
		let tid = $('.searchForm').find('.tid').val();
		console.log(tid);
		$('.searchForm')
			.attr("action",`${contextPath}/board/list/${tid}`)
			.submit();
	})//검색
	
	//페이징처리
	$('.pagination a').on('click',function(e){
		e.preventDefault();
		let pageForm = $('<form>');
		pageForm.empty();
		
		pageForm.attr('method','get')
			.attr('action',`${contextPath}/board/list/${tid}`)
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
