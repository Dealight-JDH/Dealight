package com.dealight.service;

import java.util.List;

import com.dealight.domain.Criteria;
import com.dealight.domain.LikeVO;
import com.dealight.domain.StoreVO;

public interface LikeService {
	
	void pick(String userId, Long storeId);
	
	boolean cancel(String userId, Long storeId);
	
	LikeVO findByUserIdAndStoreId(String userId, Long storeId);
	
	List<LikeVO> findListByUserId(String userId);
	
	List<LikeVO> findListByStoreId(Long storeId);
	
	List<LikeVO> findListWithPagingByUserId(String userId, Criteria cri);
	
	int getLikeTotalByUserId(String userId, Criteria cri);
	
	List<StoreVO> findStoreListWithPagingByUserId(String userId, Criteria cri);

}
