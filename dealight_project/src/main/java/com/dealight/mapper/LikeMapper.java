package com.dealight.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dealight.domain.Criteria;
import com.dealight.domain.LikeVO;

public interface LikeMapper {
	
	void insert(@Param("userId") String userId,@Param("storeId") Long storeId);
	
	int delete(@Param("userId") String userId,@Param("storeId") Long storeId);
	
	LikeVO findByUserIdAndStoreId(@Param("userId") String userId,@Param("storeId") Long storeId);
	
	List<LikeVO> findListByUserId(String userId);
	
	List<LikeVO> findListWithPagingByUserId(@Param("userId") String userId,@Param("cri") Criteria cri);
	
	List<LikeVO> findListByStoreId(Long storeId);
	
	int getLikeTotal(@Param("userId") String userId,@Param("cri") Criteria cri);

}
