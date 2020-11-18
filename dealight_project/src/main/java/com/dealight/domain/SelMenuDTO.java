package com.dealight.domain;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;
import lombok.ToString;

@Data
@Builder
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
