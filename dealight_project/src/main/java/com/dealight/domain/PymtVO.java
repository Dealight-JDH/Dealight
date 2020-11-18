package com.dealight.domain;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;
import javax.validation.constraints.NotBlank;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class PymtVO {

	// 결제번호 
	@NotNull(message = "결제번호는 null일 수 없습니다.")
    private Long pymtId;

    // 예약번호 
	@NotNull(message = "예약번호는 null일 수 없습니다.")
    private Long rsvdId;

    // 결제수단 
	@NotBlank
	@Length(min = 1, max = 10)
    private String mtd;

    // 결제총액
	@NotNull
    private int tamt;

    // 결제상태코드
	@NotBlank
    private String stusCd;

    // 결제승인번호
	@NotNull
    private int aprvNo;
}
