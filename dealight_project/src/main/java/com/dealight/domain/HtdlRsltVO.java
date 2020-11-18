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
public class HtdlRsltVO {
	
    // 핫딜번호 
	@NonNull
    private long htdlId;

    // 매장번호 
	@NonNull
    private long storeId;

    // 최종예약인원
	@NonNull
    private int lastPnum;

    // 핫딜마감인원
	@NonNull
    private int htdlLmtPnum;

    // 예약률 
	@NonNull
    private double rsvdRate;

    // 경과시간
	@NonNull
    private String elapTm;

}
