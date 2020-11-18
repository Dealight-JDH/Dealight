package com.dealight.domain;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import org.springframework.lang.Nullable;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class HtdlVO {
	@NotNull(message = "핫딜번호는 null일 수 없습니다.")
	private Long htdlId;
	// 핫딜이름
	@NotBlank
	@Length(min = 1, max = 25, message = "길이가 맞지 않습니다.")
	private String name;
	// 매장번호
	@NotNull(message = "매장번호는 null일 수 없습니다.")
	private Long storeId;
	// 할인율
	@NotNull
	private double dcRate;
	// 핫딜시작시간
	@NotEmpty
	@Length(min = 1, max = 20)
	private String startTm;
	// 핫딜마감시간
	@NotEmpty
	@Length(min = 1, max = 20)
	private String endTm;
	// 핫딜마감인원
	@NotNull
	private int lmtPnum;
	// 핫딜소개
	@Nullable
	@Length(min = 1, max = 75)
	private String intro;
	// 핫딜적용전가격
	@NotNull
	private int befPrice;
	// 할인차감금액
	@NotNull
	private int ddct;
	// 핫딜현재예약인원
	@NotNull
	private int curPnum;
	// 핫딜상태코드
	@NotBlank
	private String stusCd;
	// 등록날짜
	@NotNull
	private Date regDate;
	// 수정날짜
	@NotNull
	private Date updateDate;
	// 핫딜 상세
	private List<HtdlDtlsVO> htdlDtls;
	// 매장 평가
	private StoreEvalVO storeEval;
}
