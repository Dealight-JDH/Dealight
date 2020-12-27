package com.dealight.domain;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

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

    @Min(value = 1, message = "웨이팅 인원은 1명 이상이어야 합니다.")
    @Max(value = 10, message = "웨이팅 인원은 10명을 넘을 수 없습니다.")
    private int waitPnum;

    @NotBlank(message = "회원 전화번호는 blank일 수 없습니다.")
    private String custTelno;

    @NotBlank(message = "회원명은 blank일 수 없습니다.")
    @Length(max = 5)
    private String custNm;

    private String waitStusCd = "W";

    private int revwStus = 0;
    private int waitTot;
    private String strWaitRegTm;
    private String storeRepImg;
    private String storeNm;
    
}
