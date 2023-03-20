<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../layout/header.jsp" %>
<script src="${contextPath }/resources/js/main.js"></script>
<div class="container">
	<div class="container topMenu mt-3 mb-3 ">
	 	<!-- 광고판 -->
	 	<div>
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
			      <img src="${contextPath }/resources/images/광고.png" alt="Los Angeles" width="1100" height="500">
			    </div>
			    <div class="carousel-item">
			      <img src="${contextPath }/resources/images/광고2.png" alt="Chicago" width="1100" height="500">
			    </div>
			    <div class="carousel-item">
			      <img src="${contextPath }/resources/images/광고3.png" alt="New York" width="1100" height="500">
			    </div>
			  </div>
			  <!-- 게시물링크로 불러오고 싶을때
			    불러올 때 ?fileName=${b.bno}/${b.imageFileName}" 이렇게 되면
				-> (경로, 이미지이름)  ex) (file01_spring, no/이미지이름) 이 되어서 못찾음.
				
				컨트롤러에서 get요청이면 파라미터 이름 imageimageFileName ?뒤에랑 일치해야함.
				?fileName (x) 
				?imageimageFileName (o)
			   -->
			  
			  <!-- Left and right controls -->
			  <a class="carousel-control-prev" href="#demo" data-slide="prev">
			    <span class="carousel-control-prev-icon"></span>
			  </a>
			  <a class="carousel-control-next" href="#demo" data-slide="next">
			    <span class="carousel-control-next-icon"></span>
			  </a>
			</div>
		</div>
	</div><!-- 광고판 end -->
	
	<div class="row">
		<div class="col-8">
			<div>
				<div class="d-flex justify-content-between mb-3">
					<div class="d-inline-flex p-3 bg-light text-dark">
						<a href="${contextPath }/board/list" class="contatiner text-center">
							<img src="${contextPath }/resources/images/전체게시판.png" class="rounded-circle" alt="" width="100" height="80"><br>
							전체게시판
						</a> 
					</div>
					<div class="d-inline-flex p-3 bg-light text-dark">
						<a href="${contextPath }/hope/requestForm" class="contatiner text-center">
							<img src="${contextPath }/resources/images/도서신청.png" class="rounded-circle" alt="" width="100" height="80"><br>
							도서신청하기
						</a> 
					</div>
					<div class="d-inline-flex p-3 bg-light text-dark">
						<a href="${contextPath }/member/join" class="contatiner text-center">
							<img src="${contextPath }/resources/images/회원가입 바로가기.png" class="rounded-circle" alt="" width="100" height="80"><br>
							회원가입하기
						</a> 
					</div>
					<div class="d-inline-flex p-3 bg-light text-dark">
						<a href="${contextPath }/book/home" class="contatiner text-center">
							<img src="${contextPath }/resources/images/도서쇼핑하기.png" class="rounded-circle" alt="" width="100" height="80"><br>
							도서쇼핑
						</a> 
					</div>
				</div>	
			<div>
				<p>ㅁㅁㅁ</p>
			</div>
			</div>
		</div>	<!-- col-8 end-->
		<div class="col-4"  >
			<div class="container" >
				  <ul class="nav nav-tabs" role="tablist">
				    <li class="nav-item">
				      <a class="nav-link active" data-toggle="tab" href="#home">공지사항</a>
				    </li>
				    <li class="nav-item">
				      <a class="nav-link" data-toggle="tab" href="#menu1">도서리뷰</a>
				    </li>
				    <li class="nav-item">
				      <a class="nav-link" data-toggle="tab" href="#menu2">기타게시판</a>
				    </li>
				  </ul>
			</div> 
			<div class="tab-content">
			    <div id="home" class="container tab-pane active"><br>
			      <table class="table">
			      	<tr>
			      		<th>제목</th>
			      		<th>작성자</th>
			      	</tr>
			      	<c:forEach items="${threeNotice }" var="n">
					      	<tr>
					      		<td>
					      			<a href="${contextPath }/board/detail?bno=${n.bno}">${n.title}</a>
					      		</td>
					      		<td>${n.writer }</td>
					      	</tr>
			      	</c:forEach>
			      </table>
			    </div>
			    <div id="menu1" class="container tab-pane fade"><br>
			      <table class="table">
			      	
			      	<tr>
			      		<th>제목</th>
			      		<th>작성자</th>
			      	</tr>
					<c:forEach items="${threeReview }" var="r">
					   	<tr>
					      	<td>
					      		<a href="${contextPath }/board/detail?bno=${r.bno}">${r.title}</a>
					      	</td>
					      	<td>${r.writer }
					      	</td>
					    </tr>
			      	</c:forEach>
			      	
			      </table>		    </div>
			    <div id="menu2" class="container tab-pane fade"><br>
			      <table class="table">
			      	<tr>
			      		<th>제목</th>
			      		<th>작성자</th>
			      	</tr>
			      	</tr>
			      	<c:forEach items="${threeEtc }" var="e">
					   	<tr>
					      	<td>
					      		<a href="${contextPath }/board/detail?bno=${e.bno}">${e.title}</a>
					      	</td>
					      	<td>${e.writer }
					      	</td>
					    </tr>
			      	</c:forEach>
			      </table>
			    </div>
			</div>
		</div> <!-- col-4 end-->	
	</div><!-- row end -->



</div>
<%@include file="../layout/footer.jsp" %>

<script type="text/javascript">
	$(document).ready(function(){
		if(${!empty msgType}){
			$("#messageType").attr("class", "modal-content panel-success");    
			$("#myMessage").modal("show");
		}
	});
</script>
