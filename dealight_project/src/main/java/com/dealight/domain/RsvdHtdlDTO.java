package com.dealight.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class RsvdHtdlDTO {

	private Long rsvdId;
	private Long htdlId;
	private String stusCd;
	
}
