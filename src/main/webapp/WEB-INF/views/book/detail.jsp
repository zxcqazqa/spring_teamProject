<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp"%>
<%@include file="../layout/bookMenu.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:formatDate var="regDate" pattern = "yyyy-MM-dd" value="${detail.regDate}"/>

<style>
#ImgArea {
	border: 1px solid black;
}
</style>

<div class="container">
	<!-- Title -->
	<div class="jumbotron title">
		<h1>상세 페이지</h1>
		회원아이디 : ${mvo.id} 회원이름 : ${mvo.name}
		<input type="hidden" name="cateInfo" value="${cri.cate_id}">
		<input type="hidden" name="subCateInfo" value="${cri.subCate_id}">
		<input type="hidden" name="pageInfo" value="${cri.page}">
		<input type="hidden" name="perPage" class="perPage" value="${cri.perPageNum}">
		<input type="hidden" name="typeInfo" value="${cri.type}">
		<input type="hidden" name="keywordInfo" value="${cri.keyword}">
	</div>
	
	<!-- Content -->
	<div id="bookDetailForm">
		
		<input type="hidden" name="cate_id" value="${detail.cate_id}"> <!-- 카테고리 -->
		<input type="hidden" name="subCate_id" value="${detail.subCate_id}"> <!-- 서브카테고리 -->
		
		<!-- 장바구니담기 할 때 필요한 것들 -->
		<input type="hidden" name="id" value="${mvo.id}"> <!-- value="${mvo.id}" -->
		<input type="number" name="bookNo" value="${detail.bookNo}" style="display: none;"> <!-- 책번호 -->
		<input type="hidden" name="price" value="${detail.price}"> <!-- 책가격 -->
		
		<div class="row">
			<!-- 이미지영역 -->
			<div id="ImgArea" class="col-6">
				<c:if test="${not empty detail.bookImage}">
				<img src="${contextPath}/bookImgDisplay?category=${detail.bookCategory.cate_id}/${detail.bookSubCategory.subCate_id}&no=${detail.bookNo}&imageFileName=${detail.bookImage}" width="300px" height="400px">
				</c:if>
				<c:if test="${empty detail.bookImage}">
					<p>등록된 이미지가 없습니다.</p>
				</c:if>
			</div>
			<!-- BookInfo -->
			<div class="col-6">
				<table class="table">
					<thead>
						<tr>
							<th>책 제목</th>
							<td colspan="3">${detail.bookName}</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th>저자</th>
							<td>${detail.author}</td>
							<th>출판사</th>
							<td>${detail.publisher}</td>
						</tr>
						<tr>
							<th>카테고리</th>
							<td colspan="3">${detail.bookCategory.cate_name} / ${detail.bookSubCategory.subCate_name}</td>
						</tr>
						<tr>
							<th>책번호</th>
							<td>${detail.bookNo}</td>
							<th>등록일</th>
							<td>${regDate}</td>
						</tr>
						<tr>
							<th>가격</th>
							<td colspan="3">
								${detail.price}
							</td>
						</tr>
					</tbody>
				</table>
				<!-- Calculator -->
				<div>
					<div class="row">
						<div class="col-6">
							<b>수량</b><br>
							<button type="button" class="minus">-</button>
							<input type="number" name="amount" value="1" readonly="readonly">
							<button type="button" class="plus">+</button>
						</div>
						<div class="col-6">
							<b>총 금액</b><br>
							<input type="number" name="totalPrice" value="${detail.price}" readonly="readonly">
							<b>원</b>
						</div>
					</div>
				</div>
				<!-- Button -->
				<div>
					<c:if test="${empty mvo}">
						<a class="btn btn-danger my-2" href="${contextPath}/member/loginForm">바로구매</a>
						<a class="btn btn-primary my-2" href="${contextPath}/member/loginForm">장바구니담기</a>
					</c:if>
					<c:if test="${!empty mvo}">
						<button type="button" class="btn btn-danger my-2 buy">바로구매</button>
						<button type="button" class="btn btn-primary addCart">장바구니담기</button>
					</c:if>
					<button type="button" class="btn btn-info toBookList">목록</button>
				</div>
			</div>
		</div>
	</div>
</div>

<%@include file="../layout/footer.jsp"%>