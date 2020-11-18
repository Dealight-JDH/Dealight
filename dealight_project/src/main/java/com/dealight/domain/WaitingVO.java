package com.dealight.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class WaitingVO {
	
	// �����ù�ȣ
	@NonNull
    private Long id;

    // �����ȣ
    @NonNull
    private Long storeId;

    // ȸ�����̵� 
    private String userId;

    // �����������ð� 
    @NonNull
    @Builder.Default
    private Date waitRegTm = new Date();

    // �������ο�
    @NonNull
    private int waitPnum;

    // ������ó
    @NonNull
    private String custTelno;

    // ���̸�
    @NonNull
    private String custNm;

    // �����û����ڵ�
    @NonNull
    @Builder.Default
    private String waitStusCd = "W";
    
    private Date inDate;

}
