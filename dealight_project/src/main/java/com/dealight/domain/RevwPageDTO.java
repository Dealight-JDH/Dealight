package com.dealight.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Getter
@Data
@AllArgsConstructor
public class RevwPageDTO {

	private int revwCnt;
	private List<RevwVO> list;
	
}
