package com.dealight.mapper;

import java.util.List;

import com.dealight.domain.NStoreVO;

public interface NStoreMapper {
	
	public NStoreVO findByStoreId(long storeId);
	
	public List<NStoreVO> findAll();
	
	public void insert(NStoreVO nstore);
	
	public int update(NStoreVO nstore);
	
	public int delete(long storeId);

}
