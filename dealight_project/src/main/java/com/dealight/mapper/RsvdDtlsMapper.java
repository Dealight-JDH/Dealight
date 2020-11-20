package com.dealight.mapper;

import java.util.List;

import com.dealight.domain.RsvdDtlsVO;

public interface RsvdDtlsMapper {
	
	// create
	public void insert(RsvdDtlsVO rsvdDtls);
	
	// insert
	public void insertSelectKey(RsvdDtlsVO rsvdDtls);
	
	// insert n
	public int insertRsvdDtls(List<RsvdDtlsVO> rsvdDtls);
	
	// read
	public RsvdDtlsVO findBySeq(long rsvdDtSeq);
	
	// read by rsvd id
	public List<RsvdDtlsVO> findByRsvdId(long rsvdId);
	
	// read list
	public List<RsvdDtlsVO> findAll();
	
	// update
	public int update(RsvdDtlsVO rsvdDtls);
	
	// delete
	public int delete(long rsvdDtlsSeq);
	

}
