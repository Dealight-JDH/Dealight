package com.dealight.mapper;

import org.apache.ibatis.annotations.Param;

import com.dealight.domain.StoreEvalVO;

/*
 * 
 *****[김동인] 
 * 
 */

public interface StoreEvalMapper {

	public void insert(StoreEvalVO eval);
	public StoreEvalVO read(Long storeId);
	public int update(StoreEvalVO eval);
	public int delete(Long storeId);
	
	StoreEvalVO findByStoreID(long storeId);
	
	int addRevwRating(@Param("storeId") Long storeId, @Param("rating") double rating); 
	int addLike(Long storeId);
	int removeLike(Long storeId);
	
}
