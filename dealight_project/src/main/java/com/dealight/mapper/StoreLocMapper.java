package com.dealight.mapper;

import com.dealight.domain.StoreLocVO;

public interface StoreLocMapper {
	
	int update(StoreLocVO loc);

	void insert(StoreLocVO loc);
	
	StoreLocVO findByStoreId(long storeId);
}
