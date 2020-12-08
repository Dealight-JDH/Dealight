package com.dealight.service;

import com.dealight.domain.SnsVO;

public interface SnsService {

	void register(SnsVO vo);
	
	SnsVO read(String userId);
}
