package com.dealight.mapper;

import java.util.List;

import com.dealight.domain.HtdlRsltVO;

public interface HtdlRsltMapper {
	
	// create
	public void insert(HtdlRsltVO htdlRslt);
	
	// read
	public HtdlRsltVO findById(long htdlId);
	
	// read list
	public List<HtdlRsltVO> findAll();
	
	// update
	public int update(HtdlRsltVO htdlRslt);
	
	// delete
	public int delete(long htdlId);

}
