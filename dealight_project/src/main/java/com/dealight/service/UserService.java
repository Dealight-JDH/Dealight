package com.dealight.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.dealight.domain.UserVO;


public interface UserService {

	public void register(UserVO user);
	
	public UserVO get(String userId);
	
	public boolean modify(UserVO user);
	
	public boolean modifyPhoto(UserVO user);
	
	public boolean remove(String userId);
	
	public List<UserVO> getList();
	
	public UserVO login(String userId);
	
	public int checkId(String userId);
	
	public String getPwd(UserVO user);
	
	public int changePwd(UserVO user);
	
	public List<String> getId(String email);
	
}
