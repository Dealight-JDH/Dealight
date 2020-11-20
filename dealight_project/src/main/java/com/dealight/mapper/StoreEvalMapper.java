package com.dealight.mapper;

import com.dealight.domain.StoreEvalVO;

/*
 * 
 *****[김동인] 
 * 
 */

public interface StoreEvalMapper {

	public void insert(StoreEvalVO eval);
	public StoreEvalVO read(Long storeId);
	public int update(StoreEvalVO eval);
	public int delete(Long storeId);
	
	StoreEvalVO findByStoreID(long storeId);
	
}
