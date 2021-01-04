package com.dealight.domain;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import org.springframework.lang.Nullable;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

//jongwoo

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RsvdRequestDTO {

	@NotNull
	private Long storeId; //매장번호
	
	@NotNull
	private String userId; //일반 사용자
	
	@Nullable
	private Long htdlId; //핫딜번호
	
	@NotNull
	List<RsvdMenuDTO> menu; //예약 메뉴 리스트
	
	@NotNull
	private int pnum; //예약 인원
	
	@NotEmpty
	private String time; //예약 시간
	
	@NotNull
	private int totAmt; //총 결제금액
	
	@NotNull
	private int totQty; //총 수량
	
	
	public RsvdVO toEntity() {
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
		Date date = new Date();
		String sysdate = format.format(date);
		
		return RsvdVO.builder()
					.storeId(storeId)
					.userId(userId)
					.htdlId(htdlId)
					.pnum(pnum)
					.time(sysdate + " " + time)
					.totAmt(totAmt)
					.totQty(totQty)
					.stusCd("P")
					.revwStus(0)
					.build();
	}
}
