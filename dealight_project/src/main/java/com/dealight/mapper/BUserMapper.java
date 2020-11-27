package com.dealight.mapper;

import java.util.List;

import com.dealight.domain.BStoreVO;
import com.dealight.domain.BUserVO;

/*
 * 
 *****[김동인] , 현중
 * 
 */

public interface BUserMapper {
	
	// create
	public void insert(BUserVO buser);
	// create and get brseq
	public void insertSelectKey(BUserVO buser);
	
	// read by brseq
	public BUserVO findBySeq(long brSeq);
	
	// read list
	public List<BUserVO> findAll();
	
	// update
	public int update(BUserVO buser);
	
	// delete
	public int delete(long brSeq);

}
