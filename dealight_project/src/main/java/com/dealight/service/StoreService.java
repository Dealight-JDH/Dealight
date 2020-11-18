package com.dealight.service;

import java.util.List;

import com.dealight.domain.StoreVO;

public interface StoreService {

	
	public void register(StoreVO store);
	
	public StoreVO getAllInfo(Long storeId);
	
	public boolean modify(StoreVO store);
	
	public boolean delete(Long StoreId);
	
	public List<StoreVO> getList();
	
	public List<StoreVO> getStoreListByUserId(String userId);
	
	
}
