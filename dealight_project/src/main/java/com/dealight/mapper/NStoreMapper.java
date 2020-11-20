package com.dealight.mapper;

import java.util.List;

import com.dealight.domain.NStoreVO;

/*
 * 
 *****[김동인] 
 * 
 */

public interface NStoreMapper {
	
	//일반 매장을 등록한다.
	public void insert(NStoreVO nStoreVO);
	//일반 매장리스트를 불러온다.
	public List<NStoreVO> getList();
	//일반 매장을 불러온다.
	public NStoreVO read(Long storeId);
	//일반 매장을 삭제한다.
	public int delete(Long storeId);
	//일반 매장을 수정한다.
	public int update(NStoreVO nStoreVO);
	
	public NStoreVO findByStoreId(long storeId);
	
	//public List<NStoreVO> findAll();
	
	
	

}
