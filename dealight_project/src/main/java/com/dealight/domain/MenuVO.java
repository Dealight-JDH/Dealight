package com.dealight.domain;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
<<<<<<< HEAD

/*
 * 
 *****[김동인] 
 * 
 */

=======
//다울
>>>>>>> 79af8c3586777c0e774c0dad7d5e2e7baef0ba38
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
}
