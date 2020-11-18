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
public class RsvdDtlsVO {
	
    // �����ȣ 
	@NonNull
    private Long rsvdId;

    // �����Ϸù�ȣ
	@NonNull
    private Long rsvdSeq;

    // �޴��̸�
	@NonNull
    private String menuNm;

    // �޴�����
	@NonNull
    private int menuTotQty;

    // �޴�����
	@NonNull
    private int menuPrc;

}
