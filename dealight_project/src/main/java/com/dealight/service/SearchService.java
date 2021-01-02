package com.dealight.service;

import com.dealight.domain.Criteria;
import com.dealight.domain.PageDTO;
//현중
public interface SearchService {

	public PageDTO getListstore(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	public PageDTO getListDistStore(Criteria cri);
	
	public int getStoreWaitCnt(long storeId);
}
