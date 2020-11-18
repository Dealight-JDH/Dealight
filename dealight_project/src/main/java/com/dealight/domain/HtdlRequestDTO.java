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

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class HtdlRequestDTO {

	@NotEmpty
	private String name;
	
	@NotNull
	private String[] menu;
	
	@NotNull
	private double dcRate;
	
	@NotNull
	private int befPrice;
	
	@NotEmpty
	private String startTm;
	
	@NotEmpty
	private String endTm;
	
	@NotNull
	private int lmtPnum;
	
	@Nullable
	private String intro;
	
	
	public HtdlVO toEntity() {
		//현재 날짜
		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
		Date date = new Date();
		String sysdate = format.format(date);
		
		return HtdlVO.builder()
				.name(name)
				.dcRate(dcRate /100.0)
				.startTm(sysdate+" "+ startTm)
				.endTm(sysdate+" "+ endTm)
				.lmtPnum(lmtPnum)
				.intro(intro)
				.befPrice(befPrice)
				.ddct((int)(befPrice * (dcRate / 100)))
				.curPnum(0).stusCd("P").build();
	}
	
	
}