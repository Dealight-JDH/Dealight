package com.dealight.mapper;

import com.dealight.domain.BStoreVO;
import com.dealight.domain.StoreEvalVO;

public interface StoreEvalMapper {
	
	public int update(StoreEvalVO eval);
	
	StoreEvalVO findByStoreID(long storeId);
	
	void insert(StoreEvalVO eval);

}
