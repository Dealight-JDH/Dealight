package com.dealight.service;

import com.dealight.domain.Criteria;
import com.dealight.domain.PageDTO;

public interface SearchService {

//	public List<MainStoreJoinVO> getRadiusStore(Criteria cri);
	public PageDTO getListstore(Criteria cri);
	
	public int getTotal(Criteria cri);
	
//	public List<StoreVO> getList();
//	
//	public void register(StoreVO store);
//	
//	public StoreVO get(Long storeId);
//	
//	public boolean modify(StoreVO store);
//	
//	public boolean delete(Long StoreId);
//	
}
