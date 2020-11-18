package com.dealight.domain;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class SelMenuDTOList {

	private List<SelMenuDTO> menu;
	
	public SelMenuDTOList() {
		menu = new ArrayList<>();
	}
}
