<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	<div class="container">
	<!-- 광고판 -->
		<div id="demo" class="carousel slide" data-ride="carousel">
		
		  <!-- Indicators -->
		  <ul class="carousel-indicators">
		    <li data-target="#demo" data-slide-to="0" class="active"></li>
		    <li data-target="#demo" data-slide-to="1"></li>
		    <li data-target="#demo" data-slide-to="2"></li>
		  </ul>
		  
		  <!-- The slideshow -->
		  <div class="carousel-inner">
		    <div class="carousel-item active">
		      <img src="${contextPath }/resources/images/광고.png"  width="1100" height="500">
		    </div>
		    <div class="carousel-item">
		      <img src="${contextPath }/resources/images/광고2.png"  width="1100" height="500">
		    </div>
		    <div class="carousel-item">
		      <img src="${contextPath }/resources/images/광고3.png"  width="1100" height="500">
		    </div>
		  </div>
		  
		  <!-- Left and right controls -->
		  <a class="carousel-control-prev" href="#demo" data-slide="prev">
		    <span class="carousel-control-prev-icon"></span>
		  </a>
		  <a class="carousel-control-next" href="#demo" data-slide="next">
		    <span class="carousel-control-next-icon"></span>
		  </a>
		</div><!-- 광고 end -->
		
	<!-- 하위배너 -->
		<div class="bookMenu mt-3 mb-3">
			<div>
				<nav class="navbar navbar-expand-sm bg-light">
					<c:forEach items="${cateList}" var="c">
					  <ul class="navbar-nav">
					    <li class="nav-item active dropdown">
					      <a class="nav-link" href="book/list"cateId="${c.cate_id}">${c.cate_name}</a>
					      <div class="dropdown-menu">
								<c:forEach items="${subCateList}" var="s">
									<c:if test="${c.cate_id eq s.cate_id}">
										<a class="dropdown-item" href="book/list" cateId="${c.cate_id}" subCateId="${s.subCate_id}">${s.subCate_name}</a>
									</c:if>
								</c:forEach>
							</div>
					    </li>
					  </ul>
					</c:forEach>
				</nav>
			</div>
		</div> <!-- bookmenu end -->
	</div>


<!-- 도서 메뉴 -->

<!-- 
<div class="bookMenu">
	<div>
		<h3>book menu</h3>
	</div>
	<ul class="nav flex-column">
		<li class="nav-item">
			<a class="nav-link" href="book/home">도서 홈</a>
		</li>
	</ul>
	<c:forEach items="${cateList}" var="c">
		<ul class="nav flex-column">
			<li class="nav-item dropdown dropright">
				<a class="nav-link" href="book/list" cateId="${c.cate_id}">${c.cate_name}</a>
				<div class="dropdown-menu">
					<c:forEach items="${subCateList}" var="s">
						<c:if test="${c.cate_id eq s.cate_id}">
							<a class="dropdown-item" href="book/list" cateId="${c.cate_id}" subCateId="${s.subCate_id}">${s.subCate_name}</a>
						</c:if>
					</c:forEach>
				</div>
			</li>
		</ul>
	</c:forEach>
</div>
 -->