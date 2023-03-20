let cartService = {
	
	// 장바구니 상품 목록
	list : function(cartVO) {
		$.ajax({
			type : 'post',
			url : `${contextPath}/sample/cartList`,
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(cartVO),
			
			success : function(map) {
				let cartList = map.cartList;
				cartListRender(cartList);
			},
			error : function() {
				alert('장바구니 목록 불러오기 실패');			
			}
		}); 
	},
	
	// 삭제
	remove : function(cartVO) {
		$.ajax({
			type : 'post',
			url : `${contextPath}/sample/delCart`,
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(cartVO),
			
			success : function(map) {
				cartService.list(map);
			},
			error : function() {
				alert('삭제 실패')		
			}
		});
	},
	
	// 장바구니 상품 수량 변경
	modifyCount : function(cartVO) {
		$.ajax({
			type : 'post',
			url : `${contextPath}/sample/modifyCount`,
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(cartVO),
			
			success : function(map) {
				cartService.list(map);
			},
			error : function() {
				alert('실패')		
			}
		});
	},
	
	// 주문하기
	order : function(cartVO) {
		$.ajax({
			type : 'post',
			url : `${contextPath}/sample/order`,
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(cartVO),
			
			success : function(map) {
				alert(map.message);
				alert(map.name+'님'+' 총금액 :'+ map.totalPrice+'원' + ' 이메일(주소나 배송지) : ' +map.email);
				
			},
			error : function() {
				alert('실패');			
			}
		}); 
	}
	
};

// 장바구니 상품 목록 렌더링
function cartListRender(cartList) {
	let output = ``;
	for(let c of cartList) {
		output +=
		`<tr class="text-center">
			<input type="hidden" name="cartNo" value="${c.cartNo}">
			<input type="hidden" name="bookNo" value="${c.bookNo}">
			<input type="hidden" name="price" value="${c.bookVO.price}">
			<td>${c.bookVO.bookNo}</td>
			<td><img src="${contextPath}/bookImgDisplay?category=${c.bookVO.bookCategory.cate_id}/${c.bookVO.bookSubCategory.subCate_id}&no=${c.bookVO.bookNo}&imageFileName=${c.bookVO.bookImage}" width="40px" height="40px"></td>
			<td>${c.bookVO.bookCategory.cate_name}/${c.bookVO.bookSubCategory.subCate_name}</td>
			<td>${c.bookVO.bookName}</td>
			<td>${c.bookVO.price}</td>
			<td>
				<div class="Calculator">
					<button type="button" class="decrease_amount">-</button>
					<input type="number" name="amount" value="${c.amount}" readonly="readonly" style = "width: 50px">
					<button type="button" class="increase_amount">+</button>
				</div>
			</td>
			<td>
				<div class="result">
					<input type="hidden" name="totalPrice" value="${c.bookVO.price * c.amount}">
					${c.bookVO.price * c.amount}
				</div>
			</td>
			<td>
				<button type="button" class="btn btn-secondary delCart">삭제</button>
			</td>
		</tr>`;
	}
	$('.cartList tbody').html(output);
	
	let id = $('input[name="id"]').val();
	let cartNoObj = $('input[name="cartNo"]');
	let bookNoObj = $('input[name="bookNo"]');
	
	let priceValue = $('input[name="price"]').val();
	let amountObj = $('input[name="amount"]');
	let totalPrice = $('input[name="totalPrice"]');
	let sum = $('input[name="sum"]');
	
	// 합계
	let i = 0;
	$(totalPrice).each(function(index, item) {
		let value = $(item).val();
		i += parseInt(value);
	});
	sum.val(i);
	$('.sum span').html(sum.val());
	
	// -버튼
	$('.decrease_amount').on('click', function(){
		let cartNo = $(this).closest('tr').find($('input[name="cartNo"]')).val();
		let amount = $(this).closest('tr').find($('input[name="amount"]')).val();
		if (amount > 1) {
			amount--;
		}
		let cartVO = {
			id : id,
			cartNo : cartNo,
			amount : amount
		}		
		cartService.modifyCount(cartVO);
	});
	
	// +버튼
	$('.increase_amount').on('click', function(){
		let cartNo = $(this).closest('tr').find($('input[name="cartNo"]')).val();
		let amount = $(this).closest('tr').find($('input[name="amount"]')).val();
		if (amount < 10) {
			amount++;
		}
		let cartVO = {
			id : id,
			cartNo : cartNo,
			amount : amount
		}		
		cartService.modifyCount(cartVO);
	});
	
	// 삭제버튼
	$('.delCart').on('click', function(){
		let qq = confirm('정말 삭제합니까?');
		if(qq) {
			let cartNo = $(this).closest('tr').find(cartNoObj).val();
			let cartVO = {
				id : id,
				cartNo : cartNo,
			}	
			cartService.remove(cartVO);
		}
	});
	
}

$(function() {
	
	// 회원 아이디로 장바구니 조회
	let cartVO = {
		id : $('input[name="id"]').val()
	} 
	cartService.list(cartVO);
	
	$('.orderBtn').on('click', function(){
		cartService.order(cartVO);
	})

});