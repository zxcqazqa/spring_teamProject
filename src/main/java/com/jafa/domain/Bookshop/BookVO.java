package com.jafa.domain.Bookshop;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BookVO {
    
	// join써서 카테고리테이블에서 cate_name 불러오는 것 보다 book테이블에 cate_name까지 넣는게 더 편해보이는데....흠
	private BookCategory bookCategory; 
	private BookSubCategory bookSubCategory;
    
    private int bookNo; // 책 번호
	private String cate_id; // 카테
	private String subCate_id; // 서브카테
	private String bookName; // 책 제목
	private String author; // 저자
	private String publisher; // 출판사
	private String bookImage; // 이미지
	private int price; // 가격
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	private Date regDate; // 등록일
	
	private String take; //대여
	private int takePrice; //대여금액
	private Date takeDate; //대여일자
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private Date returnDate; //반납일자
	private String reason; // 거절시 사유
}
