package com.dealight.service;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dealight.domain.Criteria;
import com.dealight.domain.WaitVO;
import com.dealight.mapper.UserMapper;
import com.dealight.mapper.WaitMapper;

import lombok.extern.log4j.Log4j;

/*
 * 
 *****[김동인] 
 * 
 */

@Service
@Log4j
public class WaitServiceImpl implements WaitService {
	
	@Autowired
	private WaitMapper waitMapper;
	
	@Autowired
	private UserMapper userMapper;

	@Override
	public WaitVO read(Long waitid) {

		WaitVO wait = waitMapper.findById(waitid);
		
		//UserVO user = userMapper.findById(wait.getUserId());
		
		//wait.setCustTelno(user.getTelno());
		
		//wait.setCustNm(user.getName());
		
		return wait;
	}

	@Override
	public long registerOnWaiting(WaitVO waiting) {
		
		String userId = waiting.getUserId();
		
		if(!isPossibleWaitingUser(userId))
			return -1;
		
		waitMapper.insertSelectKey(waiting);
		
		return waiting.getWaitId();
	}

	@Override
	public boolean isPossibleWaitingUser(String userId) {
		
		return !isCurWaitingUser(userId) && !isCurPanaltyUser(userId);
	}

	@Override
	public boolean isCurWaitingUser(String userId) {
		
		return waitMapper.findByUserId(userId, "W").size() > 0;
	}

	@Override
	public boolean isCurPanaltyUser(String userId) {
		
		return userMapper.findById(userId).getPmStus().equalsIgnoreCase("P");
	}

	@Override
	public long registerOffWaiting(WaitVO waiting) {
		
		waitMapper.insertSelectKey(waiting);
		
		return waiting.getWaitId();

	}

	@Override
	public boolean cancelWaiting(Long waitid) {
		
		return waitMapper.changeWaitStusCd(waitid, "C") == 1;
	}

	@Override
	public boolean enterWaiting(Long waitid) {

		return waitMapper.changeWaitStusCd(waitid, "E") == 1;
	}

	// query 3번 날리는거 추후에 변경
	@Override
	public boolean panaltyWaiting(Long waitid) {
		
		log.info("panaltyWaiting.....................");
		
		String userId = waitMapper.findById(waitid).getUserId();
		
		log.info("waitId....................." + waitid);
		log.info("userId....................." + userId);
		
		if(userId == null)
			return waitMapper.changeWaitStusCd(waitid, "P") == 1;
		else 
			return waitMapper.changeWaitStusCd(waitid, "P") == 1 && 1 == userMapper.addPanaltyCnt(userId);

	}

	@Override
	public List<WaitVO> allStoreWaitList(Long storeId) {
		
		return waitMapper.findByStoreId(storeId);
	}

	@Override
	public List<WaitVO> curStoreWaitList(Long storeId, String waitStusCd) {
		
		return waitMapper.findByStoreIdAndStusCd(storeId, waitStusCd);
	}

	@Override
	public int calWatingOrder(List<WaitVO> curStoreWaitiList, Long waitid) {
				
		return curStoreWaitiList.stream().filter(c -> c.getWaitId() < waitid).collect(Collectors.toList()).size()+1;
	}

	@Override
	public int calWaitingTime(List<WaitVO> curStoreWaitiList, Long waitId, int avgTime) {
		
		return calWatingOrder(curStoreWaitiList, waitId) * avgTime;
	}

	@Override
	public WaitVO readNextWait(List<WaitVO> curStoreWaitiList) {
		
		// null check
		if(curStoreWaitiList == null)
			return null;
		if(curStoreWaitiList.size() == 0)
			return null;
		if(curStoreWaitiList.stream().filter(w -> w.getWaitStusCd().equals("W")).collect(Collectors.toList()).size() ==0)
			return null;
		
		return curStoreWaitiList.stream().filter(w -> w.getWaitStusCd().equals("W")).sorted(
				(w1, w2) -> (int) (w1.getWaitId() - w2.getWaitId())).collect(Collectors.toList()).get(0);
	}

	@Override
	public int waitInit() {
		
		return waitMapper.waitInit();
	}

	@Override
	public List<WaitVO> findWaitListWithPagingByUserId(String userId, Criteria cri) {
		
		return waitMapper.findWaitListWithPagingByUserId(userId, cri);
	}


	@Override
	public WaitVO getCurWaitByUserId(String userId) {
		
		return waitMapper.getCurWaitByUserId(userId);
	}

	@Override
	public int getCurWaitCnt(String userId, Criteria cri) {

		return waitMapper.getWaitCnt(userId, cri, "W");
	}

	@Override
	public int getEnterWaitCnt(String userId, Criteria cri) {

		return waitMapper.getWaitCnt(userId, cri, "E");
	}

	@Override
	public int getPanaltyWaitCnt(String userId, Criteria cri) {

		return waitMapper.getWaitCnt(userId, cri, "P");
	}

	@Override
	public List<WaitVO> findLastWeekRsvdListByStoreId(Long storeId) {

		return waitMapper.findLastWeekRsvdListByStoreId(storeId);
	}

}
