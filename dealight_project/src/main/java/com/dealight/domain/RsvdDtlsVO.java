package com.dealight.domain;

import java.util.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class RsvdDtlsVO {
	

	// 예약번호
	@NotNull(message = "예약번호는 null일 수 없습니다.")
    private Long rsvdId;

    // 예약일련번호
	@NotNull(message = "예약일련번호는 null일 수 없습니다.")
    private Long rsvdSeq;

    // 메뉴이름
	@NotBlank
	@Size(min = 1, max = 10)
    private String menuNm;

    // 메뉴수량
	@NotNull
    private int menuTotQty;

    // 메뉴가격
	@NotNull
    private int menuPrc;
	
	//등록 날짜
	private Date regDate;
	
	//수정 날짜
	private Date updateDate;
}
