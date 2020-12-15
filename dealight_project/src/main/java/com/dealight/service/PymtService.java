package com.dealight.service;

import java.util.List;

import com.dealight.domain.PymtVO;

public interface PymtService {
	
	//CRUD
	void register(PymtVO vo);
	
	PymtVO get(Long pymtId);
	PymtVO getByRsvdId(Long rsvdId);
	boolean modify(PymtVO vo);
	boolean stusCdModify(PymtVO vo);
	boolean remove(Long pymtId);
	
	List<PymtVO> getCancelList();
	boolean removeCancelAll();
	List<PymtVO> getList();
	
}
