package com.dealight.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StoreEvalVO {
	
	private Long storeId;
	private Double avgRating;
	private int revwTotNum;
	private int likeTotNum; 
	
}
