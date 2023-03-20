<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp"%>
<%@include file="../layout/adminMenu.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="container">
	<div class="jumbotron title">
		<h1>카테고리 관리</h1>
	</div>
	<div class="row">
		<div class="col-6 bookCate">
			<table class="table mb-0">
				<tr>
					<th class="bg-dark text-white"><h3>도서 카테고리</h3></th>
				</tr>
				<tr>
					<th>
						<span class="float-left">이름 (아이디)</span>
						<span class="float-right">
							<button type="button" class="btn btn-primary btn-sm addCate" data-toggle="modal" data-target="#addCateForm">카테고리 추가</button>
							<button type="button" class="btn btn-info btn-sm addCate" data-toggle="modal" data-target="#addSubCateForm">서브 카테고리 추가</button>
						</span>
					</th>
				</tr>
			</table>
			<c:forEach items="${cateList}" var="c">
				<div class="card mb-2">
					<div class="card-header">
						<span class="float-left">${c.cate_name} (${c.cate_id})</span>
						<span class="float-right">
							<a href="${c.cate_id}" class="delCate">삭제</a>
						</span>
					</div>
					<div class="card-body">
						<c:forEach items="${subCateList}" var="s">
							<c:if test="${s.cate_id == c.cate_id}">
								<span class="float-left">
									${s.subCate_name} (${s.subCate_id})
								</span>
								<span class="float-right">
									<a href="${s.subCate_id}" class="delsubCate">삭제</a>
								</span><br>
							</c:if>
						</c:forEach>
					</div>
				</div>
			</c:forEach>
		</div>
		<div class="col-6 boardCate">
			<table class="table mb-0">
				<tr>
					<th class="bg-dark text-white"><h3>게시판 카테고리</h3></th>
				</tr>
			</table>
		</div>
	</div>
</div>

<!-- 카테고리 추가 -->
<div class="modal" id="addCateForm">
	<div class="modal-dialog">
		<form action="${contextPath}/admin/addCate" method="post">
		<spring:hasBindErrors name="bookCategory"/> <!-- name속성 : 커맨드객체 이름 -->
			<div class="modal-content">
				
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">카테고리 추가하기</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				
				<!-- Modal body -->
				<div class="modal-body">
					<div class="form-group">
						<table class="table">
							<tr>
								<th>아이디</th>
								<td>
									<input type="text" name="cate_id" class="form-control" value="${bookCategory.cate_id}">
									<form:errors path="bookCategory.cate_id" element="div" class="input_errors1" />
								</td>
							</tr>
							<tr>
								<th>이름</th>
								<td>
									<input type="text" name="cate_name" class="form-control" value="${bookCategory.cate_name}">
									<form:errors path="bookCategory.cate_name" element="div" class="input_errors1" />
								</td>
							</tr>
						</table>
					</div>
				</div>
				
				<!-- Modal footer -->
				<div class="modal-footer">
					<button class="btn btn-primary">저장</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
				</div>
				
			</div>
			<!-- modal-content -->
		</form>
	</div>
</div>

<!-- 서브카테고리 추가 -->
<div class="modal" id="addSubCateForm">
	<div class="modal-dialog">
		<form action="${contextPath}/admin/addSubCate" method="post">
		<spring:hasBindErrors name="bookSubCategory"/> <!-- name속성 : 커맨드객체 이름 -->
			<div class="modal-content">
				
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">카테고리 추가하기</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				
				<!-- Modal body -->
				<div class="modal-body">
					<div class="form-group">
						<table class="table">
							<select name="cate_id" class="form-control mr-2">
								<c:forEach items="${cateList}" var="c">
									<option value="${c.cate_id}">${c.cate_name}</option>
								</c:forEach>
							</select>
							<tr>
								<th>아이디</th>
								<td>
									<input type="text" name="subCate_id" class="form-control" value="${bookSubCategory.subCate_id}">
									<form:errors path="bookSubCategory.subCate_id" element="div" class="input_errors2" />
								</td>
							</tr>
							<tr>
								<th>이름</th>
								<td>
									<input type="text" name="subCate_name" class="form-control" value="${bookSubCategory.subCate_name}">
									<form:errors path="bookSubCategory.subCate_name" element="div" class="input_errors2" />
								</td>
							</tr>
						</table>
					</div>
				</div>
				
				<!-- Modal footer -->
				<div class="modal-footer">
					<button class="btn btn-primary">저장</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
				</div>
				
			</div>
			<!-- modal-content -->
		</form>
	</div>
</div>


<%@include file="../layout/footer.jsp"%>

<style>
.input_errors1, .input_errors2{
	font-size: 13px;  
	font-weight:bold; 
	color:red;
}
.error_on {
	border-color: red;
}
</style>
<script>
$(function(){
	let error_form1 = $('.input_errors1');
	if(error_form1.length>0){
		$('#addCateForm').modal('show');
		error_form1.prev().addClass('error_on')
	}
	
	let error_form2 = $('.input_errors2');
	if(error_form2.length>0){
		$('#addSubCateForm').modal('show');
		error_form2.prev().addClass('error_on')
	}
})
</script>