<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="../layout/header.jsp" %>
<%@include file="../layout/bookMenu.jsp" %>


<!-- content -->
<div class="container">
	<div class="jumbotron">
		<h1> <!-- 페이지 제목 -->
		<c:if test="${cri.subCate_id == null}">
			${cri.cate_id}
		</c:if>
		<c:if test="${cri.subCate_id != null}">
			${cri.cate_id} > ${cri.subCate_id}
		</c:if>
		</h1>
	</div>
	
	<!-- 검색기능 -->
	<div class="form-inline d-flex justify-content-between mb-3">
		<form class="form-inline searchBookForm">
			<!-- 대분류 -->
			<select id="cate" class="form-control mr-2 cate">
				<option value="">====전체=====</option>
				<c:forEach items="${cateList}" var="c">
					<option value="${c.cate_id}" ${cri.cate_id == c.cate_id ? 'selected':'' }>${c.cate_name}</option>
				</c:forEach>			
			</select>
			
			<!-- 소분류 -->
			<select id="subCate" class="form-control mr-2 subCate">
				<option value="">====전체=====</option>
				<c:forEach items="${subCateList}" var="s">
					<option class="${s.cate_id}" value="${s.subCate_id}" ${cri.subCate_id == s.subCate_id ? 'selected':''}>${s.subCate_name}</option>
				</c:forEach>
			</select>
			
			<!-- 검색타입 -->
			<select id="type" name="type" class="form-control mr-2">
				<option value="B" ${cri.type == 'B' ? 'selected':''}>책제목</option>
				<option value="A" ${cri.type == 'A' ? 'selected':''}>저자</option>
				<option value="P" ${cri.type == 'P' ? 'selected':''}">출판사</option>			
			</select>
			
			<!-- 검색창 -->
			<div class="form-group mr-2">
				<input type="search" name="keyword" class="form-control" value="${cri.keyword}">
			</div>
			
			<!-- 검색버튼 -->
			<div class="form-group mr-2">
				<button type="button" class="btn btn-primary">검색</button>
			</div>
		</form>
		<div>
			<button type="button" class="btn btn-outline-dark btn-sm view1">리스트</button>
			<button type="button" class="btn btn-outline-dark btn-sm view2">이미지</button>
			<button type="button" class="btn btn-outline-dark btn-sm per10">10개씩보기</button>
			<button type="button" class="btn btn-outline-dark btn-sm per20">20개씩보기</button>
			<input type="hidden" name="perPage" class="perPage" value="${cri.perPageNum}">
		</div>
	</div>
	
	<!-- 게시물 목록 -->
	<div class="bookList">
		<div class="bookList1">
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
					</tr>
				</thead>
				<!-- 렌더링 되는 부분 -->
				<tbody></tbody> 
			</table>
		</div>
		<!-- bookList 렌더링2 -->
		<div class="bookList2"></div>
	</div>
	
	<!-- 페이징처리 -->
	<!-- pagination 렌더링 -->
	<div id="bookPagination"></div> 
	<input type="hidden" name="pageInfo" value="${cri.page}">
	
</div>

<%@include file="../layout/footer.jsp" %>