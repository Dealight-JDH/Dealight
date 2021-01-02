package com.dealight.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dealight.domain.BStoreVO;
import com.dealight.domain.HtdlWithStoreDTO;
import com.dealight.domain.RsvdWithStoreDTO;

/*
 * 
 *****[김동인] 
 * 
 */

public interface BStoreMapper {

//	public List<StoreVO> getList();
	
	//일단 매장을 등록하는 로직을 짜자
	//매장을 등록하는데 단계가있어
	// mapper -> test -> service -> test -> controller -> mockMVC(test)
	//사업자매장을 집어넣으면
	//1.storeVO에 nextval해줘서 매장번호를 등록한다.(하지만 매장번호를 기억하고있어야한다.
	//2.그다음 그 매장번호로 bstore에 저장해준다.
	//3.
	
//	사업자 매장을 등록한다.
	public void insert(BStoreVO bstoreVO);
//	사업자 매장리스트를 불러온다.
	public List<BStoreVO> getList();
//	사업자 매장을 불러온다.
	public BStoreVO read(Long storeId);
//	사업자 매장을 지운다.
	public int delete(Long storeId);
//	사업자 매장을 수정한다.
	public int update(BStoreVO bstoreVO);
	
	// read
	public BStoreVO findByStoreId(long storeId);
	
	// read list
	public List<BStoreVO> findAll();
	
	List<BStoreVO> selectIdWithAcmPnum();
	BStoreVO selectStoreWithAcmPnum(Long storeId);
	
	
	// changeSeatStus
	public int changeSeatStus(@Param("storeId") long storeId, @Param("seatStusCd") String seatStusCd);

	//jongwoo
	public List<RsvdWithStoreDTO> countAllStoreWithRsvd();
	public List<RsvdWithStoreDTO> findLastWeekRsvdRateListByStoreId();
	public List<RsvdWithStoreDTO> findLastWeekRsvdPnum(int day);
	public List<HtdlWithStoreDTO> findHtdlRslt();
	
	int updateHtdlStus(@Param("storeId")Long storeId, @Param("stusCd")String stusCd);
	
}
