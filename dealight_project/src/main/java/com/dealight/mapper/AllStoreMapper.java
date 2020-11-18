package com.dealight.mapper;

import java.util.List;

import com.dealight.domain.AllStoreVO;

public interface AllStoreMapper {
	
	// read
	AllStoreVO findAllStoreByStoreId(long storeId);

}
