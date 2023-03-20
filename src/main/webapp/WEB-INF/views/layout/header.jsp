<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
    <c:set var="contextPath" value="${pageContext.request.contextPath }"></c:set>
    <c:set var="mvo" value="${sessionScope.mvo}" />
    <c:set var="cateList" value="${applicationScope.cateList}"/>
	<c:set var="subCateList" value="${applicationScope.subCateList}"/>
	<c:set var="cate" value="${applicationScope.cate}" />
	<c:set var="subCate" value="${applicationScope.subCate}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <!--  <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.3/jquery.min.js" integrity="sha512-STof4xm1wgkfm7heWqFJVn58Hm3EtS31XFaagaa8VMReCXAkQnJZ+jEy8PCC/iT18dFy95WcExNHFTqLyp72eQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>



<link rel="stylesheet" href="${contextPath }/resources/css/style.css">
<script src="${contextPath}/resources/js/main.js"></script>
<script src="${contextPath}/resources/js/bookMenu.js"></script>
<script src="${contextPath}/resources/js/adminService.js"></script>
<script src="${contextPath}/resources/js/bookService.js"></script>
<script>
	const contextPath = "${contextPath}"
	
	let mvo = {
		mno : "${mvo.mno}",
		id : "${mvo.id}",
		name : "${mvo.name}",
		profile : "${mvo.profile}"
	};
</script>
<style type="text/css">
.footer img{ 
	width: 100%;
	margin: auto;
    display: block;}
    
.carousel-inner img {
    width: 100%;
    height: 100%;
  }
</style>


</head>
<body>
 <div class="container">
	<div class=" row mt-2">
	  <div class="container col-2 ">
	  	<a href="#">-------</a>
	  </div>
	  <div class="TopLogo col-5">
	  	<a href="${contextPath }/main">
	  		<img style="margin: auto; display: block;" alt="" src="${contextPath }/resources/images/상단로고.png">
	  	</a>
	  </div>
	  <div class="col-4" style="text-align: right;">
		<c:if test="${empty mvo}">
			<a href="${contextPath}/member/loginForm" class="badge badge-light">로그인하기</a>
			<a href="${contextPath}/member/join" class="badge badge-light">회원가입하기</a>
			</ul>
		</c:if>
		<!--추가함-->
		<c:if test="${!empty mvo}">
			<ul class="d-flex justify-content-between memberInfo">
				<li><a href="${contextPath}/book/cartPage">장바구니</a></li>
				<li><a href="${contextPath}/member/updateForm">회원정보수정</a></li>
				<li><a href="${contextPath}/member/imageForm">사진등록</a></li>
				<li><a href="${contextPath}/member/logout">로그아웃</a></li>  
			</ul>
		</c:if>
	 </div>	
	</div>
</div>
<div class="container">
	<div class="flex-wrap-reverse">
		<nav class="navbar navbar-expand-sm bg-light navbar-dark banner">
		<div class="p-2">
		  <a class="navbar-brand text-body" href="${contextPath }/main">
		 	<img alt="" src="${contextPath }/resources/images/도서로고.png">
		 	</a>
		 </div>
		  <!-- 메뉴얼 --> 
		  <div class="p-2"> 
		  	<li class="nav-item dropdown">
		      <a class="nav-link dropdown-toggle topMenu text-body" href="#" id="navbardrop" data-toggle="dropdown">
		       공지 및 문의(게시판류)
		      </a>
		      <div class="dropdown-menu ">
		      	<a class="dropdown-item" href="${contextPath }/board/list">전체</a>
		        <a class="dropdown-item" href="${contextPath }/board/list/notice">공지</a>
		        <a class="dropdown-item" href="${contextPath }/board/list/question">문의(배송,환불등등)</a>
		        <a class="dropdown-item" href="${contextPath }/board/list/etc">기타게시판</a>
		        <a class="dropdown-item" href="${contextPath }/board/list/review">도서리뷰게시판</a>
		      </div>
		    </li>
		   </div>
		<!-- 메뉴얼 -->
		 <div class="p-2">
		    <li class="nav-item " >
		      <a class="nav-link  topMenu text-body" href="${contextPath }/book/list/information_technology?" id="navbardrop" >
		        도서쇼핑
		      </a>

		    </li>
		   </div>  
		<!-- 메뉴얼 -->
		<div class="p-2">    
		  	<li class="nav-item dropdown">
		      <a class="nav-link dropdown-toggle topMenu text-body" href="#" id="navbardrop" data-toggle="dropdown">
		        대여 및 신청란
		      </a>
		      <div class="dropdown-menu">
		        <a class="dropdown-item" href="${contextPath }/hope/requestList">비치 희망도서 신청현황</a>
		        <a class="dropdown-item" href="${contextPath }/hope/requestForm">비치 희망도서 신청하기</a>
		        <a class="dropdown-item" href="${contextPath }/book/takeList">도서 대여현황 및 신청</a>
		      </div>
		    </li>
		   </div>  
		<!-- 메뉴얼 -->
		<div class="p-2"> 
		    <li class="nav-item dropdown">
		      <a class="nav-link dropdown-toggle topMenu text-body" href="${contextPath }/admin/home" id="navbardrop" data-toggle="dropdown">
		        관리자페이지
		      </a>
		      <div class="dropdown-menu ">
		        <a class="dropdown-item" href="${contextPath }/member/memInfo">회원정보관리</a> <!-- 글쓰기 -->
		        <a class="dropdown-item" href="${contextPath }/admin/home">도서관리자 메뉴</a>
		        <a class="dropdown-item" href="${contextPath }/hope/requestMaster">대여/도서신청 관리(관리자)</a>
		      </div>
			</li>
		</div>
		<div class="p-2 ml-auto">
			<c:if test="${!empty mvo}">
				<c:if test="${empty mvo.profile}">
					<a href="${contextPath}/member/updateForm" class="d-flex flex-row-reverse">
						<img class="rounded-circle" src="${contextPath}/resources/images/default.png" style="width: 50px; height: 50px;"/> 
						${mvo.name} 님Welcome.
					<a>
				</c:if>
				<c:if test="${not empty mvo.profile}">
					<div class="d-flex flex-row-reverse">
						<div>
						<a href="${contextPath}/member/updateForm">${mvo.name} 님
						 Welcome.
						 <img class="rounded-circle" src="${contextPath}/memImgDisplay?id=${mvo.id}&imageFileName=${mvo.profile}" style="width: 50px; height: 50px;"/>
						 </a>
						
						</div> 
					</div>
				</c:if>           
			</c:if>
		</div>
		</nav>
	</div>	
</div>