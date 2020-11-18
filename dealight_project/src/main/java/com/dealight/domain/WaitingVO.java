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
	
	// 웨이팅번호
	@NonNull
    private long id;

    // 매장번호
    @NonNull
    private long storeId;

    // 회원아이디 
    private String userId;

    // 웨이팅접수시간 
    @NonNull
    @Builder.Default
    private Date waitRegTm = new Date();

    // 웨이팅인원
    @NonNull
    private int waitPnum;

    // 고객연락처
    @NonNull
    private String custTelno;

    // 고객이름
    @NonNull
    private String custNm;

    // 웨이팅상태코드
    @NonNull
    @Builder.Default
    private String waitStusCd = "W";
    
    private Date inDate;

}
