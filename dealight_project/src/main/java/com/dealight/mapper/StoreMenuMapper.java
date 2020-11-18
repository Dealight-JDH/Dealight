package com.dealight.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dealight.domain.StoreMenuVO;

public interface StoreMenuMapper {

	List<StoreMenuVO> findById(Long storeId);
}

