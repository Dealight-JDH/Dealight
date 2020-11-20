package com.dealight.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dealight.domain.RsvdDtlsVO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.UserWithRsvdDTO;

/*
 * 
 *****[김동인] 
 * 
 */
//jongwoo

public interface RsvdMapper {

	//예약 mapper
	RsvdVO findById(Long rsvdId);
	int delete(Long rsvdId);
	List<RsvdVO> getList();
	
	Long getSeqRsvd();
	Long getDaySeqRsvd();
	
	//예약 상세 mapper
	void insertDtls(RsvdDtlsVO vo);
	void insertDtlsList(List<RsvdDtlsVO> dtlsList);
	List<RsvdDtlsVO> findDtlsById(Long rsvdId);
	int updateDtls(RsvdDtlsVO vo);
	int deleteDtls(Long rsvdId);
	
	//예약+상세
	
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
	
	
	// update
	public int update(RsvdVO rsvd);
	
	public List<RsvdVO> findLastWeekRsvdListByStoreId(long storeId);
	
}
