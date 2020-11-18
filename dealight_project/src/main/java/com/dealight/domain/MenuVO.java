package com.dealight.domain;

import lombok.Data;

@Data
public class MenuVO {
	private Long storeId;
	private Long menuSeq;
	private int price;
	private String imgUrl;
	private String name;
	private String recoMenu; 
}
