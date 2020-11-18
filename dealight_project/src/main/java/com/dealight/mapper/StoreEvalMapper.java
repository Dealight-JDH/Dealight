package com.dealight.mapper;

import javax.validation.constraints.NotNull;

import com.dealight.domain.StoreEvalVO;

public interface StoreEvalMapper {

	@NotNull
	public void insert(StoreEvalVO eval);
	@NotNull
	public StoreEvalVO read(Long storeId);
	@NotNull
	public int update(StoreEvalVO eval);
	@NotNull
	public int delete(Long storeId);
}
