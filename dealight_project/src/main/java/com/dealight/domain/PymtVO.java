package com.dealight.domain;

import java.util.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;
import org.springframework.lang.Nullable;

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
	
	// 회원아이디
	@NotNull
	private String userId;
	
    // 결제수단
	@Nullable
	@Length(min = 1, max = 10)
    private String mtd;

    // 결제총액
	@NotNull
    private int tamt;

    // 결제상태코드
	@NotBlank
    private String stusCd;

    // 결제승인번호
	@Nullable
    private String aprvNo;
	
	@NotNull
	private Date regDate;
	
	@NotNull
	private Date updateDate;
	@Nullable
	private Date approvedAt;
	
}
