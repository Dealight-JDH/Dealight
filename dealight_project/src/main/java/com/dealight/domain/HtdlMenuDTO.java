package com.dealight.domain;

import javax.validation.constraints.NotNull;

import lombok.Data;

//jongwoo

@Data
public class HtdlMenuDTO {
	
	//메뉴 이름
	@NotNull
	private String name;
	
	//메뉴 가격
	@NotNull
	private Integer price;

}
