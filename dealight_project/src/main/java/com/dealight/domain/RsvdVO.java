package com.dealight.domain;

import java.util.Date;

import lombok.Data;

@Data
public class RsvdVO {

	 // 예약번호 
    private int id;

    // 매장번호 
    private int storeId;

    // 회원아이디 
    private String userId;

    // 핫딜번호 
    private int htdlId;

    // 결제승인번호 
    private int aprvNo;

    // 예약인원 
    private int pnum;

    // 예약시간 
    private String time;

    // 예약상태코드 
    private String stusCd;

    // 예약총액 
    private int totAmt;

    // 총메뉴수량 
    private int totQty;
    
    private Date regdate;
    private Date updatedate;
    
    // 리뷰상태
    private int revwStus;
    
    // composition
    // 리뷰 상세
    private RsvdDtlsVO dtls;
    // 매장
    private StoreVO store;
    
}
