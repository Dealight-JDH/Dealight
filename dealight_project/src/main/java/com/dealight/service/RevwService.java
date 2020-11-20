package com.dealight.service;
// 수빈
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dealight.domain.Criteria;
import com.dealight.domain.RevwImgVO;
import com.dealight.domain.RevwPageDTO;
import com.dealight.domain.RevwVO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.WaitVO;
//다울
public interface RevwService {

	// === 수빈 ===
	
	// 내가 작성한 리뷰
	public List<RevwVO> getWrittenList(String userId);
	
	// 내가 작성한 리뷰 사진
//	public List<RevwImgVO> getWrittenListImg(String userId);

	// 내가 작성한 리뷰 개수
	public int countRevw(String userId);

	// 내가 이용한 매장 개수
	public int countStore(String userId);

	// 작성한 리뷰 읽기
	public RevwVO getRevw(Long revwId);

	// 작성 가능한 리뷰 - 예약내역
	public List<RsvdVO> getWritableListByRsvd(String userId);

	// 작성 가능한 리뷰 - 웨이팅내역
	public List<WaitVO> getWritableListByWait(String userId);
	
	// 작성 가능한 리뷰들을 하나에 담기
	 

	// 리뷰 등록
	public void registerRevw(RevwVO revw);

	// 리뷰 사진 등록
	public void registerRevwImg(RevwImgVO img);

	// 리뷰 등록에 불러올 예약 항목
	public RsvdVO getWritableItemByRsvd(@Param("userId") String userId, @Param("rsvdId") Long rsvdId);

	// 리뷰 등록에 불러올 웨이팅 항목
	public WaitVO getWritableItemByWait(@Param("userId") String userId, @Param("waitId") Long rsvdId);

	// 예약 항목의 리뷰 상태 업데이트
	public boolean updateRsvdRevwStus(@Param("userId") String userId, @Param("rsvdId") Long rsvdId);
	
	// 웨이팅 항목의 리뷰 상태 업데이트
	public boolean updateWaitRevwStus(@Param("userId") String userId, @Param("rsvdId") Long rsvdId);
	
	// 리뷰 답글 업데이트
	public boolean updateRevwReply(RevwVO revw);

	// 리뷰 삭제
	public boolean removeRevw(Long revwId);

	// 리뷰 수정 (maybe)

	// === === ===
	
	
	// public List<RevwVO> revws(Long storeId);
	public List<RevwVO> revws(Long storeId, Criteria cri);
	
	public RevwPageDTO getListPage(Criteria cri,Long storeId);
}
