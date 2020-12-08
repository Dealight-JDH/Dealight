package com.dealight.service;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dealight.domain.AuthVO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.UserVO;


//jongwoo
public interface UserService {

	//회원 등록
	public void register(UserVO user, AuthVO auth);
	
	//해당 회원 찾기
	public UserVO get(String userId);
	
	//회원 수정
	public boolean modify(UserVO user);
	
	//회원 수정(프로필)
	public boolean modifyPhoto(UserVO user);
	
	//회원 탈퇴
	public boolean remove(String userId);
	
	//모든 회원 가져오기
	public List<UserVO> getList();
	
	
	//회원 로그인
	public UserVO login(String userId);
	
	//아이디 찾기
	public int checkId(String userId);
	
	//비밀번호 찾기
	public String getPwd(UserVO user);
	
	//임시 비밀번호 변경
	public boolean changePwd(UserVO user);
	
	//이메일에 대한 아이디 찾기
	public List<String> getId(String email);
	
	// read
	// user mapper - select
	UserVO read(String userId);
	
	// read
	// user mapper - select
	
	boolean isCurWaiting(String userId);
	
	List<RsvdVO> getRsvdListThisUser(String userId);
	
	List<RsvdVO> getRsvdListStoreUser(@Param("storeId") long storeId, @Param("userId") String userId);

	// 현재 패널티 상태인지 확인한다.
	boolean isCurPanalty(String userId); 
	
	// 패널티 expi와 함께 확인하고 expi가 7일 이내이면 pm_stus를 'Y'로 바꾼다.
	boolean checkCurPanaltyExpi(String pmExpi);
	
	// 패널티 누적 획수를 1 증가한다.
	boolean addPanaltyCnt(String userId);
	
	int checkPanaltyDuration();
	
	boolean withdrawalUser(String userId);
	

}
