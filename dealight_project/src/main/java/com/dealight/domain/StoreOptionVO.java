package com.dealight.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 
 *****[김동인] 
 * 
 */

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class StoreOptionVO {
	
    private Long storeId;

    private String park;

    private String nokids;

    private String pg;

    private String wifi;

    private String pet;

    private String smoke;

}
