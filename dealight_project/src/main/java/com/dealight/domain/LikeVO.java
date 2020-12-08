package com.dealight.domain;

/*
 * 
 *****[김동인] 
 * 
 */

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class LikeVO {
	
    private String userId;

    private Long storeId;
    
    private String regdate;
    
    private String updatedate;

}
