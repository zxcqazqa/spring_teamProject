package com.jafa.domain;

import java.util.Date;

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
public class HopeVO {
	
	private Long rno;	//신청번호
	private Long mno;	//회원 번호
	private String id;
	private String name; //회원이름
	private String nbookName; //새책 이름
	private String nbookWriter; //새책 저자
	private String npublisher; // 새책 출판사
	private Date requestDate; // 신청날짜
	private String result; // 신청결과 
	private String etc; //비고 거절시 사유 입력
	
	
}
