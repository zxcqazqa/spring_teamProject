package com.jafa.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.jafa.domain.CartVO;
import com.jafa.domain.Criteria;
import com.jafa.domain.Pagination;
import com.jafa.domain.Bookshop.BookCategory;
import com.jafa.domain.Bookshop.BookSubCategory;
import com.jafa.domain.Bookshop.BookVO;
import com.jafa.repository.BookRepository;
import com.jafa.repository.CartRepository;
import com.jafa.repository.CategoryRepository;

@RestController
@RequestMapping("/sample")
public class SampleController {
	
	@Autowired
	private BookRepository bookRepository;
	
	@Autowired
	private CategoryRepository categoryRepository;
	
	@Autowired
	private CartRepository cartRepository;
	
	// 도서목록
	@PostMapping("/list") // @GetMapping에 @RequestBody붙이니까 안됨
	public Map<String, Object> list(@RequestBody Criteria criteria) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<BookVO> bookList = bookRepository.selectByCategory(criteria);
		Pagination pagination = new Pagination(criteria, bookRepository.getTotalCount(criteria));
		map.put("bookList", bookList);
		map.put("p", pagination);
		map.put("cri", criteria);
		return map; 
	}
	
	// 도서 상세정보 
	@GetMapping("/detail")
	public Map<String, Object> detail(int bookNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		BookVO detail = bookRepository.findByBookNo(bookNo); 
		map.put("detail", detail); // 책번호로 조회
		return map;
	}
	
	// 장바구니 담기
	@PostMapping("/addCart")
	public Map<String, Object> addCart(@RequestBody CartVO vo) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<CartVO> cartList = cartRepository.findById(vo.getId()); // 회원아이디로 장바구니 조회
		boolean check = false; // 중복 = false
		String message ="";
		for (CartVO list : cartList) {
			if(vo.getBookNo() == list.getBookVO().getBookNo()) { // 장바구니 목록에 같은 책 번호 있으면...
				check = true; // 중복 = true
				message+="이미 장바구니에 있다!";
			}
		}
		if(!check) { // 중복 false일 때만
			cartRepository.addCart(vo); // 장바구니에 상품 추가
			message+="장바구니 담기 성공!";
		}
		map.put("message", message);
		return map; 
	}
	
	// 장바구니 상품 삭제
	@PostMapping("/delCart")
	public Map<String, Object> delCart(@RequestBody CartVO vo) {
		Map<String, Object> map = new HashMap<String, Object>();
		int cartNo = vo.getCartNo(); // 카트번호
		String id = vo.getId(); // 회원 아이디
		cartRepository.delCart(cartNo);
		map.put("id", id);
		return map;
	}
	
	// 0306 수정
	// 장바구니 상품 목록		
	@PostMapping("/cartList")
	public Map<String, Object> cartList(@RequestBody CartVO vo) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<CartVO> cartList = cartRepository.findById(vo.getId());
		map.put("cartList", cartList);
		return map;
	}
	
	// 장바구니 상품 수량 변경
	@PostMapping("/modifyCount")
	public Map<String, Object> modifyCount(@RequestBody CartVO vo) {
		Map<String, Object> map = new HashMap<String, Object>();
		cartRepository.updateCart(vo);
		String id = vo.getId(); // 회원 아이디
		map.put("id", id);
		return map;
	}
	
	@PostMapping("/order")
	public Map<String, Object> order(@RequestBody CartVO vo) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<CartVO> cartList = cartRepository.findById(vo.getId()); // 회원아이디로 장바구니 조회
		String message = "결제페이지로 이동";
		String name = cartList.get(0).getMemberDTO().getName();
		String email = cartList.get(0).getMemberDTO().getEmail();
		int price=0;
		int amount=0;
		int totalPrice =0;
		for (CartVO list : cartList) {
			price = list.getBookVO().getPrice();
			amount =list.getAmount();
			totalPrice += price * amount;
		}
		map.put("name", name);
		map.put("email", email);
		map.put("totalPrice", totalPrice);
		map.put("message", message);
		return map;
	}
	

}