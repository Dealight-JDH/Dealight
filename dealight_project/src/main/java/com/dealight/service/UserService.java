package com.dealight.service;

import java.util.Date;
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
	
	public boolean changePwd(UserVO user);
	
	public List<String> getId(String email);
	// read
	// user mapper - select
	UserVO read(String userId);
	
	// read
	// user mapper - select
	
	boolean isCurWaiting(String userId);
	
	List<RsvdVO> getRsvdListThisUser(String userId);
	
	List<RsvdVO> getRsvdListStoreUser(@Param("storeId") long storeId,@Param("userId") String userId);

	// 현재 패널티 상태인지 확인한다.
	boolean isCurPanalty(String userId); 
	
	// 패널티 expi와 함께 확인하고 expi가 7일 이내이면 pm_stus를 'Y'로 바꾼다.
	boolean checkCurPanaltyExpi(String pmExpi);
	
	// 패널티 누적 획수를 1 증가한다.
	boolean addPanaltyCnt(String userId);
	
	int checkPanaltyDuration();
	
	boolean withdrawalUser(String userId);
	

}
