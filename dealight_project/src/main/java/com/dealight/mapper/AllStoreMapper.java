package com.dealight.mapper;

import java.util.List;

import com.dealight.domain.AllStoreVO;

/*
 * 
 *****[김동인] 
 * 
 */

public interface AllStoreMapper {
	
	// read
	AllStoreVO findAllStoreByStoreId(long storeId);

}
