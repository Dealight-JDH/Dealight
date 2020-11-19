package com.dealight.service;

import java.util.List;

import com.dealight.domain.Criteria;
import com.dealight.domain.RevwVO;
import com.dealight.domain.StoreVO;

public interface StoreService {

	public StoreVO nstore(Long storeId);
	
	public StoreVO bstore(Long storeId);
	
	public String storeCd(Long storeId);
	
}
