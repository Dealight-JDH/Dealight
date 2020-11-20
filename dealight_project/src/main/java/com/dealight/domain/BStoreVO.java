package com.dealight.domain;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BStoreVO {
	
	    private Long storeId;
	    // 사업자회원아이디 
	    private String buserId;
//	    =======================
	    private String brch;
	    private String repMenu;
	    private String repImg;
//	    =======================
	    // 착석상태코드 
	    private String seatStusCd = "B";
	    // 영업시작시간 
	    private String openTm;
	    // 영업종료시간 
	    private String closeTm;
	    // 브레이크타입시작시간 
	    private String breakSttm;
	    // 브레이크타임종료시간 
	    private String breakEntm;
	    // 라스트오더시간 
	    private String lastOrdTm;
	    // 1인테이블개수 
	    private int n1SeatNo = -1;
	    // 2인테이블개수 
	    private int n2SeatNo = -1;
	    // 4인테이블개수 
	    private int n4SeatNo = -1;
	    // 매장소개 
	    private String storeIntro;
	    // 매장평균식사시간 
	    private int avgMealTm = -1;
	    // 매장휴무일 
	    private String hldy;
	    // 수용인원 
	    private int acmPnum = -1;
	    
	    private HtdlVO htdl;
	    private List<StoreTagVO> tag;
	    private List<MenuVO> menus;
	    //추가 WaitVO 추가됨
	    private List<WaitVO> waits;
	    
	    public static class Builder{
	    	private final Long storeId;
	    	private final String buserId;
	    	private final String brch;
	 	    private final String repMenu;
	 	    private final String repImg;
	    	private final String openTm;
	    	private final String closeTm;
	    	
	    	private String seatStusCd;
	    	private String breakSttm;
	    	private String breakEntm;
	    	private int n1SeatNo;
	 	    private int n2SeatNo;
	 	    private int n4SeatNo;
	 	    private String storeIntro;
		    private int avgMealTm;
		    private String hldy;
		    private int acmPnum;
		    
		    
		    
			public Builder(Long storeId, String buserId,
							String brch, String repMenu, String repImg,
							String openTm, String closeTm) {
				super();
				this.storeId = storeId;
				this.buserId = buserId;
				this.brch = brch;
				this.repImg = repImg;
				this.repMenu = repMenu;
				this.openTm = openTm;
				this.closeTm = closeTm;
			}

			public Builder setseatStusCd(String seatStusCd) {this.seatStusCd = seatStusCd; 	return this;}
			public Builder setBreakSttm	(String breakSttm) 	{this.breakSttm = breakSttm; 	return this;}
			public Builder setBreakEntm	(String breakEntm) 	{this.breakEntm = breakEntm;	return this;}
			public Builder setN1SeatNo	(int n1SeatNo) 		{this.n1SeatNo = n1SeatNo; 		return this;}
			public Builder setN2SeatNo	(int n2SeatNo) 		{this.n2SeatNo = n2SeatNo; 		return this;}
			public Builder setN4SeatNo	(int n4SeatNo) 		{this.n4SeatNo = n4SeatNo; 		return this;}
			public Builder setStoreIntro(String storeIntro) {this.storeIntro = storeIntro; 	return this;}
			public Builder setAvgMealTm	(int avgMealTm) 	{this.avgMealTm = avgMealTm; 	return this;}
			public Builder setHldy		(String hldy) 		{this.hldy = hldy; 				return this;}
			public Builder setAcmPnum	(int acmPnum) 		{this.acmPnum = acmPnum; 		return this;}
			
		    public BStoreVO build() {
		    	return new BStoreVO(this);
		    }
	    }
	    
	    public BStoreVO(Builder builder) {
	    	storeId = builder.storeId;
	    	buserId = builder.buserId;
	    	brch = builder.brch;
	    	repImg = builder.repImg;
	    	repMenu = builder.repMenu;
	    	openTm = builder.openTm;
	    	closeTm = builder.closeTm;
	    	seatStusCd = builder.seatStusCd;
	    	breakSttm = builder.breakSttm;
	    	breakEntm = builder.breakEntm;
	    	n1SeatNo = builder.n1SeatNo;
	    	n2SeatNo = builder.n2SeatNo;
	    	n4SeatNo = builder.n4SeatNo;
	    	storeIntro = builder.storeIntro;
	    	avgMealTm = builder.avgMealTm;
	    	hldy = builder.hldy;
	    	acmPnum = builder.acmPnum;
	    }
}
