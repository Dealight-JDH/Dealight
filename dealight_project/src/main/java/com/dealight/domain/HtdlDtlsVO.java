package com.dealight.domain;

import java.util.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class HtdlDtlsVO {
	
	// 핫딜번호
	@NotNull(message = "핫딜번호는 null일 수 없습니다.")
    private Long htdlId;

    // 핫딜상세일련번호
	@NotNull(message = "핫딜상세일련번호는 null일 수 없습니다.")
    private Long htdlSeq;

    // 핫딜메뉴이름
	@NotBlank
	@Length(min = 1, max = 20)
    private String menuName;

    // 메뉴가격
	@NotNull
    private int menuPrice;
	
	// 등록날짜
	@NotNull
	private Date regDate;
	
	// 수정날짜
	@NotNull
	private Date updateDate;
}