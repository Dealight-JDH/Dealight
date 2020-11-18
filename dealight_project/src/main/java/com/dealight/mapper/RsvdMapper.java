package com.dealight.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dealight.domain.RsvdVO;
import com.dealight.domain.UserVO;
import com.dealight.domain.UserWithRsvdDTO;

public interface RsvdMapper {

	// create
	public void insert(RsvdVO rsvd);
	
	public void insertSelectKey(RsvdVO rsvd);
	
	// read
	public RsvdVO findById(long id);
	
	// read by user id
	public List<RsvdVO> findByUserId(String userId);
	
	// read by store id
	public List<RsvdVO> findByStoreId(@Param("storeId") long storeId);
	
	// read by store id and UserVO user
	public List<RsvdVO> findByStoreIdAndUserId(@Param("storeId") long storeId, @Param("userId")String userId);
	
	// read by store id and cur suts "W"
	public List<RsvdVO> findByStoreIdAndCurStus(@Param("storeId") long storeId, @Param("stusCd") String stusCd);
	
	// read by store id and today
	public List<RsvdVO> findByStoreIdToday(@Param("storeId") long storeId, @Param("today") String today);
	
	// read by store id and date
	public List<RsvdVO> findByStoreIdAndDate(@Param("storeId") long storeId, @Param("date") String date);
	
	// read by store and date and menu count ORDER BY count
	public List<HashMap<String, Object>> findMenuCntByStoreIdAndDate(@Param("storeId") long storeId, @Param("date") String date);
	
	// read by store and date and menu count ORDER BY count
	public List<UserWithRsvdDTO> findUserByStoreIdAndDate(@Param("storeId") long storeId, @Param("date") String date);
	
	// read by rsvd id 
	// join rsvd dtls
	public RsvdVO findRsvdByRsvdIdWithDtls(long rsvdId);
	
	// read list
	public List<RsvdVO> findAll();
	
	// update
	public int update(RsvdVO rsvd);
	
	// delete
	public int delete(long id);
	
	public List<RsvdVO> findLastWeekRsvdListByStoreId(long storeId);
	
}
