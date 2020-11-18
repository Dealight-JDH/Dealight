package com.dealight.mapper;



import com.dealight.domain.StoreVO;

public interface StoreMapper {

	
	public StoreVO getBstore(Long storeId);
	
	public StoreVO getNstore(Long storeId);
	
	public String getStoreCd(Long storeId);
	

	
	
}
