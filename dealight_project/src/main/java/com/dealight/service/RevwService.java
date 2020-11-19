package com.dealight.service;

import java.util.List;

import com.dealight.domain.Criteria;
import com.dealight.domain.RevwPageDTO;
import com.dealight.domain.RevwVO;

public interface RevwService {

	// public List<RevwVO> revws(Long storeId);
	public List<RevwVO> revws(Long storeId, Criteria cri);
	
	public RevwPageDTO getListPage(Criteria cri,Long storeId);
}
