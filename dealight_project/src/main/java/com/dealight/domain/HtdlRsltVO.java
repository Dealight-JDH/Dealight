package com.dealight.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class HtdlRsltVO {
	
    // �ֵ���ȣ 
	@NonNull
    private Long htdlId;

    // �����ȣ 
	@NonNull
    private Long storeId;

    // ���������ο�
	@NonNull
    private int lastPnum;

    // �ֵ������ο�
	@NonNull
    private int htdlLmtPnum;

    // ����� 
	@NonNull
    private double rsvdRate;

    // ����ð�
	@NonNull
    private String elapTm;

}
