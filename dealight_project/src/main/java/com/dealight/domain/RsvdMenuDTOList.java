package com.dealight.domain;

import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@AllArgsConstructor
@Builder
public class RsvdMenuDTOList {
	private List<RsvdMenuDTO> menu;
	
	public RsvdMenuDTOList() {
		menu = new ArrayList<>();
	}
}
