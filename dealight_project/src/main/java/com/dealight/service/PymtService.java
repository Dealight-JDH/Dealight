package com.dealight.service;

import java.util.List;

import com.dealight.domain.PymtVO;

public interface PymtService {
	
	//CRUD
	void register(PymtVO vo);
	
	PymtVO get(Long pymtId);
	boolean modify(PymtVO vo);
	boolean remove(Long pymtId);
	
	List<PymtVO> getList();
	
}
