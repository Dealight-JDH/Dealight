package com.dealight.mapper;

import com.dealight.domain.SnsVO;

public interface SnsMapper {

	
	void insert(SnsVO vo);
	
	SnsVO findById(String userId);
	
	SnsVO read(String userId);
}
