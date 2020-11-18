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
	
    // �����ȣ 
    private Long storeId;

    // �������ɿ��� 
    private String park;

    // ��Ű�� 
    private String nokids;

    // ������ 
    private String pg;

    // �������� 
    private String wifi;

    // �ֿϵ������ݰ��ɿ��� 
    private String pet;

    // ���� 
    private String smoke;

}
