package com.dealight.domain;

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
	
    // ȸ�����̵� 
    private String userId;

    // �����ȣ 
    private Long storeId;

}
