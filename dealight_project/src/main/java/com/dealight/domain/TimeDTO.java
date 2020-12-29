package com.dealight.domain;

import java.time.LocalDateTime;

import lombok.Getter;

@Getter
public enum TimeDTO { 
	
	NINE(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),9,0)),
	NINEHALF(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),9,30)),
	TEN(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),10,0)),
	TENHALF(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),10,30)),
	ELEVEN(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),11,0)),
	ELEVENHALF(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),11,30)),
	TWELVE(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),12,0)),
	TWELVEHALF(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),12,30)),
	THIRTEEN(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),13,0)),
	THIRTEENHALF(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),13,30)),
	FOURTEEN(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),14,0)),
	FOURTEENHALF(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),14,30)),
	FIFTEEN(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),15,0)),
	FIFTEENHALF(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),15,30)),
	SIXTEEN(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),16,0)),
	SIXTEENHALF(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),16,30)),
	SEVENTEEN(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),17,0)),
	SEVENTEENHALF(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),17,30)),
	EIGHTEEN(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),18,0)),
	EIGHTEENHALF(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),18,30)),
	NINETEEN(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),19,0)),
	NINETEENHALF(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),19,30)),
	TWENTY(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),20,0)),
	TWENTYHALF(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),20,30)),
	TWENTYONE(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),21,0)),
	TWENTYONEHALF(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),21,30)),
	TWENTYTWO(LocalDateTime.of(LocalDateTime.now().getYear(),LocalDateTime.now().getMonthValue(),LocalDateTime.now().getDayOfMonth(),22,0));
	
	
	private LocalDateTime time;

	private TimeDTO(LocalDateTime time) {
		this.time = time;
	}
	

}

