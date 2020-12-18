package com.dealight.domain;

import lombok.Data;

@Data
public class SugRequestDTO {

	private Long storeId;
	private String buserId;
	private String htdlName;
	private String startTm;
	private String endTm;
	private int lmtPnum;
	
	
}
