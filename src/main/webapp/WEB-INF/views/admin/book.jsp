<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp"%>
<%@include file="../layout/adminMenu.jsp"%>
<%@include file="registerBookForm_modal.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- Content -->
<div class="container admin">
	<div class="jumbotron mb-2">
		<h1>도서 관리</h1>
	</div>

	<!-- 버튼 -->
	<button type="button" class="btn btn-primary addBook my-2">도서
		등록</button>

	<!-- 검색기능 --> <!-- id,class cate, subCate -->
	<div class="form-inline d-flex justify-content-between mb-3">
		<form class="form-inline adminSearchBookForm">
			<!-- 대분류 -->
			<select id="cate" class="form-control mr-2 cate">
				<option value="">====전체=====</option>
				<c:forEach items="${cateList}" var="c">
					<option value="${c.cate_id}"
						${cri.cate_id == c.cate_id ? 'selected':'' }>${c.cate_name}</option>
				</c:forEach>
			</select>

			<!-- 소분류 -->
			<select id="subCate" class="form-control mr-2 subCate">
				<option value="">====전체=====</option>
				<c:forEach items="${subCateList}" var="s">
					<option class="${s.cate_id}" value="${s.subCate_id}"
						${cri.subCate_id == s.subCate_id ? 'selected':''}>${s.subCate_name}</option>
				</c:forEach>
			</select>

			<!-- 검색타입 -->
			<select id="type" name="type" class="form-control mr-2 type">
				<option value="B" ${cri.type == 'B' ? 'selected':''}>책제목</option>
				<option value="A" ${cri.type == 'A' ? 'selected':''}>저자</option>
				<option value="P"${cri.type == 'P' ? 'selected':''}">출판사</option>
			</select>

			<!-- 검색창 -->
			<div class="form-group mr-2">
				<input type="search" name="keyword" class="form-control keyword"
					value="${cri.keyword}">
			</div>

			<!-- 검색버튼 -->
			<div class="form-group mr-2">
				<button type="button" class="btn btn-primary">검색</button>
			</div>
		</form>
	</div>

	<!-- 수정, 삭제 -->
	<div>
		<div class="bookList">
			<div class="bookList3">
				<table class="table">
					<thead>
						<tr>
							<th>책 번호</th>
							<th>이미지</th>
							<th>카테고리</th>
							<th>책 제목</th>
							<th>저자</th>
							<th>출판사</th>
							<th>가격</th>
							<th>등록일</th>
							<th></th>
							<th></th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
		</div>

		<!-- 페이징처리 -->
		<!-- pagination 렌더링 -->
		<div id="adminBookPagination"></div>
		<input type="hidden" name="pageInfo" value="${cri.page}">

	</div>

	<!-- 최근 등록한 도서상품 목록 -->
	<div class="row mb-2">
		<table class="table">
			<tr>
				<th colspan="9" class="bg-dark text-white"><h3>최근에 등록한 상품</h3></th>
			</tr>
			<tr>
				<th>책번호</th>
				<th>이미지</th>
				<th>카테고리</th>
				<th>서브카테고리</th>
				<th>책제목</th>
				<th>저자</th>
				<th>출판사</th>
				<th>가격</th>
				<th>등록일</th>
			</tr>
			<c:forEach items="${latest}" var="r">
				<fmt:formatDate var="regDate" pattern="yyyy-MM-dd"
					value="${r.regDate}" />
				<tr>
					<td>${r.bookNo}</td>
					<td><c:if test="${not empty r.bookImage}">
							<img
								src="${contextPath}/bookImgDisplay?category=${r.bookCategory.cate_id}/${r.bookSubCategory.subCate_id}&no=${r.bookNo}&imageFileName=${r.bookImage}"
								width="40px" height="40px">
						</c:if> <c:if test="${empty r.bookImage}">
							<p>이미지X</p>
						</c:if></td>
					<td>${r.bookCategory.cate_name}</td>
					<td>${r.bookSubCategory.subCate_name}</td>
					<td>${r.bookName}</td>
					<td>${r.author}</td>
					<td>${r.publisher}</td>
					<td>${r.price}</td>
					<td>${regDate}</td>
				</tr>
			</c:forEach>
		</table>
	</div>

</div>

<!-- 수정폼 -->
<div class="modal" id="modifyBookBookForm">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<form class="modifyBookForm">
				<!-- Modal Header -->
				<div class="modal-header bg-success text-white">
					<h4 class="modal-title">도서 수정</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
	
				<!-- Modal body -->
				<div class="modal-body">
					<div class="row">
						<!-- 책번호 -->
						<input type="hidden" class="form-control bookNo" name="bookNo">
						
						<div class="col-4">
							<div id="ImgArea" class="preview">
								<!-- 원본이미지 -->
								<img class="originImg" src="" width="300px" height="350px">
							</div>
						</div>
						
						<div class="col-8">
							<table class="table">
								<!-- 파일폼 -->
								<tr>
									<th>이미지</th>
									<td colspan="3">
										<input type="file" class="form-control attachFile" name="attachFile">
										<div class="changeImg"></div>
									</td>
								</tr>
								<!-- 책제목 -->
								<tr>
									<th>책체목</th>
									<td colspan="3">
										<input type="text" class="form-control" name="bookName">
									</td>
								</tr>
								<!-- 저자 / 출판사 -->
								<tr>
									<th>저자</th>
									<td><input type="text" class="form-control" name="author"></td>
									<th>출판사</th>
									<td><input type="text" class="form-control" name="publisher"></td>
								</tr>
								<!-- 카테고리 -->
								<tr>
									<th>대분류</th>
									<td>
										<select id="cate1" name="cate_id" class="form-control cate1">
											<option value="none"">===선택하세요===</option>
											<c:forEach items="${cateList}" var="c">
												<option value="${c.cate_id}">${c.cate_name}</option>
											</c:forEach>	
										</select>
									</td>
									<th>소분류</th>
									<td>
										<select id="cate2" name="subCate_id" class="form-control cate2">
											<option id="none">===선택하세요===</option>
											<c:forEach items="${subCateList}" var="s">
												<option class="${s.cate_id}" value="${s.subCate_id}" style="display: none;">${s.subCate_name}</option>
											</c:forEach>		
										</select>
									</td>
								</tr>
								<!-- 가격 -->
								<tr>
									<th>가격</th>
									<td colspan="3"><input type="text" name="price" class="form-control" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/></td>
								</tr>
							</table>
						</div>
						
					</div>
				</div>
	
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary modifyBookBtn">수정하기</button>
					<button type="button" class="btn btn-secondary cancelModifyBtn">취소</button>
				</div>
			</form>
		</div>
	</div>
</div>


<%@include file="../layout/footer.jsp"%>

