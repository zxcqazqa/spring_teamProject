<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp"%>
<script src="${contextPath}/resources/js/cartService.js"></script>


<div class="container">
	<div class="jumbotron">
		<h1>장바구니 페이지</h1>
		<input type="hidden" name="id" value="${mvo.id}">
	</div>

	<form id="cartForm">
		<table class="table cartList">
			<thead>
				<tr class="text-center">
					<th>책번호</th>
					<th>이미지</th>
					<th>카테고리</th>
					<th>책제목</th>
					<th>가격</th>
					<th>수량</th>
					<th>합계</th>
					<th>삭제</th>
				</tr>
			</thead>
			<!-- 장바구니 상품 목록 -->
			<tbody></tbody>
		</table>
		<div class="text-right sum">
			<input type="hidden" name="sum"> 합계 : <span></span> 원
		</div>
		<div class="text-right">
			<button type="button" class="btn btn-danger my-2 orderBtn">주문하기</button>
		</div>
	</form>


</div>


<%@include file="../layout/footer.jsp"%>