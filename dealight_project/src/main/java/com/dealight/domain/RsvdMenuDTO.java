package com.dealight.domain;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotNull;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

//jongwoo

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class RsvdMenuDTO {

	private String name;
	
	private Integer price;
	
	private Integer qty;

}