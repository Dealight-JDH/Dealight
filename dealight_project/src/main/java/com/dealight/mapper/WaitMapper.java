package com.dealight.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dealight.domain.WaitVO;

/*
 * 
 *****[김동인] 
 * 
 */

public interface WaitMapper {
	
	// create
	public void insert(WaitVO wait);
	
	public void insertSelectKey(WaitVO wait);
	
	// read
	public WaitVO findById(Long id);
	
	// read
	// by store id
	public List<WaitVO> findByStoreId(Long storeId);
	
	// read
	// by store id and date
	public List<WaitVO> findByStoreIdAndDate(@Param("storeId") Long storeId, @Param("date") String date);
	
	// read
	// by store id and stus_cd
	public List<WaitVO> findByStoreIdAndStusCd(@Param("storeId")Long storeId,@Param("waitStusCd") String waitStusCd);

	
	// read by UserID and stus_cd
	public List<WaitVO> findByUserId(@Param("userId") String userId, @Param("waitStusCd") String waitStusCd);
	
	// read list
	public List<WaitVO> findAll();	

	
	// update
	public int update(WaitVO waiting);
	
	// update
	// changeWaitStusCd
	public int changeWaitStusCd(@Param("waitId") Long waitId, @Param("waitStusCd") String waitStusCd);
	
	// delete
	public int delete(Long id);
	
	// update
	public int waitInit();

}
