package com.dealight.service;

import com.dealight.domain.Criteria;
import com.dealight.domain.PageDTO;
//현중
public interface SearchService {

	public PageDTO getListstore(Criteria cri);
	
	public int getTotal(Criteria cri);
	
}
