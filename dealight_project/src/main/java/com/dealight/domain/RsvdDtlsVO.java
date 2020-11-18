package com.dealight.domain;

import java.util.Date;

<<<<<<< HEAD
import lombok.Data;

@Data
public class RsvdDtlsVO {

    // 예약번호 
    private int rsvdId;

    // 예약일련번호 
    private int rsvdSeq;

    // 메뉴이름 
    private String menuNm;

    // 메뉴수량 
    private int menuTotQty;

    // 메뉴가격 
    private int menuPrc;
    
    private Date regdate;
    private Date updatedate;
=======
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;
import lombok.ToString;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.validation.constraints.NotBlank;

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
>>>>>>> bf8ab310d18e4a1e0cd6669f63450ff680f936b7
}
