package com.dealight.domain;

import lombok.Data;
import lombok.Getter;

@Data
public class HtdlCriteria {

	private int pageNum;
	private int amount;
	
	public HtdlCriteria() {
		this(1,9);
	}
	
	public HtdlCriteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
}
