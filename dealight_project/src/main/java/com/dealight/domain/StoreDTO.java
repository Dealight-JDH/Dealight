package com.dealight.domain;

import lombok.Data;

@Data
public class StoreDTO {

	private Long storeId;
	private String name;
	private String buserId;
	private int rsvdRate;
	private int htdlRate;
	private boolean suggestChecked = true;
}
