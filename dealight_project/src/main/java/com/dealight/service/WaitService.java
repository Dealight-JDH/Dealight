package com.dealight.service;

import java.util.List;

import com.dealight.domain.Criteria;
import com.dealight.domain.WaitVO;

/*
 * 
 *****[김동인] 
 * 
 */

public interface WaitService {
	
	
	// get wait by wait id
	WaitVO read(Long waitId);
	
	// register wait return wait id
	long registerOnWaiting(WaitVO waiting);
	
	boolean isCurWaitingUser(String userId);

	boolean isCurPanaltyUser(String userId);
	
	// isCurWaitingUser + isCurPanaltyUser
	boolean isPossibleWaitingUser(String userId);
	
	long registerOffWaiting(WaitVO waiting);
	
	boolean cancelWaiting(Long waitId);
	
	boolean enterWaiting(Long waitId);
	
	boolean panaltyWaiting(Long waitId);
	
	List<WaitVO> allStoreWaitList(Long storeId);
	
	List<WaitVO> curStoreWaitList(Long storeId, String waitStusCd);
	
	int calWatingOrder(List<WaitVO> curStoreWaitiList, Long waitId);
	
	int calWaitingTime(List<WaitVO> curStoreWaitiList, Long waitId, int avgTime);
	
	WaitVO readNextWait(List<WaitVO> curStoreWaitiList);
	
	int waitInit();
	
	List<WaitVO> findWaitListWithPagingByUserId(String userId, Criteria cri);
	
	int getCurWaitCnt(String userId, Criteria cri);
	
	int getEnterWaitCnt(String userId, Criteria cri);
	
	int getPanaltyWaitCnt(String userId, Criteria cri);
	
	WaitVO getCurWaitByUserId(String userId);
	
	
	List<WaitVO> findLastWeekRsvdListByStoreId(Long storeId);
	

}
