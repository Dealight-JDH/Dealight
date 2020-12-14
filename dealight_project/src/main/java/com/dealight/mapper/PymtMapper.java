package com.dealight.mapper;

import java.util.List;

import com.dealight.domain.PymtVO;

public interface PymtMapper {

	//CRUD
	void insert(PymtVO vo);
	void insertSelectKey(PymtVO vo);
	
	//상태코드, 결제승인시간
	int update(PymtVO vo);	
	int stusCdUpdate(PymtVO vo);
	PymtVO findById(Long pymtId);
	PymtVO findByRsvdId(Long rsvdId);
	int delete(Long pymtId);
	
	List<PymtVO> findCancelList();
	int deleteCancelAll();
	List<PymtVO> getList();
	
}
