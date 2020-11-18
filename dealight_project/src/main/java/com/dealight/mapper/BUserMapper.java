package com.dealight.mapper;

import java.util.List;

import com.dealight.domain.BStoreVO;
import com.dealight.domain.BUserVO;

public interface BUserMapper {
	
	// create
	public void insert(BUserVO buser);

	public void insertSelectKey(BUserVO buser);
	
	// read
	public BUserVO findBySeq(long brSeq);
	
	// read list
	public List<BUserVO> findAll();
	
	// update
	public int update(BUserVO buser);
	
	// delete
	public int delete(long storeId);

}
