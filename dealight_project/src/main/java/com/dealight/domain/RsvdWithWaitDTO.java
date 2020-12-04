package com.dealight.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class RsvdWithWaitDTO {

	private Long storeId;
	private String userId;
	private String time;
	private int revwStus;
	private RsvdVO rsvd;
	private WaitVO wait;
	
}
