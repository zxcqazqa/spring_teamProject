package com.jafa.domain.Bookshop;

import javax.validation.constraints.NotBlank;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BookCategory {

	@NotBlank(message = "아이디는 필수 항목입니다.")
	private String cate_id; // 카테 아이디
	@NotBlank(message = "이름는 필수 항목입니다.")
	private String cate_name; // 카테 네임
}
