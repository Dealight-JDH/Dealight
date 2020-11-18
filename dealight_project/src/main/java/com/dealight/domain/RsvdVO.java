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
	
    // 예약번호 
    private long id;

    // 매장번호
    private long storeId;

    // 회원아이디
    private String userId;

    // 핫딜번호 
    private long htdlId;

    // 결제승인번호 
    private int aprvNo;

    // 예약인원
    private int pnum;

    // 예약시간
    private String time;

    // 예약상태코드
    private String stusCd = "P";

    // 예약총액
    private int totAmt;

    // 총메뉴수량
    private int totQty;
    
    private Date inDate;
    
    private String strInDate;

}
