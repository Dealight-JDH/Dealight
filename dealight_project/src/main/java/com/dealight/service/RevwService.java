package com.dealight.service;
// 수빈
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dealight.domain.Criteria;
import com.dealight.domain.RevwImgVO;
import com.dealight.domain.RevwVO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.RsvdWithWaitDTO;
import com.dealight.domain.WaitVO;

public interface RevwService {
	
	// 리뷰 가능한 목록(예약 + 웨이팅) 불러오기
	List<RsvdWithWaitDTO> getWritableListWithPagingByUserId(String userId, Criteria cri);
	
	int countWritableTotal(String userId);
	
	int countWritableWait(String userId);
	
	int countWritableRsvd(String userId);
	
	// 예약 번호로 리뷰 찾기
	RevwVO findRevwWtihImgsByRsvdId(Long rsvdId);
	// 웨이팅 번호로 리뷰 찾기
	RevwVO findRevwWtihImgsByWaitId(Long waitId);
	
	// 매장 리뷰 리스트 가져오기(페이징)
	List<RevwVO> getRevwListWithPagingByStoreId(Long storeId, Criteria cri);
	
	// 회원 리뷰 리스트 가져오기(페이징)
	List<RevwVO> getRevwListWithPagingByUserId(String userId, Criteria cri);
	
	// 매장 리뷰 총 개수
	int getCountByStoreId(Long storeId);
	
	// 리뷰 등록하기
	void regRevw(RevwVO revw);
	
	// 리뷰 보기
	RevwVO findById(Long revwId);
	
	// 리뷰 이미지와 보기
	RevwVO findRevwWtihImgsById(Long revwId);
	
	// 내가 작성한 리뷰
	List<RevwVO> getWrittenList(String userId);
	
	List<RevwVO> getWrittenListWtihPagingByUserId(String userId,Criteria cri);
	
	// 내가 작성한 리뷰 개수
	int countRevw(String userId);
	
	// 딜라이트 매장 이용 수
	int countTotal(String userId);

	// 내가 이용한 예약 횟수
	int countRsvd(String userId);
	
	// 내가 이용한 웨이팅 횟수
	int countWait(String userId);

	// 리뷰 작성 가능 목록 - 예약내역
	List<RsvdVO> getWritableListByRsvd(String userId);
	
	// 리뷰 작성 가능 목록 - 웨이팅내역
	List<WaitVO> getWritableListByWait(String userId);
	
	// 리뷰 답글 달기
	boolean regReply(Long revwId,String replyCnts);

	// 리뷰 삭제
	boolean deleteRevw(Long revwId);
	
	List<RevwImgVO> findRevwImgsByRevwId(Long revwId);
	
}
