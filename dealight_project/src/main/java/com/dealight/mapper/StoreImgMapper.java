package com.dealight.mapper;

import java.util.List;

import com.dealight.domain.StoreImgVO;

public interface StoreImgMapper {
	
	public void insert(StoreImgVO storeImg);
	
	public void insertAll(List<StoreImgVO> storeImgList);

	public int delete(String uuid);
	
	public void deleteAll(long storeId);
	
	public List<StoreImgVO> findByStoreId(long storeId);
	
	public List<StoreImgVO> getOldFiles();
	

}
