<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@include file="../layout/adminMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
	<div class="jumbotron">
		<h1 class="title">신청처리(관리자)</h1>
	</div>
	<div class="row">
		<div class="col-3">
			<ul class="list-group">
				<li class="list-group-item">
					<a href="${contextPath}/hope/requestList">비치희망도서 신청현황</a>
				</li>
				<li class="list-group-item">
					<a href="${contextPath }/hope/requestForm">비치희망도서 신청하기</a>
				</li>
				<li class="list-group-item">
					<a href="${contextPath }/hope/requestMaster">도서신청/대여관리(관리자용)</a>
				</li>
				<li class="list-group-item">
					<a href="${contextPath }/book/takeList">도서대여 현황 및 신청</a>
				</li>
			</ul>
		</div>
		<div class="col-9">
			<div >
				
				<a href="${contextPath }/book/takeMaster?type=TR&keyword=신청대기" class="btn btn-info mb-3 mr-3">대여관리</a>
				<a href="${contextPath }/hope/requestMaster" class="btn btn-info mb-3 mr-3">신청관리</a>
			</div>
			<div>
				- 신청 거절시 사유 필히 작성
				<form  action="${contextPath }/hope/requestResult" method="post">
					<table class="table">
						<tr>
							<th>신청번호</th>
							<th>책제목</th>
							<th>저자</th>
							<th>출판사</th>
							<th>신청인</th>
							<th colspan="2">승인/거절</th>
							<th>*비고</th>
						</tr>
						<c:forEach items="${ requestMaster}" var="r">
						<tr>
							<td>${r.rno }</td>
							<td>${r.nbookName }</td>
							<td>${r.nbookWriter }</td>
							<td>${r.npublisher }</td>
							<td>${r.id }</td>
							<td> 
			 					<input type="checkbox" name="goResult_ck" class="form-control resultGo_ckbox" value="${r.rno }">
							</td>
							<td>
			 					<input type="checkbox" name="noResult_ck" class="form-control resultNo_ckbox" value="${r.rno }">
			 				</td>
						</tr>
						</c:forEach>
					</table>
					
					<button class="btn btn-info mb-3">결과전송</button>
				
				</form>
				<ul class="pagination">
					<c:if test="${p.prev}">
						<li class="page-item">
							<a class="page-link" href="${p.startPage-1}">이전</a>
						</li>
					</c:if>
					<c:forEach begin="${p.startPage }" end="${p.endPage}" var="pageNum">
						<li class="page-item ${cri.page == pageNum ? 'active':''}">
							<a class="page-link" href="${pageNum}">${pageNum}</a>
						</li>		
					</c:forEach>
					<c:if test="${p.next}">
						<li class="page-item">
							<a class="page-link" href="${p.endPage+1 }">다음</a>
						</li>		
					</c:if>
				</ul>
			</div>	
		</div>	
	</div>
</div>


</body>
</html>
<%@ include file="../layout/footer.jsp" %>
<script>
$(function(){
	let typeValue = getSearchParam('type');
	let keywordValue = getSearchParam('keyword');

	//신청페이징처리
	$('.pagination a').on('click',function(e){
		e.preventDefault();
		let pageForm = $('<form>');
		pageForm.empty();
		
		pageForm.attr('method','get')
			.attr('action',`${contextPath}/hope/requestList`)
			.append(getInputHiddenTag('page',$(this).attr('href')))
		if(typeValue !=null && keywordValue != null){
			pageForm.append(getInputHiddenTag('type',typeValue))
				.append(getInputHiddenTag('keyword',keywordValue))
		}
		pageForm.appendTo('body')
			.submit();

	});	//페이징처리
	
	
	let GoResultSet = new Set();//승인집합
	let NoResultSet = new Set();//거절집합 
	
	//승인
	$('.resultGo_ckbox').on('change',function(){ //값이 변할때 발생하는 이벤트 'change' : checked/unchecked
		let goResult = $(this).val(); //위 클래스의 밸류값. 신청번호값
		let checkOn	= $(this).prop('checked'); // 체크선택
		let etc = $(this).closest('td').next('td').next('td'); //etc항목 td
			if(checkOn){//승인을 체크하면
				GoResultSet.add(goResult+'체크'); //승인집합에 신청번호값 추가
				etc.remove(); //승인을 체크하면 비고란을 쓸수 없게
				$(this).closest('tr').find('.resultNo_ckbox') //승인을 체크하면 거절은 체크할수 없게, 같은신청번호의 두항목을 클릭할 수 없게 
					.prop("checked",false).prop("disable",false);
			}else{// 다시 체크해제 했다면	
				GoResultSet.delete(goResult);//승인집합의 해당신청번호값 제거
			 }
		console.log(GoResultSet);
	})//resultGo
	
	//거절
	$('.resultNo_ckbox').on('change',function(){
		let noResult = $(this).val(); //위 클래스의 밸류값. 신청번호값
		let checkOn	= $(this).prop('checked'); //
		let etc = $(this).closest('td').next('td');
			if(checkOn){
				NoResultSet.add(noResult+'체크');
				etc.remove();
				$(this).closest('tr').append("<td><input type='text' name='etc' class='etc' ></td>")//거절사유란 추가
				$(this).closest('tr').find('.resultGo_ckbox')//거절을 체크하면 승인을 체크할수 없게,
					.prop("checked",false).prop("disable",false);
			}else{//체크해제 한다면
				NoResultSet.delete(noResult);//거절집합에서 거절신청번호 제거
				etc.remove(); // 거절사유 입력란 제거
			}
		console.log(NoResultSet);
	})//resultNo

	
		
	
})
</script>
