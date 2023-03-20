package com.jafa.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.jafa.domain.Criteria;
import com.jafa.domain.Bookshop.BookVO;

public interface BookRepository {

	// 게시물(책) 목록
	List<BookVO> selectByCategory(Criteria criteria);
	// 가장 최근에 등록한 도서 목록 최대(5개)
	List<BookVO> latestList();

	// 총 게시물(책) 수
	int getTotalCount(Criteria criteria);

	// 게시물(책) 상세
	BookVO findByBookNo(int bookNo);
	List<Map<String, Integer>> bookOfCate();
	List<Map<String, Integer>> bookOfSubCate();
	// 게시물(책) 등록
	void insertBook(BookVO vo);
	
	// 도서 상품 수정
	void updateBook(BookVO vo);

	// 도서상품 삭제
	void deleteBook(int bookNo);
	
	List<BookVO> bookList();
	void addBook(@Param("bookList") List<BookVO> bookList);
//--------------------------대여-------------------//
	//대여현황 목록
	List<BookVO> getTakeList(Criteria criteria);
	
	//신청받으면 take컬럼 업데이트 시키기
	void requestTake(String bookName);

	//대여신청받은목록(신청대기자만 관리자페이지에서 테이블로 표기)
	List<BookVO> takeMaster(Criteria criteria);
	//대여승인해주면 take컬럼 신청대기에서->대여중으로 업데이트
	void yesUpdate(String bookName);
	//대여를 거절하면 take컬럼 신청대기->거절로 업데이트하면서 거절사유까지 업데이트 하기
	void noUpdate(@Param("bookName") String bookName,@Param("reason") String reason);
	int getTakeTotalCount(Criteria criteria);
}
