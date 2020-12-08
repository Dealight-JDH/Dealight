package com.dealight.mapper;

import java.util.List;

import com.dealight.domain.BUserVO;
import com.dealight.domain.Criteria;

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
	
	public List<BUserVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	// update
	public int update(BUserVO buser);
	
	// delete
	public int delete(long brSeq);
	
	//유저로 모록가져오기
	public List<BUserVO> findAllByUserId(String userId);
	
	

}
