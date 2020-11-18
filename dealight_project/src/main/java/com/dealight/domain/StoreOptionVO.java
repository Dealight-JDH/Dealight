package com.dealight.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class StoreOptionVO {
	
    // 매장번호 
    private long storeId;

    // 주차가능여부 
    private String park;

    // 노키즈 
    private String nokids;

    // 놀이터 
    private String pg;

    // 와이파이 
    private String wifi;

    // 애완동물동반가능여부 
    private String pet;

    // 흡연실 
    private String smoke;

}
