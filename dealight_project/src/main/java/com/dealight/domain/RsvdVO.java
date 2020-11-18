package com.dealight.domain;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class RsvdVO {
	
	// composition
	private List<RsvdDtlsVO> rsvdDtlsList;
	
    // �����ȣ 
    private Long id;

    // �����ȣ
    private Long storeId;

    // ȸ�����̵�
    private String userId;

    // �ֵ���ȣ 
    private Long htdlId;

    // �������ι�ȣ 
    private int aprvNo;

    // �����ο�
    private int pnum;

    // ����ð�
    private String time;

    // ��������ڵ�
    private String stusCd = "P";

    // �����Ѿ�
    private int totAmt;

    // �Ѹ޴�����
    private int totQty;
    
    private Date inDate;
    
    private String strInDate;

}
