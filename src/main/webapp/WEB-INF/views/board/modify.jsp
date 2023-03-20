<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../layout/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="container">
	<div class="jumbotron">
		<h1>글수정</h1>
	</div>
	<div class="container form-group">
	<form action="${contextPath}/board/modify" method="post" enctype="multipart/form-data">
		<input type="hidden" name="bno" value="${b.bno }">
		<table class="table">
			<tr>
				<th>글번호</th>
				<td>${b.bno }</td>
				<th>분류</th>
				<td>
					${b.tid =='notice'?'공지':''}
					${b.tid =='question'?'문의':''}
					${b.tid =='review'?'도서리뷰':''}
					${b.tid =='etc'?'기타':''}
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3">
					<input type="text" class="form-control" value="${b.title }" name="title">
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3">
					<textarea rows="10" class="form-control" name="content">${b.content}</textarea>
				</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${b.writer}</td>
				<th>작성일시</th>
				<td>${b.writeDate}</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td colspan="3">
					<c:if test="${empty b.imageFileName}">
					</div class="preview">
						<p>첨부파일이 없습니다.</p>
						<input type="file" name="attachFile" class="form-control">
					</div>
					</c:if>
					
					<c:if test="${not empty b.imageFileName}">
						<div>
							<span>파일 삭제 : <input type="checkbox" name="delChk" class="delChk"></span>
							<input type="file" name="attachFile" class="form-control attachFile">
						</div>
						<c:if test="${b.fileType eq 'IMAGE'}">
							<img src="${contextPath}/imgDisplay?fileName=${b.bno}/${b.imageFileName}">
						</c:if>
						<c:if test="${b.fileType eq 'OTHER'}">
							<a href="${contextPath}/download?fileName=${b.bno}/${b.imageFileName}">${b.imageFileName}</a> 
						</c:if>
					</c:if>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<button class="btn btn-info">수정</button>
					<a href="${contextPath }/board/detail?bno=${b.bno}" class="btn btn-info backViewMode">돌아가기</a>
				</td>
			</tr>
		</table>		
	</form>
	</div>
</div>
</body>
</html>
<%@include file="../layout/footer.jsp" %>

<script>
$(function(){
	//파일 이미지가 있을때 
	//삭제 체크란
	$('.delChk').change(function(){
		console.log($(this).prop('checked'));
		if($(this).prop('checked')){
			$('.attachFile').hide();//체크
		}else{
			$('.attachFile').show();//언체크
		}
	})
	$('.attachFile').change(function(){
		let fileFormVal = $(this).val();
		if(fileFormVal!=''){
			$('.delChk').hide();//체크
		}else{
			$('.delChk').show();//체크
		}
	})
	let imageFile= "${board.imageFileName}"; 
	let titleObj = $('input[name="title"]');
	let contentObj = $('textarea[name="content"]');
	let pTag = $('.preview p').html(); 
	
	//수정취소시 돌아갈때
	$('.backViewMode').on('click',function(){
		$('input[name="title"],textarea[name="content"]').attr("readonly",true);
		$('.viewMode').hide();
		$(this).closest('tr').prev().show();
		$('.preview').html(originImg); // 수정전 이미지 복원
		$('input[type="file"]').val(''); // 파일폼 초기화
		titleObj.val(titleVal); // 수정전 제목 복원
		contentObj.val(contentVal); // 수정전 내용 복원
		if(imageFile==''||imageFile==null){ // 이거
			$('.preview').html(pTag);
		}
	});
})
</script>