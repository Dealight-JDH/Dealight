package com.dealight.mapper;


import java.util.List;

import org.springframework.web.bind.annotation.RequestParam;

import com.dealight.domain.AuthVO;
import com.dealight.domain.UserVO;

/*
 * 
 *****[김동인] 
 * 
 */
public interface UserMapper {

	public void insertAuth(AuthVO auth);
	//로그인 된 유저 정보 불러오기
	public UserVO read(String userId);
	//관리자 한테 필요할 듯 모든 회원 리스트 불러오기
	public List<UserVO>getList(); 
	//회원가입시 회원 등록
	public void insert(UserVO user);
	//회원 탈퇴
	public int delete(String userId);
	//회원정보 수정
	public int update(UserVO user);
	//프로필 사진 등록,변경
	public int updatePhoto(UserVO user);
	//
	public UserVO login(String userId);
	//아이디 중복체크
	public int checkId(@RequestParam("userId")String userId);
	//비밀번호 찾기 
	public String getPwd(UserVO user);
	//비밀번호를 임시비밀번호로 변경하기
	public int changePwd(UserVO user);
	//아이디찾기
	public List<String> getId(String email);
	//Read
	//@Select("SELECT * FROM tbl_user WHERE user_id = #{userId}")
	public UserVO findById(String userId);
	
	//Read List
	//@Select("SELECT * FROM tbl_user")
	public List<UserVO> findAll();
	
	public int addPanaltyCnt(String userId);
	
	public int checkPanaltyDuration();
	
	public int withdrawalUser(String userId);

}
