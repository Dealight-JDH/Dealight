package com.dealight.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class WaitVO {

	// 웨이팅번호 
	private Long id;
	// 매장번호
	private Long storeId;


    // 회원아이디 
    private String userId;

    // 웨이팅접수시간 
    private Timestamp waitRegTm;

    // 웨이팅인원 
    private int waitPnum;

    // 고객연락처 
    private String custTelno;

    // 고객이름 
    private String custNm;

    // 웨이팅상태코드 
    private String waitStusCd;

    // 리뷰상태 
    private int revwStus;

    // composition
    // 매장
    private StoreVO store;
    //웨이팅 수
    private int waitTot;
	
}
