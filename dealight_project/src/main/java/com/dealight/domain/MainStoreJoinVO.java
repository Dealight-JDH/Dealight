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
public class MainStoreJoinVO {
	private double dist;
	
	// 매장번호 
    private Long storeId;
	private String storeNm;
    // 매장전화번호 
    private String telno;
    // 매장분류코드 
    private String clsCd;
    //====================================사업자매장테이블
    private String brch;
    private String repMenu;
    private String repImg;
    // 착석상태코드 
    private String seatStusCd;
    // 영업시작시간 
    private String openTm;
    // 영업종료시간 
    private String closeTm;
    // 브레이크타입시작시간 
    private String breakSttm;
    // 브레이크타임종료시간 
    private String breakEntm;
//추가코드 핫딜 상태코드
    private String htdlStusCd;
//예약관련 변수 추가해야 
   
    //====================================위치테이블
    private String addr;
	private Double lat;
	private Double lng;
	//====================================평가테이블
	private Double avgRating;
	private int revwTotNum;
	private int likeTotNum;
	
}
