package com.dealight.service;

import java.util.List;

import com.dealight.domain.BUserVO;

public interface BizAuthService {

	//등록
	public void register(BUserVO buser);
	//일련번호로 조회
	public BUserVO read(long brSeq);
	//모든 목록조회(관리자사용)
	public List<BUserVO> getList();
	//해당유저의 목록불러오기
	public List<BUserVO> getListByUserId(String userId);
	//수정
	public boolean modify(BUserVO buser);
	//삭제
	public boolean delete(long brSeq);
}
