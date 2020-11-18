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
import javax.validation.constraints.NotNull;
import javax.validation.constraints.NotBlank;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class HtdlRsltVO {
	

	// 핫딜번호
	@NotNull(message = "핫딜번호는 null일 수 없습니다.")
    private Long htdlId;

    // 매장번호
	@NotNull(message = "매장번호는 null일 수 없습니다.")
    private Long storeId;

    // 최종예약인원
	@NotNull
    private int lastPnum;

    // 핫딜마감인원
	@NotNull
    private int htdlLmtPnum;

    // 예약률
	// double로 수정해야 함
    @NotNull
    private Double rsvdRate;

    // 경과시간
    @NotBlank
    private String elapTm;
    
    @NotNull
    private Date regDate;
    
    @NotNull
    private Date updateDate;
}

