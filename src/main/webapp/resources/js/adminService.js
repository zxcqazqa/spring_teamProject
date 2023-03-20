console.log('adminService');

let adminService = {
	
	// 목록
	list : function(criteria) {
		$.ajax({
			type : 'post',
			url : `${contextPath}/sample/list`,
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(criteria),
			
			success : function(map) {
				let p = map.p;
				adminbookListRender(map);
				adminPaginationRender(p);
			},
			error : function() {
				alert('목록 조회 실패');			
			}
		}); // ajax end
	},
	
	// 수정폼에 띄울 정보
	detail : function(bookNo) {
		$.ajax({
			type : 'get',
			url : `${contextPath}/sample/detail?bookNo=${bookNo}`,
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(bookNo),
			
			success : function(map) {
				let detail = map.detail; // 책번호로 조회
				let cateList = map.cateList; // 카테고리 목록
				let subCateList = map.subCateList; // 서브카테고리 목록
				
				// input태그 선택
				$('.originImg').attr('src',`${contextPath}/bookImgDisplay?category=${detail.bookCategory.cate_id}/${detail.bookSubCategory.subCate_id}&no=${detail.bookNo}&imageFileName=${detail.bookImage}`);
				let bookNoInput = $('input[name="bookNo"]'); // 책번호
				let bookNameInput = $('input[name="bookName"]'); // 책제목
				let authorInput = $('input[name="author"]'); // 저자
				let publisherInput = $('input[name="publisher"]'); // 출판사
				let priceInput = $('input[name="price"]'); // 가격
				
				// 값 넣기
				bookNoInput.val(`${detail.bookNo}`);
				bookNameInput.val(`${detail.bookName}`);
				authorInput.val(`${detail.author}`);
				publisherInput.val(`${detail.publisher}`);
				priceInput.val(`${detail.price}`);
				$('.cate1').closest('td').find(`option[value="${detail.bookCategory.cate_id}"]`).prop("selected", true);
				$('.cate2').closest('td').find(`option[value="${detail.bookSubCategory.subCate_id}"]`).prop("selected", true);
				$('#modifyBookBookForm').modal('show');
				
			},
			error : function() {
				alert('상세정보 조회 실패');			
			}
		}); // ajax end
	}
	
}

// 관리자 페이지에서 도서목록 띄우기
function adminbookListRender(map) {
	let output3 = ``;
	for(let b of map.bookList) {
		output3 +=`
		<tr>
			<td>${b.bookNo}</td>`;
			if(b.bookImage == '' || b.bookImage == null) {
				output3 +=
				`<td>이미지X</td>`;
			} else {
				output3 +=
				`<td><img src="${contextPath}/bookImgDisplay?category=${b.bookCategory.cate_id}/${b.bookSubCategory.subCate_id}&no=${b.bookNo}&imageFileName=${b.bookImage}" width="40px" height="40px"></td>`;
			}
		output3 +=`
			<td>${b.bookCategory.cate_name} / ${b.bookSubCategory.subCate_name}</td>
			<td>${b.bookName}</td>
			<td>${b.author}</td>
			<td>${b.publisher}</td>
			<td>${b.price}</td>
			<td>${b.regDate}</td>
			<td><button id="${b.bookNo}" type="button" class="btn btn-secondary btn-sm delBookBtn">삭제</button></td>
			<td><button id="${b.bookNo}" type="button" class="btn btn-success btn-sm openModifyForm">수정</button></td>
		</tr>`;
	}
	$('.bookList3 tbody').html(output3);
	
	// 수정폼 띄우기
	$('.openModifyForm').on('click', function() {
		let bookNo = $(this).attr('id');
		adminService.detail(bookNo);
	})
	
	// 도서상품 삭제버튼
	$('.delBookBtn').on('click', function(e) {
		e.preventDefault();
		let qq = confirm("삭제합니까?");
		if(qq) {
			//let bookNo = $(this).attr('id');
			let bookNo = parseInt($(this).attr('id'));
			let form = $('<form/>')
			form.attr('action',`${contextPath}/admin/removeBook?bookNo=${bookNo}`)
				.attr('method','post')
				.appendTo('body')
				.submit();
		}
	});
}

// 관리자 페이지 페이지네이션
function adminPaginationRender(p) {
	let output =`
		<ul class="pagination adminBookPagination">`;
		if(p.prev) {
			output +=
			`<li class="page-item">
				<a class="page-link" href="${p.startPage-1}">이전</a>
			</li>`;
		}
		for(let pageNum=p.startPage; pageNum<=p.endPage; pageNum++) {
			output +=
			`<li class="page-item ${p.criteria.page == pageNum ? 'active':''}">
				<a class="page-link" href="${pageNum}">${pageNum}</a>
			</li>`;
		}
		if(p.next) {
			output +=
			`<li class="page-item">
				<a class="page-link" href="${p.endPage+1 }">다음</a>
			</li>`;
		}
	output +=`</ul>`;
	$('#adminBookPagination').html(output);
	
	// 관리자 페이지에서 페이지 이동
	$('.adminBookPagination a').on('click',function(e){
		e.preventDefault();
		// 한번에 표시할 게시물 수, 검색한 내용, 카테고리 유지한 채로 페이지 이동 할 때 필요한거
		let criteria = {
			page : $(this).attr('href'), // 클릭한 페이지 번호
			perPageNum : 10,
			cate_id : p.criteria.cate_id,
			subCate_id : p.criteria.subCate_id,
			type : p.criteria.type, // 검색 할 때 필요한거
			keyword : p.criteria.keyword // 검색 할 때 필요한거
		}
		adminService.list(criteria);
	});	 
}

$(function(){
	
	let page = $('input[name="pageInfo"]').val(); // ${cri.page}
	
	let criteria = {
		page : 1,
		perPageNum : 10
	}
	adminService.list(criteria);
	
	// 검색 -> 검색 클릭하면 되는데 엔터치니깐 안됨...왜??
	$('.adminSearchBookForm button').on('click',function(){
		/* 카테고리 바꾸고 검색 했을 때*/
		let criteria = {
			page : 1,
			perPageNum : 10,
			cate_id : $('.adminSearchBookForm').children('.cate').val(),
			subCate_id : $('.adminSearchBookForm').children('.subCate').val(),
			type : $('.adminSearchBookForm').children('.type').val(), // 검색 할 때 필요한거
			keyword : $('.adminSearchBookForm input').val() // 검색 할 때 필요한거
		}
		adminService.list(criteria);
	});

// =========================등록관련===================================	
	// 도서등록 모달창 띄우기
	$('.addBook').on('click', function(){
		$('.registerBookForm li').not('li:eq(0)').remove(); // 첫번째 li 제외하고 다 지우기
		LiNumber = 1; // LiNumber 1로 초기화
		$('#addBookForm form').find('input').val('');
		$('#addBookForm form').find('.preview').html('');
		$('#addBookForm').modal('show');
	});
	
	// 대분류(#cate1)먼저 선택해야만 -> 소분류(#cate2) 보여지게 하는 거
	$('select[name="bookList[0].cate_id"]').on('change', function(){
		$('select[name="bookList[0].subCate_id"]').find('option').hide(); // 바꿀때 마다 #subCate 옵션 전체 숨김
		let selectedValue = $('select[name="bookList[0].cate_id"] option:selected').val(); // 선택된 값을 selectedValue 변수에 저장
		
		// 소분류 옵션에서 선택된 대분류 포함되어 있는거 찾아서...
		$('select[name="bookList[0].subCate_id"]').find('option[class='+selectedValue+']').each(function(index, item) {
			$(item).toggle(); // 보여주기
		});
		$('select[name="bookList[0].subCate_id"] option:eq(0)').prop("selected", true); // 첫번째 옵션으로 초기화
	});
	
	// 이미지 파일만 업로드
	$('input[id="attachFile[0]"').on('change', function() {
		if (this.files[0]) {
			let reader = new FileReader(); // 파일읽기 객체
			reader.onload = function(e) { // 파일을 읽으면 이벤트 발생
				let value = e.target.result;
				if (value.startsWith("data:image/")) { // 이미지 파일인 경우
					let imgTag = `<img src="${value}" alt="다운로드 이미지" width="300px" height="350px">`;
					$('input[id="attachFile[0]"').closest('li').find('.preview').html(imgTag);
				} else { // 이미지 파일이 아닌경우
					alert('이미지 파일만 등록하세요');
					$('input[id="attachFile[0]"').val('');
					$('input[id="attachFile[0]"').closest('li').find('.preview').html('');
				}
			}
			reader.readAsDataURL(this.files[0]); // 파일 읽기 메소드 호출
		}
	});
	
	// 폼추가 버튼
	let LiNumber = 1; // 처음 인덱스 값
	$('.addbookLiBtn').on('click', function() {
		if (LiNumber >= 5) {
			alert('더 이상 추가할 수 없음');
			return;
		}
		let bookLi = $('.registerBookForm li').eq(0).clone(); // .clone(true)
		bookLi.find('input').val(''); // input태그 모든값 삭제
		bookLi.find('.preview').html(''); // 미리보기 삭제
		bookLi.find('.cate_id option:eq(0)').prop("selected", true); // 카테고리 초기화
		
		// input 선택
		let bookImg = bookLi.find('.attachFile'); 
		let bookName = bookLi.find('.bookName'); 
		let author  = bookLi.find('.author'); 
		let publisher = bookLi.find('.publisher'); 
		let cate = bookLi.find('.cate_id'); 
		let subCate = bookLi.find('.subCate_id'); 
		let price = bookLi.find('.price'); 
		
		// name속성 변경
		let I = bookImg.attr("id").replace('0', LiNumber); 
		let B = bookName.attr("name").replace('0', LiNumber); 
		let A = author.attr("name").replace('0', LiNumber); 
		let H = publisher.attr("name").replace('0', LiNumber); 
		let C = cate.attr("name").replace('0', LiNumber); 
		let S = subCate.attr("name").replace('0', LiNumber); 
		let P = price.attr("name").replace('0', LiNumber); 
		
		// 변경한 name속성 설정
		bookImg.attr("id", I); 
		bookName.attr("name", B); 
		author.attr("name", A); 
		publisher.attr("name", H); 
		cate.attr("name", C); 
		subCate.attr("name", S); 
		price.attr("name", P); 
		$('.registerBookForm ul').append(bookLi); // ul태그에 추가
		
		$('.cate_id').on('change', function(){
			let selectedVal = $(this).val(); // 선택된 값
			
			$(this).closest('tr').find('.subCate_id option').each(function(index, item) {
				if($(item).attr('class')==selectedVal){
					$(item).show();		
				} else {
					$(item).hide();
				}
			});
			$(this).closest('tr').find('.subCate_id option').eq(0).prop("selected", true);
			
		});
		
		// 이미지 첨부 할 때 이벤트
		$('input[id="attachFile['+LiNumber+']"]').on('change', function() {
			let obj = $(this);
			if (this.files[0]) {
				let reader = new FileReader(); // 파일읽기 객체
				reader.onload = function(e) { // 파일을 읽으면 이벤트 발생
					//hello();
					let value = e.target.result;
					if (value.startsWith("data:image/")) { // 이미지 파일인 경우
						let imgTag = `<img src="${value}" alt="다운로드 이미지" width="300px" height="350px">`;
						obj.closest('li').find('.preview').html(imgTag); // $(this)안되네...
					} else { // 이미지가 아닌경우
						alert('이미지 파일만 등록하세요');
						obj.val('');
						obj.closest('li').find('.preview').html('');
					}
				}
				reader.readAsDataURL(this.files[0]); // 파일 읽기 메소드 호출
			}
		});
		
		LiNumber++; // 인덱스번호 증가
	});
	
	// 폼삭제 버튼
	$('.delbookLiBtn').on('click', function() {
		if (LiNumber <= 1) { // 폼이 하나만 있을 때 삭제할 수 없음
			alert('마지막 폼은 삭제할 수 없습니다.');
			return;
		}
		$('.registerBookForm li').eq(LiNumber - 1).remove(); // 마지막폼 삭제
		LiNumber--; // 인덱스 번호 감소
	})
	
	// 도서등록버튼 클릭 이벤트
	$('.registerBookBtn').on('click',function(e){
		e.preventDefault();
		$('.registerBookForm').attr('action',`${contextPath}/admin/registerBook`)
			.attr('method','post')
			.attr('enctype', 'multipart/form-data')
			.appendTo('body')
			.submit();
	});
	
	
// =================================카테고리 관리 =========================================	
	
	// 카테고리 삭제
	$('.delCate').on('click',function(e){
		e.preventDefault();
		let form = $('<form/>')
		let id = $(this).attr('href')
		form.attr('action',`${contextPath}/admin/delCate?id=`+id).attr('method','post').appendTo('body').submit();
	})
	// 서브 카테고리 삭제
	$('.delsubCate').on('click',function(e){
		e.preventDefault();
		let form = $('<form/>')
		let id = $(this).attr('href')
		form.attr('action',`${contextPath}/admin/delSubCate?id=`+id).attr('method','post').appendTo('body').submit()
	})

// ===========================수정, 삭제 관련 =========================================

	// 수정완료하기 버튼
	$('.modifyBookBtn').on('click', function(e){
		e.preventDefault();
		let bookNodata = $('input[name="bookNo"]');
		bookNodata.attr('type', 'number');
		$('.modifyBookForm').attr('action',`${contextPath}/admin/modifyBook`)
			.attr('method','post')
			.attr('enctype', 'multipart/form-data')
			.append(bookNodata)
			.appendTo('body')
			.submit();
	});
	
	// 수정폼에서 카테고리 변경 이벤트
	$('.cate1').on('change', function(){
		let selectedVal = $(this).val(); // 선택된 값
		$(this).closest('tr').find('.cate2 option').each(function(index, item) {
			if($(item).attr('class')==selectedVal){
				$(item).show();
				$(this).closest('tr').find('.cate2 option').eq(0).show();
			} else {
				$(item).hide();
			}
		});
		$(this).closest('tr').find('.cate2 option').eq(0).prop("selected", true);
	});
	
	// 수정폼에서 수정할 이미지 미리보기
	$('#modifyBookBookForm').find('input[type="file"]').on('change', function(){
		if (this.files[0]) {
			let reader = new FileReader(); // 파일읽기 객체
			reader.onload = function(e) { // 파일을 읽으면 이벤트 발생
				let value = e.target.result;
				if (value.startsWith("data:image/")) { // 이미지 파일인 경우
					let imgTag = '<img src="'+value+'" alt="다운로드 이미지" width="180px" height="220px">';
					$('input[name="attachFile"').closest('td').find('.changeImg').html(imgTag);
				} else { // 이미지 파일이 아닌경우
					alert('이미지 파일만 등록하세요');
					$('input[name="attachFile"').val('');
					$('input[name="attachFile"').closest('td').find('.changeImg').html('');
				}
			}
			reader.readAsDataURL(this.files[0]); // 파일 읽기 메소드 호출
		}
	});
	
	// 수정폼 닫기 버튼 파일폼, 미리보기 초기화
	$('.cancelModifyBtn').on('click', function(){
		$('input[name="attachFile"').val(''); 
		$('input[name="attachFile"').closest('td').find('.changeImg').html('');
		$('#modifyBookBookForm').modal('hide');
	});
	
})