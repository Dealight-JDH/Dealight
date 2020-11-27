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
public class MenuVO {
	private Long storeId;
	private Long menuSeq;
	private int price;
	private String imgUrl = "menu_default.png";
	private String name;
	private String recoMenu; 
	private String thumImgUrl = "menu_default.png";
}
