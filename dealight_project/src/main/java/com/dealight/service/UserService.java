package com.dealight.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dealight.domain.RsvdVO;
import com.dealight.domain.UserVO;


//현수현수현수
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
	// read
	// user mapper - select
	UserVO read(String userId);
	
	// read
	// user mapper - select
	boolean isCurPanalty(String userId); 
	
	boolean isCurWaiting(String userId);
	
	List<RsvdVO> getRsvdListThisUser(String userId);
	
	List<RsvdVO> getRsvdListStoreUser(@Param("storeId") long storeId,@Param("userId") String userId);

}
