package com.jafa.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.jafa.domain.Bookshop.BookCategory;
import com.jafa.domain.Bookshop.BookSubCategory;
import com.jafa.domain.Bookshop.BookVO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
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
public class MemberVO {

	private int mno; 
	private String id;  
	private String pwd;
	private String name;
	private int age; // <-null, 0
	private String gender;
	private String email;
	private String profile; //사진정보
	private FileType fileType;

public enum FileType{
		IMAGE, OTHER;
}
}