package com.dealight.service;

import java.util.List;

import com.dealight.domain.WaitVO;

/*
 * 
 *****[김동인] 
 * 
 */

public interface WaitService {
	
	// wait dtls mapper - select
	// read
	WaitVO read(Long waitId);
	
	// wait mapper - inserSelectKey
	// insert
	long registerOnWaiting(WaitVO waiting);
	
	boolean isPossibleWaitingUser(String userId);
	
	boolean isCurWaitingUser(String userId);
	
	boolean isCurPanaltyUser(String userId);
	
	// wait mapper - inserSelectKey
	// insert
	long registerOffWaiting(WaitVO waiting);
	
	// 웨이팅 상태 변경clsCd waitStusCd = "C" 
	// wait mapper - update
	boolean cancelWaiting(Long waitId);
	
	// 웨이팅 상태 변경 clsCd waitStusCd = "E" 
	// wait mapper - update
	boolean enterWaiting(Long waitId);
	
	// 웨이팅 상태 변경 clsCd waitStusCd = "P" 
	// wait mapper - update
	boolean panaltyWaiting(Long waitId);
	
	// wait mapper - select list
	List<WaitVO> allStoreWaitList(Long storeId);
	
	// wait mapper - select list
	// -storeid
	// -clsCd waitStusCd = "C" 
	List<WaitVO> curStoreWaitList(Long storeId, String waitStusCd);
	
	int calWatingOrder(List<WaitVO> curStoreWaitiList, Long waitId);
	
	int calWaitingTime(List<WaitVO> curStoreWaitiList, Long waitId, int avgTime);
	
	WaitVO readNextWait(List<WaitVO> curStoreWaitiList);
	
	int waitInit();

}
