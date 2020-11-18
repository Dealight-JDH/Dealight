package com.dealight.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@AllArgsConstructor
@Builder
public class SelMenuDTOList {

	private List<SelMenuDTO> menu;
	
	public SelMenuDTOList() {
		menu = new ArrayList<>();
	}
}
