package com.dealight.service;

import java.util.List;

import com.dealight.domain.BUserVO;

public interface BizAuthService {

	//등록
	public void register(BUserVO buser);
	//일련번호로 조회
	public BUserVO read(long brSeq);
	
	public List<BUserVO> getList();
	
	public int modify(BUserVO buser);
	
	public int delete(long brSeq);
}
