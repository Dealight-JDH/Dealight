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
	
    // 예약번호 
	@NonNull
    private long rsvdId;

    // 예약일련번호
	@NonNull
    private long rsvdSeq;

    // 메뉴이름
	@NonNull
    private String menuNm;

    // 메뉴수량
	@NonNull
    private int menuTotQty;

    // 메뉴가격
	@NonNull
    private int menuPrc;

}
