package com.dealight.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class StoreTagVO {
	// 매장번호
	private Long storeId;
	// 해시태그이름
	private String tagNm;

}