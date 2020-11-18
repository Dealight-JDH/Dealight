package com.dealight.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dealight.domain.RsvdVO;
import com.dealight.domain.WaitVO;
import com.dealight.domain.RevwImgVO;
import com.dealight.domain.RevwVO;

public interface RevwMapper {
	
	// create
	
	public void insert(RevwVO revw);

	
	public void insertSelectKey(RevwVO revw);
	
	// **********동인
	// read
	public RevwVO findById(long id);
	
	// read list
	public List<RevwVO> findAll();
	
	// update
	public int update(RevwVO revw);
	
	// delete
	public int delete(long id);
	
	// **********동인

	// 내가 작성한 리뷰 내역
	public List<RevwVO> getWrittenList(String userId);
	
	// 내가 작성한 리뷰 이미지
	public List<RevwImgVO> getWrittenListImg(String userId);
	
	// 내가 작성한 리뷰 개수
	public int countRevw(String userId);
	
	// 내가 이용한 매장 개수
	public int countStore(String userId);
	
	// 리뷰 작성 가능 목록 - 예약내역
	public List<RsvdVO> getWritableListByRsvd(String userId);
	
	// 리뷰 작성 가능 목록 - 웨이팅내역
	public List<WaitVO> getWritableListByWait(String userId);
	
	// 리뷰 하나씩 읽어오기
	public RevwVO readRevw(Long revwId);

	// 리뷰 등록에 불러올 예약 항목 (파라미터 2개 이상일 때 @Param 붙이기)
	public RsvdVO getWritableItemByRsvd(@Param("userId") String userId, @Param("rsvdId") int rsvdId);
	
	// 리뷰 등록에 불러올 웨이팅 항목
	public WaitVO getWritableItemByWait(@Param("userId") String userId, @Param("waitId") int waitId);
	
	// 리뷰 등록
	public void insertRevw(RevwVO revw);
	
	// 리뷰 사진 등록
	public void insertRevwImg(RevwImgVO img);
	
	// 예약 항목 리뷰 상태 업데이트
	public int updateRsvdRevwStus(@Param("userId") String userId, @Param("rsvdId") int rsvdId);
	
	// 웨이팅 항목 리뷰 상태 업데이트
	public int updateWaitRevwStus(@Param("userId") String userId, @Param("waitId") int waitId);
	
	// 리뷰 답글 업데이트
	public int updateRevwReply(RevwVO revw);

	// 리뷰 삭제
	public int deleteRevw(Long revwId);

	// 리뷰 수정 (maybe)
	
}
