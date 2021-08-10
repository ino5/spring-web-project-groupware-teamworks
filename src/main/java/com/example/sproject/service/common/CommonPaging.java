package com.example.sproject.service.common;

import lombok.Data;

@Data
public class CommonPaging {
	private int	currentPage;		
	private int rowPage; //한 페이지에 몇 줄인지
	private int pageBlock; //보여줄 페이지 버튼의 수
	private int start;					
	private int end;
	private int startPage;				
	private int endPage;
	private int total;					
	private int totalPage;
	
	private final int DEFAULT_CURRENT_PAGE = 1;
	private final int DEFAULT_ROW_PAGE = 10;
	private final int DEFAULT_PAGE_BLOCK = 10;
	
	public CommonPaging(int total, Integer currentPage) {		
		this.total = total;
		this.currentPage = currentPage != null ? currentPage : DEFAULT_CURRENT_PAGE;
		this.rowPage = DEFAULT_ROW_PAGE;
		this.pageBlock = DEFAULT_PAGE_BLOCK;
		doPaging();
	}
	
	
	public CommonPaging(int total, Integer currentPage, int rowPage, int pageBlock) {		
		this.total = total;
		this.currentPage = currentPage != null ? currentPage : DEFAULT_CURRENT_PAGE;
		this.rowPage = rowPage;
		this.pageBlock = pageBlock;
		doPaging();
	}
	
	private void doPaging() {
		start = (currentPage -1) * rowPage + 1;	// 시작 record 번호
		end	  = start + rowPage -1;				// 마지막 record 번호
		totalPage = (int) Math.ceil((double)total / rowPage);	// 전체 페이지 수
		startPage = currentPage -  (currentPage -1) % pageBlock; // 시작 페이지 값은 페이지블럭 단위의 배수 + 1
		endPage = startPage + pageBlock -1; // 마지막 페이지 블럭 값
		if (endPage > totalPage) { // 마지막 페이지 블럭 값은 무조건 전체 페이지 수 이하
			endPage = totalPage;
		}		
	}
}
