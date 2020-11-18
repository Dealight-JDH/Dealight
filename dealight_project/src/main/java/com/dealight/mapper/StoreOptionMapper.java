package com.dealight.mapper;

import com.dealight.domain.StoreOptionVO;

public interface StoreOptionMapper {
	
	int update(StoreOptionVO opt);
	
	void insert(StoreOptionVO opt);
	
	StoreOptionVO findByStoreId(long storeId);

}
