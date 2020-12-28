package com.dealight.domain;

import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
public class HtdlSearchDTO {

	@NotNull
	private String region;
	@NotNull
	private String startTm;
	@NotNull
	private String endTm;
	
	
}
