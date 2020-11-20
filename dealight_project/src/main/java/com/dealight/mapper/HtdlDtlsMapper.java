package com.dealight.mapper;

import java.util.List;

import com.dealight.domain.HtdlDtlsVO;
import com.dealight.domain.RsvdDtlsVO;

public interface HtdlDtlsMapper {
	
	// create
	public void insert(HtdlDtlsVO htdlDtls);
	
	
	public void insertSelectKey(HtdlDtlsVO htdlDtls);
	
	// insert n
	public int insertHtdlDtls(List<HtdlDtlsVO> rsvdDtlsList);
	
	// read
	public HtdlDtlsVO findBySeq(long htdlSeq);
	
	// read
	// by htdl id
	public List<HtdlDtlsVO> findByHtdlId(long htdlId);
	
	// read list
	public List<HtdlDtlsVO> findAll();
	
	// update
	public int update(HtdlDtlsVO htdl);
	
	// delete
	public int delete(long htdlSeq);

}
