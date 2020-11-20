package com.dealight.mapper;

import java.util.List;

import com.dealight.domain.StoreLocVO;

/*
 * 
 *****[김동인] 
 * 
 */

public interface StoreLocMapper {

	public void insert(StoreLocVO storeLocVO);
	
	public List<StoreLocVO> getList();
	
	public StoreLocVO read(Long storeId);
	
	public int delete(Long StoreId);

	public int update(StoreLocVO storeLocVO);
	StoreLocVO findByStoreId(long storeId);
	
}
	
