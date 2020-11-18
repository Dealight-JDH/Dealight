package com.dealight.service;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.dealight.domain.UserVO;
import com.dealight.mapper.UserMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class UserServiceImpl implements UserService{

	private UserMapper mapper;

	@Override
	public void register(UserVO user) {
		
		log.info("register...."+user);
		//회원정보를 등록한다.
		mapper.insert(user);
		
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
	public int changePwd(UserVO user) {
		return mapper.changePwd(user);
	}
	@Override
	public List<String> getId(String email) {
		return mapper.getId(email);
	}
	
}
