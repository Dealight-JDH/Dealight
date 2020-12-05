package com.dealight.service;

import java.util.List;

import com.dealight.domain.BUserVO;
import com.dealight.domain.StoreVO;
import com.dealight.domain.UserVO;

public interface AdminService {

	//----------------------사업자등록-----------------------------
	//리스트불러오기
	public List<BUserVO> getBUserList();
	//조회
	public BUserVO readBUser(long brSeq);
	//등록
	public void registerBUser(BUserVO buser);
	//수정
	public boolean modifyBUser(BUserVO buser);
	//삭제
	public boolean deleteBUser(long brSeq);
	
	//----------------------매장관리------------------------------
	//리스트불러오기
	public List<StoreVO> getStroeList();
	//조회
	public StoreVO readStore(long brSeq);
	//등록
	public void registerStore(StoreVO store);
	//수정
	public boolean modifyStore(StoreVO store);
	//삭제
	public boolean deleteStore(long storeId);
	
	//----------------------회원관리------------------------------
	//리스트불러오기
	public List<UserVO> getUserList();
	//조회
	public UserVO readUser(String userId);
	//등록
	public void register(UserVO user);
	//수정
	public boolean modifyUser(UserVO user);
	//삭제
	public boolean delete(long userId);
	//----------------------고객센터------------------------------
	//리스트불러오기
	//조회
	//등록
	//수정
	//삭제
	//----------------------매장리뷰------------------------------
	//리스트불러오기
	//조회
	//등록
	//수정
	//삭제
	
	
	
}