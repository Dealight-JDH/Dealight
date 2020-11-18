package com.dealight.domain;

import java.util.HashMap;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RsvdRsltDTO {
	
	int totalTodayRsvd;
	int totalTodayRsvdPnum;
	HashMap<String,Integer> todayFavMenuMap;
	

}
