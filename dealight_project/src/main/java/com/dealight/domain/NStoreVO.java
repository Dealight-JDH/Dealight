package com.dealight.domain;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
/*
 * 
 *****[김동인] 
 * 
 */
//다울
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class NStoreVO {

	private Long storeId;
	//비즈타임
	private String bizTm;
	private String menu;
}
