package com.dealight.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.ToString;

@Data
@AllArgsConstructor
public class HtdlPageDTO {

//	private int startPage;
//	private int endPage;
//	private boolean prev, next;
//	
	private int total;
	//private HtdlCriteria hCri;
	private List<HtdlVO> lists;
	
//	public HtdlPageDTO(HtdlCriteria hCri, int total, List<HtdlVO> lists) {
//		super();
//		
//		this.hCri = hCri;
//		this.total = total;
//		this.lists = lists;
		
//		this.endPage = (int) (Math.ceil(hCri.getPageNum() / 10.0)) * 10;
//		this.startPage = this.endPage - 9;
//		
//		int realEnd = (int) (Math.ceil((total * 1.0) / hCri.getAmount()));
//		
//		if(realEnd < this.endPage) {
//			this.endPage = realEnd;
//		}
//		
//		this.prev = this.startPage > 1;
//		this.next = this.endPage < realEnd;
//	}
	
	
	
	
}
