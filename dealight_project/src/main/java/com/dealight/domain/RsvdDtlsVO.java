package com.dealight.domain;

import java.util.Date;

import lombok.Data;

@Data
public class RsvdDtlsVO {

    // 예약번호 
    private int rsvdId;

    // 예약일련번호 
    private int rsvdSeq;

    // 메뉴이름 
    private String menuNm;

    // 메뉴수량 
    private int menuTotQty;

    // 메뉴가격 
    private int menuPrc;
    
    private Date regdate;
    private Date updatedate;
}
