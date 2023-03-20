console.log('북서비스');

let bookService = {
	
	// 목록
	list : function(criteria) {
		
		$.ajax({
			type : 'post',
			url : `${contextPath}/sample/list`,
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(criteria),
			
			success : function(map) {
				let p = map.p;
				bookListRender(map);
				paginationRender(p);
			},
			error : function() {
				alert('목록 조회 실패');			
			}
		}); // ajax end
	},
	
	// 장바구니 담기
	addCart : function(cartVO) {
		$.ajax({
			type : 'post',
			url : `${contextPath}/sample/addCart`,
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(cartVO),
			
			success : function(map) {
				alert(map.message);
			},
			error : function() {
				alert('실패')	;			
			}
		}); 
	}
	
};

// ==================================도서목록 렌더링 ========================================
function bookListRender(map) {
	let output = ``;
	for(let b of map.bookList) {
		output +=`
		<tr>
			<td>${b.bookNo}</td>`;
			if(b.bookImage == '' || b.bookImage == null) {
				output +=
				`<td>이미지X</td>`;
			} else {
				output +=
				`<td><img src="${contextPath}/bookImgDisplay?category=${b.bookCategory.cate_id}/${b.bookSubCategory.subCate_id}&no=${b.bookNo}&imageFileName=${b.bookImage}" width="40px" height="40px"></td>`;
			}
		output +=`
			<td>${b.bookCategory.cate_name} / ${b.bookSubCategory.subCate_name}</td>
			<td><a id="${b.bookNo}" href="${contextPath}/book/detail?bookNo=${b.bookNo}">${b.bookName}</a></td>
			<td>${b.author}</td>
			<td>${b.publisher}</td>
			<td>${b.price}</td>
			<td>${b.regDate}</td>
		</tr>`;
	}
	$('.bookList1 tbody').html(output);
	
	// 화면2
	let output2 =`<ul class="bookList2">`;
	for(let b of map.bookList) {
		output2 +=`
		<li>
			<div id="bookImgArea">`;
		if(b.bookImage == '' || b.bookImage == null) {
			output2 +=`
				<p>이미지X</p>
			</div>`;
		} else {
			output2 +=`
				<a id="${b.bookNo}" href="${contextPath}/book/detail?bookNo=${b.bookNo}">
					<img src="${contextPath}/bookImgDisplay?category=${b.bookCategory.cate_id}/${b.bookSubCategory.subCate_id}&no=${b.bookNo}&imageFileName=${b.bookImage}" width="180px" height="220px">
				</a>
			</div>`;
		}
		output2 +=`
			<div>
				<span>${b.bookCategory.cate_name} / ${b.bookSubCategory.subCate_name}</span><br>
				<span><a id="${b.bookNo}" href="${contextPath}/book/detail?bookNo=${b.bookNo}">${b.bookName}</a></span><br>
				<span>저자 : ${b.author}</span>
				<span>출판사 : ${b.publisher}</span><br>
				<span>가격 : ${b.price}</span><br>
			</div>
		</li>`;
	}
	output2 +=`</ul>`;
	$('.bookList2').html(output2);

	// 제목 클릭하면 상세 페이지로 이동
	$('.bookList a').on('click', function(e){
		e.preventDefault();
		let bookNo = $(this).attr('id'); // 자신의 id="${b.bookNo}"속성 가져옴
		// 상세페이지로 이동할 때 현재 페이지, 카테고리, 검색조건 가지고 감 -> 목록으로 돌아갈 때 사용하려고
		let page = map.cri.page; // 현재 페이지
		let cate_id = map.cri.cate_id; // 카테고리
		let subCate_id = map.cri.subCate_id; // 카테고리
		let type = map.cri.type; // 검색타입
		let keyword = map.cri.keyword; // 검색키워드
		
		let form = $('<form>');
		form.attr('method','post')
			.attr('action',`${contextPath}/book/detail?bookNo=${bookNo}`)
			.append(getInputHiddenTag('page', page))
			.append(getInputHiddenTag('cate_id', cate_id))
			.append(getInputHiddenTag('subCate_id', subCate_id))
			.append(getInputHiddenTag('type', type))
			.append(getInputHiddenTag('keyword', keyword))
			.append(getInputHiddenTag('perPageNum', $('input[name="perPage"]').val()))
			.appendTo('body')
			.submit();
	});
	
}

// ==================================페이지네이션 렌더링====================================
function paginationRender(p) {
	let output =`
		<ul class="pagination bookPagination">`;
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
	$('#bookPagination').html(output);
	
	// 페이지이동
	$('.bookPagination a').on('click',function(e){
		e.preventDefault();
		let typeValue = $('select[name="type"]').val(); // 셀렉트태그에서 선택된 값
		let keywordValue = $('input[name="keyword"]').val(); // input[name="keyword"]태그 값
		
		// 한번에 표시할 게시물 수, 검색한 내용, 카테고리 유지한 채로 페이지 이동 할 때 필요한거
		let criteria = {
			page : $(this).attr('href'), // 클릭한 페이지 번호
			perPageNum : p.criteria.perPageNum,
			cate_id : p.criteria.cate_id,
			subCate_id : p.criteria.subCate_id,
			type : typeValue,
			keyword : keywordValue
		}
		bookService.list(criteria); // 해당 페이지 리스트 새로 불러옴
	});

}

$(function() {
	
	let page = $('input[name="pageInfo"]').val();
	let cate_id = $('#cate option:selected').val(); // 셀렉트태그에서 선택된 값
	let subCate_id = $('#subCate option:selected').val();  // 셀렉트태그에서 선택된 값
	let typeValue = $('select[name="type"]').val(); // // 셀렉트태그에서 선택된 값
	let keywordValue = $('input[name="keyword"]').val(); // input[name="keyword"]태그 값
	let perPage = $('.perPage'); // input[class="perPage"]태그 가져오기

	let criteria = {
		page : page,
		perPageNum : perPage.val(),
		cate_id : cate_id,
		subCate_id : subCate_id,
		type : typeValue, // 검색 할 때 필요한거
		keyword : keywordValue // 검색 할 때 필요한거
	}
	bookService.list(criteria);




	
// ========================== 검색관련 ========================================	
	
	
	
	// 선택한 카테고리와 관련없는 것들 숨기기
	$('.subCate option').each(function(index, item){
		if($(item).attr('class')==cate_id){
			$(item).show();
			$('.subCate option:eq(0)').show(); // 첫번째 옵션은 무조건 나오게
		} else {
			$(item).hide();
		}
	})
	
	// 카테고리 변경 이벤트
	$('.cate').on('change', function(){
		let selectedVal = $(this).val(); // 선택된 값
		
		// 선택된 카테고리에 해당하는 하위 항목 띄워주기
		$(this).closest('div').find('.subCate option').each(function(index, item) {
			if($(item).attr('class')==selectedVal){
				$(item).show();	
				$(this).closest('div').find('.subCate option').eq(0).show();	
			} else {
				$(item).hide();
			}
		});
		$(this).closest('div').find('.subCate option').eq(0).prop("selected", true);
	});
	
	// 검색
	$('.searchBookForm button').on('click',function(){
		/* 카테고리 바꾸고 검색 했을 때*/
		let cate_id = $('#cate option:selected').val(); // // 셀렉트태그에서 선택된 값
		let subCate_id = $('#subCate option:selected').val(); // 셀렉트태그에서 선택된 값
		
		let searchForm = $('.searchBookForm');
		if(cate_id != '' && subCate_id != '') { // 대분류, 소분류 둘 다 선택
			searchForm.attr('action',`${contextPath}/book/list/${cate_id}/${subCate_id}`)
		} else { // 대분류만 선택
			searchForm.attr('action',`${contextPath}/book/list/${cate_id}`)
		}
		searchForm.append($('<input/>', {type: 'number', name: 'perPageNum', value: ''+perPage.val() }))
			.appendTo('body')
			.submit();
	});






// =================================== 화면전환 ============================================	
	
	$('.bookList1').hide();
	// 화면1
	$('.view1').on('click', function(){
		$('.bookList1').show();
		$('.bookList2').hide();
	});
	// 화면2
	$('.view2').on('click', function(){
		$('.bookList2').show();
		$('.bookList1').hide();
	})
	
	// 10개씩 보기
	$('.per10').on('click', function(){
		perPage.val('10');
		let criteria = {
			page : page,
			perPageNum : perPage.val(),
			cate_id : cate_id,
			subCate_id : subCate_id,
			type : typeValue, // 검색 할 때 필요한거
			keyword : keywordValue // 검색 할 때 필요한거
		}
		bookService.list(criteria);
	});
	
	// 20개씩 보기
	$('.per20').on('click', function(){
		perPage.val('20');
		let criteria = {
			page : page,
			perPageNum : perPage.val(),
			cate_id : cate_id,
			subCate_id : subCate_id,
			type : typeValue, // 검색 할 때 필요한거
			keyword : keywordValue // 검색 할 때 필요한거
		}
		bookService.list(criteria);
	});



// ======================================상세페이지에서 쓰는 거 ==============================================	
	
	// 목록버튼 클릭 이벤트
	$('.toBookList').on('click', function(){
		let cate_id = $('input[name="cateInfo"]').val();
		let subCate_id = $('input[name="subCateInfo"]').val();
		let perPageNum = getInputHiddenTag('perPageNum', $('input[name="perPage"]').val());
		perPageNum.attr('type', 'number');
		let form = $('<form>');
		form.attr('method','get')
		if(cate_id != '' && subCate_id != '') { // cate_id, subCate_id 둘 다 있으면
			form.attr('action',`${contextPath}/book/list/${cate_id}/${subCate_id}`)
		}
		else if(cate_id != '' && subCate_id == ''){ // cate_id만 있으면
			form.attr('action',`${contextPath}/book/list/${cate_id}`)
		}
		else {
			form.attr('action',`${contextPath}/book/list`)
		}
		form.append(getInputHiddenTag('page', $('input[name="pageInfo"]').val()))
			.append(getInputHiddenTag('type', $('input[name="typeInfo"]').val()))
			.append(getInputHiddenTag('keyword', $('input[name="keywordInfo"]').val()))
			.append(perPageNum)
			.appendTo('body')
			.submit();
	});
	
	
	let priceValue = $('input[name="price"]').val(); // 상품가격
	let amountObj = $('input[name="amount"]'); // 수량
	let totalPriceObj = $('input[name="totalPrice"]'); // 총 금액(수량 * 가격)
	let count = amountObj.val();
	// 수량감소
	$('.minus').on('click', function() {
		count--; // 1감소
		if(count < 1) { // 1보다 작은경우
			count =1; // 최소값 1
		}
		amountObj.val(count);
		totalPriceObj.val(priceValue * count);
	});
	// 수량증가
	$('.plus').on('click',function(){
		count++; // 1증가
		if(count > 10) { // 10보가 큰경우
			count = 10; // 최대 10까지
		}
		amountObj.val(count);
		totalPriceObj.val(priceValue * count);
	});
	
	// 장바구니 담기 버튼
	$('.addCart').on('click', function() {
		let cartVO = {
			id : $('input[name="id"]').val(),
			bookNo : $('input[name="bookNo"]').val(),
			amount : amountObj.val()
		}
		bookService.addCart(cartVO);
	});
	
});