package com.jafa.repository;

import java.util.List;

import com.jafa.domain.CartVO;

public interface CartRepository {

	// 회원아이디로 장바구니 조회
	List<CartVO> findById(String id);
	
	// 장바구니 담기
	void addCart(CartVO vo);
	
	// 장바구니 상품 삭제
	void delCart(int cartNo);
	
	// 장바구니 상품 수량 변경
	void updateCart(CartVO vo);
	
	// 장바구니에 담긴 상품 갯수
	int getCount(String id);
	

	

}
