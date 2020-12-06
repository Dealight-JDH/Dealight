package com.dealight.domain;
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
public class WaitVO {
	
    private Long waitId;

    @NotNull(message = "매장번호는 null일 수 없습니다.")
    private Long storeId;

    private String userId;

    private String waitRegTm;

    @NotNull(message = "웨이팅 인원은 null일 수 없습니다.")
    private int waitPnum;

    @NotNull(message = "회원 전화번호는 null일 수 없습니다.")
    private String custTelno;

    @NotNull(message = "회원명은 null일 수 없습니다.")
    private String custNm;

    private String waitStusCd = "W";

    private int revwStus = 0;
    
    private String strWaitRegTm;
    
}
