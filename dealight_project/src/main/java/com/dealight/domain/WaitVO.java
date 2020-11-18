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
public class WaitVO {
	
	//

	@NonNull
    private Long waitId;

    @NonNull
    private Long storeId;

    private String userId;

    @NonNull
    private Date waitRegTm;

    private int waitPnum;

    @NonNull
    private String custTelno;

    @NonNull
    private String custNm;

    @NonNull
    private String waitStusCd = "W";

    // 리뷰상태 
    private int revwStus;

    // composition
    // 매장
    // 이거 만든사람 이거 뺄수있는 방법좀 생각해주세요
    private StoreVO store;
    //웨이팅 수
    private int waitTot;
	
}
