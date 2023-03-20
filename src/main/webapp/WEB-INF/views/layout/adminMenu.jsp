<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 관리자 메뉴 -->
<div class="adminMenu">
	<div>
		<h3>admin menu</h3>
	</div>
	<ul class="nav flex-column">
		<li class="nav-item"><a class="nav-link"
			href="${contextPath}/admin/home">홈</a></li>
	</ul>
	<ul class="nav flex-column">
		<li class="nav-item"><a class="nav-link"
			href="${contextPath}/admin/book">도서관리</a></li>
	</ul>
	<ul class="nav flex-column">
		<li class="nav-item"><a class="nav-link" href="${contextPath}/member/memInfo">회원관리</a></li>
	</ul>
	<ul class="nav flex-column">
		<li class="nav-item"><a class="nav-link"
			href="${contextPath}/admin/category">카테고리관리</a></li>
	</ul>
	<ul class="navbar-nav">
		<li class="nav-item"><a class="nav-link"
			href="${contextPath}/hope/requestMaster">도서대여/도서신청 관리</a></li>
	</ul>
	<c:forEach items="${cate}" var="c">
		<ul class="nav flex-column">
			<li class="nav-item dropdown dropright"><a class="nav-link"
				href="${contextPath}/book/list/${c.cate_id}">${c.cate_name} <span
					class="badge badge-primary badge-pill">${c.count}</span></a>
				<div class="dropdown-menu">
					<c:forEach items="${subCate}" var="s">
						<c:if test="${s.cate_id == c.cate_id}">
							<a href="${contextPath}/book/list/${c.cate_id}/${s.subCate_id}">${s.subCate_name}</a>
							<span class="badge badge-primary badge-pill">${s.count}</span>
							<br>
						</c:if>
					</c:forEach>
				</div></li>
		</ul>
	</c:forEach>
</div>