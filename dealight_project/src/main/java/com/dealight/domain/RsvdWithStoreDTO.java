package com.dealight.domain;

import lombok.Data;

@Data
public class RsvdWithStoreDTO {

	private Long rsvdId;
	private Long storeId;
	private Long htdlId;
	private String buserId;
	private int pnum;
	private String time;
	private String stusCd;
	private int totRsvd;
	private int totHtdlRsvd;
	private int acmPnum;
	
}
