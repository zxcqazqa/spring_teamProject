<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 도서 등록 폼 -->
<div class="modal" id="addBookForm">
	<div class="modal-dialog modal-xl">
		<div class="modal-content container" style="padding: 0;">

			<!-- Modal Header -->
			<div class="modal-header bg-primary text-white">
				<h4 class="modal-title">도서 등록</h4>
				<span class="float-right">
					<button class="btn btn-info addbookLiBtn">폼추가</button>
					<button class="btn btn-danger delbookLiBtn">폼삭제</button>
				</span>
			</div>

			<!-- Modal body -->
			<div id="modalBody" class="row modal-body">
				<form class="registerBookForm">
					<ul class="list-group" style="width: 1100px;">
						<li class="list-group-item">
							<div class="row">
								<div class="col-4" style="border: solid 1px;">
									<div id="bookImgArea" class="preview"></div>
								</div>
								<div class="col-8">
									<table class="table">
										<!-- 이미지 -->
										<tr>
											<th>이미지</th>
											<td colspan="3"><input id="attachFile[0]" type="file"
												class="form-control attachFile" name="attachFile"></td>
										</tr>
										<!-- 책제목 -->
										<tr>
											<th>책 제목</th>
											<td colspan="3"><input id="bookName" type="text"
												class="form-control bookName" name="bookList[0].bookName">
											</td>
										</tr>
										<!-- 저자 -->
										<tr>
											<th>저자</th>
											<td colspan="3"><input id="author" type="text"
												class="form-control author" name="bookList[0].author">
											</td>
										</tr>
										<!-- 출판사 -->
										<tr>
											<th>출판사</th>
											<td colspan="3"><input id="publisher" type="text"
												class="form-control publisher" name="bookList[0].publisher">
											</td>
										</tr>
										<!-- 카테고리 -->
										<tr>
											<th>대분류</th>
											<td><select id="cate1" name="bookList[0].cate_id"
												class="form-control cate_id">
													<option value="none"">===선택===</option>
													<c:forEach items="${cateList}" var="c">
														<option value="${c.cate_id}">${c.cate_name}</option>
													</c:forEach>
											</select></td>
											<th>소분류</th>
											<td><select id="cate2" name="bookList[0].subCate_id"
												class="form-control subCate_id">
													<option id="none">===선택===</option>
													<c:forEach items="${subCateList}" var="s">
														<option class="${s.cate_id}" value="${s.subCate_id}"
															style="display: none;">${s.subCate_name}</option>
													</c:forEach>
											</select></td>
										</tr>
										<!-- 가격 -->
										<tr>
											<th>가격</th>
											<td colspan="3"><input type="text"
												class="form-control price" name="bookList[0].price"
												onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" /></td>
										</tr>
									</table>
								</div>
							</div>

						</li>
					</ul>
				</form>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary registerBookBtn">등록하기</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
			</div>

		</div>
		</form>
	</div>
</div>