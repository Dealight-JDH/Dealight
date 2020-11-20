package com.dealight.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
public class Criteria {

	private int pageNum;
	private int amount;
	//km기준 1km = 1
	private double distance;
	private double lat;
	private double lng;
	//정렬기준을 알려주는 변수
	private String sortType;
	//----------------필터조건---------------
	//핫딜매우선보기 Htdl
	//식사가능 우선보기 Seat
	//예약가능 우선보기 Rsvd
	//웨이팅하는 매장보기 Wait
	private String sortPriority;
	//영업중인 매장보기
	private boolean openStore;
	//-------------------헤시태그-------------
	//해시태그는 계속생각해보
	
	public Criteria() {
		this(1,20,1,37.570414,126.985320,"D", "", true);
		
	}
	
//	다울이랑 이야기해야
//	public Criteria() {
//		this(1,4);
//	}
	
	
	public double getRange() {
		return distance * 0.01;
	}
	
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
}
