package com.jafa.domain;

import com.jafa.domain.Bookshop.BookVO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@ToString
@NoArgsConstructor
@Builder
public class CartVO {
    
    private int cartNo; // 카트번호
	private String id; // 회원아이디
	private int bookNo; // 책번호
	private int amount; // 수량
	
	private MemberDTO memberDTO;
	private BookVO bookVO;
	
}
