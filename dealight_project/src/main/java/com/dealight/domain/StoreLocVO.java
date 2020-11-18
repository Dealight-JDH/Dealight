package com.dealight.domain;

import lombok.Data;

@Data
public class StoreLocVO {
	private Long storeId;
	private String addr;
	private Double lat;
	private Double lng;
	
}
