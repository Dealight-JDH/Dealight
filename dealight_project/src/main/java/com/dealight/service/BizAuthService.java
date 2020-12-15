package com.dealight.service;

import java.util.List;

import com.dealight.domain.BUserVO;
import com.dealight.domain.Criteria;

public interface BizAuthService {

	//등록
	public void register(BUserVO buser);
	//일련번호로 조회
	public BUserVO read(long brSeq);
	//모든 목록조회(관리자사용)
	public List<BUserVO> getList();
	public List<BUserVO> getListWithCri(Criteria cri);
	//해당유저의 목록불러오기
	public List<BUserVO> getListByUserId(String userId);
	//수정
	public boolean modify(BUserVO buser);
	//삭제
	public boolean delete(long brSeq);
	
	// 사업자 심사 상태 코드 'B상태'로 변경
	public boolean updateStusCdToB(Long brSeq);
}
