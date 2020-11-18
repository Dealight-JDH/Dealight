package com.dealight.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dealight.domain.Criteria;
import com.dealight.domain.RevwVO;

public interface RevwMapper {

	//public List<RevwVO> getRevwList(Long storeId);
	
	public List<RevwVO> getRevwListWithPaging(@Param("storeId") Long storeId,@Param("cri") Criteria cri);
	
	public int getCountByStoreId(Long storeId);
}
