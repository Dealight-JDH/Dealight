package com.dealight.service;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.AuthVO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.UserVO;
import com.dealight.mapper.RsvdMapper;
import com.dealight.mapper.UserMapper;
import com.dealight.mapper.WaitMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

//
@Log4j
@Service
@AllArgsConstructor
public class UserServiceImpl implements UserService{

	private UserMapper mapper;
	private UserMapper userMapper;
	private WaitMapper waitMapper;
	
	private RsvdMapper rsvdMapper;

	
	@Transactional
	@Override
	public void register(UserVO user, AuthVO auth) {
		
		log.info("register...."+user);
		//회원정보를 등록한다.
		mapper.insert(user);
		mapper.insertAuth(auth);
	}

	@Override
	public UserVO get(String userId) {
		log.info("get........"+userId);

		return mapper.read(userId);
	}

	@Override
	public boolean modify(UserVO user) {
		
		log.info("modify...."+user);
		
		return mapper.update(user)==1;
	}


	@Override
	public boolean remove(String userId) {
		log.info("remove....."+userId);
		return mapper.delete(userId)==1;
	}

	@Override
	public boolean modifyPhoto(UserVO user) {
		log.info("modifyPhoto...."+user);
		return mapper.updatePhoto(user)==1;
	}

	@Override
	public List<UserVO> getList() {
		log.info("getList......");
		return mapper.getList();
		
	}

	@Override
	public UserVO login(String userId) {
		
		log.info("login..");
		return mapper.login(userId);
	}

	@Override
	public int checkId(String userId) {
		
		return mapper.checkId(userId);
	}
	
	@Override
	public String getPwd(UserVO user) {
		log.info(user.getUserId());
        return mapper.getPwd(user);
    }
	
	@Override
	public boolean changePwd(UserVO user) {
		return mapper.changePwd(user) == 1;
	}
	@Override
	public List<String> getId(String email) {
		return mapper.getId(email);
	}
	
	
	

	@Override
	public UserVO read(String userId) {
		
		return mapper.findById(userId);
	}

	@Override
	public boolean isCurWaiting(String userId) {
		
		
		return null == waitMapper.findByUserId(userId, "W");
	}

	@Override
	public List<RsvdVO> getRsvdListThisUser(String userId) {
		
		
		return rsvdMapper.findByUserId(userId);
	}

	@Override
	public List<RsvdVO> getRsvdListStoreUser(long storeId, String userId) {
		
		
		return rsvdMapper.findByStoreIdAndUserId(storeId, userId);
	}
	
	@Override
	public boolean isCurPanalty(String userId) {
		
		UserVO user = userMapper.findById(userId);
		
		// 만약 user의 pmexpi가 7일 이내이면
		// 상태를 "Y"로 바꾼다.
		if(checkCurPanaltyExpi(user.getPmExpi())) {
			user.setPmStus("Y");
			userMapper.update(user);
		}
		
		return user.getPmStus().equalsIgnoreCase("Y");
	}

	@Override
	public boolean checkCurPanaltyExpi(String pmExpi) {
		
		log.info("pmExpi.........."+pmExpi);
		
		pmExpi = pmExpi.substring(0,11);
		
		Date curTime = new Date();
		
		
		try {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			
			Date pmExpiDate = format.parse(pmExpi);
			
			log.info("pmExpiDate................"+pmExpiDate);
			
			log.info("curTime................"+curTime);
			
			Long calDate = curTime.getTime() - pmExpiDate.getTime();
			
			log.info("calDate................"+calDate);
			
			Long calDateDays = calDate / (24*60*60*1000);
			
			log.info("calDateDays................."+calDateDays);
			
			calDateDays = Math.abs(calDateDays);
			
			log.info("오늘로부터 날짜 차이 : " + calDateDays);
			
			return calDateDays <= 7L;
		} catch (ParseException e) {

			e.printStackTrace();
		}
		
		return false;
	}

	@Override
	public boolean addPanaltyCnt(String userId) {
		
		return userMapper.addPanaltyCnt(userId) == 1;
	}

	@Override
	public int checkPanaltyDuration() {
		
		// 7일 이전의 'Y' 상태의 패널티 상태를 'N'로 바꿔준다.
		return userMapper.checkPanaltyDuration();
	}

	@Override
	public boolean withdrawalUser(String userId) {
		
		return 1 == userMapper.withdrawalUser(userId);
	}

}
