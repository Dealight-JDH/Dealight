package com.dealight.domain;
// 수빈
import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotNull;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

/*
 * 
 *****[김동인] 
 * 
 */

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
//다울
public class WaitVO {
	
    private Long waitId;

    @NonNull
    private Long storeId;

    private String userId;

    private String waitRegTm;

    private int waitPnum;

    @NonNull
    private String custTelno;

    @NonNull
    private String custNm;

    @NonNull
    private String waitStusCd = "W";

    // 리뷰상태 
    @NotNull
    private int revwStus = 0;

    //웨이팅 수
    private int waitTot;
    
    // composition
    // 매장
    // 이 방식이 아닌 조인하는 컬럼들만 묶은 VO를 따로 생성할 예정
    private StoreVO store;
    private BStoreVO bstore;
	
}
