package com.dealight.mapper;

import java.util.List;

import com.dealight.domain.UserVO;

public interface UserMapper {
	
	//Create
	public void insert(UserVO user);
	
	//Read
	//@Select("SELECT * FROM tbl_user WHERE user_id = #{userId}")
	public UserVO findById(String userId);
	
	//Read List
	//@Select("SELECT * FROM tbl_user")
	public List<UserVO> findAll();

	//Update
	public int update(UserVO user);
	
	//Delete
	public int delete(String userId);
	
	
}
