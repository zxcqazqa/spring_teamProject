package com.jafa.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Pagination {
	private Criteria criteria;
	
	private int startPage; 
	private int endPage; 
	private int tempEndPage; 
	private int displayPageNum; 
	
	private boolean prev; 
	private boolean next; 
	
	public Pagination(Criteria criteria, int totalCount) {
		this.criteria = criteria;
		this.displayPageNum = 10;

		endPage = (int) Math.ceil(criteria.getPage()/(double)displayPageNum)*displayPageNum;
		startPage = endPage - displayPageNum + 1;
		tempEndPage = (int) Math.ceil((double)totalCount/criteria.getPerPageNum());
		
		prev = startPage != 1; 
		next = endPage < tempEndPage;
		
		if(endPage>tempEndPage) endPage = tempEndPage;
	}
}
