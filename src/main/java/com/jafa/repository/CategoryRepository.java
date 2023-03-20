package com.jafa.repository;

import java.util.List;

import javax.validation.Valid;

import com.jafa.domain.Bookshop.BookCategory;
import com.jafa.domain.Bookshop.BookSubCategory;

public interface CategoryRepository {

	// 카테고리 목록 불러오기
	List<BookCategory> getCateList();
	// 서브 카테고리 목록 불러오기
	List<BookSubCategory> getSubCateList();
	
	// 카테고리 추가
	void saveCate(BookCategory bookCategory);
	// 서브 카테고리 추가
	void saveSubCate(BookSubCategory bookSubCategory);
	
	// 카테고리 삭제
	void delCate(String id);
	// 서브 카테고리 삭제
	void delSubCate(String id);
	
	

}
