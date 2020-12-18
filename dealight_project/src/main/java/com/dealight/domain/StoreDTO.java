package com.dealight.domain;

import lombok.Data;

@Data
public class StoreDTO {

	private Long storeId;
	private String name;
	private String buserId;
	private boolean suggestChecked =true;
}
