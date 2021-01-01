package com.dealight.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SearchDTO {
	
	private int pNum;
	private String time;
	private double lat;
	private double lng;
	private String region;

}
