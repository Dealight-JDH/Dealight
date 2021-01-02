package com.dealight.domain;

import java.util.Date;

import javax.validation.constraints.NotNull;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class HtdlWithStoreDTO {

	private Long htdlId;
	private String htdlName;
	private Long storeId;
	private String name;
	private String time;
	private String stusCd;
	private int rsvdRate;
	private Date regDate;

	private boolean suggestChecked;
	
}
