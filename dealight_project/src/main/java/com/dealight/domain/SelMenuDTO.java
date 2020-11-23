package com.dealight.domain;


import lombok.Builder;
import lombok.Data;
//다울
@Data
@Builder
public class SelMenuDTO {

	private String name;
	private int price;
	private int qty;

	public SelMenuDTO() {
		this("nothing", 0, 0);
	}

	public SelMenuDTO(String name, int price, int qty) {
		this.name = name;
		this.price = price;
		this.qty = qty;
	}

}
