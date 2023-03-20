<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- ==================================대여신청모달======================================== -->
<div class="modal" id="addTake">
	<div class="modal-dialog">
		<form> 
			<div class="modal-content">
				
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">대여 신청하기</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<!-- Modal body -->
				<div class="modal-body">
					<div class="form-group">
						<ul class="list">
							<h4>--대여시 알아야할 부분--</h4>
						</ul>
						<ul>
							<li>기본 대여기간은 7일</li>
							<li>대여금액은 기본대여기간을 기준으로 1000원</li>
							<li>반납기한 초과시 3일초과시 과금 1000원추가 부과</li>
							<li>최초 책 대여시 대여료 납부</li>
						</ul>
						<table class="table">
							<tr>
								<th>책제목</th>
								<th>반납일시</th>
								<th>대여료</th>
							</tr>
							<tr class="bookName"></tr>
							<tr>
								<td colspan="3">위 책을 대여하시겠습니까?</td>			 
							</tr>
						</table>
					</div>
				</div>
				
				<!-- Modal footer -->
				<div class="modal-footer">
					
					<button type="button" class="btn btn-primary takeRequest">대여신청하기</button>
					<button type="button" class="btn btn-danger modal_close" data-dismiss="modal" >취소</button>
				</div>
				
			</div>
			<!-- modal-content -->
		</form>
	</div>
</div>
<!-- ==================================거절시 모달======================================== -->
<div class="modal" id="reject">
	<div class="modal-dialog">
		<form> 
			<div class="modal-content">
				
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">거절</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<!-- Modal body -->
				<div class="modal-body">
					<div class="form-group">
						<ul class="list">
							<h4>도서 대여가 거절되었습니다.</h4>
						</ul>
						<ul>
							<li>아래와 같은 사유로 거절되었습니다.</li>
						</ul>
						<table class="table">
							<tr class="rejectReason"></tr>
							<tr>
								<td colspan="3">다른도서를 대여해주세요</td>			 
							</tr>
						</table>
					</div>
				</div>
				
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger modal_close" data-dismiss="modal">돌아가기</button>
				</div>
				
			</div>
			<!-- modal-content -->
		</form>
	</div>
</div>
<!-- ==================================신청대기시 모달======================================== -->
<div class="modal" id="wait">
	<div class="modal-dialog">
		<form> 
			<div class="modal-content">
				
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">대기중..</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<!-- Modal body -->
				<div class="modal-body">
					<div class="form-group">
						<ul class="list">
							<h4>신청확인중입니다!</h4>
						</ul>
						<table class="table">
							<tr>
								<td>해당 도서는 신청후 도서확인중에 있습니다.</td>
							</tr>
							<tr>
								<td colspan="3">다른도서를 대여해주세요</td>			 
							</tr>
						</table>
					</div>
				</div>
				
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger modal_close" data-dismiss="modal">돌아가기</button>
				</div>
				
			</div>
			<!-- modal-content -->
		</form>
	</div>
</div>
<!-- ==================================대여중======================================== -->
<div class="modal" id="ing">
	<div class="modal-dialog">
		<form> 
			<div class="modal-content">
				
				<!-- Modal Header -->
				
				<div class="modal-header">
					<h4 class="modal-title">도서 대여중</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<!-- Modal body -->
				<div class="modal-body">
					<div class="form-group">
						<ul class="list">
							<h4>이책은 대여된 도서입니다</h4>
						</ul>
						<table class="table">
							<tr class="howDay">
								<td>해당 도서는 이미 대여 되었습니다.</td><br>
							</tr>
							<tr>
								<td colspan="3">다른도서를 대여해주세요</td>			 
							</tr>
						</table>
					</div>
				</div>
				
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger modal_close" data-dismiss="modal">돌아가기</button>
				</div>
				
			</div>
			<!-- modal-content -->
		</form>
	</div>
</div>
</body>
</html>