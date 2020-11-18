package com.dealight.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dealight.domain.WaitVO;

public interface WaitMapper {
	
	// create
	public void insert(WaitVO waiting);
	
	public void insertSelectKey(WaitVO waiting);
	
	// read
	public WaitVO findById(long id);
	
	// read
	// by store id
	public List<WaitVO> findByStoreId(long storeId);
	
	// read
	// by store id and date
	public List<WaitVO> findByStoreIdAndDate(@Param("storeId") long storeId, @Param("date") String date);
	
	// read
	// by store id and stus_cd
	public List<WaitVO> findByStoreIdAndStusCd(@Param("storeId")long storeId,@Param("waitStusCd") String waitStusCd);

	
	// read by UserID and stus_cd
	public List<WaitVO> findByUserId(@Param("userId") String userId, @Param("waitStusCd") String waitStusCd);
	
	// read list
	public List<WaitVO> findAll();	

	
	// update
	public int update(WaitVO waiting);
	
	// update
	// changeWaitStusCd
	public int changeWaitStusCd(@Param("id") long id, @Param("waitStusCd") String waitStusCd);
	
	// delete
	public int delete(long id);

}
