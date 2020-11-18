package com.dealight.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class SelMenuDTO {

	private String name;
	private int price;
	private int quan;

	public SelMenuDTO() {
		this("nothing", 0, 0);
	}

	public SelMenuDTO(String name, int price, int quan) {
		this.name = name;
		this.price = price;
		this.quan = quan;
	}

}
