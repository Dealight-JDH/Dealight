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
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MenuVO {
	private Long storeId;
	private Long menuSeq;
	private int price;
	private String imgUrl;
	private String name;
	private String recoMenu; 
	private String thumImgUrl;
	private String encThumImgUrl;
}
