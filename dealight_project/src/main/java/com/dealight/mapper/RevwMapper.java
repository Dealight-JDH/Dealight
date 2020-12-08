package com.dealight.mapper;
// 수빈
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dealight.domain.Criteria;
import com.dealight.domain.RevwImgVO;
import com.dealight.domain.RevwVO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.RsvdWithWaitDTO;
import com.dealight.domain.WaitVO;

/*
 * 
 *****[김동인] 
 * 
 */

public interface RevwMapper {
	
	List<RsvdWithWaitDTO> getWritableListWithPagingByUserId(@Param("userId") String userId, @Param("cri") Criteria cri);
	
	int countWritableWait(String userId);
	
	int countWritableRsvd(String userId);

	List<RevwVO> getRevwListWithPagingByStoreId(@Param("storeId") Long storeId,@Param("cri") Criteria cri);
	
	List<RevwVO> getRevwListWithPagingByUserId(@Param("userId") String userId,@Param("cri") Criteria cri);
	
	RevwVO findRevwWtihImgsByRsvdId(Long rsvdId);
	
	RevwVO findRevwWtihImgsByWaitId(Long waitId);
	
	List<RevwImgVO> findRevwImgsByRevwId(Long revwId);

	public int getCountByStoreId(Long storeId);
	
	public void insert(RevwVO revw);
	
	public void insertSelectKey(RevwVO revw);
	
	public RevwVO findById(Long revwId);
	
	public RevwVO findRevwWtihImgsById(Long revwId);
	
	public List<RevwVO> findAll();
	
	public int update(RevwVO revw);
	
	public int delete(long id);
	
	// 내가 작성한 리뷰 내역
	public List<RevwVO> getWrittenList(String userId);
	
	public List<RevwVO> getWrittenListWtihPagingByUserId(@Param("userId") String userId,@Param("cri") Criteria cri);
	
	// 내가 작성한 리뷰 개수
	public int countRevw(String userId);
	
	// 내가 이용한 예약 횟수
	public int countRsvd(String userId);
	
	// 내가 이용한 웨이팅 횟수
	public int countWait(String userId);
	
	// 리뷰 작성 가능 목록 - 예약내역
	public List<RsvdVO> getWritableListByRsvd(String userId);
	
	// 리뷰 작성 가능 목록 - 웨이팅내역
	public List<WaitVO> getWritableListByWait(String userId);
	
	// 리뷰 사진 등록
	public void insertImg(RevwImgVO img);

	// 다중 리뷰 사진 등록
	public void insertAllImgs(List<RevwImgVO> imgs);
	
	// 리뷰 등록 후 리뷰 수 카운팅하여 매장평가에 반영
	//	public int countRevwForStoreEval(Long storeId);
	
	// 예약 항목 리뷰 상태 업데이트
	public int addCntRsvdRevwStus(Long rsvdId);
	
	// 웨이팅 항목 리뷰 상태 업데이트
	public int addCntWaitRevwStus(Long waitId);
	
	// 리뷰 답글 달기
	public int regReply(@Param("revwId") Long revwId,@Param("replyCnts") String replyCnts);

	// 리뷰 삭제
	public int deleteRevw(Long revwId);
	

}
