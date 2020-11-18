package com.dealight.domain;

import java.util.Date;
import java.util.List;

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
public class RsvdVO {
	
	// composition
	private List<RsvdDtlsVO> rsvdDtlsList;

	// **************변경 id -> rsvdId 
	// 예약번호 
	@NotNull(message = "예약번호는 null일 수 없습니다.")
    private Long rsvdId;

    // 매장번호
	@NotNull(message = "매장번호는 null일 수 없습니다.")
    private Long storeId;

    // 회원아이디
	@NotBlank
	@Length(min = 1, max = 20)
    private String userId;

    // 핫딜번호
	@Nullable
    private Long htdlId;

    // 결제승인번호
    @Nullable
    private Long aprvNo;

    // 예약인원
    @NotNull
    private int pnum;

    // 예약시간
    @NotBlank
    @Length(min = 1, max = 20)
    private String time;

    // 예약상태코드
    @NotBlank
    private String stusCd;

    // 예약총액
    @NotNull
    private int totAmt;

    // 총메뉴수량
    @NotNull
    private int totQty;
    
    @NotNull
    private Date regDate;
    
    @NotNull
    private Date updateDate;
    
    @NotNull
    private int revwStus;
    
    //@Nullable
    //private List<RsvdDtlsVO> dtlsList;
    //==================================================
    //이거에대한 설명필요해요 수빈씨
//    // 리뷰 상세
//    private RsvdDtlsVO dtls;
//    // 매장
//    private StoreVO store;
}
