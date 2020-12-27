package com.dealight.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class LikeListDTO {

	private List<StoreVO> storeList;
	private int total;
	private PageDTO pageMaker;
}
