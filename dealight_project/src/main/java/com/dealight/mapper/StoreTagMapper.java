package com.dealight.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dealight.domain.StoreTagVO;

public interface StoreTagMapper {
	
	int update(StoreTagVO tag);
	
	void insert(StoreTagVO tag);
	
	List<StoreTagVO> findByStoreId(long storeId);
	
	int delete(@Param("storeId") long storeId, @Param("tagNm") String tagNm);

}
