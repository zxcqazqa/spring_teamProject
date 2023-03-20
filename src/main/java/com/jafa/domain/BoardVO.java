package com.jafa.domain;

import java.util.Date;

import org.apache.ibatis.type.Alias;

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
public class BoardVO {
	private Long bno;
	private String tid;
	private String title;
	private String content;
	private String writer;
	private Date writeDate;
	private String imageFileName;
	private FileType fileType;

	public enum FileType{
		IMAGE, OTHER;
	}
}