package com.dealight.domain;

import lombok.Data;


@Data
public class RsvdRequestInfoDTO {
	
	private Long storeId;
	private Long htdlId;
	
	private String pnum;
	private String time;

}
