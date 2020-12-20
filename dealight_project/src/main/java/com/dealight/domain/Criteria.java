package com.dealight.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
//현중
@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor 
public class Criteria {

	private int pageNum;
	private int amount;
	private String type;
	private String keyword;
	//km기준 1km = 1
	private double distance;
	private double lat;
	private double lng;
	//정렬기준
	private String sortType;
	
	//----------------필터조건---------------
	//정렬우선조건
	private String sortPriority;
	//필터타입
	private String filterType;
	//영업중인 매장보기(필터타입으로 무조건 합쳐짐 생각해라)
	private boolean openStore;
	//-------------------헤시태그-------------
	//해시태그는 계속생각해보기
	
	public String[] getFilterTypeArr() {
		return filterType == null? new String[] {}: type.split("");
	}
	
	public String[] getTypeArr() {
		
		return type == null? new String[] {}: type.split("");
	}
	
	public double getRange() {
		return distance * 0.01;
	}
	
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public Criteria(int pageNum, int amount, double distance, double lat, double lng, String sortType, String sortPriority, boolean openStore) {
		this.amount = amount;
		this.pageNum = pageNum;
		this.distance = distance;
		this.lat = lat;
		this.lng = lng;
		this.sortPriority = sortPriority;
		this.sortType = sortType;
		this.openStore = openStore;
	}
	
	public String getBrnoListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("page", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
				
		return builder.toUriString();
	}
	
	public String getFilterTypeLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("page", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("filterType", this.getFilterType())
				.queryParam("keyword", this.getKeyword());
				
		return builder.toUriString();
	}
}
